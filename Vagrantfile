#
# Barebones script to just install docker
#
$script = <<SCRIPT

sudo apt-get install -y curl
curl -sSL https://get.docker.com/ubuntu/ | sudo sh
sudo usermod -a -G docker vagrant

SCRIPT


Vagrant.configure("2") do |config|
  
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  parent_folder = File.expand_path("..", Dir.pwd)
  config.vm.network :forwarded_port, guest: 8000, host: 8000
  config.vm.provision "shell", inline: $script

end