FROM alpine@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978 as builder

WORKDIR /app

ARG PLAYIT_VERSION=0.15.9

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-linux-$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "aarch64")" && \
    chmod u+x playit

FROM debian:bookworm-slim@sha256:b55e2651b71408015f8068dd74e1d04404a8fa607dd2cfe284b4824c11f4d9bd

WORKDIR /app

COPY entrypoint.sh /app/

COPY --from=builder /app/playit /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT [ "/app/entrypoint.sh" ]
