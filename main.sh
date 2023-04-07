#!/bin/bash

# dir for screenshot
mkdir -p out

# read ip
while read line; do
  IP=$(echo "$line" | cut -d':' -f1)
  PORT=$(echo "$line" | cut -d':' -f2)

  # run vncviewer & screenshot
  (vncviewer -compresslevel 0 -quality 0 -viewonly "$IP:$PORT" & sleep 8; WID=$(xdotool search --name "TightVNC"); if [[ $WID != "" ]]; then import -window "$WID" root "out/${IP}:${PORT}.jpg"; fi) &
  # if it returned an error
  sleep 10
  if ! pgrep vncviewer > /dev/null && [[ ! $(xdotool search --name "TightVNC") ]]; then
    echo "Connection failed for ${IP}:${PORT}"
    pkill vncviewer
  fi

  # exit
  if [[ $(xdotool search --name "TightVNC") ]]; then
    WID=$(xdotool search --name "TightVNC")
    xdotool windowactivate $WID key "alt+F4"
  fi

done < ips.txt
