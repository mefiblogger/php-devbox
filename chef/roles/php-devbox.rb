# Name of the role should match the name of the file
name "vagrant-test-box"

# Root passwords
override_attributes(
    "mysql" => {
        "server_root_password" => "devbox",
        "server_repl_password" => "devbox",
        "server_debian_password" => "devbox"
    }
)

# Run list function we mentioned earlier
run_list(
    "recipe[apt]",
    "recipe[vim]",
    "recipe[openssl]",
    "recipe[apache2]",
    "recipe[apache2::mod_php5]",
    "recipe[mysql::client]",
    "recipe[mysql::server]",
    "recipe[php]"
)

