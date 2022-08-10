# ISC DHCP Docker Container

# We start with our good old friend Alpine
FROM alpine:latest
MAINTAINER gri.daniel@gmail.com
# RUN apk update
RUN apk add dhcp-server-vanilla

# Copy the default config, or choose one from the config_templates folder
COPY ./dhcpd.conf /etc/dhcp/dhcpd.conf
COPY ./config_templates/basic /etc/dhcp/basic.conf
COPY ./config_templates/basic_hosts /etc/dhcp/basic_hosts.conf
COPY ./config_templates/multiple_pools /etc/dhcp/multiple_pools.conf
COPY ./config_templates/classes /etc/dhcp/classes.conf
COPY ./config_templates/full /etc/dhcp/full.conf
RUN mkdir -p /var/lib/dhcpd
RUN touch /var/lib/dhcpd/dhcpd.leases
# DHCPD start options
# -f -> foreground, -d -> debug logging, -p -> custom port
# -cf -> config file, -lf -> lease file, -pf -> pid file
# -q -> suppress copyright message on start
ENTRYPOINT ["/usr/sbin/dhcpd","-4","-q","-f","-d"]
