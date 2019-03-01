# Installation on fresh server

## Install docker

```
sudo apt-get update
sudo apt-get install  -y   apt-transport-https     ca-certificates     curl     gnupg2     software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/debian    $(lsb_release -cs)    stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
```

## Hard Reboot

## Build OTS explorer

```
git clone https://github.com/satoshiportal/ots-explorer.git
cd ots-explorer/
docker build -t ots-explorer .
docker network create --driver=overlay --attachable --opt encrypted otswebnet
sed -i 's/<EMAIL_LE>/letsencrypt@yourdomain.com/g' docker-compose-lecompanion.yml docker-compose-traefik.yml traefik/traefik.toml
sed -i 's/<DOMAIN_LE>/ots-explorer.yourdomain.com/g' docker-compose-lecompanion.yml docker-compose-traefik.yml traefik/traefik.toml
```

## Run using Let's Encrypt Companion

```
docker swarm init
docker stack deploy -c docker-compose-lecompanion.yml ots-explorer
```

## Run using Traefik

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker-compose -f traefik/docker-compose.yml up -d
docker-compose -f docker-compose-traefik.yml up -d
```
