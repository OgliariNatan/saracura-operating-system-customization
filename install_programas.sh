
#para o ANYdesk
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg && \
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list && \
apt update && \
apt install anydesk -y && \
#==========================
#Para o chorme
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-linux-signing-key.gpg && \
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
apt update && \
apt install google-chrome-stable -y && \
# =========================
# Para o onlyoffice
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5 && \
echo "deb https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list && \
apt update && \
apt install onlyoffice-desktopeditors -y && \
# =========================


apt install tuxpaint -y && \
apt install vlc -y && \
apt install gimp -y && \
apt install wget -y && \
apt install curl -y && \
apt install net-tools -y && \
apt install htop -y && \
apt install openssh-server -y && \

# pacotes para  drivers de impressoras
apt install printer-driver-all foomatic-db-engine hp-ppd openprinting-ppds -y && \
