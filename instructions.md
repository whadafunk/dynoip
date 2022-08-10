# How to use this container:

First of all, because DHCP works with broadcasts, you cannot get away with port publishing.  
The container needs to be connected to a network that transmits and receives broadcasts from clients.  
This means that you can use either bridge or a macvlan network.  

When you create the docker network you need to be aware of the subnets used in config.  
Like for example, the default config uses 192.168.40.0/24,
So we need to create a docker network with --subnet 192.168.40.0/24

## Example

**docker network create -d macvlan --subnet 192.168.40.0/24 --gateway 192.168.40.1 --ip-range 192.168.40.128/28 --opt parent enp0s8 macnet**

*If you are going to use macvlan network, do not forget to set promiscuous mode on the parent interface,  
or you will not be able to communicate with the physical network connected to the parent interface.

**ip link set dev enp0s8 promisc on**

## Config Files

There are a couple of different configuration files under config_template folder, and there is also a default
one called dhcpd.conf, in the root folder. The container will start with dhcpd.conf by default, but we can change that.

1. You can either mount a different config file as /etc/dhcp/dhcpd.conf
> docker container run -v config_templates/basic /etc/dhcp/dhcpd.conf
2. You can specify -cf /etc/dhcpd/basic as a parameter at container runtime
> docker container run ..... routerology/dhcp -cf /etc/dhcp/basic
3. You can create a custom docker file that copies the config file at build time

## Running the container

**docker container run --network macnet --name dhcp --detach --rm routerology/dhcp**
