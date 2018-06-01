FROM ubuntu:16.04

# Thanks to https://nbsoftsolutions.com/blog/routing-select-docker-containers-through-wireguard-vpn
RUN apt-get update -y && \
    apt-get install -y software-properties-common iptables curl iproute2 ifupdown iputils-ping && \
    echo resolvconf resolvconf/linkify-resolvconf boolean false | debconf-set-selections && \
    echo "REPORT_ABSENT_SYMLINK=no" >> /etc/default/resolvconf && \
    add-apt-repository --yes ppa:wireguard/wireguard && \
    apt-get install resolvconf

COPY scripts /scripts

ENTRYPOINT ["/scripts/run.sh"]
CMD []
