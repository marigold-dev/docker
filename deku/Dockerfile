FROM esydev/esy:nightly-alpine-latest as builder
RUN apk --update add ca-certificates libexecinfo-dev bash nodejs tar xz gzip
WORKDIR /app
RUN curl -L https://github.com/marigold-dev/deku/tarball/master -o deku-master.tgz
RUN tar -xf deku-master.tgz
WORKDIR marigold-dev-deku-d420fea
RUN node scripts/run.js /path/sidechain/esy.json > esy.json
COPY ./esy.json ./esy.json
RUN esy install
# Copy the rest of the files
RUN esy release
WORKDIR _release
RUN npm pack && npm install -g --prefix=/usr/local ./sidechain-0.0.0.tgz

FROM node:17-alpine3.14 as runtime
# Setup OPENSSL so that it finds the certs
ENV OPENSSL_STATIC=1
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR=/etc/ssl/certs
RUN apk --update add bash
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/local/bin/deku-* /usr/local/bin/
RUN mkdir -p /usr/local/lib/node_modules
COPY --from=builder /usr/local/lib/node_modules/sidechain/ /usr/local/lib/node_modules/sidechain
# ENTRYPOINT ["deku-node"]
# CMD ["/app/data"]
ENTRYPOINT ["/bin/bash"]
