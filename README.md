# Overview
Lightweight DHCP and DHCPv6 server based on dnsmasq for testing purposes.
The dnsmasq daemon runs in debug mode in the foreground. The main purpose of this repository is to quickly setup a DHCP and DHCPv6 server mainly for lab and testing purposes. The DNS server of dnsmasq is disabled (dnsmasq daemon is startet with with -p 0 option.

The container must be run on the host network, because for IPv6 there is no NAT. Otherwise a global IPv6 routable address space must be assigned to the docker deamon. If you're using DHCP(v4) only, the container may be run in a docker network and the DHCP server port (udp/67) must be exposed. This way the DHCP(v4) server may be used for other subnets (e.g.  by using a DHCP relay agent).

# Example run:
    docker run -it --rm --net=host --cap-add=NET_ADMIN \
    -v "$(pwd)/dnsmasq":/etc/dnsmasq -p 67:67/udp -p 547:547/udp \
    netgab/dnsmasq-dhcp

The container is run in the foreground and deleted after dnsmasq is terminated using CTRL+C.
The udp port 67 is needed for DHCP(v4) and udp port 547 is used for DHCPv6 (default ports).

The configuration file(s) (*.conf) must be placed in the current working directory (where the docker command is executed) in the subdirectory dnsmasq.
Example configuration (very simple and basic): dhcp_scopes.conf

    dhcp-range=internal-v4, {IPv4-START-ADDRESS}, {IPv4-END-ADDRESS}, 2h
    dhcp-range=internal-v6, {IPv6-START-ADDRESS}, {IPv6-END-ADDRESS}, 2h
(The example above uses a lease time of 2 hours)
Please refer to the dnsmasq.conf documentation for more details.
Of course the configuration folder may be any other folder on the local filesystem. Just modify the volume statement in the docker run command.