Invisible Internet over Tailscale
=================================

![](./assets/StandWithUkraine.svg)

Private router to access the Invisible Internet via Tailscale IPN

![Screenshot](./assets/screenshot.png)

## Usage

```
$ podman run -d --name=i2p --hostname=i2p \
     -e TAILSCALE_AUTH_KEY=tskey-... \
     ghcr.io/spotsnel/i2pscale:latest
```

and get the node IP with

```
$ tailscale ip -4 i2p
```

and use with port `4444`, `4445` and `7657`

