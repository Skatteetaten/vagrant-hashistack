Vagrant.configure("2") do |config|
    config.vm.box = "fredrikhgrelland/hashistack"

    config.vm.provider "virtualbox" do |vb|
        vb.linked_clone = true
        vb.memory = 2048
    end

    config.vm.provision "ansible_local" do |startup|
        run = "always"
        startup.playbook = "/etc/ansible/startup.yml"
    end
end
