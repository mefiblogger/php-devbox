Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "php-devbox.localhost"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.222.222"

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.synced_folder "www", "/var/www/", type: "nfs"
  config.vm.synced_folder "config", "/usr/local/php-devbox/config", type: "nfs"

  config.vm.provision :shell, path: "php-devbox.sh", keep_color: true
end
