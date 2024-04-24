FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b as builder

WORKDIR /builder

ARG PLAYIT_VERSION=1.0.0-rc3

COPY entrypoint.sh /builder/

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-${PLAYIT_VERSION}$([[ "$(uname -m)" == "x86_64" ]] && echo "" || echo "-aarch64")" && \
    chmod u+x playit

RUN chmod +x entrypoint.sh

FROM bitnami/minideb:bullseye@sha256:a9c6a602c3707131cbcbee7ee7d7f546bd4456e1ae21c01f58b26cb6c6726428

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN groupadd -g 1000 nonroot && \
    useradd -u 1000 -g nonroot -s /bin/bash nonroot

COPY --from=builder --chown=nonroot /builder/ /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

USER nonroot

ENTRYPOINT [ "/app/entrypoint.sh" ]
