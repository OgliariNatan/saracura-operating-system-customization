# Saracura Operating System Customization

Personalização customizada do Ubuntu 24.04 LTS usando Cubic para criar uma ISO com aplicações e configurações personalizadas.

No mais a mais, digo que é um processo datalhista e demorado. Possui inumeras formas de chegar a um denominador comum, estes passos em sua grande maioria são a subistituição de arquivos mantendo os nomes dos originais, acredito que não seria a melhor maneira levando em considerações conhecementos sobre o sistema operacional, o ideal seria manter os originais e adicionar os customizados e alterar os arquivos de configurações, no entento, é complexo e sensível a erros.
Ressalto que as aplicações não estão visiveis na instalação do sistema, será aplicado após a reinicialização, pois houve algumas mudanção no Ubuntu e supostamente a equipe do CUBIC ainda não ajustou.

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


## 📦 Instalação do Cubic

```bash
sudo apt-add-repository universe
sudo apt-add-repository ppa:cubic-wizard/release
sudo apt update
sudo apt install --no-install-recommends cubic
```

## 🚀 Processo de Customização

### 1. ISO Ubuntu 24.04
   Baixe a iso do Ubuntu 24.04

### 2. Iniciar o Cubic

1. Abra o Cubic
2. Selecione a ISO original do Ubuntu 24.04
3. Escolha um diretório de trabalho
4. Aguarde a extração dos arquivos

### 3. Entrar no Ambiente Chroot

Quando o terminal do Cubic abrir, você estará dentro do ambiente chroot da ISO.

#### Atualize o OS

```bash
chmod +x /root/atualiza.sh && \
/root/./atualiza.sh
```

#### 🗑️ Remoção de Aplicações
Para remover aplicações rode o scripty **remove_programas.sh**

```bash
chmod +x /root/remove_programas.sh && \
/root/./remove_programas.sh
```

atualize o OS
```bash
/root/./atualiza.sh
```


#### 📥 Instalação de Aplicações

##### 3.1. Atualizar Sistema

```bash
/root/./atualiza.sh
```

##### 3.2. 🚨 Para instalar app's rode o scripty

```bash
chmod +x /root/install_programas.sh && \
/root/./install_programas.sh
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

# Copie seu logo personalizado
cp /root/logo.png /usr/share/plymouth/themes/spinner/watermark.png

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

Exemplo: 

```xml
   
   .....
   <wallpaper>
     <name>Ogliari</name>
     <filename>/usr/share/backgrounds/logo_cinza.png</filename>
     <options>zoom</options>
     <pcolor>#000000</pcolor>
     <scolor>#000000</scolor>
     <shade_type>solid</shade_type>
   </wallpaper>
</wallpapers>
``` 


Adicionar o papel de parede as arquivo ``` /usr/share/gnome-background-properties/noble-wallpapers.xml``` 


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

/usr/share/plymouth/themes/spinner/
└── watermark.png
```

## 🏁 Geração da ISO

1. No Cubic, após todas as personalizações, clique em "Next"
2. Configure as informações da ISO:
   - Nome: Saracura OS
   - Versão: <Escolha_uma>
   - Descrição personalizada
3. Gere a ISO
4. Teste a ISO em máquina virtual antes de usar em produção

## ✅ Checklist de Verificação

- [x] LibreOffice removido
- [x] OnlyOffice instalado
- [x] GIMP instalado
- [ ] Spotify instalado
- [x] Google Chrome instalado
- [ ] AnyDesk instalado
- [x] Logo de inicialização personalizado
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