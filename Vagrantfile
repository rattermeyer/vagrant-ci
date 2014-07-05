# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "gitlab" do |gitlab|
    gitlab.vm.box = "devopsarchitect/ubuntu-trusty-docker-puppet-14.04"
    gitlab.vm.hostname = "gitlab.vm"
    if Vagrant.has_plugin?("vagrant-proxyconf")
      gitlab.proxy.http     = "http://tuxedo:3129/"
      gitlab.proxy.https    = "http://tuxedo:3129/"
      gitlab.proxy.no_proxy = "localhost,127.0.0.1,.friz.box"
      gitlab.apt_proxy.http  = "http://tuxedo:3142"
      gitlab.apt_proxy.https = "DIRECT"
    end
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
    end
    gitlab.vm.network "forwarded_port", guest: 80, host: 10080
    gitlab.vm.provider "virtualbox" do |vb|
       vb.customize ["modifyvm", :id, "--memory", "1024"]
       vb.customize ["modifyvm", :id, "--nic1", "nat"]
       vb.customize ["modifyvm", :id, "--nic2", "hostonly"]
       vb.customize ["modifyvm", :id, "--hostonlyadapter2", "vboxnet0"]
    end
    gitlab.vm.provision "shell", path: "install-gitlab.sh"
    gitlab.vm.provision "puppet" do |puppet| 
      puppet.manifest_file = "gitlab.pp"
      puppet.module_path = "modules"
    end
  end
  config.vm.define "cimaster" do |cimaster|
    cimaster.vm.box = "devopsarchitect/ubuntu-trusty-docker-puppet-14.04"
    cimaster.vm.hostname = "ci-master.vm"
    if Vagrant.has_plugin?("vagrant-proxyconf")
      cimaster.proxy.http     = "http://tuxedo:3129/"
      cimaster.proxy.https    = "http://tuxedo:3129/"
      cimaster.proxy.no_proxy = "localhost,127.0.0.1,.friz.box"
      cimaster.apt_proxy.http  = "http://tuxedo:3142"
      cimaster.apt_proxy.https = "DIRECT"
    end
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
      # For more information please check http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
    end
    cimaster.vm.provider "virtualbox" do |vb|
       vb.customize ["modifyvm", :id, "--memory", "2048"]
       vb.customize ["modifyvm", :id, "--nic1", "nat"]
       vb.customize ["modifyvm", :id, "--nic2", "hostonly"]
       vb.customize ["modifyvm", :id, "--hostonlyadapter2", "vboxnet0"]
    end
    cimaster.vm.provision "shell", path: "install.sh"
  end
end
