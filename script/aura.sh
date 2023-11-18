iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.213.0.0/16

apt-get update -y
apt-get install isc-dhcp-relay -y

echo '
SERVERS="192.213.1.1"
INTERFACES="eth1 eth3 eth4"
OPTIONS=' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf

service isc-dhcp-relay start