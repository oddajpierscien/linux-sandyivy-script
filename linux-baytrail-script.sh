#!/bin/bash

info() {
    echo -e "\e[92m[*] $1\e[39m"
}

info "linux-baytrail-script by LiamxDev (https://liamxdev.ovh) (https://github.com/liamxdev)"
info "Starting script..."
info "Adding Gallium OS repo..."
echo -e "deb http://apt.galliumos.org xenon main\ndeb-src http://apt.galliumos.org xenon main" | tee /etc/apt/sources.list.d/galliumos.list
info "Installing curl..."
apt install curl -y
info "Adding Gallium OS key..."
curl https://apt.galliumos.org/galliumos.gpg | apt-key add
info "Updating repos..."
apt update
info "Upgrading system..."
apt dist-upgrade -y
info "Changing priority in Gallium OS repo..."
sed -i -e 's/9999/1/g' /etc/apt/preferences.d/galliumos.pref
info "Updating repos and system again..."
apt update
apt dist-upgrade -y
info "Installing Gallium OS BayTrail kernel..."
apt install linux-image-galliumos galliumos-baytrail -y
info "Deleting other kernels..."
apt remove linux-*generic -y
info "Updating GRUB..."
update-grub
info "Success! Now reboot your chromebook!"