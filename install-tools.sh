#!/usr/bin/env bash
TARGETPLATFORM=$1
declare VARIANT
 if [ "$TARGETPLATFORM" = "linux/arm64" ]; then
     VARIANT="arm64"
    else
     VARIANT="x86_64"
    fi
echo $VARIANT
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-"${VARIANT}".tar.gz
tar -xvf nvim-linux-"${VARIANT}".tar.gz
mv nvim-linux-"${VARIANT}"/bin/nvim /usr/local/bin/
cp -r nvim-linux-"${VARIANT}"/share/nvim/runtime /usr/local/share/nvim


LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_"${VARIANT}".tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit -D -t /usr/local/bin/
