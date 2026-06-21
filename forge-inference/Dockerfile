# forge-inference — self-contained inference image with the model BAKED IN.
#
# Built once per model in CI: the GGUF is downloaded at BUILD time and baked into
# the image, so a rented Vast GPU has zero runtime dependency on HuggingFace — it
# just pulls this image and serves. Published per model as
# ghcr.io/kandiforge/forge-<name>. Consumed by KandiForge/servers (api/lib/vast/*).
#
# Build args select which GGUF gets baked in:
#   MODEL_HF_REPO / MODEL_HF_FILE   (build-time download source)

FROM ghcr.io/ggml-org/llama.cpp:server-cuda
LABEL org.opencontainers.image.source=https://github.com/KandiForge/distribution

ARG MODEL_HF_REPO
ARG MODEL_HF_FILE

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /models
# Bake the weights in at build time (one-time, in CI) — never downloaded at boot.
RUN test -n "$MODEL_HF_REPO" && test -n "$MODEL_HF_FILE" \
    && curl -fSL --retry 5 --retry-delay 10 -o model.gguf \
       "https://huggingface.co/${MODEL_HF_REPO}/resolve/main/${MODEL_HF_FILE}" \
    && ls -lh model.gguf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
