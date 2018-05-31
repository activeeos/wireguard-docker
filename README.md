# wireguard-docker

A Docker image containing Wireguard.

## Usage

### Configuration

A volume has to be mounted at `/etc/wireguard` containing a single
configuration file with a `.conf` file corresponding to the VPN
interface.

More information about the structure of this file can be found in the
Wireguard man page and on its [website](https://www.wireguard.com/).

### Permissions

When running a container based upon this image, the following system
capabilities are necessary:
- NET_ADMIN
- SYS_MODULE

## Inspiration

Thanks to Nick Babcock for his [blog
post](https://nbsoftsolutions.com/blog/routing-select-docker-containers-through-wireguard-vpn)
explaining the mechanics behind running Wireguard inside of a
container.
