# Docker playit.gg

This is for docker playit.gg program, inside the container!

## Docker Compose Beta

Here is beta version of playit.gg container, please follow the step to setup connection.

```yaml
version: '3'

services:
  playit:
    container_name: playit
    image: ghcr.io/docker-collection/payit-beta:latest
    restart: always
    volumes:
      - ./config:/app/config
```

1. First copy the docker compose.

2. Create config folder and setup permission
   ```bash
   mkdir config
   sudo chown 1000:1000 config/
   ```

3. Start container with ``docker compose up -d``, you can see ``docker compose logs`` it is sleeping, because current not have secret.

4. Run ``docker compose exec playit ./playit --secret_path config/playit.toml`` and follow step to setup, after you see is connected, you can Crtl+C to close it.

5. Restart container, and it should connect!
   ```bash
   docker compose down
   docker compose up -d
   ```

## Docker Compose Latest (Host)

For docker compose, the network use host to get all local address!

```yaml
version: "3"

services:
  playit:
    container_name: playit
    image: ghcr.io/docker-collection/payit:latest
    network_mode: host
    restart: always
    volumes:
      - "./config:/app/config"
```

## Docker Compose Latest (Pterodactyl)

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
    image: ghcr.io/docker-collection/payit:latest
    networks:
      - pterodactyl_network
    restart: always
    volumes:
      - "./config:/app/config"
```

## Reference

- [mafen/playit-docker](https://github.com/mafen/playit-docker)
