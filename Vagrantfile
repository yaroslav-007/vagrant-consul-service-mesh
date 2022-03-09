Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"


    config.vm.define "server" do |server|
      server.vm.provision "shell", path: "script/install-server.sh", privileged: true
      server.vm.network "private_network", ip: "192.168.56.4"
      server.vm.network "forwarded_port", guest: 8500, host: 9000
      server.vm.hostname = "server"
    end

    config.vm.define "client" do |client|
      client.vm.provision "shell", path: "script/install-client.sh", privileged: true
      client.vm.provision "shell", path: "script/proxy.sh", privileged: false
      client.vm.network "private_network", ip: "192.168.56.5"
      client.vm.network "forwarded_port", guest: 9002, host: 9002
      client.vm.hostname = "client"

    end

  end