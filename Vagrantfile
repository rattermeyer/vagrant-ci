# vim: set autoindent ft=ruby : 
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "docker-repos" do |repos|
    repos.vm.provider "docker" do |d|
      d.build_dir = "docker-repos"
      d.build_args = ["-t", "devopsarchitect/repos"]
      d.name = "repo1"
      d.has_ssh = true
      d.expose = ["8081","22"]
      d.ports = ["8081:8081","10023:22"]
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
end
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "docker-sonar" do |repos|
    repos.vm.provider "docker" do |d|
      #d.image = "tpires/sonar-server"
      d.build_dir = "docker-sonar"
      d.build_args = ["-t", "devopsarchitect/sonar"]
      d.name = "sonar1"
      d.expose = ["9000"]
      d.ports = ["9000:9000"]
    end
  end
  config.vm.define "docker-cimaster" do |cim|
    cim.vm.provider "docker" do |d|
      d.build_dir = "docker-cimaster"
      d.build_args = ["-t", "devopsarchitect/jenkinsmaster"]
      d.name = "jenkinsmaster1"
      d.has_ssh = true
      d.expose = ["8080"]
      d.ports  = ["8080:8080"]
    end
  end
end
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "docker-slave" do |repos|
    repos.vm.provider "docker" do |d|
      d.build_dir = "docker-slave"
      d.build_args = ["-t", "devopsarchitect/jenkinsslave"]
      d.name = "slave1"
      d.has_ssh = false
      d.expose = ["22"]
      d.ports  = ["20022:22"]
      d.cmd=["-master", "http://jenkinsmaster1.jenkinsmaster.dev.docker.:8080/jenkins", "-executors", "1", "-fsroot", "/var/lib/jenkins"]
    end
  end
end
