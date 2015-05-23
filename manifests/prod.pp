exec {"apt-get update":
    path => "/usr/bin",
}
package {['vim', 'curl', 'git']:
    ensure => installed,
    require => Exec["apt-get update"]
}
package {"nginx":
    ensure => present,
           require => Exec["apt-get update"],
}
service { "nginx":
    ensure => "running",
           require => Package["nginx"]
}
package {['mysql-server', 'mysql-client']:
    ensure => installed,
           require => Exec["apt-get update"]
}
service { 'mysql':
    ensure  => running,
            require => Package['mysql-server'],
}
package { ["php5-common", "php5-fpm", "php5-cli", "php-apc", "php5-mysql", "php5-xdebug"]:
    ensure => installed,
           notify => Service["nginx"],
           require => [Exec["apt-get update"], Package['mysql-client'], Package['nginx']],
}
exec { "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer":
    path => '/usr/bin/',
    unless => 'which composer',
    require => Package["curl", "php5-cli"]
}
exec { "composer self-update":
    path => "/usr/bin/",
    onlyif => "which composer"
}
exec { "git clone https://github.com/mefiblogger/mefiblog.git /var/www/mefiblog" :
    path => "/usr/bin",
    unless => "/usr/bin/test -e /var/www/mefiblog",
    require => Package["git"]
}
exec { "composer update --no-interaction":
    path => "/usr/bin",
    cwd => "/var/www/mefiblog",
    onlyif => "which composer",
    require => Exec["git clone https://github.com/mefiblogger/mefiblog.git /var/www/mefiblog"]
}
