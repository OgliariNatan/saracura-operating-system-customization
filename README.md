# Saracura Operating System Customization

Este projeto tem como objetivo personalizar a ISO do Ubuntu 24.04, utilizando o Cubic para facilitar a instalação e configuração de um sistema operacional otimizado para os usuários do Saracura OS.

## Estrutura do Projeto

O projeto é organizado da seguinte forma:

- **scripts/**: Contém scripts para instalação, remoção e configuração do sistema.
  - `install_programas.sh`: Script para instalar programas básicos e essenciais.
  - `remove_programas.sh`: Script para remover programas padrão desnecessários.
  - `primeiro-login.sh`: Script que registra o número de patrimônio no primeiro login do usuário.
  - `pos-instalacao.sh`: Script para executar tarefas pós-instalação.

- **config/**: Contém arquivos de configuração para o sistema.
  - **patrimonio/**: Scripts e arquivos relacionados ao registro de patrimônio.
    - `registrar_patrimonio.sh`: Script responsável por registrar o patrimônio do equipamento.
  - **kde/**: Configurações específicas do ambiente de desktop KDE.
    - `kdeglobals`: Configurações gerais do KDE.
    - `kwinrc`: Configurações do gerenciador de janelas KWin.
  - **autostart/**: Configurações para iniciar scripts automaticamente.
    - `saracura-primeiro-login.desktop`: Executa o script de registro de patrimônio na inicialização.
  - **sddm/**: Configurações do gerenciador de exibição SDDM.
    - `sddm.conf`: Configurações para o SDDM.
  - **sudoers.d/**: Permissões para execução de comandos sem senha.
    - `saracura-patrimonio`: Permite execução de comandos específicos com sudo sem senha.

- **resources/**: Contém recursos como wallpapers.
  - **wallpapers/**: Diretório para armazenar wallpapers do sistema.

- **cubic/**: Contém arquivos de configuração do Cubic.
  - `cubic-project.conf`: Configurações do projeto de personalização da ISO.
  - `preseed.cfg`: Automatiza a instalação do sistema.

- **docs/**: Documentação do projeto.
  - `GUIA-CUBIC.md`: Guia sobre como usar o Cubic.
  - `LISTA-PROGRAMAS.md`: Lista de programas a serem instalados ou removidos.
  - `CHANGELOG.md`: Histórico de alterações do projeto.

- **.gitignore**: Arquivo para especificar arquivos a serem ignorados pelo Git.

- **LICENSE**: Licença do projeto.

## Como Usar

1. **Clone o repositório**: 
   ```
   git clone <URL do repositório>
   cd saracura-operating-system-customization
   ```

2. **Execute o script de instalação**:
   ```
   sudo bash scripts/install_programas.sh
   ```

3. **Personalize a ISO com o Cubic**:
   - Abra o Cubic e selecione a ISO do Ubuntu 24.04.
   - Siga as instruções do guia `docs/GUIDE-CUBIC.md` para personalizar a ISO conforme suas necessidades.

4. **Reinicie o sistema após a instalação** para aplicar as mudanças.

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests para melhorias e correções.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).