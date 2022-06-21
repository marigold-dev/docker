#! /usr/bin/env bash

set -euo pipefail

version="$1"
profile="$2"
repository="$3"
build="$4"

git clone -b $version --single-branch $repository
cd tezos
# git checkout $version

export OPAMYES="true"
# Disable usage of instructions from the ADX extension to avoid incompatibility
# with old CPUs, see https://gitlab.com/dannywillems/ocaml-bls12-381/-/merge_requests/135/
export BLST_PORTABLE="yes"
wget https://sh.rustup.rs/rustup-init.sh
chmod +x rustup-init.sh
./rustup-init.sh --profile minimal --default-toolchain 1.52.1 -y
source "$HOME/.cargo/env"

opam init --bare --disable-sandboxing
make build-deps
eval "$(opam env)" && PROFILE="$profile" make $build
chmod +x tezos-*
cp tezos-* /bin/