FROM alpine@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5 as builder

WORKDIR /builder

ARG PLAYIT_VERSION=1.0.0-rc3

COPY entrypoint.sh /builder/

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-${PLAYIT_VERSION}$([[ "$(uname -m)" == "x86_64" ]] && echo "" || echo "-aarch64")" && \
    chmod u+x playit

RUN chmod +x entrypoint.sh

FROM bitnami/minideb:bullseye@sha256:3b2e0870aa3f5cdbea6f51dd1673945e7c7be28a9dec2490e4f7ec41079b6bf4

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN groupadd -g 1000 nonroot && \
    useradd -u 1000 -g nonroot -s /bin/bash nonroot

COPY --from=builder --chown=nonroot /builder/ /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

USER nonroot

ENTRYPOINT [ "/app/entrypoint.sh" ]
