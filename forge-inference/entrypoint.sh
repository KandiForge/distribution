#!/usr/bin/env bash
# forge-inference entrypoint: fetch a GGUF, verify it, serve it OpenAI-style.
#
# Env (passed by the on/off helper when it rents the instance). NOTE: Vast's env
# field splits on spaces, so every value here MUST be a single token (no spaces).
#   INSTANCE_SECRET   required. Bearer token llama.cpp requires on every request.
#   NGL               optional. GPU layers to offload (default 99 = all; it's a GPU box).
#   CTX_SIZE          optional. Context window (default 8192).
#
#   Weight source — ONE of:
#   (a) HuggingFace (public, used for placeholder base models):
#       MODEL_HF_REPO   e.g. Qwen/Qwen2.5-Coder-32B-Instruct-GGUF
#       MODEL_HF_FILE   e.g. qwen2.5-coder-32b-instruct-q4_k_m.gguf
#   (b) Direct URL (used for our own fine-tune weights, e.g. signed R2/S3 URL):
#       MODEL_URL       a fully-qualified download URL
#       MODEL_SHA256    optional but recommended: verified before serving
set -euo pipefail

: "${INSTANCE_SECRET:?INSTANCE_SECRET is required}"
MODEL_PATH="/models/model.gguf"

if [[ -n "${MODEL_URL:-}" ]]; then
  SRC="$MODEL_URL"
elif [[ -n "${MODEL_HF_REPO:-}" && -n "${MODEL_HF_FILE:-}" ]]; then
  SRC="https://huggingface.co/${MODEL_HF_REPO}/resolve/main/${MODEL_HF_FILE}"
else
  echo "FATAL: set MODEL_URL, or MODEL_HF_REPO + MODEL_HF_FILE" >&2
  exit 1
fi

echo "[forge-inference] downloading: ${SRC}"
curl -fSL --retry 5 --retry-delay 5 -o "$MODEL_PATH" "$SRC"

if [[ -n "${MODEL_SHA256:-}" ]]; then
  echo "[forge-inference] verifying sha256…"
  echo "${MODEL_SHA256}  ${MODEL_PATH}" | sha256sum -c -
fi

echo "[forge-inference] starting llama-server (ngl=${NGL:-99} ctx=${CTX_SIZE:-8192})"
exec llama-server \
  --host 0.0.0.0 --port 8080 \
  --api-key "$INSTANCE_SECRET" \
  -m "$MODEL_PATH" \
  --n-gpu-layers "${NGL:-99}" \
  --ctx-size "${CTX_SIZE:-8192}"
