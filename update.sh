sudo apt update
sudo apt upgrade -y

echo '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update

asdf plugin update --all

pip3 install docker-compose --upgrade
