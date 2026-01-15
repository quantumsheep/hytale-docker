#!/bin/sh
set -e

echo "Configuring /etc/machine-id..."
head -c 16 /dev/urandom | xxd -p > /etc/machine-id

echo "Starting Hytale Server..."
java \
    -XX:AOTCache=/usr/local/hytale/HytaleServer.aot \
    -jar /usr/local/hytale/HytaleServer.jar \
    --assets /usr/local/hytale/Assets.zip \
    --bind "$ADDRESS:$PORT" \
    "$@"
