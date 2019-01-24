FROM alpine:latest

## Dockerfile author
MAINTAINER Johannes Luther <joe@netgab.net> 

## Install packages
RUN apk --no-cache add dnsmasq \
    && echo "conf-dir=/etc/dnsmasq,*.conf" > /etc/dnsmasq.conf

EXPOSE 67/udp 547/udp

## Mapping volumes
VOLUME ["/etc/dnsmasq"]

ENTRYPOINT ["dnsmasq"]
CMD ["-p0","-d"]