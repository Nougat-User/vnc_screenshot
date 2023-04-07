#!/bin/bash

# Создаем папку для сохранения скриншотов
mkdir -p out

# Читаем файл ips.txt построчно
while read line; do
  IP=$(echo "$line" | cut -d':' -f1)
  PORT=$(echo "$line" | cut -d':' -f2)

  # Запускаем vncviewer и делаем скриншот
  (vncviewer -compresslevel 0 -quality 0 -viewonly "$IP:$PORT" & sleep 8; WID=$(xdotool search --name "TightVNC"); if [[ $WID != "" ]]; then import -window "$WID" root "out/${IP}:${PORT}.jpg"; fi) &
  # Ждем 10 секунд и проверяем статус вывода vncviewer
  sleep 10
  if ! pgrep vncviewer > /dev/null && [[ ! $(xdotool search --name "TightVNC") ]]; then
    echo "Connection failed for ${IP}:${PORT}"
    pkill vncviewer
  fi

  # Закрываем окно vncviewer
  if [[ $(xdotool search --name "TightVNC") ]]; then
    WID=$(xdotool search --name "TightVNC")
    xdotool windowactivate $WID key "alt+F4"
  fi

done < ips.txt
