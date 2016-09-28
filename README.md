# jessie64-vagrant-devbox
Vagrant box built on Debian8 "Jessie", installs a lamp stack and the usual slew of development tools.

# Setup

The parameters for your vagrant box are hosted in 1_local-vagrant-config.rb.

In here you will set;
- VM ip
- VM Hostname, accessible in your host's browser
- Primary application folder and nested public folder

By default a simple LAMP stack is installed as well as;
- Composer
- Bower
- Node

Project specific needs should be placed in 2_project-vagrant-bootstrap.php
This would include any generators, specific php modules or server tools.

Everyone loves to have it their way, so put any persnickity preferences inside
3_local-vagrant-bootstrap.php (after removing the .sample suffix), this file will be skipped.
