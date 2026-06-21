#!/usr/bin/env bash
# Serve the BAKED-IN model. No runtime download — the GGUF is already at
# /models/model.gguf (baked at build time). Single-token env only (Vast splits the
# env field on spaces).
#   INSTANCE_SECRET  required. Bearer token llama.cpp requires on every request.
#   NGL              GPU layers to offload (default 99 = all; it's a GPU box).
#   CTX_SIZE         total context across all slots (default 8192).
#   PARALLEL         concurrent slots; requests beyond this queue (default 1).
#   KV_QUANT         optional KV cache type, e.g. q8_0 (fits more sessions).
set -euo pipefail

: "${INSTANCE_SECRET:?INSTANCE_SECRET is required}"
MODEL_PATH="/models/model.gguf"
[ -f "$MODEL_PATH" ] || { echo "FATAL: baked model missing at $MODEL_PATH" >&2; exit 1; }

ARGS=(--host 0.0.0.0 --port 8080 --api-key "$INSTANCE_SECRET" -m "$MODEL_PATH"
      --n-gpu-layers "${NGL:-99}" --ctx-size "${CTX_SIZE:-8192}" --parallel "${PARALLEL:-1}")
if [ -n "${KV_QUANT:-}" ]; then
  ARGS+=(--cache-type-k "$KV_QUANT" --cache-type-v "$KV_QUANT")
fi

echo "[forge-inference] serving baked model (ngl=${NGL:-99} ctx=${CTX_SIZE:-8192} parallel=${PARALLEL:-1} kv=${KV_QUANT:-fp16})"
exec llama-server "${ARGS[@]}"
