#!/bin/sh

echo 'Starting up Tailscale...'

/app/tailscaled --verbose=1 --port 41641 --tun=userspace-networking --socks5-server=localhost:3215 &
sleep 5
if [ ! -S /var/run/tailscale/tailscaled.sock ]; then
    echo "tailscaled.sock does not exist. exit!"
    exit 1
fi

until /app/tailscale up \
    --authkey=${TAILSCALE_AUTH_KEY} \
    --hostname=i2p \
    --ssh
do
    sleep 0.1
done

echo 'Tailscale serve i2p proxy...'

export IP_ADDR=127.0.0.1

/app/tailscale serve tcp:4444 tcp://${IP_ADDR}:4444
/app/tailscale serve tcp:4445 tcp://${IP_ADDR}:4445
/app/tailscale serve tcp:7657 tcp://${IP_ADDR}:7657

echo 'Tailscale started'

echo 'Starting up i2p...'

/app/starti2p.sh

