# forge-inference — generic on-demand inference container.
#
# One image serves ANY KandiForge model: the weights are NOT baked in, they are
# fetched at boot from the source the on/off helper passes via env. A rented Vast
# GPU runs this. Consumed by KandiForge/servers (api/lib/vast/*).
#
# Published publicly to ghcr.io/kandiforge/forge-inference from THIS public repo so
# Vast can pull it anonymously. The source label below links the GHCR package to
# this public repo (which is what makes the package public).

FROM ghcr.io/ggml-org/llama.cpp:server-cuda
LABEL org.opencontainers.image.source=https://github.com/KandiForge/distribution

# curl for HuggingFace/bucket downloads; ca-certs for TLS.
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /models
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# llama.cpp server listens here; Vast maps this port to a public one.
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
