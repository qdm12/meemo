FROM node:alpine
RUN mkdir -p /meemo /data && cd /meemo && \
    apk add --virtual build-dependencies --no-cache --update \
    python python-dev build-base wget ca-certificates && \
    wget https://github.com/nebulade/meemo/archive/master.tar.gz && \
    tar --strip-components=1 -xzf master.tar.gz && rm master.tar.gz && \
    rm -fr start.sh .dockerignore .gitignore .travis.yml CHANGELOG Dockerfile \
    CloudronManifest.json DESCRIPTION.md LICENSE README.md screenshots && \
    npm install && \
    npm install -g gulp && \
    gulp default && \
    npm uninstall -g gulp && \
    apk del build-dependencies
EXPOSE 3000
ENTRYPOINT ["node", "meemo/app.js"]