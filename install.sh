#!bin/bash



echo "Beginning install..."



ZSHRC_PATH="$HOME/.zshrc"

if test -f "$ZSHRC_PATH"; then
  mv "$ZSHRC_PATH" "$HOME/.zshrc_old"
fi
cp .zshrc "$ZSHRC_PATH"


NVIM_PATH="$HOME/.config/nvim/lua"

timestamp=$(date +%s)
if test -f "$NVIM_PATH"; then
  mv "$NVIM_PATH" "$HOME/.config/nvim_back$timestamp"
fi

cp -r neovim/custom $NVIM_PATH

echo "Installation complete."
