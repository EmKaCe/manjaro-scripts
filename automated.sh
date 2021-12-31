#!/bin/bash

if ! command -v git &> /dev/null
then
	sudo pamac install --no-confirm git
fi

git clone https://github.com/EmKaCe/manjaro-scripts.git
cd manjaro-scripts
chmod +x install.sh
./install.sh
