#!/usr/bin/env bash
# forge-inference entrypoint: fetch a GGUF, verify it, serve it OpenAI-style.
#
# Env (passed by the on/off helper when it rents the instance):
#   INSTANCE_SECRET   required. Bearer token llama.cpp requires on every request.
#   LLAMA_ARGS        optional. Extra llama-server flags (ctx size, ngl, …).
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

echo "[forge-inference] starting llama-server"
# shellcheck disable=SC2086  # LLAMA_ARGS is intentionally word-split.
exec llama-server \
  --host 0.0.0.0 --port 8080 \
  --api-key "$INSTANCE_SECRET" \
  -m "$MODEL_PATH" \
  ${LLAMA_ARGS:-}
