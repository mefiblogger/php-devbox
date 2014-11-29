php-devbox
==========

A PHP devbox made with [Vagrant](https://www.vagrantup.com/) and [Chef](https://www.getchef.com/chef/) for super fast local developments.

This is mostly just for playfully learn Vagrant and Chef. Feel free to do anything with it!

## How to start

1. [Install Vagrant](https://docs.vagrantup.com/v2/getting-started/).
2. Clone this repository: ```git clone git@github.com:mefiblogger/php-devbox.git```
3. Init submodules: ```git submodule update --init```
4. Add a precise64 box called php-devbox: ```vagrant box add php-devbox http://files.vagrantup.com/precise64.box```
5. In the php-devbox folder, run: ```vagrant up```
6. Be patient! It takes some time on the first start.
7. Open your browser: http://192.168.222.222/

## What's in the box?

The most important things:

- Apache
- MySQL (server and client)
- PHP with XDebug
- PHPUnit
- PHP Mass Detector
- PHP CodeSniffer

... and a lots more.

## Useful links

- https://github.com/inviqa/chef-php-extra
- https://github.com/opscode-cookbooks/
- http://adamcod.es/2013/01/15/vagrant-is-easy-chef-is-hard.html
- http://adamcod.es/2013/01/15/vagrant-is-easy-chef-is-hard-part2.html
