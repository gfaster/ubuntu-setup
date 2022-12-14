#!bin/bash
set -e

# autostart guake (seems to be something up with the symlink, so we need to futz around with it)
# if [ -L /usr/share/applications/guake.desktop ] ; then
#   if [ -e /usr/share/applications/guake.desktop ] ; then
# 		sudo install -m 644 /usr/share/applications/guake.desktop /etc/xdg/autostart/guake.desktop
# 	else
# 		sudo rm /usr/share/applications/guake.desktop
# 		sudo install -m 644  /usr/share/guake/autostart-guake.desktop /etc/xdg/autostart/guake.desktop
# 	fi
# else
# 	sudo install -m 644  /usr/share/guake/autostart-guake.desktop /etc/xdg/autostart/guake.desktop
# fi


sudo apt update && sudo apt upgrade

sh load_dotfiles.sh -I


# Settings - I need to check if this may change
xfconf-query -c xfce4-panel -p /plugins/plugin-12/digital-format -s "%Y-%m-%d %l:%M %p (%a)"
# disable desktop icons (set to 2 to restore)
xfconf-query -c xfce4-desktop -v --create -p /desktop-icons/style -t int -s 0

# Setup network security
mkdir -p /usr/local/scripts/setup
# install -m 700 # adfafsaafafasd


sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 5353/udp # avahi
sudo ufw allow imap
sudo ufw allow smtp
sudo ufw logging on
sudo ufw enable


# Parts of this were stolen from: https://github.com/ukncsc/Device-Security-Guidance-Configuration-Packs/blob/main/Linux/UbuntuLTS/
# -------------------------------------
# Disable spyware
sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo systemctl mask apport.service

sudo systemctl stop whoopsie.service
sudo systemctl disable whoopsie.service
sudo systemctl mask whoopsie.service

sudo systemctl stop ua-messaging.timer
sudo systemctl disable ua-messaging.timer
sudo systemctl mask ua-messaging.timer

sudo systemctl stop ua-messaging.service
sudo systemctl diable ua-messaging.service
sudo systemctl mask ua-messaging.service

sudo systemctl stop ua-timer.timer
sudo systemctl disable ua-timer.timer
sudo systemctl mask ua-timer.timer

sudo rm /etc/apt/apt.conf.d/20apt-esm-hook.conf

sudo apt-get remove -y popularity-contest

# Set some AppArmor profiles to enforce mode.
# avahi broadcasts on local network
sudo aa-enforce /etc/apparmor.d/usr.bin.firefox
sudo aa-enforce /etc/apparmor.d/usr.sbin.avahi-daemon
sudo aa-enforce /etc/apparmor.d/usr.sbin.dnsmasq
sudo aa-enforce /etc/apparmor.d/bin.ping
sudo aa-enforce /etc/apparmor.d/usr.sbin.rsyslogd
