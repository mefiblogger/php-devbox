Vagrant.configure("2") do |config|
  config.omnibus.chef_version = :latest
end

Vagrant::Config.run do |config|
  config.vm.box = "php-devbox"
  config.vm.network :hostonly, "192.168.222.222"
  config.vm.share_folder "public", "/public", "../Sites", :nfs => true
  config.vm.provision :chef_solo do |chef|
    chef.roles_path = "./chef/roles"
    chef.cookbooks_path = ["./chef/cookbooks"]
    chef.add_role "php-devbox"
  end
end
