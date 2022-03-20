FROM tezos/tezos:latest-release
RUN sudo apk add curl lz4 xz jq
COPY node-bootstrap.sh /
ENTRYPOINT ["/node-bootstrap.sh"]
CMD []
