# Hytale Server Docker

This repository contains a Docker setup for running a Hytale Server.

## Quick Start

1. **Start the Server:**

    ```bash
    docker run -d --name hytale_server -p 5520:5520/udp -v./data:/hytale ghcr.io/quantumsheep/hytale-docker:latest
    ```

    You can also use [`docker-compose`](https://github.com/quantumsheep/hytale-docker/blob/main/docker-compose.yml):

    ```bash
    docker-compose up -d
    ```

2. **Authentication (First Run Only):**
    On the first run, you need to authenticate the server.
    Attach to the container's console to see the auth code:

    ```bash
    docker attach hytale_server
    ```

    Type `/auth persistence Encrypted` in the console.

    Once the "Credential storage changed to: Encrypted" message appears, you need to login.

    Type `/auth login device` in the console.

    Follow the instructions on the screen (visit the URL and enter the code).
    Once authenticated, you can detach (usually `Ctrl+P`, `Ctrl+Q`).

## Persistence

Server data (world, config, logs) is stored in the `/hytale` directory inside the container.

## Ports

The server listens on **UDP port 5520**. Ensure this port is forwarded if you are behind a router.

You can change the port using the `PORT` environment variable.
