#!/usr/bin/env bash

if nmcli connection show --active | grep -q "wg0-mullvad"; then
  echo '{"text": "", "class": "vpn-connected"}'
else
  echo '{"text": "", "class": "vpn-disconnected"}'
fi

