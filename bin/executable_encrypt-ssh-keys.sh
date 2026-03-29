#!/bin/sh
set -eu

src_dir="$HOME/.ssh"
dst_dir="$HOME/.config/chezmoi"

mkdir -p "$dst_dir"

# Identifica tu clave GPG (ajusta el correo)
RECIPIENT="AQUI email asociado al GPG"

echo "Encriptando id_ed25519..."
gpg --armor --encrypt \
  --recipient "$RECIPIENT" \
  "$src_dir/id_ed25519"

# Mueve a la carpeta de chezmoi con nombre estándar
mv "$src_dir/id_ed25519.asc" "$dst_dir/encrypted_private_id_ed25519.asc"

echo "Encriptando id_rsa..."
gpg --armor --encrypt \
  --recipient "$RECIPIENT" \
  "$src_dir/id_rsa"

mv "$src_dir/id_rsa.asc" "$dst_dir/encrypted_private_id_rsa.asc"

echo "Claves encriptadas guardadas en:"
echo "  $dst_dir/encrypted_private_id_ed25519.asc"
echo "  $dst_dir/encrypted_private_id_rsa.asc"

# Añade a chezmoi (opcional, pero recomendado)
chezmoi add "$dst_dir/encrypted_private_id_ed25519.asc"
chezmoi add "$dst_dir/encrypted_private_id_rsa.asc"

echo "Done. Run 'chezmoi cd && git commit -m \"Update encrypted SSH keys\" && git push' when ready."

