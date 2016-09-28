# ------------------------------------------------------------------------------------------------------------------
# This file runs at the end of vagrant-bootstrap.sh (but before the local-vagrant-bootstrap),
# any project specific customization to your box's setup should happen here.
# ------------------------------------------------------------------------------------------------------------------

# # # get laravel installer installed boyee
cat >> ~/.bashrc <<EOF
export PATH=~/.composer/vendor/bin:\$PATH
EOF
composer global require "laravel/installer"
figlet -f banner LARAVEL LOADED


# # # install yo, and the usual generators. (for existing projects, you can comment this out)
sudo npm install --global yo


# # # install gulp
sudo npm install --global gulp
sudo npm install --global gulp-cli


# # Install Mailcatcher and run it on port 1080
# # Remember to forward this port in your Vagrantfile

# sudo apt-get -y install ruby-dev libsqlite3-dev
# sudo gem install mime-types --version "< 3"
# sudo gem install --conservative mailcatcher
# mailcatcher --http-ip=0.0.0.0

# # install dumb old mcrypt

# sudo apt-get install -y mcrypt php5-mcrypt
# sudo php5enmod mcrypt

# # install imap for php

# sudo apt-get install -y libc-client-dev
# sudo apt-get install -y php5-imap
# sudo php5enmod imap


