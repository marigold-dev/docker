ARG VERSION=latest
FROM tezos/tezos:${VERSION}
RUN sudo apk add curl lz4 xz jq
COPY tezos-snapshot-downloader.sh /
ENTRYPOINT ["/tezos-snapshot-downloader.sh"]
CMD []
