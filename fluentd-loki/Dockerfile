FROM fluent/fluentd:v1.14-debian

USER root

RUN fluent-gem install fluent-plugin-grafana-loki \ 
    && fluent-gem install fluent-plugin-kubernetes_metadata_filter \
    && fluent-gem install fluent-plugin-multi-format-parser \
    && fluent-gem install fluent-plugin-parser-cri --no-document

USER fluent
