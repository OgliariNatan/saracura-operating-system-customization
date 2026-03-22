#!/bin/bash
## Script de pós-instalação - Saracura OS
## Copia recursos (wallpapers, bgrt-fallback, watermark) e configurações
## Para uso DENTRO DO CUBIC (chroot) - executar APÓS install_programas.sh
## Autor: @OgliariNatan
## Última Atualização: 03/2026
##################################################################

if [ "$EUID" -ne 0 ]; then
    echo "❌ Execute como root: sudo bash $0"
    exit 1
fi

# Diretório base do projeto (dentro do Cubic, copie o projeto para /tmp/saracura)
PROJETO_DIR="${1:-/tmp/saracura}"

if [ ! -d "$PROJETO_DIR" ]; then
    echo "❌ Diretório do projeto não encontrado: $PROJETO_DIR"
    echo "   Uso: sudo bash $0 [caminho_do_projeto]"
    echo "   No Cubic, copie a pasta do projeto para /tmp/saracura/"
    exit 1
fi

echo "==========================================="
echo "=== Pós-Instalação - Saracura OS        ==="
echo "=== Imagens, Branding e Configurações   ==="
echo "=== Projeto: $PROJETO_DIR"
echo "==========================================="

# ========================
# 1. WALLPAPERS
# ========================
echo ""
echo "=== 1. WALLPAPERS ==="
WALLPAPER_DEST="/usr/share/backgrounds/saracura"
mkdir -p "$WALLPAPER_DEST"

if [ -d "$PROJETO_DIR/resources/wallpapers" ]; then
    WALLPAPER_COUNT=$(find "$PROJETO_DIR/resources/wallpapers" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | wc -l)
    if [ "$WALLPAPER_COUNT" -gt 0 ]; then
        cp -v "$PROJETO_DIR/resources/wallpapers/"*.{png,jpg,jpeg} "$WALLPAPER_DEST/" 2>/dev/null
        echo "✅ $WALLPAPER_COUNT wallpaper(s) copiado(s) para $WALLPAPER_DEST"

        # Define o wallpaper padrão do KDE para novos usuários
        WALLPAPER_DEFAULT=$(find "$WALLPAPER_DEST" -type f \( -name "*.png" -o -name "*.jpg" \) | head -1)
        if [ -n "$WALLPAPER_DEFAULT" ]; then
            mkdir -p /etc/skel/.config
            cat > /etc/skel/.config/plasma-org.kde.plasma.desktop-appletsrc <<PLASMA_EOF
[Containments][1]
wallpaperplugin=org.kde.image

[Containments][1][Wallpaper][org.kde.image][General]
Image=file://$WALLPAPER_DEFAULT
FillMode=1
PLASMA_EOF
            echo "✅ Wallpaper padrão: $WALLPAPER_DEFAULT"
        fi
    else
        echo "⚠️ Nenhuma imagem encontrada em $PROJETO_DIR/resources/wallpapers/"
    fi
else
    echo "⚠️ Diretório wallpapers não encontrado"
fi

# ========================
# 2. BGRT-FALLBACK (Tela de boot/splash Plymouth)
# ========================
echo ""
echo "=== 2. BGRT-FALLBACK (Tela de Boot) ==="
BGRT_SRC="$PROJETO_DIR/resources/bgrt-fallback"
BGRT_DEST="/usr/share/plymouth/themes/spinner"

