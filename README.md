# Saracura Operating System Customization

Personalização customizada do Ubuntu 24.04 LTS usando Cubic para criar uma ISO com aplicações e configurações personalizadas.

## 📋 Índice

- [Pré-requisitos](#pré-requisitos)
- [Instalação do Cubic](#instalação-do-cubic)
- [Processo de Customização](#processo-de-customização)
- [Remoção de Aplicações](#remoção-de-aplicações)
- [Instalação de Aplicações](#instalação-de-aplicações)
- [Personalização Visual](#personalização-visual)
- [Configuração do Dock](#configuração-do-dock)
- [Autostart de Personalizações](#autostart-de-personalizações)
- [Geração da ISO](#geração-da-iso)

## 🔧 Pré-requisitos

- Ubuntu 24.04 LTS (ou derivado)
- Acesso root/sudo
- ISO original do Ubuntu 24.04 LTS
- Espaço em disco: mínimo 20GB livres

## 📦 Instalação do Cubic

```bash
sudo apt-add-repository universe
sudo apt-add-repository ppa:cubic-wizard/release
sudo apt update
sudo apt install --no-install-recommends cubic
```

## 🚀 Processo de Customização

### 1. Iniciar o Cubic

1. Abra o Cubic
2. Selecione a ISO original do Ubuntu 24.04
3. Escolha um diretório de trabalho
4. Aguarde a extração dos arquivos

### 2. Entrar no Ambiente Chroot

Quando o terminal do Cubic abrir, você estará dentro do ambiente chroot da ISO.

## 🗑️ Remoção de Aplicações

### Remover LibreOffice

```bash
sudo apt remove --purge libreoffice* -y
sudo apt autoremove -y
sudo apt autoclean
```

## 📥 Instalação de Aplicações

### 1. Atualizar Sistema

```bash
apt update
apt upgrade -y
```

### 2. Instalar OnlyOffice Desktop Editors

```bash
sudo apt install apt-transport-https
mkdir -p -m 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg

echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee /etc/apt/sources.list.d/onlyoffice.list

apt update
apt install onlyoffice-desktopeditors -y
```

### 3. Instalar GIMP

```bash
apt install gimp -y
```

### 4. Instalar Spotify

```bash
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

apt update
apt install spotify-client -y
```

### 5. Instalar Google Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb -y
rm google-chrome-stable_current_amd64.deb
```

### 6. Instalar AnyDesk

```bash
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

apt update
apt install anydesk -y
```

## 🎨 Personalização Visual

### Logo de Inicialização (Plymouth)

1. Copie sua imagem de logo para `/usr/share/plymouth/themes/spinner/`
2. Substitua o arquivo watermark.png

```bash
# Backup do logo original
cp /usr/share/plymouth/themes/spinner/watermark.png /usr/share/plymouth/themes/spinner/watermark.png.bak

# Copie seu logo personalizado
cp /caminho/para/seu/logo.png /usr/share/plymouth/themes/spinner/watermark.png

# Atualize o initramfs
update-initramfs -u
```

### Papel de Parede

Copie o papel de parede personalizado para o diretório de wallpapers:

```bash
# Criar diretório se necessário
mkdir -p /usr/share/backgrounds/saracura/

# Copiar papel de parede
cp /caminho/para/wallpaper.jpg /usr/share/backgrounds/saracura/wallpaper.jpg

```

### Configuração será aplicada automaticamente

O papel de parede será definido automaticamente pelo arquivo de autostart configurado na próxima seção.

## 🎯 Configuração do Dock

### Criar Pasta para Configuração Automática

```bash
mkdir -p /etc/skel/.config/autostart/
```

### Criar Arquivo de Configuração

```bash
nano /etc/skel/.config/autostart/personalizacoes-saracura.desktop
```

Cole o conteúdo do arquivo [personalizacoes-saracura.desktop](personalizacoes-saracura.desktop).

### Configurações do Dock via gsettings

As configurações do dock serão aplicadas automaticamente através do arquivo de autostart `personalizacoes-saracura.desktop`:

`

## 📁 Estrutura de Arquivos

```
/etc/skel/.config/autostart/
└── personalizacoes-saracura.desktop

/usr/share/backgrounds/saracura/
└── wallpaper.jpg

/usr/share/plymouth/themes/ubuntu-logo/
└── ubuntu-logo.png
```

## 🏁 Geração da ISO

1. No Cubic, após todas as personalizações, clique em "Next"
2. Configure as informações da ISO:
   - Nome: Saracura OS
   - Versão: 24.04
   - Descrição personalizada
3. Gere a ISO
4. Teste a ISO em máquina virtual antes de usar em produção

## ✅ Checklist de Verificação

- [ ] LibreOffice removido
- [ ] OnlyOffice instalado
- [ ] GIMP instalado
- [ ] Spotify instalado
- [ ] Google Chrome instalado
- [ ] AnyDesk instalado
- [ ] Logo de inicialização personalizado
- [ ] Papel de parede configurado
- [ ] Dock posicionado corretamente
- [ ] Autostart configurado
- [ ] ISO gerada e testada

## 📝 Notas Importantes

- Todos os comandos devem ser executados dentro do ambiente chroot do Cubic
- As configurações em `/etc/skel/` serão aplicadas a novos usuários criados
- Teste a ISO em máquina virtual antes de distribuir
- Mantenha backup da ISO original

## 📄 Licença

Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.