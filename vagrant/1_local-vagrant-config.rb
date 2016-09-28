# -*- mode: ruby -*-
# vi: set ft=ruby :

# BASIC LOCAL GUEST CONFIGURATION
LOCAL_ARGS = {
	"guest_ip" => '192.168.11.99', # use an ip that is unlikely to conflict with something on you're local network
	"guest_hostname" => 'development-website.dev', # accessible in your host machine's browser
	"app_root" => 'application', # the directory your project will be contained in, same folder level as vagrant/
	"doc_root" => 'public' # your site's public directory, expected to be within app_root
}