if [ -d "$BGRT_SRC" ]; then
    BGRT_IMG=$(find "$BGRT_SRC" -type f \( -name "*.png" -o -name "*.jpg" \) | head -1)
    if [ -n "$BGRT_IMG" ]; then
        # Backup da original
        if [ -f "$BGRT_DEST/bgrt-fallback.png" ]; then
            cp "$BGRT_DEST/bgrt-fallback.png" "$BGRT_DEST/bgrt-fallback.png.original"
            echo "📦 Backup: bgrt-fallback.png.original"
        fi

        # Copia a imagem personalizada (Plymouth espera PNG)
        cp -v "$BGRT_IMG" "$BGRT_DEST/bgrt-fallback.png"
        echo "✅ bgrt-fallback instalado em $BGRT_DEST/"

        # Também copia para o tema ubuntu-logo se existir
        if [ -d "/usr/share/plymouth/themes/ubuntu-logo" ]; then
            cp "$BGRT_IMG" "/usr/share/plymouth/themes/ubuntu-logo/bgrt-fallback.png"
            echo "✅ Copiado também para ubuntu-logo"
        fi

        # Atualiza o initramfs
        echo ">>> Atualizando initramfs..."
        update-initramfs -u 2>/dev/null || echo "⚠️ update-initramfs será executado no boot"
    else
        echo "⚠️ Nenhuma imagem encontrada em $BGRT_SRC/"
    fi
else
    echo "⚠️ Diretório bgrt-fallback não encontrado"
fi

# ========================
# 3. WATERMARK (Marca d'água na tela de login SDDM)
# ========================
echo ""
echo "=== 3. WATERMARK (Tela de Login SDDM) ==="
WATERMARK_SRC="$PROJETO_DIR/resources/watermark"
SDDM_THEME_DIR="/usr/share/sddm/themes/breeze"

