#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install python3-pip

sudo rm -f /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python
python --version
pip3 install scons

sudo dkp-pacman -Syu --noconfirm switch-pkg-config switch-freetype switch-bulletphysics switch-libtheora switch-libpcre2 switch-mesa switch-opusfile switch-mbedtls switch-libwebp switch-libvpx switch-miniupnpc
$HOME/.local/bin/scons platform=switch tools=no target=release_debug -j2