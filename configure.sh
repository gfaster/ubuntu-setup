#!bin/bash
set -e

# autostart guake
sudo cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

# setup bash profile
cp ./.gfasters-bashrc ~/ &&
grep -Fq "source ~/.gfasters-bashrc" < ~/.bashrc || echo "source ~/.gfasters-bashrc" >> ~/.bashrc

# enable gcm - there is probably more to do here
git config --global credential.credentialStore "cache --timeout=86400"
