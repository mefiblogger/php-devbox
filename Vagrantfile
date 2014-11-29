Vagrant.configure("2") do |config|
  config.omnibus.chef_version = :latest
end

Vagrant::Config.run do |config|
  # Your local name for the basebox you want to use.
  config.vm.box = "php-devbox"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.222.222"

  # Use the vagrant hostmaster plugin[^5] to automatically add a domain name
  config.vm.host_name = "devbox.localhost"

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # You can add as many of these as you like, anywhere you like
  config.vm.share_folder "public", "/public", "../Sites", :nfs => true

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  config.vm.provision :chef_solo do |chef|
    chef.roles_path = "./chef/roles"
    chef.cookbooks_path = ["./chef/cookbooks"]
    chef.add_role "php-devbox"
  end
end
