#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install build-essential python3-pip pkg-config libx11-dev libxcursor-dev libxinerama-dev \
    libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libfreetype6-dev libudev-dev libxi-dev \
    libxrandr-dev yasm

sudo rm -f /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python
python --version
pip3 install scons

# There's a compiler error. Let's uhhhhhh silence it.
# TODO: Fix this.
$HOME/.local/bin/scons platform=x11 tools=yes target=release_debug \
      udev=yes use_static_cpp=yes progress=no CXXFLAGS=-fno-strict-aliasing -j2

# Create Linux editor AppImage
strip "bin/godot.x11.opt.tools.64"
mkdir -p "appdir/usr/bin/" "appdir/usr/share/icons/hicolor/scalable/apps/"
cp "bin/godot.x11.opt.tools.64" "appdir/usr/bin/godot"
cp "misc/dist/linux/org.godotengine.Godot.desktop" "appdir/godot.desktop"
cp "icon.svg" "appdir/usr/share/icons/hicolor/scalable/apps/godot.svg"
curl -fsSLO "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
chmod +x "linuxdeployqt-continuous-x86_64.AppImage"
./linuxdeployqt-continuous-x86_64.AppImage \
    --appimage-extract-and-run \
    "appdir/godot.desktop" -appimage

mv \
    "Godot_Engine-"*"-x86_64.AppImage" \
    "godot-linux-nightly-x86_64.AppImage"
