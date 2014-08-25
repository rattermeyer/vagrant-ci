# vim: set autoindent ft=ruby : 
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "docker" do |d|
    d.build_dir = "docker-cimaster"
    d.name = "cimaster"
    d.has_ssh = true
    d.ports = ["8080:8080"]
  end
end
