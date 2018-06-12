# wireguard-docker

A Docker image containing Wireguard that enables containerized
VPNs. Containers that use this image can provide VPN services to other
Docker containers by sharing the same Docker network.

## Requirements

Unfortunately, due to Wireguard's kernel module, this image only run
on kernels where Ubuntu 16.04, the OS for the base image, can pull
down kernel headers. This has been verified to work on kernels 4.13
and newer.

## Image

An up-to date Docker image can be found on Dockerhub at
`activeeos/wireguard-docker`. To pull:

```bash
$ docker pull activeeos/wireguard-docker
```

## Usage

### Configuration

A volume has to be mounted at `/etc/wireguard` containing a single
configuration file with a `.conf` file corresponding to the VPN
interface.

More information about the structure of this file can be found in the
Wireguard man page and on its [website](https://www.wireguard.com/).

Note: if Wireguard is running as a server, the UDP port that it
listens on has to be exposed from the container.

### Kernel Modules

A custom kernel module is installed when the container boots up. In
order for this process to work, the underlying system either already
needs to have Wireguard installed or the host modules directory needs
to be shared with the container. Specifically, the `/lib/modules`
directory needs to be mapped to `/lib/modules` in the container. This
can be done with the `-v /lib/modules:/lib/modules` flag in `docker
run`.

### Permissions

When running a container based upon this image, the following system
capabilities are necessary:
- NET_ADMIN
- SYS_MODULE

### Example `docker run` command

```bash
docker run -it --rm --cap-add net_admin --cap-add sys_module \
       -v /etc/wireguard:/etc/wireguard -v /lib/wireguard:/lib/wireguard \
       -p 5555:5555/udp activeeos/wireguard-docker
```

## Inspiration

Thanks to Nick Babcock for his [blog
post](https://nbsoftsolutions.com/blog/routing-select-docker-containers-through-wireguard-vpn)
explaining the mechanics behind running Wireguard inside of a
container.
