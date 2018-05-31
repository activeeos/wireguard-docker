#!/bin/bash

set -e

interfaces=`find /etc/wireguard -type f`

if [[ -z $interfaces ]]; then
	echo "$(date): Interface not found in /etc/wireguard" >&2
	exit 1
fi

interface=`echo $interfaces | head -n 1`

echo "$(date): Starting Wireguard"
wg-quick up $interface

finish () {
    echo "$(date): Shutting down Wireguard"
    wg-quick down $interface
	exit 0
}

trap finish SIGTERM SIGINT SIGQUIT

sleep infinity &
wait $!
