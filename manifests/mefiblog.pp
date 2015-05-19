package {['vim', 'curl', 'git']:
    ensure => installed,
               require => Exec["apt-get update"]
}
exec { "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer":
    path => '/usr/bin/',
    unless => 'which composer'
}
exec { "composer self-update":
    path => '/usr/bin/'
}
exec { "git clone https://github.com/mefiblogger/mefiblog.git /var/www/mefiblog" :
    path => "/usr/bin",
    unless => "/usr/bin/test -e /var/www/mefiblog"
}
exec { "composer update":
    path => "/usr/bin",
    cwd => "/var/www/mefiblog"
}
