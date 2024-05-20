VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Configurazione del Manager
  config.vm.define "k8s-manager" do |manager|
    manager.vm.box = "ubuntu/bionic64"
    manager.vm.hostname = "k8s-manager"
    manager.vm.network "private_network", ip: "192.168.56.10"
    manager.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end
    manager.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/setup.yml"
      ansible.groups = {
        "k8s_manager" => ["k8s-manager"]
      }
    end
  end

  # Configurazione dei Worker
  (1..2).each do |i|
    config.vm.define "k8s-worker-#{i}" do |worker|
      worker.vm.box = "ubuntu/bionic64"
      worker.vm.hostname = "k8s-worker-#{i}"
      worker.vm.network "private_network", ip: "192.168.56.#{10 + i}"
      worker.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 2
      end
      worker.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/setup.yml"
        ansible.groups = {
          "k8s_worker" => ["k8s-worker-#{i}"]
        }
      end
    end
  end
end
