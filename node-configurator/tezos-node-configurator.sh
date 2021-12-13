#!/bin/sh

set -ex

bin_dir="/usr/local/bin"

data_dir="/var/run/tezos"
node_dir="$data_dir/node"
client_dir="$data_dir/client"
node="$bin_dir/tezos-node"
node_data_dir="$node_dir/data"

echo "Writing custom configuration for public node\n"
# why hard-code this file ?
# Reason 1: we could regenerate it from scratch with cli but it requires doing tezos-node config init or tezos-node config reset, depending on whether this file is already here
# Reason 2: the --connections parameter automatically puts the number of minimal connections to half that of expected connections, resulting in logs spewing "Not enough connections (2)" all the time. Hard-coding the config file solves this.

rm -rvf ${node_dir}/data/config.json
mkdir -p ${node_dir}/data
cat << EOF > ${node_dir}/data/config.json
{ "data-dir": "/var/run/tezos/node/data",
  "network": "$TEZOS_NETWORK",
  "rpc":
    {
      "listen-addrs": [ ":8732", "0.0.0.0:8732" ],
      "acl":
        [ { "address": ":8732", "blacklist": [] },
          { "address": "0.0.0.0:8732", "blacklist": [
            "POST /injection/**",
            "GET /network/**",
            "GET /workers/**",
            "GET /worker/**",
            "GET /stats/**",
            "GET /config/**",
            "GET /chains/main/blocks/[0-9A-Za-z]+/helpers/(baking|endorsing)_rights",
            "GET /helpers/(baking|endorsing)_rights",
          ] } 
        ]
    },
  "p2p":
    { "limits":
        { "connection-timeout": 10, "min-connections": 25,
          "max-connections": 75, "max_known_points": [ 400, 300 ],
          "max_known_peer_ids": [ 400, 300 ] } },
  "shell": { "chain_validator": { "bootstrap_threshold": 1 },
             "history_mode": "$HISTORY_MODE" } }
EOF

cat ${node_dir}/data/config.json

# Generate a new identity if not present
if [ ! -f "$node_data_dir/identity.json" ]; then
    echo "Generating a new node identity..."
    exec "${node}" identity generate "${IDENTITY_POW:-26}". \
            --data-dir "$node_data_dir"
fi
