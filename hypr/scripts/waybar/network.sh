#!/usr/bin/env bash

if nmcli connection show --active | grep -q "wg0-mullvad"; then
  echo ""
else
  echo ""
fi

