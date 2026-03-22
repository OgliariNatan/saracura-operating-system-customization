#!/bin/bash
## Script para instalar programas básicos - Saracura Linux (KDE)
## Para uso DENTRO DO CUBIC (chroot)
## Autor: @OgliariNatan
## Última Atualização: 03/2026
##################################################################

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Execute este script como root: sudo bash $0"
    exit 1
fi

echo "==========================================="
echo "=== Iniciando a Instalação de Programas ==="
echo "=== Saracura OS - KDE Plasma            ==="
echo "=== Para uso com Cubic                  ==="
echo "=== @OgliariNatan                        ==="
echo "==========================================="

# Função para instalar e verificar
instalar() {
    echo ""
    echo ">>> Instalando: $@"
    apt install -y "$@"
    if [ $? -eq 0 ]; then
        echo "✅ $@ instalado com sucesso"
    else
        echo "❌ Falha ao instalar $@"
    fi
}

# ========================
# ATUALIZAR REPOSITÓRIOS
# ========================
echo ""
echo "=== ATUALIZANDO REPOSITÓRIOS ==="
apt update

# ========================
# UTILITÁRIOS BÁSICOS
# ========================
echo ""
echo "=== UTILITÁRIOS BÁSICOS ==="
instalar wget curl net-tools htop openssh-server

# ========================
# KDE PLASMA
# ========================
echo ""
echo "=== KDE PLASMA ==="
instalar kde-standard sddm plasma-workspace plasma-desktop \
    konsole dolphin kdeconnect kde-spectacle okular ark gwenview

# Define SDDM como display manager padrão
echo ">>> Configurando SDDM como display manager padrão"
echo "sddm sddm/daemon select sddm" | debconf-set-selections
dpkg-reconfigure -f noninteractive sddm 2>/dev/null || true

# ========================
# MULTIMÍDIA E EDUCAÇÃO
# ========================
echo ""
echo "=== MULTIMÍDIA E EDUCAÇÃO ==="
instalar tuxpaint vlc gimp

# ========================
# ANYDESK
# ========================
echo ""
echo "=== ANYDESK ==="
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg
echo "deb http://deb.anydesk.com/ all main" | tee /etc/apt/sources.list.d/anydesk-stable.list
apt update
instalar anydesk

# ========================
# GOOGLE CHROME
# ========================
echo ""
echo "=== GOOGLE CHROME ==="
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-signing-key.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
apt update
instalar google-chrome-stable

# ========================
# ONLYOFFICE
# ========================
echo ""
echo "=== ONLYOFFICE ==="
mkdir -p /usr/share/keyrings
gpg --no-default-keyring --keyring /usr/share/keyrings/onlyoffice.gpg \
    --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5 || true
echo "deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main" \
    | tee /etc/apt/sources.list.d/onlyoffice.list
apt update
instalar onlyoffice-desktopeditors

# ========================
# DRIVERS DE IMPRESSORAS
# ========================
echo ""
echo "=== DRIVERS DE IMPRESSORAS ==="
instalar printer-driver-all foomatic-db-engine hp-ppd openprinting-ppds

# ========================
# JAVA
# ========================
echo ""
echo "=== JAVA ==="
instalar default-jre default-jdk

# ========================
# ZOOM
# ========================
echo ""
echo "=== ZOOM ==="
wget -q https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom.deb
apt install -y /tmp/zoom.deb || apt install -f -y
rm -f /tmp/zoom.deb

# ========================
# ASSINADOR DIGITAL SERPRO
# ========================
echo ""
echo "=== ASSINADOR DIGITAL SERPRO ==="
curl -fsSL https://assinadorserpro.estaleiro.serpro.gov.br/downloads/instalar.sh | bash \
    || echo "⚠️ SERPRO falhou - instalar manualmente após a instalação"

# ========================
# LIMPEZA
# ========================
echo ""
echo "=== LIMPEZA ==="
apt autoremove -y
apt autoclean -y
apt clean -y

echo ""
echo "==========================================="
echo "=== ✅ Instalação de programas concluída ==="
echo "=== Agora execute: pos-instalacao.sh     ==="
echo "==========================================="