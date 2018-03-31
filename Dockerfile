FROM alpine:3.7
LABEL maintainer="quentin.mcgaw@gmail.com" \
      description="Run a lightweight Meemo server 1.7 with database on Docker with docker-compose" \
      size="157MB" \
      ram="67MB" \
      github="https://github.com/qdm12/stackedit-docker"
RUN apk add -q --progress --no-cache --update nodejs && \
    apk add -q --progress --virtual build-dependencies --no-cache --update \
    python python-dev build-base git && \
    git clone https://github.com/nebulade/meemo.git && \
    cd meemo && \
    rm -fr start.sh .dockerignore .gitignore .travis.yml CHANGELOG Dockerfile \
    CloudronManifest.json DESCRIPTION.md LICENSE README.md screenshots && \
    npm --silent install && \
    npm --silent -g install gulp && \
    gulp default && \
    npm --silent -g uninstall gulp && \
    apk del -q --progress --purge build-dependencies
EXPOSE 3000
ENTRYPOINT ["node", "meemo/app.js"]