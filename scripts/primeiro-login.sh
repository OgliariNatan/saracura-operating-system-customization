#!/bin/bash
## Script para registrar o número de patrimônio no primeiro login
## Autor: @OgliariNatan
## Última Atualização: 03/2026

PATRIMONIO_FILE="/etc/saracura/patrimonio.conf"
FLAG_FILE="$HOME/.config/saracura/primeiro-login-concluido"

# Se já foi registrado para este usuário, não exibe novamente
if [ -f "$FLAG_FILE" ]; then
    exit 0
fi

# Verifica se o kdialog está disponível (KDE)
if ! command -v kdialog &> /dev/null; then
    echo "kdialog não encontrado. Instale o KDE."
    exit 1
fi

# Loop até o usuário informar um número válido
while true; do
    PATRIMONIO=$(kdialog --title "Saracura OS - Registro de Patrimônio" \
        --inputbox "Bem-vindo ao Saracura OS!\n\nPor favor, informe o número de patrimônio deste equipamento:\n\n(Exemplo: 123456)" \
        "" 2>/dev/null)

    # Se o usuário cancelar, perguntar se deseja sair
    if [ $? -ne 0 ]; then
        kdialog --title "Atenção" \
            --yesno "O número de patrimônio é obrigatório.\n\nDeseja realmente pular esta etapa?" \
            2>/dev/null
        if [ $? -eq 0 ]; then
            PATRIMONIO="NAO_INFORMADO"
            break
        fi
        continue
    fi

    # Validar se não está vazio
    if [ -z "$PATRIMONIO" ]; then
        kdialog --title "Erro" \
            --error "O número de patrimônio não pode ser vazio!" \
            2>/dev/null
        continue
    fi

    # Confirmar o número informado
    kdialog --title "Confirmação" \
        --yesno "O número de patrimônio informado é:\n\n  ➜  $PATRIMONIO\n\nEstá correto?" \
        2>/dev/null
    if [ $? -eq 0 ]; then
        break
    fi
done

# Coleta informações do sistema
HOSTNAME=$(hostname)
DATA_REGISTRO=$(date '+%Y-%m-%d %H:%M:%S')
USUARIO=$(whoami)
MAC_ADDRESS=$(ip link show | awk '/ether/ {print $2; exit}')
SERIAL=$(sudo dmidecode -s system-serial-number 2>/dev/null || echo "N/A")
MODELO=$(sudo dmidecode -s system-product-name 2>/dev/null || echo "N/A")
FABRICANTE=$(sudo dmidecode -s system-manufacturer 2>/dev/null || echo "N/A")
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Cria o diretório de configuração do sistema (precisa de sudo)
sudo mkdir -p /etc/saracura

# Salva as informações no arquivo de patrimônio
sudo tee "$PATRIMONIO_FILE" > /dev/null <<EOF
#############################################
# Saracura OS - Registro de Patrimônio
# Gerado automaticamente - NÃO EDITE MANUALMENTE
#############################################

[PATRIMONIO]
numero=$PATRIMONIO
data_registro=$DATA_REGISTRO
usuario_registro=$USUARIO

[HARDWARE]
hostname=$HOSTNAME
fabricante=$FABRICANTE
modelo=$MODELO
serial=$SERIAL
mac_address=$MAC_ADDRESS
ip_registro=$IP_ADDRESS

[SISTEMA]
versao_saracura=1.0
base=Ubuntu 24.04 LTS
desktop=KDE Plasma
EOF

# Altera o hostname para incluir o patrimônio (opcional)
NOVO_HOSTNAME="saracura-${PATRIMONIO}"
# Remove caracteres especiais do hostname
NOVO_HOSTNAME=$(echo "$NOVO_HOSTNAME" | sed 's/[^a-zA-Z0-9-]/-/g' | tr '[:upper:]' '[:lower:]')

kdialog --title "Alterar nome do computador" \
    --yesno "Deseja alterar o nome deste computador para:\n\n  ➜  $NOVO_HOSTNAME\n\nIsso facilita a identificação na rede." \
    2>/dev/null

if [ $? -eq 0 ]; then
    sudo hostnamectl set-hostname "$NOVO_HOSTNAME"
    sudo sed -i "s/127.0.1.1.*/127.0.1.1\t$NOVO_HOSTNAME/" /etc/hosts
fi

# Marca como concluído para este usuário
mkdir -p "$HOME/.config/saracura"
echo "primeiro_login=$DATA_REGISTRO" > "$FLAG_FILE"
echo "patrimonio=$PATRIMONIO" >> "$FLAG_FILE"

# Mensagem final
kdialog --title "Saracura OS" \
    --msgbox "✅ Patrimônio registrado com sucesso!\n\n  Número: $PATRIMONIO\n  Hostname: $(hostname)\n  Arquivo: $PATRIMONIO_FILE\n\nObrigado!" \
    2>/dev/null

exit 0