exec {"apt-get update":
    path => "/usr/bin",
}
package {['vim', 'curl', 'git']:
    ensure => installed,
    require => Exec["apt-get update"]
}
package {"apache2":
    ensure => present,
           require => Exec["apt-get update"],
}
service { "apache2":
    ensure => "running",
           require => Package["apache2"]
}
package {['mysql-server', 'mysql-client']:
    ensure => installed,
           require => Exec["apt-get update"]
}
service { 'mysql':
    ensure  => running,
            require => Package['mysql-server'],
}
package { ["php5-common", "libapache2-mod-php5", "php5-cli", "php-apc", "php5-mysql", "php5-xdebug"]:
    ensure => installed,
           notify => Service["apache2"],
           require => [Exec["apt-get update"], Package['mysql-client'], Package['apache2']],
}
exec { "/usr/sbin/a2enmod rewrite" :
    unless => "/bin/readlink -e /etc/apache2/mods-enabled/rewrite.load",
           notify => Service[apache2],
           require => Package['apache2']
}
file {"/var/www":
    ensure => "link",
           target => "/vagrant/www",
           require => Package["apache2"],
           notify => Service["apache2"],
           replace => yes,
           force => true,
}
file { "/etc/apache2/sites-available/default":
    ensure => "link",
           target => "/vagrant/manifests/assets/vhost.conf",
           require => Package["apache2"],
           notify => Service["apache2"],
           replace => yes,
           force => true,
}
exec { "ApacheUserChange" :
    command => "/bin/sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/' /etc/apache2/envvars",
            onlyif  => "/bin/grep -c 'APACHE_RUN_USER=www-data' /etc/apache2/envvars",
            require => Package["apache2"],
            notify  => Service["apache2"],
}
exec { "ApacheGroupChange" :
    command => "/bin/sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars",
            onlyif  => "/bin/grep -c 'APACHE_RUN_GROUP=www-data' /etc/apache2/envvars",
            require => Package["apache2"],
            notify  => Service["apache2"],
}
exec { "apache_lockfile_permissions" :
    command => "/bin/chown -R vagrant:www-data /var/lock/apache2",
            require => Package["apache2"],
            notify  => Service["apache2"],
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
