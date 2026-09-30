#!/bin/bash
set -e

export USER=headless
export HOME=/home/headless
export DISPLAY=:1

mkdir -p "$HOME/.vnc"
chown -R headless:headless "$HOME"

echo "headless" | vncpasswd -f > "$HOME/.vnc/passwd"
chmod 600 "$HOME/.vnc/passwd"
chown headless:headless "$HOME/.vnc/passwd"

su - headless -c "vncserver :1 -geometry 1360x768 -depth 24 -localhost no"

sleep 3

websockify --web=/usr/share/novnc/ 6080 localhost:5901 &
 
echo "======================================"
echo "XFCE + VNC + noVNC started"
echo "noVNC: http://0.0.0.0:6080/vnc.html"
echo "VNC password: headless"
echo "======================================"

wait
