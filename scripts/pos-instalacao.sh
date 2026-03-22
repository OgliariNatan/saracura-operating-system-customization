#!/bin/bash
## Script para executar tarefas pós-instalação - Saracura OS
## Autor: @OgliariNatan
## Última Atualização: 03/2026
##################################################################

echo "==========================================="
echo "=== Iniciando tarefas pós-instalação ===="
echo "=== Saracura OS - KDE Plasma            ==="
echo "=== @OgliariNatan                        ==="
echo "==========================================="

# Atualiza o sistema
echo ">>> Atualizando o sistema..."
apt update && apt upgrade -y

# Limpeza de pacotes desnecessários
echo ">>> Removendo pacotes desnecessários..."
apt autoremove -y
apt autoclean -y

# Configurações adicionais podem ser adicionadas aqui

echo "=== ✅ Tarefas pós-instalação concluídas ==="