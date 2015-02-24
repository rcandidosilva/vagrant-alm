# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "chef/centos-6.5"
    jenkins.vm.provision :shell, path: "bootstrap-jenkins-complete.sh"
    jenkins.vm.network :forwarded_port, host: 8085, guest: 8085

    jenkins.vm.provider "virtualbox" do |vb|
        vb.name= "jenkins"
        vb.gui = false
        vb.customize ["modifyvm", :id, "--memory", "1024"]
        vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
  end

  config.vm.define "sonar" do |sonar|
    sonar.vm.box = "chef/centos-6.5"
    sonar.vm.provision :shell, path: "bootstrap-sonar-complete.sh"
    sonar.vm.network :forwarded_port, host: 3306, guest: 3306
    sonar.vm.network :forwarded_port, host: 8086, guest: 8086

    sonar.vm.provider "virtualbox" do |vb|
      vb.name= "sonar"
      vb.gui = false
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
  end

  config.vm.define "gitblit", autostart: false do |gitblit|
    gitblit.vm.box = "chef/centos-6.5"
    gitblit.vm.provision :shell, path: "bootstrap-gitblit-complete.sh"
    gitblit.vm.network :forwarded_port, host: 8087, guest: 8087
    gitblit.vm.network :forwarded_port, host: 8088, guest: 8088

    gitblit.vm.provider "virtualbox" do |vb|
      vb.name= "gitblit"
      vb.gui = false
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
  end

  config.vm.define "nexus" do |nexus|
    nexus.vm.box = "chef/centos-6.5"
    nexus.vm.provision :shell, path: "bootstrap-nexus-complete.sh"
    nexus.vm.network :forwarded_port, host: 8089, guest: 8089

    nexus.vm.provider "virtualbox" do |vb|
      vb.name= "nexus"
      vb.gui = false
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
  end

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.provider "virtualbox" do |vb|
    vb.name= "ALM"
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
  end

end
