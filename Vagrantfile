# vim: set autoindent ft=ruby : 
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "docker-repos" do |repos|
    repos.vm.provider "docker" do |d|
      d.build_dir = "docker-repos"
      d.name = "repos"
      d.has_ssh = true
      d.expose = ["8081","22"]
      d.ports = ["8081:8081","22:10023"]
    end
  end
  config.vm.define "docker-sonar-mysql" do |repos|
    repos.vm.provider "docker" do |d|
      d.image = "tpires/sonar-mysql"
      d.name = "smysql"
      d.expose = ["3306"]
      d.ports = ["3306:3306"]
    end
  end
  config.vm.define "docker-sonar" do |repos|
    repos.vm.provider "docker" do |d|
      d.image = "tpires/sonar-server"
      d.name = "sonar"
      d.expose = ["9000"]
      d.ports = ["9000:9000"]
      d.link("smysql:db")
    end
  end
  config.vm.define "docker-cimaster", primary: true do |cim|
    cim.vm.provider "docker" do |d|
      d.build_dir = "docker-cimaster"
      d.name = "cimaster"
      d.link("repos:repos")
      d.link("smysql:smysql")
      d.has_ssh = true
      d.expose = ["8080","22"]
      d.ports  = ["8080:8080","22:10022"]
    end
  end
  config.vm.define "docker-slave", autostart: false do |repos|
    repos.vm.provider "docker" do |d|
      d.build_dir = "docker-slave"
      d.name = "slave-1"
      d.link("cimaster:cimaster")
      d.link("repos:repos")
      d.has_ssh = false
      d.expose = ["22"]
      d.cmd=["-master", "http://cimaster:8080/jenkins", "-executors", "1", "-fsroot", "/var/lib/jenkins"]
    end
  end
end
