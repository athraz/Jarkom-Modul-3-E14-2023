echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

echo '
zone "riegel.canyon.E14.com" {
        type master;
        file "/etc/bind/jarkom/riegel.canyon.E14.com";
};

zone "granz.channel.E14.com" {
        type master;
        file "/etc/bind/jarkom/granz.channel.E14.com";
};' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.E14.com root.riegel.canyon.E14.com. (
                                    2023110101    ; Serial
                        604800        ; Refresh
                        86400         ; Retry
                        2419200       ; Expire
                        604800 )      ; Negative Cache TTL
;
@               IN      NS      riegel.canyon.E14.com.
@               IN      A       192.213.4.1         ; IP Frieren

' >  /etc/bind/jarkom/riegel.canyon.E14.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.E14.com root.granz.channel.E14.com. (
                                    2023110101    ; Serial
                        604800        ; Refresh
                        86400         ; Retry
                        2419200       ; Expire
                        604800 )      ; Negative Cache TTL
;
@               IN      NS      granz.channel.E14.com.
@               IN      A       192.213.3.1         ; IP Lawine
' >  /etc/bind/jarkom/granz.channel.E14.com

echo 'options {
        directory "/var/cache/bind";

        forwarders {
                   192.168.122.1;
          };
        //dnssec-validation auto;
        allow-query{ any; };
        listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

service bind9 restart