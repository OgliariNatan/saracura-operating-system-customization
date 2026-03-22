# GUIA DE PERSONALIZAÇÃO DA ISO COM CUBIC

## Introdução
Este guia tem como objetivo fornecer instruções sobre como utilizar o Cubic para personalizar a ISO do Ubuntu 24.04, adaptando-a às necessidades do projeto Saracura OS.

## O que é o Cubic?
Cubic (Custom Ubuntu ISO Creator) é uma ferramenta que permite criar uma imagem ISO personalizada do Ubuntu. Com o Cubic, você pode adicionar, remover ou modificar pacotes, alterar configurações do sistema e incluir scripts de inicialização.

## Pré-requisitos
Antes de começar, certifique-se de que você possui:
- Uma instalação do Ubuntu 24.04.
- O Cubic instalado. Você pode instalá-lo usando o seguinte comando:
  ```bash
  sudo apt install cubic
  ```

## Passo a Passo para Personalização da ISO

### 1. Iniciar o Cubic
- Abra o Cubic a partir do menu de aplicativos.
- Selecione a ISO do Ubuntu 24.04 que você deseja personalizar.

### 2. Configuração do Projeto
- Na tela de configuração do projeto, você pode definir o nome do projeto e a descrição. Utilize as informações do projeto Saracura OS.

### 3. Modificar Pacotes
- Na seção de gerenciamento de pacotes, você pode adicionar ou remover pacotes conforme necessário. Utilize os scripts `install_programas.sh` e `remove_programas.sh` para gerenciar os programas que serão instalados ou removidos.

### 4. Adicionar Scripts
- Copie os scripts do diretório `scripts` para a ISO. Isso pode incluir:
  - `primeiro-login.sh`: Para registrar o patrimônio no primeiro login.
  - `pos-instalacao.sh`: Para executar tarefas pós-instalação.

### 5. Configurações do Sistema
- Modifique os arquivos de configuração no diretório `config` conforme necessário. Isso pode incluir:
  - `kdeglobals` e `kwinrc` para personalizar o ambiente KDE.
  - `sddm.conf` para configurar o gerenciador de exibição.

### 6. Configuração do Autostart
- Adicione o arquivo `saracura-primeiro-login.desktop` ao diretório de autostart para garantir que o script de registro de patrimônio seja executado na inicialização.

### 7. Finalizar e Criar a ISO
- Após realizar todas as modificações, siga as instruções do Cubic para finalizar o processo e criar a nova ISO personalizada.

## Conclusão
Com o Cubic, você pode facilmente personalizar a ISO do Ubuntu 24.04 para atender às necessidades do Saracura OS. Siga este guia para garantir que todas as etapas sejam seguidas corretamente e que a ISO resultante esteja pronta para uso.

## Suporte
Para mais informações ou suporte, consulte a documentação do Cubic ou entre em contato com a equipe do projeto Saracura OS.