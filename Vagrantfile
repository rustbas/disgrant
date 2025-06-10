# -*- mode: ruby -*-
# vi: set ft=ruby :

# Default box
box_name = "debian.jessie64.libvirt.box"

# List of nodes
nodes = [
  { :memory => 2048, :cpu => 2 },
  { :memory => 1024, :cpu => 1 },
  { :memory => 1024, :cpu => 1 },
]

# Auto-calculating IP-addresses in 10.200.1.0/24 begin with 2
N_NODES = nodes.length
DISTCC_HOSTS = (2..N_NODES+1).map {|i| "10.200.1.#{i}/24"}


# Set script for DISTCC_HOSTS in /etc/profile.d/
$SET_ENVIRONMENT = <<SCRIPT
tee "/etc/profile.d/distcc_var.sh" > "/dev/null" <<EOF
# Set distcc_hosts variable
export DISTCC_HOSTS="#{DISTCC_HOSTS.join(" ")}"
EOF
SCRIPT

Vagrant.configure("2") do |config|

  # Nodes configs
  nodes.each_with_index do |node, i|
    config.vm.box_check_update = false
    config.vm.define "node-#{ i+1 }" do |nodeconfig|
      nodeconfig.vm.box = box_name
      
      nodeconfig.vm.hostname = "node-#{ i+1 }"

      nodeconfig.vm.network :private_network, ip: "10.200.1.#{ i+2 }"
      nodeconfig.vm.provision "shell", inline: $SET_ENVIRONMENT, run: "always"
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
