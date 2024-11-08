# -*- mode: ruby -*-
# vi: set ft=ruby :

nodes = [
  { :hostname => "master", :ip => "10.200.0.2", :memory => 1024, :cpu => 1, :boxname => "debian.jessie64.libvirt.box" },
  { :hostname => "slave-1", :ip => "10.200.0.3", :memory => 1024, :cpu => 1, :boxname => "debian.jessie64.libvirt.box" },
]

Vagrant.configure("2") do |config|
  
  nodes.each do |node|
    config.vm.box_check_update = false
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:boxname]
      nodeconfig.vm.hostname = node[:hostname]
      nodeconfig.vm.network :private_network, ip: node[:ip]
      nodeconfig.vm.provider :libvirt do |vb|
        vb.memory = node[:memory]
        vb.cpus = node[:cpu]
      end
    end
  end
  
  # config.vm.box = "debian.jessie64.libvirt.box"
  # config.vm.hostname = "distcc-debian1"
  # config.vm.network :private_network, ip: "10.200.0.2"
end
