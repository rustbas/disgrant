# -*- mode: ruby -*-
# vi: set ft=ruby :

# Default box
box_name = "debian.jessie64.libvirt.box"

# Master
master_node = {
  :hostname => "master", :ip => "10.200.1.2", :memory => 1024, :cpu => 1
}

# List of slaves
nodes = [
  { :memory => 1024, :cpu => 1 },
  { :memory => 2048, :cpu => 2 },
  { :memory => 1024, :cpu => 2 },
]

$distcc_install = <<-SCRIPT
apt update
apt install -y make distcc gcc g++ tmux libz-dev git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison time neofetch
# wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.13.tar.gz
# echo 'export DISTCC_HOSTS="10.200.1.2/24,10.200.1.3/24,10.200.1.4/24"' >> ~/home/vagrant/.bashrc
SCRIPT

Vagrant.configure("2") do |config|

  # Nodes configs
  nodes.each_with_index do |node, i|
    config.vm.box_check_update = false
    config.vm.define "node-#{ i+1 }" do |nodeconfig|
      nodeconfig.vm.box = box_name
      
      nodeconfig.vm.hostname = "node-#{ i+1 }"

      nodeconfig.vm.network :private_network, ip: "10.200.1.#{ i+2 }"
      nodeconfig.vm.provider :libvirt do |vb|
        vb.memory = node[:memory]
        vb.cpus = node[:cpu]
      end

      nodeconfig.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "provisioning/playbook.yaml"
        ansible.become = true
      end
    end
  end
end
