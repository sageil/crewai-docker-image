#!/usr/bin/env bash

set -euo pipefail

TARGETPLATFORM=${1:-linux/amd64}
case "${TARGETPLATFORM}" in
  linux/arm64)
    VARIANT="arm64"
    ;;
  *)
    VARIANT="x86_64"
    ;;
esac

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${VARIANT}.tar.gz" \
  -o "${TMP_DIR}/nvim.tar.gz"
tar -xzf "${TMP_DIR}/nvim.tar.gz" -C "${TMP_DIR}"
install -m 0755 "${TMP_DIR}/nvim-linux-${VARIANT}/bin/nvim" /usr/local/bin/nvim
install -d /usr/local/share/nvim
cp -a "${TMP_DIR}/nvim-linux-${VARIANT}/share/nvim/runtime" /usr/local/share/nvim/

LAZYGIT_VERSION="$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name' | sed 's/^v//')"
if [ -z "${LAZYGIT_VERSION}" ] || [ "${LAZYGIT_VERSION}" = "null" ]; then
  echo "Unable to resolve lazygit version" >&2
  exit 1
fi
curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${VARIANT}.tar.gz" \
  -o "${TMP_DIR}/lazygit.tar.gz"
tar -xzf "${TMP_DIR}/lazygit.tar.gz" -C "${TMP_DIR}" lazygit
install -m 0755 "${TMP_DIR}/lazygit" /usr/local/bin/lazygit
