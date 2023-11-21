FROM alpine@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978 as builder

WORKDIR /builder

ARG PLAYIT_VERSION=1.0.0-rc3

COPY entrypoint.sh /builder/

RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/download/v${PLAYIT_VERSION}/playit-${PLAYIT_VERSION}$([[ "$(uname -m)" == "x86_64" ]] && echo "" || echo "-aarch64")" && \
    chmod u+x playit

RUN chmod +x entrypoint.sh

FROM bitnami/minideb:bullseye@sha256:b9e6eded5e67bc932a85cd0a266dd89958e26d6f081f684615c896a8fef92341

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN groupadd -g 1000 nonroot && \
    useradd -u 1000 -g nonroot -s /bin/bash nonroot

COPY --from=builder --chown=nonroot /builder/ /app/

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

USER nonroot

ENTRYPOINT [ "/app/entrypoint.sh" ]
