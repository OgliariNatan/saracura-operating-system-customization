#!/bin/bash
## Script de primeiro login - Saracura OS
## Wrapper que chama o registro de patrimônio
## Autor: @OgliariNatan
## Última Atualização: 03/2026
##################################################################

# Executa o registro de patrimônio (instalado pelo pos-instalacao.sh)
if [ -x /usr/local/bin/registrar_patrimonio.sh ]; then
    /usr/local/bin/registrar_patrimonio.sh
else
    echo "Script de patrimônio não encontrado em /usr/local/bin/"
fi