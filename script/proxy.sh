#!/usr/bin/env bash
set -x
wget https://archive.tetratelabs.io/envoy/download/v1.18.3/envoy-v1.18.3-linux-amd64.tar.xz
tar -xf envoy-v1.18.3-linux-amd64.tar.xz
sudo cp ./envoy-v1.18.3-linux-amd64/bin/envoy /usr/local/bin
rm -Rf envoy-v1.18.3-linux-amd64 envoy-v1.18.3-linux-amd64.tar.xz

wget https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/counting-service_linux_amd64.zip
wget https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/dashboard-service_linux_amd64.zip
unzip dashboard-service_linux_amd64.zip
unzip counting-service_linux_amd64.zip
rm counting-service_linux_amd64.zip dashboard-service_linux_amd64.zip



consul config write /vagrant/consul-artifacts/intention-config.hcl
consul services register /vagrant/consul-artifacts/counting.hcl
consul services register /vagrant/consul-artifacts/dashboard.hcl


sleep 6
PORT=9003 /home/vagrant/counting-service_linux_amd64 &> /vagrant/counting.log &
sleep 6
PORT=9002 COUNTING_SERVICE_URL="http://localhost:5000" /home/vagrant/dashboard-service_linux_amd64 &> /vagrant/dashboard.log &
sleep 6



consul connect envoy -sidecar-for counting-1 -admin-bind localhost:19001 &> /vagrant/counting-proxy.log &
consul connect envoy -sidecar-for dashboard &> /vagrant/dashboard-proxy.log &



# sleep 2
# consul connect envoy -sidecar-for counting-1 -admin-bind localhost:19001 > counting-proxy.log &
# consul connect envoy -sidecar-for dashboard > dashboard-proxy.log &




