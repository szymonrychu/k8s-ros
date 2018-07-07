#!/bin/bash
export DISPLAY=:1
sudo Xvfb :1 -screen 0 1600x900x16 &
sleep 5
sudo openbox-session&
sudo x11vnc -display :1 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever &
cd /home/ros/noVNC && ln -s vnc_auto.html index.html && ./utils/launch.sh --vnc localhost:5900