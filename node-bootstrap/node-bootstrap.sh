#!/bin/sh

set -e
set -x

bin_dir="/usr/local/bin"

data_dir="/var/run/tezos"
node_dir="$data_dir/node"
node_data_dir="$node_dir/data"
node="$bin_dir/tezos-node"

if [ -d ${node_dir}/data/context ]; then
    echo "Blockchain has already been bootstrapped, exiting"
    exit 0
else
    echo "Did not find pre-existing data, bootstrapping blockchain"
    mkdir -p ${node_dir}/data
    exec "${node}" bootstrapped --network $TEZOS_NETWORK --config-file ${node_data_dir}/config.json
    find ${node_dir}
fi
