# -*- mode: ruby -*-
# vi: set ft=ruby :

nodes = [
  { :hostname => "master",  :ip => "10.200.1.2", :memory => 512, :cpu => 1, :boxname => "debian.jessie64.libvirt.box" },
  # { :hostname => "slave-1", :ip => "10.200.1.3", :memory => 512, :cpu => 1, :boxname => "debian.jessie64.libvirt.box" },
  # { :hostname => "slave-2", :ip => "10.200.1.4", :memory => 512, :cpu => 1, :boxname => "debian.jessie64.libvirt.box" },
]

$distcc_install = <<-SCRIPT
apt update
# apt upgrade -y
apt install -y make distcc gcc g++
echo 'export DISTCC_HOSTS="10.200.1.2/24,10.200.1.3/24,10.200.1.4/24"' >> ~/.bashrc
SCRIPT
# systemctl enable --now distccd

Vagrant.configure("2") do |config|
  
  nodes.each do |node|
    config.vm.box_check_update = false
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:boxname]
      nodeconfig.vm.hostname = node[:hostname]
      nodeconfig.vm.network :private_network, ip: node[:ip]
      nodeconfig.vm.provision "shell", inline: $distcc_install
      nodeconfig.vm.provision "file", source: "./compile", destination: "~/compile"
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
