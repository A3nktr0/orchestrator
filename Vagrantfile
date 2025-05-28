
master_ip = "192.168.56.10"
agent_ip = "192.168.56.11"

# Master Node Script
master_script = <<-SHELL
    # Install K3s on Master Node with --tls-san option
    curl -sfL https://get.k3s.io | sh -s - --tls-san #{master_ip}
    sleep 5

    # Copy node-token to shared folder
    while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
        echo "Waiting for node-token to be generated..."
        sleep 2
    done
    cp /var/lib/rancher/k3s/server/node-token /vagrant_shared/node-token

    # Update k3s.yaml to use the master node's private IP
    sed -i 's/127.0.0.1/#{master_ip}/g' /etc/rancher/k3s/k3s.yaml

    # Copy k3s.yaml to shared folder and adjust permissions
    chmod 644 /etc/rancher/k3s/k3s.yaml
    cp /etc/rancher/k3s/k3s.yaml /vagrant_shared/k3s.yaml

    # Apply Kubernetes manifests
    if [ -d /vagrant_shared/manifests ]; then
        kubectl apply -f /vagrant_shared/manifests
    fi
SHELL

# Agent Node Script
agent_script = <<-SHELL
    # Wait for node-token to be available
    while [ ! -f /vagrant_shared/node-token ]; do
        echo "Waiting for node-token to be available from master..."
        sleep 2
    done

    # Install K3s on Agent Node
    curl -sfL https://get.k3s.io | K3S_URL="https://#{master_ip}:6443" K3S_TOKEN=$(cat /vagrant_shared/node-token) sh -
SHELL

Vagrant.configure("2") do |config|
  # Shared folder for token and k3s.yaml
  shared_folder = "./k3s"
  manifests_folder = "./manifests"

  # Master Node Configuration
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/focal64"
    master.vm.hostname = "k3s-master"
    master.vm.network "private_network", ip: master_ip
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 4
    end

    # Shared folder for token and k3s.yaml
    master.vm.synced_folder shared_folder, "/vagrant_shared", create: true

    # Synchronize Kubernetes manifests folder
    master.vm.synced_folder manifests_folder, "/vagrant_shared/manifests", create: true

    # Provision Master Node
    master.vm.provision "shell", inline: master_script
  end

  # Agent Node Configuration
  config.vm.define "agent" do |agent|
    agent.vm.box = "ubuntu/focal64"
    agent.vm.hostname = "k3s-agent"
    agent.vm.network "private_network", ip: agent_ip
    agent.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 4
    end

    # Shared folder for token and k3s.yaml
    agent.vm.synced_folder shared_folder, "/vagrant_shared", create: true

    # Provision Agent Node
    agent.vm.provision "shell", inline: agent_script
  end
end
