FROM fluent/fluentd:v1.14-debian

USER root

RUN apt-get update && apt-get install build-essential g++ --yes && apt-get autoremove --yes

RUN fluent-gem install fluent-plugin-grafana-loki \ 
    && fluent-gem install fluent-plugin-parser-cri --no-document \
    && fluent-gem install fluent-plugin-kubernetes_metadata_filter \
    && fluent-gem install fluent-plugin-multi-format-parser

USER fluent
