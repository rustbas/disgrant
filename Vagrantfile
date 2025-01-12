# -*- mode: ruby -*-
# vi: set ft=ruby :

# Default box
box_name = "debian.jessie64.libvirt.box"

# Master
master_node = {
  :hostname => "master-node", :ip => "10.200.1.2", :memory => 2048, :cpu => 4
}

# List of slaves
slaves = [
  { :memory => 512,  :cpu => 1 },
  # { :memory => 512,  :cpu => 1 },
  # { :memory => 1024, :cpu => 2 }
]

$distcc_install = <<-SCRIPT
# apt update
# apt install -y make distcc gcc g++
# echo 'export DISTCC_HOSTS="10.200.1.2/24,10.200.1.3/24,10.200.1.4/24"' >> ~/home/vagrant/.bashrc
SCRIPT

Vagrant.configure("2") do |config|

  # Master node's config
  config.vm.box_check_update = false
  config.vm.define master_node[:hostname] do |nodeconfig|
    nodeconfig.vm.box = box_name
    nodeconfig.vm.hostname = master_node[:hostname]
    nodeconfig.vm.network(:private_network, ip: master_node[:ip])
    nodeconfig.vm.provision "shell", inline: $distcc_install
    # nodeconfig.vm.provision "file", source: "./compile", destination: "~/compile"
    nodeconfig.vm.provider :libvirt do |vb|
      vb.memory = master_node[:memory]
      vb.cpus = master_node[:cpu]
    end
  end

  # Slaves configs
  slaves.each_with_index do |slave, i|
    config.vm.box_check_update = false
    config.vm.define "slave-#{ i+1 }" do |nodeconfig|
      # Default box-name (cause I have only it)
      nodeconfig.vm.box = box_name
      
      # Hostname: slave-N
      nodeconfig.vm.hostname = "slave-#{ i+1 }"

      # IP-address: 10.200.1.{N+2}
      nodeconfig.vm.network :private_network, ip: "10.200.1.#{ i+2 }"
      nodeconfig.vm.provision "shell", inline: $distcc_install
      # nodeconfig.vm.provision "file", source: "./compile", destination: "~/compile"
      nodeconfig.vm.provider :libvirt do |vb|
        vb.memory = slave[:memory]
        vb.cpus = slave[:cpu]
      end
    end
  end
  
  # config.vm.box = "debian.jessie64.libvirt.box"
  # config.vm.hostname = "distcc-debian1"
  # config.vm.network :private_network, ip: "10.200.0.2"
end
