# Docker Playit.gg

This is for docker playit.gg program, inside the container!

## Docker Compose (Host)

For docker compose, the network use host to get all local address!

```yaml
version: "3"

services:
  playit:
    container_name: playit
    image: ghcr.io/docker-collection/payit
    network_mode: host
    restart: always
    volumes:
      - "./config:/app/config"
```

## Docker Compose (Pterodactyl)

For docker compose, the network uses pterodactyl local network to connect wings deploy the container.

```yaml
version: "3"

networks:
  pterodactyl_network:
    name: pterodactyl_nw
    external: true

services:
  playit:
    container_name: playit
    image: ghcr.io/docker-collection/payit
    networks:
      - pterodactyl_network
    restart: always
    volumes:
      - "./config:/app/config"
```

## Reference

- [mafen/playit-docker](https://github.com/mafen/playit-docker)
