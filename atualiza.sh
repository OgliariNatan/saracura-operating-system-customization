#!/bin/bash
## Script para instalar programas basicos em uma nova instalação da Saracura Linux
##Autor: @OgliariNatan
##Ultima Atualização: 12/2025
##################################################################


echo "==========================================="
echo "=== Iniciando a Atualização do Sistema ==="
echo "============Aguarde......=================="
echo "==========================================="

apt update && \
apt upgrade -y && \
apt autoremove -y && \
apt autoclean -y && \
apt clean -y