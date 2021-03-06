#!/bin/bash -ex
exec > >(tee /var/log/packer-data.log|logger -t packer-data -s 2>/dev/console) 2>&1

RIEMANN_VERSION=$1

apt-get update
apt-get -y install default-jre
apt-get -y install default-jdk

# Riemann Dash (there if you want it)
apt-get -y install ruby-full
gem install riemann-dash

mkdir /riemann
cd /riemann
curl -skL https://github.com/riemann/riemann/releases/download/$RIEMANN_VERSION/riemann-$RIEMANN_VERSION.tar.bz2 | bunzip2 | tar -x
mv riemann-$RIEMANN_VERSION /app