if [ -d "$WATERMARK_SRC" ]; then
    WATERMARK_IMG=$(find "$WATERMARK_SRC" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.svg" \) | head -1)
    if [ -n "$WATERMARK_IMG" ]; then
        mkdir -p "$SDDM_THEME_DIR"
        cp -v "$WATERMARK_IMG" "$SDDM_THEME_DIR/watermark.png"
        echo "✅ Watermark instalada em $SDDM_THEME_DIR/"

        # Copia wallpaper também para o SDDM (background da tela de login)
        if [ -n "$WALLPAPER_DEFAULT" ] && [ -f "$WALLPAPER_DEFAULT" ]; then
            cp "$WALLPAPER_DEFAULT" "$SDDM_THEME_DIR/background.png"
            echo "✅ Background do SDDM configurado"
        fi

        # Cria configuração do tema
        cat > "$SDDM_THEME_DIR/theme.conf.user" <<THEME_EOF
[General]
background=$SDDM_THEME_DIR/background.png
type=image
THEME_EOF
        echo "✅ Tema SDDM configurado"
    else
        echo "⚠️ Nenhuma imagem encontrada em $WATERMARK_SRC/"
    fi
else
    echo "⚠️ Diretório watermark não encontrado"
fi

# ========================
# 4. CONFIGURAÇÃO DO SDDM
# ========================
echo ""
echo "=== 4. CONFIGURAÇÃO SDDM ==="
if [ -f "$PROJETO_DIR/config/sddm/sddm.conf" ]; then
    mkdir -p /etc/sddm.conf.d
    cp -v "$PROJETO_DIR/config/sddm/sddm.conf" /etc/sddm.conf.d/saracura.conf
    echo "✅ SDDM configurado em /etc/sddm.conf.d/saracura.conf"
fi

# ========================
# 5. CONFIGURAÇÕES KDE
# ========================
echo ""
echo "=== 5. CONFIGURAÇÕES KDE ==="
mkdir -p /etc/skel/.config

if [ -f "$PROJETO_DIR/config/kde/kdeglobals" ]; then
    cp -v "$PROJETO_DIR/config/kde/kdeglobals" /etc/skel/.config/kdeglobals
    echo "✅ kdeglobals → /etc/skel/.config/"
fi

if [ -f "$PROJETO_DIR/config/kde/kwinrc" ]; then
    cp -v "$PROJETO_DIR/config/kde/kwinrc" /etc/skel/.config/kwinrc
    echo "✅ kwinrc → /etc/skel/.config/"
fi

# ========================
# 6. SCRIPT DE PATRIMÔNIO
# ========================
echo ""
echo "=== 6. SCRIPT DE PATRIMÔNIO ==="
if [ -f "$PROJETO_DIR/config/patrimonio/registrar_patrimonio.sh" ]; then
    cp -v "$PROJETO_DIR/config/patrimonio/registrar_patrimonio.sh" /usr/local/bin/registrar_patrimonio.sh
    chmod +x /usr/local/bin/registrar_patrimonio.sh
    echo "✅ Script → /usr/local/bin/registrar_patrimonio.sh"
else
    echo "❌ registrar_patrimonio.sh não encontrado!"
fi

# ========================
# 7. AUTOSTART DO PRIMEIRO LOGIN
# ========================
echo ""
echo "=== 7. AUTOSTART ==="
mkdir -p /etc/xdg/autostart
if [ -f "$PROJETO_DIR/config/autostart/saracura-primeiro-login.desktop" ]; then
    cp -v "$PROJETO_DIR/config/autostart/saracura-primeiro-login.desktop" /etc/xdg/autostart/
    echo "✅ Autostart → /etc/xdg/autostart/"
fi

# ========================
# 8. SUDOERS
# ========================
echo ""
echo "=== 8. SUDOERS ==="
if [ -f "$PROJETO_DIR/config/sudoers.d/saracura-patrimonio" ]; then
    cp -v "$PROJETO_DIR/config/sudoers.d/saracura-patrimonio" /etc/sudoers.d/saracura-patrimonio
    chmod 440 /etc/sudoers.d/saracura-patrimonio
    # Valida a sintaxe do sudoers
    visudo -cf /etc/sudoers.d/saracura-patrimonio && echo "✅ Sudoers válido" || echo "❌ ERRO na sintaxe do sudoers!"
fi

# ========================
# 9. BRANDING
# ========================
echo ""
echo "=== 9. BRANDING ==="
mkdir -p /etc/saracura

cat > /etc/saracura/release <<EOF
DISTRIB_ID=SaracuraOS
DISTRIB_RELEASE=1.0
DISTRIB_CODENAME=saracura
DISTRIB_DESCRIPTION="Saracura OS 1.0 - Baseado no Ubuntu 24.04 LTS"
DISTRIB_DESKTOP=kde-plasma
BUILD_DATE=$(date '+%Y-%m-%d %H:%M:%S')
EOF

cat > /etc/os-release <<EOF
PRETTY_NAME="Saracura OS 1.0"
NAME="Saracura OS"
VERSION_ID="1.0"
VERSION="1.0 (Noble)"
VERSION_CODENAME=noble
ID=saracura
ID_LIKE=ubuntu debian
HOME_URL="https://github.com/OgliariNatan"
UBUNTU_CODENAME=noble
EOF

cat > /etc/issue <<'EOF'

  ███████╗ █████╗ ██████╗  █████╗  ██████╗██╗   ██╗██████╗  █████╗
  ██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██║   ██║██╔══██╗██╔══██╗
  ███████╗███████║██████╔╝███████║██║     ██║   ██║██████╔╝███████║
  ╚════██║██╔══██║██╔══██╗██╔══██║██║     ██║   ██║██╔══██╗██╔══██║
  ███████║██║  ██║██║  ██║██║  ██║╚██████╗╚██████╔╝██║  ██║██║  ██║
  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

  Saracura OS 1.0 - Baseado no Ubuntu 24.04 LTS
  \n \l

EOF

echo "✅ Branding configurado"

# ========================
# 10. LIMPEZA
# ========================
echo ""
echo "=== 10. LIMPEZA ==="
apt autoremove -y
apt autoclean -y
apt clean -y

echo ""
echo "==========================================="
echo "=== ✅ Pós-instalação concluída!        ==="
echo "==========================================="
echo ""
echo "Verifique:"
echo "  Wallpapers:    ls /usr/share/backgrounds/saracura/"
echo "  Boot splash:   ls /usr/share/plymouth/themes/spinner/bgrt-fallback.png"
echo "  Login SDDM:    ls /usr/share/sddm/themes/breeze/watermark.png"
echo "  Patrimônio:    ls /usr/local/bin/registrar_patrimonio.sh"
echo "  Autostart:     ls /etc/xdg/autostart/saracura-primeiro-login.desktop"
echo "  Branding:      cat /etc/os-release"
echo ""