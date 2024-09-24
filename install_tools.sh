#!/bin/bash

# Função para exibir mensagens de erro
erro() {
  echo "Erro: $1"
  exit 1
}

# Atualiza os pacotes do sistema
echo "Atualizando os pacotes do sistema..."
sudo apt update && sudo apt upgrade -y || erro "Falha ao atualizar pacotes."

# Instala o curl
echo "Adicionar o curl"
sudo apt install curl

# Instala Git
echo "Instalando Git..."
sudo apt install git -y || erro "Falha ao instalar Git."

# Instala NVM (Node Version Manager)
echo "Instalando NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash || erro "Falha ao instalar NVM."
source ~/.nvm/nvm.sh
nvm install node || erro "Falha ao instalar Node.js."

# Instala Angular CLI
echo "Instalando Angular CLI..."
npm install -g @angular/cli || erro "Falha ao instalar Angular CLI."

# Instala Rust (via rustup)
echo "Instalando Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || erro "Falha ao instalar Rust."
source $HOME/.cargo/env

# Instala Docker
echo "Instalando Docker..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y || erro "Falha ao instalar dependências do Docker."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y || erro "Falha ao instalar Docker."
sudo systemctl start docker
sudo systemctl enable docker

# Instala DBeaver
echo "Instalando DBeaver..."
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add - || erro "Falha ao adicionar chave do DBeaver."
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update
sudo apt install dbeaver-ce -y || erro "Falha ao instalar DBeaver."

echo "Instalação concluída com sucesso!"
