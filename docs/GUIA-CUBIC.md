# Guia de Personalização da ISO com Cubic - Saracura OS

## O que é o Cubic?

Cubic (Custom Ubuntu ISO Creator) é uma ferramenta gráfica que permite criar uma ISO personalizada do Ubuntu. Ele abre um terminal chroot dentro da ISO, onde você pode instalar/remover pacotes e modificar configurações.

## Pré-requisitos

```bash
sudo apt-add-repository universe
sudo apt-add-repository ppa:cubic-wizard/release
sudo apt update
sudo apt install cubic
```

- ISO do Ubuntu 24.04 LTS Desktop (amd64)
- Pelo menos 20GB de espaço livre em disco
- Conexão com a internet (para baixar pacotes no chroot)

## Passo a Passo

### 1. Abrir o Cubic

```bash
sudo cubic
```

- Selecione um **diretório de projeto** (ex: `~/cubic-saracura`)
- Selecione a **ISO do Ubuntu 24.04 LTS Desktop**
- Clique em **Next**

### 2. Copiar o projeto para dentro do chroot

O Cubic permite arrastar e soltar arquivos na janela do terminal. Copie todo o projeto para `/tmp/saracura/`:

```bash
# Dentro do Cubic, crie o diretório
mkdir -p /tmp/saracura
```

**Arraste as pastas para `/tmp/saracura/` no Cubic:**
- `scripts/`
- `config/`
- `resources/` (contém wallpapers/, bgrt-fallback/, watermark/)

A estrutura dentro do Cubic deve ficar assim:
```
/tmp/saracura/
├── scripts/
│   ├── remove_programas.sh
│   ├── install_programas.sh
│   └── pos-instalacao.sh
├── config/
│   ├── autostart/saracura-primeiro-login.desktop
│   ├── kde/kdeglobals
│   ├── kde/kwinrc
│   ├── patrimonio/registrar_patrimonio.sh
│   ├── sddm/sddm.conf
│   └── sudoers.d/saracura-patrimonio
└── resources/
    ├── bgrt-fallback/bgrt-fallback.png
    ├── wallpapers/logo_PP_saracura_TROCA.png
    └── watermark/watermark.png
```

### 3. Executar os scripts na ordem

```bash
# 1. Remover programas desnecessários (GNOME, LibreOffice, etc.)
bash /tmp/saracura/scripts/remove_programas.sh

# 2. Instalar KDE Plasma + programas
bash /tmp/saracura/scripts/install_programas.sh

# 3. Pós-instalação (imagens, configurações, branding)
bash /tmp/saracura/scripts/pos-instalacao.sh /tmp/saracura
```

### 4. Verificar se tudo foi instalado

```bash
# Wallpapers
ls -la /usr/share/backgrounds/saracura/

# Tela de boot (Plymouth)
ls -la /usr/share/plymouth/themes/spinner/bgrt-fallback.png

# Watermark na tela de login (SDDM)
ls -la /usr/share/sddm/themes/breeze/watermark.png

# Script de patrimônio
ls -la /usr/local/bin/registrar_patrimonio.sh

# Autostart
ls -la /etc/xdg/autostart/saracura-primeiro-login.desktop

# Configurações KDE para novos usuários
ls -la /etc/skel/.config/kdeglobals
ls -la /etc/skel/.config/kwinrc

# Branding
cat /etc/os-release
cat /etc/saracura/release
```

### 5. Finalizar no Cubic

- Clique em **Next**
- Na tela de **Packages**, remova pacotes extras se desejar
- Clique em **Next**
- Na tela de boot, altere "Ubuntu" para "Saracura OS" se desejado
- Clique em **Generate** para criar a ISO

### 6. Gravar no Pendrive

```bash
# Substitua /dev/sdX pelo seu dispositivo USB
sudo dd if=~/cubic-saracura/saracura-os-1.0-amd64.iso of=/dev/sdX bs=4M status=progress sync
```

## Onde cada imagem aparece

| Recurso | Origem no projeto | Destino no sistema | Quando aparece |
|---|---|---|---|
| **bgrt-fallback** | `resources/bgrt-fallback/` | `/usr/share/plymouth/themes/spinner/bgrt-fallback.png` | **Boot** (logo Plymouth) |
| **wallpapers** | `resources/wallpapers/` | `/usr/share/backgrounds/saracura/` | **Área de trabalho** KDE |
| **watermark** | `resources/watermark/` | `/usr/share/sddm/themes/breeze/watermark.png` | **Tela de login** SDDM |

## Tamanhos recomendados das imagens

| Imagem | Tamanho recomendado | Formato |
|---|---|---|
| bgrt-fallback | 300x300 px (centralizado) | PNG |
| wallpaper | 1920x1080 px (ou 4K) | PNG ou JPG |
| watermark | 200x50 px (logo pequeno) | PNG com transparência |

## Fluxo após a instalação

```
Boot → bgrt-fallback (Plymouth)
  ↓
Login → watermark + wallpaper (SDDM)
  ↓
Primeiro login → kdialog pede nº de patrimônio
  ↓
Área de trabalho → wallpaper + configs KDE
```