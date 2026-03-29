#!/bin/sh
set -eu

src="$HOME/.local/share/chezmoi"
dst="$HOME/.ssh"

mkdir -p "$dst"

if [ ! -f "$dst/id_ed25519" ] && [ -f "$src/encrypted_private_id_ed25519.asc" ]; then
  echo "Descifrando id_ed25519..."
  gpg --decrypt "$src/encrypted_private_id_ed25519.asc" > "$dst/id_ed25519"
  chmod 600 "$dst/id_ed25519"
  echo "id_ed25519 restaurada."
fi

if [ ! -f "$dst/id_rsa" ] && [ -f "$src/encrypted_private_id_rsa.asc" ]; then
  echo "Descifrando id_rsa..."
  gpg --decrypt "$src/encrypted_private_id_rsa.asc" > "$dst/id_rsa"
  chmod 600 "$dst/id_rsa"
  echo "id_rsa restaurada."
fi

echo "Claves SSH privadas listas para usar."

