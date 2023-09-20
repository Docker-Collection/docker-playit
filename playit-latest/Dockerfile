FROM alpine@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a as builder

WORKDIR /app

ARG PLAYIT_VERSION=0.9.3

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-${PLAYIT_VERSION}$([[ "$(uname -m)" == "x86_64" ]] && echo "" || echo "-aarch64")" && \
    chmod u+x playit

FROM debian:bookworm-slim@sha256:c62117c632d194a6007f7b5e6c62c6613b573fa373de66ffd6811425a0f55363

WORKDIR /app

COPY entrypoint.sh /app/

COPY --from=builder /app/playit /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT [ "/app/entrypoint.sh" ]
