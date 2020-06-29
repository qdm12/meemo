ARG ALPINE_VERSION=3.12

FROM --platform=linux/amd64 alpine:${ALPINE_VERSION} AS builder
ARG MEEMO_VERSION=v1.13.0
RUN apk add -q --progress --update npm git
RUN mkdir /tmp/download /tmp/build && \
    cd /tmp/download && \
    git clone --branch ${MEEMO_VERSION} --single-branch --depth 1 https://github.com/nebulade/meemo.git . &> /dev/null && \
    mv src /tmp/build/src && \
    mv frontend /tmp/build/frontend && \
    mv gulpfile.js package.json package-lock.json app.js things.json logo.png /tmp/build/ && \
    cd /tmp/build && \
    rm -r /tmp/download
WORKDIR /tmp/build
RUN npm --silent install
RUN npm --silent -g install gulp-cli
RUN gulp default --revision ${MEEMO_VERSION}

FROM alpine:${ALPINE_VERSION}
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL \
    org.opencontainers.image.authors="quentin.mcgaw@gmail.com" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.url="https://github.com/qdm12/meemo" \
    org.opencontainers.image.documentation="https://github.com/qdm12/meemo/blob/master/README.md" \
    org.opencontainers.image.source="https://github.com/qdm12/meemo" \
    org.opencontainers.image.title="Meemo" \
    org.opencontainers.image.description="Meemo container"
EXPOSE 3000/tcp
RUN apk add -q --progress --no-cache --update nodejs && \
    rm -rf /var/cache/apk/*
ENTRYPOINT ["node", "meemo/app.js"]
HEALTHCHECK --interval=3m --timeout=5s --start-period=20s --retries=1 \
    CMD [ "$(wget -qS -O /dev/null http://localhost:$PORT 2>&1 | grep -F HTTP | cut -d " " -f 4 | grep -o 200)" = "200"  ] || exit 1
ENV PORT=3000 \
    BIND_ADDRESS=0.0.0.0 \
    CLOUDRON_APP_ORIGIN=http://localhost \
    CLOUDRON_MONGODB_URL=mongodb://mongodb:27017/meemo \
    ATTACHMENT_DIR=/data \
    CLOUDRON_LOCAL_AUTH_FILE=/users.json \
    NODE_ENV=production
COPY --from=builder --chown=1000 /tmp/build/ /meemo/
USER 1000
