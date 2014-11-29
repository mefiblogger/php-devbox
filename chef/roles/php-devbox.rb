name "php-devbox"

override_attributes(
    "mysql" => {
        "server_root_password" => "devbox",
        "server_repl_password" => "devbox",
        "server_debian_password" => "devbox"
    }
)

run_list(
    "recipe[apt]",
    "recipe[vim]",
    "recipe[dmg]",
    "recipe[runit]",
    "recipe[git]",
    "recipe[openssl]",
    "recipe[apache2]",
    "recipe[apache2::mod_php5]",
    "recipe[mysql::client]",
    "recipe[mysql::server]",
    "recipe[php]",
    "recipe[chef-php-extra]",
    "recipe[chef-php-extra::development]"
)

