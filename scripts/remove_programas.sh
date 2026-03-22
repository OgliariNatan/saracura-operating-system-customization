#!/bin/bash
## Script para remover programas padrões do Ubuntu 24.04 LTS
## Autor: @OgliariNatan
## Última Atualização: 03/2026
##################################################################

if [ "$EUID" -ne 0 ]; then
    echo "❌ Execute como root: sudo bash $0"
    exit 1
fi

echo "=== Removendo programas desnecessários ==="

# Suíte de escritório (será substituída pelo OnlyOffice)
apt remove --purge libreoffice* -y

# Cliente de e-mail
apt remove --purge thunderbird -y

# Acesso remoto (será substituído pelo AnyDesk)
apt remove --purge remmina -y

# GNOME (será substituído pelo KDE)
echo "=== Removendo componentes GNOME ==="
apt remove --purge gnome-shell -y
apt remove --purge gdm3 -y
apt remove --purge ubuntu-desktop -y

apt autoremove -y
apt autoclean -y

echo "=== ✅ Remoção concluída ==="