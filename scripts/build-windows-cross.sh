#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y mingw-w64 python3-pip

sudo rm -f /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python
python --version
pip3 install scons

sudo update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix
sudo update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix

$HOME/.local/bin/scons platform=windows tools=yes target=release_debug -j2