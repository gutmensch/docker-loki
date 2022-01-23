ARG LOKI_VERSION=2.4.2

FROM grafana/loki:$LOKI_VERSION

ARG LOKI_UID=2030
ARG LOKI_GID=2030

USER root

RUN apk update \
  && apk --no-cache add shadow findutils \
  && usermod -u $LOKI_UID loki \
  && groupmod -g $LOKI_GID loki \
  && sh -c "find / -uid 10001 -exec chown ${LOKI_UID}:${LOKI_GID} {} \; || true"

VOLUME ["/loki"]

USER $LOKI_UID
