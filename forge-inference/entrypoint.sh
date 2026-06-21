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

# The base image puts the binary at /app/llama-server and does NOT add /app to PATH.
LLAMA_BIN="$(command -v llama-server || true)"
[ -n "$LLAMA_BIN" ] || LLAMA_BIN=/app/llama-server

echo "[forge-inference] serving baked model (ngl=${NGL:-99} ctx=${CTX_SIZE:-8192} parallel=${PARALLEL:-1} kv=${KV_QUANT:-fp16}) via $LLAMA_BIN"
echo "[forge-inference] $($LLAMA_BIN --version 2>&1 | head -1 || echo 'version probe failed')"

# DEBUG_HOLD (set via env only when debugging): if llama-server exits, keep the
# container alive so its logs can be retrieved. Prod leaves it unset → plain exec.
if [ -n "${DEBUG_HOLD:-}" ]; then
  set +e
  "$LLAMA_BIN" "${ARGS[@]}"
  echo "[forge-inference] llama-server exited code=$? — holding 30m for inspection"
  sleep 1800
else
  exec "$LLAMA_BIN" "${ARGS[@]}"
fi
