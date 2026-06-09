# install pre-reqs: bash, curl and HTTPS transport support for apt
sudo apt-get install -y curl apt-transport-https ca-certificates

# install fast-apt-mirror.sh under /usr/local/bin/ to make it automatically available via $PATH
sudo curl https://raw.githubusercontent.com/vegardit/fast-apt-mirror.sh/v1/fast-apt-mirror.sh -o /usr/local/bin/fast-apt-mirror.sh
sudo chmod 755 /usr/local/bin/fast-apt-mirror.sh

# show the help
echo "$ fast-apt-mirror.sh --help"

