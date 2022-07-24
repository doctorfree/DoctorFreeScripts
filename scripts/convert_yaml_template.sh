#!/bin/bash
#
# convert_yaml_template - set values in a YAML template
#    converts a YAML template named template.yaml to final.yaml
#    with template variables replaced by values in final
#    also demonstrates how to add a file's contents
#
# from https://www.starkandwayne.com/blog/bashing-your-yaml
#
# Example YAML template named template.yaml:
# ----
# # ${sample}
# nats:
#   password: "${nats_password}"
#   username: '${nats_username}'
#   machines: ${nats_machines}
#
# Another example YAML template named template.yaml:
# ---
# # ${sample}
# nats:
#   password: "${nats_password}"
#   username: '${nats_username}'
#   machines: ${nats_machines}
# bosh_exporter:
#   bosh:
#     ca_cert: |
# $(awk '{printf "      %s\n", $0}' < cert.pem)
#
# With file cert.pem:
# --- BEGIN ---
# Four score and seven
# beers ago, our forefathers
# ....
# --- END ---
#
# Running convert_yaml_template produces a final.yaml that looks like:
#
# ---
# Hello Yaml!
# nats:
#   password: "password"
#   username: 'nats'
#   machines: 10.2.3.4
# bosh_exporter:
#   bosh:
#     ca_cert: |
#       --- BEGIN ---
#       Four score and seven
#       beers ago, our forefathers
#       ....
#       --- END ---

export sample="Hello Yaml!"
export nats_machines="10.2.3.4"
export nats_username="nats"
export nats_password="password"
rm -f final.yaml temp.yaml

# Here is the secret sauce
( echo "cat <<EOF >final.yaml";
  cat template.yaml;
  echo "EOF";
) >temp.yaml
. temp.yaml
cat final.yaml

