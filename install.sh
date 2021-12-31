#!/bin/bash

# Update system
echo "--- SYSTEM UPDATE ---"
sudo pamac update
sudo pamac upgrade

# Enable snap & flatpak
echo ""
echo "--- SNAP & FLATPAK ---"
sudo pamac install snapd libpamac-snap-plugin
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap 

sudo pamac install flatpak libpamac-flatpak-plugin
read -n 1 -s -r -p "Enable snap & flatpak in pamac, then press any key to continue..."
echo "Done!"

# Install software
echo ""
echo "--- SOFTWARE PACKAGES ---"
sudo pamac install bitwarden chromium code discord geary gnome-clocks gnome-weather gimp keepassxc obs-studio onlyoffice-desktopeditors seahorse

sudo snap install insomnia jdownloader2 mockoon orchis-themes transmission-gtk

# Install firefox addons
echo ""
echo "--- FIREFOX ---"
addons=("3886236" "3861819" "3886960" "3871271" "898030" "3883584" "3883046" "3883479" "3872957" "3878893")
for i in ${addons[@]}
do
	firefox https://addons.mozilla.org/firefox/downloads/file/$i/
done
read -n 1 -s -r -p "Install addons, then press any key to continue..."
echo "Done!"


# Adjust Desktop Environment
# gnome extensions
echo ""
echo "--- GNOME EXTENSIONS ---"
sudo pamac install curl wget jq unzip
wget https://raw.githubusercontent.com/cyfrost/install-gnome-extensions/master/install-gnome-extensions.sh
chmod +x install-gnome-extensions.sh
./install-gnome-extensions.sh --enable 19 307 1160 1503 3628
rm install-gnome-extensions.sh

# Dash-To-Pane
gnome-extensions prefs dash-to-panel@jderose9.github.com
echo "Import dashtopanel-settings and CLOSE THE WINDOW"
read -n 1 -s -r -p "Press any key to continue..."
echo ""

# ArcMenu
echo "Import arcmenu-settings and CLOSE THE WINDOW"
read -n 1 -s -r -p "Press any key to continue..."
echo "Done!"

# dynamic wallpaper
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

# Theme
echo ""
echo "--- ICONS ---"
echo ""
git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
cd Tela-circle-icon-theme
sudo install.sh -a
cd ..
rm -rf Tela-circle-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-purple-dark'
echo "Done!"
