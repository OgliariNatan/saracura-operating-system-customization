# Saracura OS - Customização de ISO Ubuntu 24.04

Projeto de personalização da ISO do Ubuntu 24.04 LTS usando **Cubic**, com ambiente **KDE Plasma**, registro de patrimônio no primeiro login e branding customizado.

## Estrutura do Projeto

```
saracura-operating-system-customization/
├── scripts/                          # Scripts de automação
│   ├── remove_programas.sh           # Remove GNOME, LibreOffice, etc.
│   ├── install_programas.sh          # Instala KDE + programas
│   ├── pos-instalacao.sh             # Copia recursos e configura branding
│   └── primeiro-login.sh             # Wrapper para registro de patrimônio
├── config/                           # Arquivos de configuração
│   ├── autostart/
│   │   └── saracura-primeiro-login.desktop   # Autostart do KDE
│   ├── kde/
│   │   ├── kdeglobals                # Configurações globais do KDE
│   │   └── kwinrc                    # Configurações do KWin
│   ├── patrimonio/
│   │   └── registrar_patrimonio.sh   # Script de registro de patrimônio
│   ├── sddm/
│   │   └── sddm.conf                # Configuração do login SDDM
│   └── sudoers.d/
│       └── saracura-patrimonio       # Permissões sudo para patrimônio
├── resources/                        # Recursos visuais
│   ├── bgrt-fallback/                # Imagem da tela de boot (Plymouth)
│   ├── wallpapers/                   # Wallpapers da área de trabalho
│   └── watermark/                    # Marca d'água da tela de login SDDM
├── cubic/                            # Configuração do Cubic
│   ├── cubic-project.conf
│   └── preseed.cfg                   # Automação de instalação
├── docs/                             # Documentação
│   ├── GUIA-CUBIC.md                 # Passo a passo com Cubic
│   ├── LISTA-PROGRAMAS.md            # Programas instalados/removidos
│   └── CHANGELOG.md                  # Histórico de alterações
└── README.md
```

## Recursos Visuais

| Recurso | Pasta | Destino no sistema | Onde aparece |
|---|---|---|---|
| **bgrt-fallback** | `resources/bgrt-fallback/` | `/usr/share/plymouth/themes/spinner/bgrt-fallback.png` | Tela de boot |
| **wallpapers** | `resources/wallpapers/` | `/usr/share/backgrounds/saracura/` | Área de trabalho |
| **watermark** | `resources/watermark/` | `/usr/share/sddm/themes/breeze/watermark.png` | Tela de login |

## Como Usar (com Cubic)

1. Instale o Cubic:
   ```bash
   sudo apt-add-repository ppa:cubic-wizard/release
   sudo apt update && sudo apt install cubic
   ```

2. Abra o Cubic e selecione a ISO do Ubuntu 24.04 LTS.

3. No terminal chroot do Cubic, copie o projeto para `/tmp/saracura/` e execute:
   ```bash
   bash /tmp/saracura/scripts/remove_programas.sh
   bash /tmp/saracura/scripts/install_programas.sh
   bash /tmp/saracura/scripts/pos-instalacao.sh /tmp/saracura
   ```

4. Finalize e gere a ISO pelo Cubic.

Para instruções detalhadas, consulte `docs/GUIA-CUBIC.md`.

## Primeiro Login

No primeiro login do usuário, uma janela (kdialog) solicita o **número de patrimônio** do equipamento. As informações coletadas (patrimônio, hostname, MAC, serial, etc.) são salvas em `/etc/saracura/patrimonio.conf`.

## Programas Instalados

- **Desktop:** KDE Plasma + SDDM
- **Escritório:** OnlyOffice
- **Navegador:** Google Chrome
- **Multimídia:** VLC, GIMP
- **Educação:** TuxPaint
- **Acesso remoto:** AnyDesk
- **Comunicação:** Zoom
- **Governo:** Assinador Digital SERPRO
- **Utilitários:** wget, curl, htop, net-tools, SSH
- **Impressoras:** Drivers genéricos + HP
- **Java:** JRE + JDK

## Licença

Este projeto está licenciado sob a [Licença Apache 2.0](COPYING.APACHE).