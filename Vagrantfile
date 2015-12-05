# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Vagrantのmountエラーを解決しようとしたらvboxのリビルドがこける
# http://qiita.com/wakaba260/items/b5c87b7815b710f303a0
script = <<SCRIPT
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provision "shell", inline: script
  config.vm.hostname = "hiroshima-arc-ruby-webapp"
  config.vm.box = "hiroshima-arc/ruby-study-env"
  config.vm.network "forwarded_port", guest: 9292, host: 9292
  config.vm.synced_folder ".", "/vagrant", disabled: false

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "2024"]
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  end
end