FROM tezos/tezos:master
RUN sudo apk add curl lz4 xz jq
COPY tezos-snapshot-downloader.sh /
ENTRYPOINT ["/tezos-snapshot-downloader.sh"]
CMD []
