FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b as builder

WORKDIR /app

ARG PLAYIT_VERSION=0.15.9

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-linux-$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "aarch64")" && \
    chmod u+x playit

FROM debian:bookworm-slim@sha256:d02c76d82364cedca16ba3ed6f9102406fa9fa8833076a609cabf14270f43dfc

WORKDIR /app

COPY entrypoint.sh /app/

COPY --from=builder /app/playit /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT [ "/app/entrypoint.sh" ]
