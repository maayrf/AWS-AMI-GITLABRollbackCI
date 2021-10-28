#!/bin/bash

sudo mkdir /root/.aws
sudo chmod 700 /root/.aws
sudo touch /root/.aws/credentials
# sudo groupadd -g 1001 infra, Que grupo é esse?

# Pegando as chaves da AWS
curl -s http://[IP]/latest/meta-data/iam/security-credentials/`curl -s http://[IP]/latest/meta-data/iam/security-credentials/` | jq -r ' . | { aws_access_key_id: .AccessKeyId, aws_secret_access_key: .SecretAccessKey, aws_session_token: .Token }' | sed -e 's/:/=/g' -e 's/"//g' -e 's/ //g' -e 's/,//g' -e 's/}//g' -e 's/{/[default]/g' | sudo tee /root/.aws/credentials > /dev/null


# Pegando a lista de colaboradores
sudo aws --region ${AWS_REGION} ssm get-parameters --names "/${ENVIRONMENT}/infraestrutura/colaboradores" --with-decryption | jq -r '.Parameters[] | .Value' > /tmp/rsa-users-infra.txt

# Adicionando o grupo infra no sudoers
echo "%infra ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/gerencianet-infra-users

# Percorrendo a lista de colaboradores, criando os usuarios e adicionando chaves publicas
while read -r USER TIPO_CHAVE CHAVE ; 
do 
    sudo adduser ${USER} ; 
    sudo usermod -g infra ${USER} ;
    sudo mkdir /home/${USER}/.ssh/ ; 
    sudo chmod 700 /home/${USER}/.ssh/ ; 
    sudo chown ${USER}:${USER} /home/${USER}/.ssh/ ; 
    echo "${TIPO_CHAVE} ${CHAVE} ${USER}" | sudo tee /home/${USER}/.ssh/authorized_keys > /dev/null; 
    sudo chmod 600 /home/${USER}/.ssh/authorized_keys ; 
    sudo chown ${USER}:${USER} /home/${USER}/.ssh/authorized_keys ; 
done < /tmp/rsa-users-infra.txt

sudo usermod -a -G testing aws-kinesis-agent-user
