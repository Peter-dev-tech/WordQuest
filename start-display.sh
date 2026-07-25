#!/bin/bash

echo "Deteniendo procesos anteriores si existen..."
pkill Xvfb 2>/dev/null
pkill x11vnc 2>/dev/null
pkill -f novnc_proxy 2>/dev/null
rm -f /tmp/.X99-lock

echo "Iniciando pantalla virtual (Xvfb)..."
sudo Xvfb :99 -screen 0 1280x800x24 &
sleep 2

export DISPLAY=:99
echo "export DISPLAY=:99" >> ~/.bashrc

echo "Iniciando transmisión VNC (x11vnc)..."
x11vnc -display :99 -forever -shared -rfbport 5900 &
sleep 2

echo "Iniciando noVNC (puerto 6080)..."
cd noVNC
./utils/novnc_proxy --vnc localhost:5900 --listen 6080 &
cd ..

echo ""
echo "Listo. Abre el puerto 6080 en la pestaña PUERTOS y entra a /vnc.html"
echo "Ya puedes correr: cd WordQuest && mvn clean javafx:run"
