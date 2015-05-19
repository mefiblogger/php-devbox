VAGRANTFILE_API_VERSION = "2"
  Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.network :private_network, ip: "192.168.222.222"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.hostname = "php-devbox.localhost"  
  config.vm.define "php-devbox" do |f| end
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider "virtualbox" do |v|
    v.name = "php-devbox"
    v.memory = "2048"
  end

  config.ssh.forward_agent = true

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests/"
    puppet.manifest_file = "site.pp"
    puppet.options = '--verbose --debug'
  end

# if you have some naughty error, turn this on
#  config.vm.provider :virtualbox do |vb|
#    vb.gui = true
#  end
end
