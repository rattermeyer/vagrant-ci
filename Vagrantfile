# vim: set autoindent ft=ruby : 
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "docker-repos" do |repos|
    repos.vm.provider "docker" do |d|
      d.build_dir = "docker-repos"
      d.name = "repos"
      d.has_ssh = true
      d.expose = ["8081","22"]
    end
  end
  config.vm.define "docker-cimaster" do |cim|
    cim.vm.provider "docker" do |d|
      d.build_dir = "docker-cimaster"
      d.name = "cimaster"
      d.link("repos:repos")
      d.has_ssh = true
      d.expose = ["8080","22"]
      d.ports  = ["8080:8080"]
    end
  end
  config.vm.define "docker-slave" do |repos|
    repos.vm.provider "docker" do |d|
      d.build_dir = "docker-slave"
      d.name = "slave-1"
      d.link("cimaster:cimaster")
      d.link("repos:repos")
      d.has_ssh = false
      d.expose = ["22"]
    end
  end
end
