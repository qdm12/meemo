FROM alpine:3.8
LABEL maintainer="quentin.mcgaw@gmail.com" \
      description="Run a lightweight Meemo server 1.8.1 with database on Docker with docker-compose" \
      download="54.3MB" \
      size="157MB" \
      ram="70MB" \
      cpu_usage="Very low" \
      github="https://github.com/qdm12/stackedit-docker"
RUN apk add -q --progress --no-cache --update npm && \
    apk add -q --progress --virtual build-dependencies --no-cache --update python python-dev build-base git && \
    git clone --branch v1.8.1 --single-branch --depth 1 https://github.com/nebulade/meemo.git &> /dev/null && \
    cd meemo && \
    rm -fr start.sh .dockerignore .gitignore *.yml CHANGELOG Dockerfile \
    CloudronManifest.json *.md screenshots && \
    npm --silent install && \
    npm --silent -g install gulp && \
    gulp default && \
    npm --silent -g uninstall gulp && \
    apk del -q --progress --purge build-dependencies && \
    rm -rf /var/cache/apk/*
EXPOSE 3000
ENTRYPOINT ["node", "meemo/app.js"]