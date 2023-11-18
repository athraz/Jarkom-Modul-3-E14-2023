echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update -y
apt-get install isc-dhcp-server -y

echo '
INTERFACESv4="eth0"
INTERFACESv6=' > /etc/default/isc-dhcp-server

echo '
subnet 192.213.1.0 netmask 255.255.255.0 {

}

subnet 192.213.2.0 netmask 255.255.255.0 {

}

subnet 192.213.3.0 netmask 255.255.255.0 {
    range 192.213.3.16 192.213.3.32;
    range 192.213.3.64 192.213.3.80;
    option routers 192.213.3.14;
    option broadcast-address 192.213.3.255;
    option domain-name-servers 192.213.1.2;
    default-lease-time 180;
    max-lease-time 5760;

}

subnet 192.213.4.0 netmask 255.255.255.0 {
    range 192.213.4.12 192.213.4.20;
    range 192.213.4.160 192.213.4.168;
    option routers 192.213.4.14;
    option broadcast-address 192.213.4.255;
    option domain-name-servers 192.213.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}

host Revolte {
    hardware ethernet 3e:6c:9e:d0:88:fe;
    fixed-address 192.213.3.69;
}

host Sein {
    hardware ethernet 46:05:70:39:71:8f;
    fixed-address 192.213.4.167;
}

host Lawine {
    hardware ethernet 1e:99:c9:88:bf:09;
    fixed-address 192.213.3.1;
}

host Linie {
    hardware ethernet 6e:05:14:42:e7:77;
    fixed-address 192.213.3.2;
}

host Lugner {
    hardware ethernet 52:fc:fc:9e:82:51;
    fixed-address 192.213.3.3;
}

host Frieren {
    hardware ethernet 72:07:14:c2:de:6a;
    fixed-address 192.213.4.1;
}

host Flamme {
    hardware ethernet 16:dd:11:71:e2:f1;
    fixed-address 192.213.4.2;
}

host Fern {
    hardware ethernet ee:0d:fc:5c:c5:2c;
    fixed-address 192.213.4.3;
}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart