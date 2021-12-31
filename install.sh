#!/bin/bash

# Update system
echo "--- SYSTEM UPDATE ---"
sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
sudo pamac update --no-confirm
sudo pamac upgrade --no-confirm

# Enable snap & flatpak
echo ""
echo "--- SNAP & FLATPAK ---"
sudo pamac install --no-confirm snapd libpamac-snap-plugin 
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap 

sudo pamac install --no-confirm flatpak libpamac-flatpak-plugin
read -p "Enable snap & flatpak in pamac, then press enter to continue..."
echo "Done!"

# Install software
echo ""
echo "--- SOFTWARE PACKAGES ---"
sudo pamac install --no-confirm bash-completion bitwarden chromium code discord geary gnome-clocks gnome-weather gimp keepassxc obs-studio onlyoffice-desktopeditors seahorse

sudo snap install insomnia jdownloader2 mockoon orchis-themes transmission-gtk

# Install firefox addons
echo ""
echo "--- FIREFOX ---"
addons=("3886236" "3861819" "3886960" "3871271" "898030" "3883584" "3883046" "3883479" "3872957" "3878893")
for i in ${addons[@]}
do
	firefox https://addons.mozilla.org/firefox/downloads/file/$i/
done
echo ""


# Adjust Desktop Environment
# Install extensions
echo ""
echo "--- GNOME EXTENSIONS ---"
sudo pamac install --no-confirm curl wget jq unzip
wget https://raw.githubusercontent.com/cyfrost/install-gnome-extensions/master/install-gnome-extensions.sh
chmod +x install-gnome-extensions.sh
./install-gnome-extensions.sh --enable 19 307 1160 1503 3628
rm install-gnome-extensions.sh

# Extension settings
echo ""
echo "--- DASH-TO-PANEL SETTINGS ---"
while DTP= read -r line
do
	gsettings set $line
done < "settings/dash-to-panel"

echo ""
echo "--- DASH-TO-DOCK SETTINGS ---"
while DTD= read -r line
do
	gsettings set $line
done < "settings/dash-to-dock"

echo ""
echo "--- ARCMENU SETTINGS ---"
while ARC= read -r line
do
	gsettings set $line
done < "settings/arcmenu"

# Dynamic wallpaper
echo ""
echo "--- DYNMAIC WALLPAPER ---"
echo ""
sudo mkdir -p /usr/local/share/gnome-background-properties
sudo mkdir -p /usr/local/share/backgrounds/gnome
sudo cp backgrounds/wallpaper/* /usr/local/share/gnome-background-properties/
sudo cp -R backgrounds/gnome/* /usr/local/share/backgrounds/gnome/
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/local/share/backgrounds/gnome/lakeside-timed.xml'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/local/share/backgrounds/gnome/lakeside-timed.xml'
echo "Done!"

# Theme
echo ""
echo "--- THEME ---"
echo ""
wget https://github.com/vinceliuice/Orchis-theme/raw/master/release/Orchis-purple.tar.xz
mkdir -p ~/.themes
tar -xf Orchis-purple.tar.xz -C ~/.themes/
gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-purple-dark'
gsettings set org.gnome.shell.extensions.user-theme name 'Orchis-purple-dark'
rm Orchis-purple.tar.xz
echo "Done!"

# Icons
echo ""
echo "--- ICONS ---"
echo ""
git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
cd Tela-circle-icon-theme
chmod +x install.sh
sudo ./install.sh -a
cd ..
rm -rf Tela-circle-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-purple-dark'
echo "Done!"
