#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

set interfaces ethernet eth1 address '192.168.62.10/24'
set interfaces tunnel tun0 address '10.100.102.2/30'
set interfaces tunnel tun0 encapsulation 'gre'
set interfaces tunnel tun0 ip ospf authentication plaintext-password 'cloud1'
set interfaces tunnel tun0 ip ospf 'mtu-ignore'
set interfaces tunnel tun0 ip ospf network 'point-to-point'
set interfaces tunnel tun0 ip ospf priority '1'
set interfaces tunnel tun0 local-ip '192.168.62.10'
set interfaces tunnel tun0 multicast 'disable'
set interfaces tunnel tun0 remote-ip '10.50.0.1'
set interfaces tunnel tun1 address '10.100.103.2/30'
set interfaces tunnel tun1 encapsulation 'gre'
set interfaces tunnel tun1 ip ospf authentication plaintext-password 'cloud2'
set interfaces tunnel tun1 ip ospf 'mtu-ignore'
set interfaces tunnel tun1 ip ospf network 'point-to-point'
set interfaces tunnel tun1 ip ospf priority '2'
set interfaces tunnel tun1 local-ip '192.168.62.10'
set interfaces tunnel tun1 multicast 'disable'
set interfaces tunnel tun1 remote-ip '10.50.0.2'
set protocols ospf area 0 authentication 'plaintext-password'
set protocols ospf area 0 network '192.168.61.0/24'
set protocols ospf area 0 network '10.100.103.0/30'
set protocols ospf area 0 network '10.100.102.0/30'
set protocols ospf neighbor 10.100.101.1 priority '100'
set protocols ospf neighbor 10.100.102.1 priority '150'
set protocols ospf passive-interface 'eth0'
set protocols ospf passive-interface 'eth1'
set protocols static route 10.50.0.0/30 next-hop '192.168.62.1'

commit
save
exit

