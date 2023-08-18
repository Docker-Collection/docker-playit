FROM alpine@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a as builder

WORKDIR /builder

ARG PLAYIT_VERSION=1.0.0-rc3

COPY entrypoint.sh /builder/

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-${PLAYIT_VERSION}$([[ "$(uname -m)" == "x86_64" ]] && echo "" || echo "-aarch64")" && \
    chmod u+x playit

RUN chmod +x entrypoint.sh

FROM bitnami/minideb:bullseye@sha256:45244c4b85a35ca9aba6a3f392ba6ac4e92aaf5cc51d7a95e9fa5faff3a77701

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN groupadd -g 1000 nonroot && \
    useradd -u 1000 -g nonroot -s /bin/bash nonroot

COPY --from=builder --chown=nonroot /builder/ /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

USER nonroot

ENTRYPOINT [ "/app/entrypoint.sh" ]
