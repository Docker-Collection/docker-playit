FROM alpine@sha256:82d1e9d7ed48a7523bdebc18cf6290bdb97b82302a8a9c27d4fe885949ea94d1 as builder

WORKDIR /app

ARG PLAYIT_VERSION=0.9.3

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-${PLAYIT_VERSION}$([[ "$(uname -m)" == "x86_64" ]] && echo "" || echo "-aarch64")" && \
    chmod u+x playit

FROM debian:bookworm-slim@sha256:89468107e4c2b9fdea2f15fc582bf92c25aa4296a661ca0202f7ea2f4fc3f48c

WORKDIR /app

COPY entrypoint.sh /app/

COPY --from=builder /app/playit /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT [ "/app/entrypoint.sh" ]
