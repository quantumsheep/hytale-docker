FROM eclipse-temurin:25-jdk AS downloader

# Install necessary tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory for installation
WORKDIR /usr/local/hytale

# Download and run Hytale Downloader
# This will fetch HytaleServer.jar, Assets.zip and other necessary files into /usr/local/hytale
RUN curl -o hytale-downloader.zip https://downloader.hytale.com/hytale-downloader.zip \
    && unzip hytale-downloader.zip \
    && rm hytale-downloader.zip \
    && chmod +x hytale-downloader-linux-amd64 \
    && ./hytale-downloader-linux-amd64 -download-path game.zip \
    && unzip game.zip -d . \
    && rm game.zip hytale-downloader-linux-amd64 \
    && mv Server/* . \
    && rm -rf Server \
    && rm hytale-downloader-windows-amd64.exe QUICKSTART.md

FROM eclipse-temurin:25-jdk

# Copy Hytale server files from the builder stage
COPY --from=downloader /usr/local/hytale /usr/local/hytale

# Set working directory for runtime data
WORKDIR /hytale
VOLUME ["/hytale"]

ENV ADDRESS=0.0.0.0
ENV PORT=5520

EXPOSE 5520/udp

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
