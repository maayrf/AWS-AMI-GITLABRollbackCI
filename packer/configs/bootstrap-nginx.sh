#!/bin/bash
sudo groupadd infra
sudo adduser ${ENVIRONMENT}
sudo mkdir /home/${ENVIRONMENT}/project 
sudo chown -R ${ENVIRONMENT}:${ENVIRONMENT} /home/${ENVIRONMENT}
sudo -u ${ENVIRONMENT} -i <<EOF
curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
source /home/${ENVIRONMENT}/.bashrc
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install ${NODE_VERSION}
EOF


# Instala e configura nginx
sudo amazon-linux-extras install -y nginx1
sudo mv /tmp/nginx-vhosts.conf /etc/nginx/conf.d/virtual.conf
sudo mv /tmp/nginx.conf /etc/nginx/nginx.conf
#sudo mkdir /usr/share/nginx/cache
#sudo chown -R nginx.nginx /usr/share/nginx/cache
