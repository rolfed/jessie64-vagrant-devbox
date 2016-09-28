# # friendly up vars
USER="$(whoami)"
HOST=$2
APP_ROOT=$3
DOC_ROOT=$4
MYSQL_PASSWORD='vagrant'
# APP_CONFIG_PATH=$DOC_ROOT'config'

echo "Howdy ${USER}, let's get this server servin'"

# # update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# # might as well look good doin' it
sudo apt-get -y install figlet
figlet -f banner FIGLET INSTALLED

# # prevent debconf from having to look for stdin
sudo ex +"%s@DPkg@//DPkg" -cwq /etc/apt/apt.conf.d/70debconf
sudo dpkg-reconfigure debconf -f noninteractive -p critical

sudo debconf-set-selections <<< "grub-pc	grub-pc/install_devices	multiselect	/dev/sda"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD"

# # install server utils
sudo apt-get install -y vim
sudo apt-get install -y htop
sudo apt-get install -y curl
sudo apt-get install -y git-core

figlet -f banner SERVER UTILS INSTALLED

# # LAMP SETUP

# # # install mariadb or mysql (mariadb preffered)
# sudo apt-get -y install mariadb-server mariadb-client
sudo apt-get -y install mysql-server
figlet -f banner mysql/maria installed

# # # install apache 2.x and php 5.x
sudo apt-get -y install apache2
sudo apt-get -y install php5 libapache2-mod-php5
sudo apt-get install -y php5-mysqlnd

# # # install php dev tools (necessary for some other shit)
sudo apt-get install -y php5-dev
figlet -f banner php installed


# # LAMP EXTRAS
sudo apt-get install -y php5-gd
sudo apt-get install -y php5-curl

# # FINISH UP LAMP SETUP

# # # enable apache mods
sudo a2enmod headers
sudo a2enmod php5
sudo a2enmod rewrite

# # # set up docroot
sudo rm -rf /var/www/html
sudo mkdir -p /var/www/$APP_ROOT/$DOC_ROOT


# # # setup hosts file
VHOST=$(cat <<EOF
<Directory /var/www/$APP_ROOT/$DOC_ROOT>
    AllowOverride All
    Order Allow,Deny
    Allow from All
</Directory>
<VirtualHost *:80>
    ServerName $HOST
    DocumentRoot /var/www/$APP_ROOT/$DOC_ROOT/
</VirtualHost>
EOF
)

# # # gotta touch before you can echo, permissions amirite
sudo touch /etc/apache2/sites-available/$HOST.conf
sudo chown vagrant:vagrant /etc/apache2/sites-available/$HOST.conf
sudo echo "${VHOST}" > /etc/apache2/sites-available/$HOST.conf

# # # start site
sudo a2dissite 000-default.conf
sudo a2ensite $HOST.conf

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
figlet -f banner COMPOSER INSTALLED


# # # install Node.js v4.x LTS Argon and npm
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install --global npm@latest


# # # install bower
sudo npm install --global bower

# # just make life easier
echo "cd /var/www" >> /home/vagrant/.bashrc

# # Run Project Bootstrap
. /var/www/vagrant/2_project-vagrant-bootstrap.sh

# # Run Local Bootstrap
if [ -f /var/www/vagrant/3_local-vagrant-bootstrap.sh ]; then
	. /var/www/vagrant/3_local-vagrant-bootstrap.sh
fi

# # FINISH HIM!
sudo service apache2 reload
figlet -f banner $HOST IS UP