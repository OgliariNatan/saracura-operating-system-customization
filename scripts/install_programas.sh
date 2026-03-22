#!/bin/bash
## Script para instalar programas básicos - Saracura Linux (KDE)
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
echo "=== @OgliariNatan                        ==="
echo "==========================================="

# Função para instalar e verificar
instalar() {
    echo ""
    echo ">>> Instalando: $1"
    apt install -y $1
    if [ $? -eq 0 ]; then
        echo "✅ $1 instalado com sucesso"
    else
        echo "❌ Falha ao instalar $1"
    fi
}

# ========================
# UTILITÁRIOS BÁSICOS
# ========================
echo ""
echo "=== UTILITÁRIOS BÁSICOS ==="
instalar "wget"
instalar "curl"
instalar "net-tools"
instalar "htop"
instalar "openssh-server"

# ========================
# KDE PLASMA
# ========================
echo ""
echo "=== KDE PLASMA ==="
instalar "kde-full"
instalar "kdeconnect"
instalar "sddm"

# Define SDDM como display manager padrão
echo ">>> Configurando SDDM como display manager padrão"
echo "sddm sddm/daemon select sddm" | debconf-set-selections
dpkg-reconfigure -f noninteractive sddm

# ========================
# MULTIMÍDIA E EDUCAÇÃO
# ========================
echo ""
echo "=== MULTIMÍDIA E EDUCAÇÃO ==="
instalar "tuxpaint"
instalar "vlc"
instalar "gimp"

# ========================
# ANYDESK
# ========================
echo ""
echo "=== ANYDESK ==="
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg
echo "deb http://deb.anydesk.com/ all main" | tee /etc/apt/sources.list.d/anydesk-stable.list
apt update
instalar "anydesk"

# ========================
# GOOGLE CHROME
# ========================
echo ""
echo "=== GOOGLE CHROME ==="
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-signing-key.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
apt update
instalar "google-chrome-stable"

# ========================
# ONLYOFFICE
# ========================
echo ""
echo "=== ONLYOFFICE ==="
mkdir -p /usr/share/keyrings
gpg --no-default-keyring --keyring /usr/share/keyrings/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
echo "deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main" | tee /etc/apt/sources.list.d/onlyoffice.list
apt update
instalar "onlyoffice-desktopeditors"

# ========================
# DRIVERS DE IMPRESSORAS
# ========================
echo ""
echo "=== DRIVERS DE IMPRESSORAS ==="
instalar "printer-driver-all foomatic-db-engine hp-ppd openprinting-ppds"

# ========================
# JAVA
# ========================
echo ""
echo "=== JAVA ==="
instalar "default-jre"
instalar "default-jdk"

# ========================
# ZOOM
# ========================
echo ""
echo "=== ZOOM ==="
wget -q https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom.deb
apt install -y /tmp/zoom.deb
apt install -f -y
rm -f /tmp/zoom.deb

# ========================
# ASSINADOR DIGITAL SERPRO
# ========================
echo ""
echo "=== ASSINADOR DIGITAL SERPRO ==="
curl -fsSL https://assinadorserpro.estaleiro.serpro.gov.br/downloads/instalar.sh | bash

# ========================
# CONFIGURAÇÃO DO SARACURA OS
# ========================
echo ""
echo "=== CONFIGURAÇÕES SARACURA OS ==="

# Cria diretório de configuração
mkdir -p /etc/saracura

# Copia o script de patrimônio para o sistema
cp config/patrimonio/registrar_patrimonio.sh /usr/local/bin/registrar_patrimonio.sh
chmod +x /usr/local/bin/registrar_patrimonio.sh

# Copia o autostart para todos os usuários
mkdir -p /etc/xdg/autostart
cp config/autostart/saracura-primeiro-login.desktop /etc/xdg/autostart/

# Copia wallpaper
if [ -f resources/wallpapers/logo_PP_saracura_TROCA.png ]; then
    cp resources/wallpapers/logo_PP_saracura_TROCA.png /usr/share/backgrounds/
fi

# Permite que o script use sudo sem senha para comandos específicos
cat > /etc/sudoers.d/saracura-patrimonio <<SUDOERS
# Permite registro de patrimônio sem senha
ALL ALL=(root) NOPASSWD: /usr/bin/mkdir -p /etc/saracura
ALL ALL=(root) NOPASSWD: /usr/bin/tee /etc/saracura/patrimonio.conf
ALL ALL=(root) NOPASSWD: /usr/bin/hostnamectl set-hostname *
ALL ALL=(root) NOPASSWD: /usr/bin/dmidecode *
ALL ALL=(root) NOPASSWD: /usr/bin/sed -i * /etc/hosts
SUDOERS
chmod 440 /etc/sudoers.d/saracura-patrimonio

# ========================
# ATUALIZAÇÃO FINAL
# ========================
echo ""
echo "=== ATUALIZAÇÃO DO SISTEMA ==="
apt update
apt upgrade -y
apt autoremove -y
apt autoclean -y
apt clean -y

echo ""
echo "==========================================="
echo "=== ✅ Instalação concluída com sucesso ==="
echo "=== Reinicie o sistema para usar o KDE  ==="
echo "==========================================="