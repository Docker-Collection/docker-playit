FROM alpine@sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126 as builder

WORKDIR /app

ARG PLAYIT_VERSION=0.9.3

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-${PLAYIT_VERSION}$([[ "$(uname -m)" == "x86_64" ]] && echo "" || echo "-aarch64")" && \
    chmod u+x playit

FROM debian:bookworm-slim@sha256:e69f8a9d5a883a890b70a7e8b6b7cb0ebb60bf1779f64064b89b43a1bb65e346

WORKDIR /app

COPY entrypoint.sh /app/

COPY --from=builder /app/playit /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT [ "/app/entrypoint.sh" ]
