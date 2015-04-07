php-devbox
==========

A PHP devbox made with [Vagrant](https://www.vagrantup.com/) and a bash installscript for super fast local developments.

This is mostly just for playfully learn Vagrant. Feel free to do anything with it!

## How to start

1. [Install Vagrant](https://docs.vagrantup.com/v2/getting-started/).
2. Clone this repository: ```git clone git@github.com:mefiblogger/php-devbox.git```
3. Init submodules: ```git submodule update --init```
4. Add a precise64 box called php-devbox: ```vagrant box add php-devbox http://files.vagrantup.com/precise64.box```
5. In the php-devbox folder, run: ```vagrant up```
6. Be patient! It takes some time on the first start.
7. Meanwhile, add php-devbox.localhost 192.168.222.222 to your hosts file.
7. Open your browser: http://php-devbox.localhost/ or http://192.168.222.222/

## What's in the box?

The most important things:

- Apache
- MySQL (server and client)
- PHP (5.3.29) with XDebug
- PHPUnit
- PHP Mass Detector
- PHP CodeSniffer

... and a lots more.
