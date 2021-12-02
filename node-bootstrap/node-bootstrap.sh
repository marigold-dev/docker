#!/bin/sh

set -e
set -x

bin_dir="/usr/local/bin"

data_dir="/var/run/tezos"
client_dir="$data_dir/client"
node_dir="$data_dir/node"
node_data_dir="$node_dir/data"
client="$bin_dir/tezos-client"

if [ -d ${node_dir}/data/context ]; then
    echo "Blockchain has already been bootstrapped, exiting"
    exit 0
else
    echo "Did not find pre-existing data, bootstrapping blockchain"
    mkdir -p ${node_dir}/data
    exec "${client}" bootstrapped
    find ${node_dir}
fi
