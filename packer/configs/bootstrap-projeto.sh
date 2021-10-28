#!/bin/bash

#g++ necessario para instalacao de algumas bibliotecas
sudo yum install -y libstd*-devel bc* gcc-c++

# Pegando arquivo env do parameter store
sudo aws --region ${AWS_REGION} ssm get-parameters --names "/${ENVIRONMENT}/${PROJECT_NAME}/config" --with-decryption | jq -r '.Parameters[] | .Value' > /tmp/.env

## Instalando projeto
sudo -u ${ENVIRONMENT} -i <<EOF
git clone --single-branch --branch ${PROJECT_VERSION} ${PROJECT_URL} ~/project/build/
cd ~/project/build/
cp /tmp/.env .
npm run build
mkdir ~/project/release/
mv ~/project/build/dist/* ~/project/release/

EOF

#Copia release para a pasta acessivel pelo nginx
sudo cp -R /home/${ENVIRONMENT}/project/release /usr/share/nginx/html/application

# Ajustando permissoes do arquivo de log da aplicacao
sudo mkdir -p /srv/project/logs
sudo chmod 770 -R /srv
sudo chown ${ENVIRONMENT}:log_reader -R /srv
