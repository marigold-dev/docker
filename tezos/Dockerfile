FROM alpine:3.12
RUN apk update
RUN apk --no-cache --virtual add rsync git m4 build-base patch unzip \
    bubblewrap wget pkgconfig gmp-dev libev-dev hidapi-dev eudev-dev perl opam libusb-dev bash \
    autoconf automake libtool linux-headers cargo libffi-dev zlib-static

COPY ./build/build-libusb-and-hidapi.sh /build-libusb-and-hidapi.sh
RUN chmod +x /build-libusb-and-hidapi.sh
RUN /build-libusb-and-hidapi.sh

ARG VERSION=master
ARG PROFILE=dev
ARG REPOSITORY=https://gitlab.com/tezos/tezos.git
ARG BUILD=build
COPY ./build/build-tezos.sh /build-tezos.sh
RUN chmod +x /build-tezos.sh
RUN /build-tezos.sh ${VERSION} ${PROFILE} ${REPOSITORY} ${BUILD}
