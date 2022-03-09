# Deploy a consul service mesh

This code will deploy one consul server and client in vagrant box. It will deploy and connect a simple counting service with web based dashboard and will connect them with Consul Service Mesh. The project is automation of https://learn.hashicorp.com/tutorials/consul/service-mesh-with-envoy-proxy?in=consul/developer-mesh

## Prerequisite
Download and install vagrant according to your OS from https://www.vagrantup.com/downloads

## Usage

From the directory containing `Vagrantfile` run the following command:

```
vagrant up
```
 When the deploy is ready you should be able to access 
 - Consul UI: http://localhost:9000
 - Counting Dashboard: http://localhost:9002
 



## License
[MIT](https://choosealicense.com/licenses/mit/)