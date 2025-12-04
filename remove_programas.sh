#!/bin/bash
## Script para remover programas padrões do Ubuntu 24.04 LTS
##Autor: @OgliariNatan
##Ultima Atualização: 12/2025
##################################################################

apt remove --purge LibreOffice* -y && \
apt remove --purge thunderbird -y && \
apt remove --purge remmina -y 

