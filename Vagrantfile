# -*- mode: ruby -*-
# vi: set ft=ruby :
ubuntu="ubuntu/xenial64"
key = File.read("#{Dir.home}/.ssh/id_rsa.pub")
validator = File.read("#{Dir.home}/ss-academy/vagrant_lamp/softserve-validator.pem")
client_db = File.read("#{Dir.home}/ss-academy/vagrant_lamp/client_db.rb")
client_web = File.read("#{Dir.home}/ss-academy/vagrant_lamp/client_web.rb")

nodes = [
	{box: ubuntu, name: 'web', hostname: 'roman-web', ip: '172.16.2.11', client: client_web},
	{box: ubuntu, name: 'db', hostname: 'roman-db', ip: '172.16.2.10', client: client_db}
	]

Vagrant.configure("2") do |config|
  nodes.each do |nodes|
  config.vm.define nodes[:name] do |node|
    node.vm.box =  nodes[:box]
    node.vm.network "private_network", ip: nodes[:ip]
    node.vm.hostname = nodes[:name]
    node.vm.provision "shell", inline:<<-SHELL
      cd /tmp
      wget https://packages.chef.io/files/stable/chef/14.4.56/ubuntu/16.04/chef_14.4.56-1_amd64.deb 2>/dev/null
      sudo dpkg -i chef_14.4.56-1_amd64.deb
      sudo mkdir /etc/chef
      sudo echo '#{validator}' >> /etc/chef/softserve-validator.pem
      sudo echo '#{nodes[:client]}' >> /etc/chef/client.rb
      sudo chef-client
     SHELL
    end
  end
end
#  config.vm.define "db" do |db|
#	db.vm.box = "ubuntu/xenial64"
#	db.vm.network "private_network", ip: "172.16.2.10"
#        db.vm.hostname = 'db'
#        db.vm.provider :virtualbox do |vb|
#          vb.name = 'db'
#        end
#	db.vm.provision "shell", path: "db.sh"
#        db.vm.provision "shell", inline:<<-SHELL
#         sudo apt-get install -y python
#         echo '#{id_rsa}' >> /home/vagrant/.ssh/authorized_keys
#	SHELL
#  end
  
#  config.vm.define "web" do |web|
#	web.vm.box = "ubuntu/xenial64"
#	web.vm.network "private_network", ip: "172.16.2.11"
#        web.vm.hostname = 'web'
#        web.vm.provider :virtualbox do |vb|
#          vb.name = 'web'
#        end 
#	web.vm.provision "shell", path: "web.sh"
#        web.vm.provision "shell", inline:<<-SHELL
#         sudo apt-get install -y python
#         echo '#{id_rsa}' >> /home/vagrant/.ssh/authorized_keys
#	SHELL
#  end
#end
