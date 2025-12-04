#!/bin/bash
## Script para instalar programas basicos em uma nova instalação da Saracura Linux
##Autor: @OgliariNatan
##Ultima Atualização: 12/2025
##################################################################


echo "==========================================="
echo "=== Iniciando a Instalacao de Programas ==="
echo "============Aguarde......=================="
echo "============@Ogliarinatan=================="
echo "==========================================="
apt install tuxpaint -y && \
apt install vlc -y && \
apt install gimp -y && \
apt install wget -y && \
apt install curl -y && \
apt install net-tools -y && \
apt install htop -y && \
apt install openssh-server -y && \


echo "++++ANYDESK ++++" && \
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY| gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg && \
echo "deb http://deb.anydesk.com/ all main" | tee /etc/apt/sources.list.d/anydesk-stable.list && \
echo "deb http://deb.anydesk.com/ all main" | tee /etc/apt/sources.list.d/anydesk-stable.list && \
apt update && \
apt install anydesk -y && \
#==========================
#Para o chorme
echo "++++GOOGLE CHROME ++++" && \
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-signing-key.gpg && \
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
apt update && \
apt install google-chrome-stable -y && \
# =========================
# Para o onlyoffice
echo "++++ONLYOFFICE ++++" && \
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5 && \
echo "deb https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list && \
apt update && \
apt install onlyoffice-desktopeditors -y && \
# =========================


# pacotes para  drivers de impressoras
echo "++++DRIVERS DE IMPRESSORAS ++++" && \
apt install printer-driver-all foomatic-db-engine hp-ppd openprinting-ppds -y && \

# para java
echo "++++JAVA ++++" && \
apt install default-jre -y && \
apt install default-jdk -y && \


# INSTALAR O ZOOM
echo "++++ZOOM ++++" && \
wget https://zoom.us/client/latest/zoom_amd64.deb -O zoom.deb && \
apt install ./zoom.deb -y && \
apt install -f -y && \
rm zoom.deb && \


echo "========================================" && \
echo "=== Programas instalados com sucesso ===" && \
echo "========================================"