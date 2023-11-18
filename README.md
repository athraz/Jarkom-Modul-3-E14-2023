# Jarkom-Modul-3-E14-2023

| Nama                      | NRP           |Username      |
|---------------------------|---------------|--------------|
|Muhammad Razan Athallah    |5025211008     |athraz        |
|Moh rosy haqqy aminy       |5025211012     |hqlco         |

## Soal 0
> Setelah mengalahkan Demon King, perjalanan berlanjut. Kali ini, kalian diminta untuk melakukan register domain berupa riegel.canyon.yyy.com untuk worker Laravel dan granz.channel.yyy.com untuk worker PHP, mengarah pada worker yang memiliki IP [prefix IP].x.1.

Untuk melakukan register domain, pada node Heiter (DNS Server) ditambahkan zone domain dan data file bind sebagai berikut:

```sh
echo '
zone "riegel.canyon.E14.com" {
        type master;
        file "/etc/bind/jarkom/riegel.canyon.E14.com";
};

zone "granz.channel.E14.com" {
        type master;
        file "/etc/bind/jarkom/granz.channel.E14.com";
};' > /etc/bind/named.conf.local
```

```sh
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
```

```sh
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
```

Pada soal diminta untuk mengarahkan domain pada worker dengan IP akhir x.1. Sehingga riegel.canyon.E14.com diarahkan ke `192.213.4.1` dan granz.channel.E14.com diarahkan ke `192.213.3.1`. Berikut hasil ping kedua DNS tersebut:
![Screenshot 2023-11-18 144331](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/95c52204-312b-4b38-8c58-4f5483911f5b)
![Screenshot 2023-11-18 144347](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/13e992e6-2c5b-4b29-8f94-ae6f297c3736)

## Soal 1
> Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

Berikut topologi yang digunakan:
![Screenshot 2023-11-18 112022](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/ecbe21e5-380b-4fcb-ad98-1edfc4b49e3d)

Dengan ketentuan sebaagai berikut:
| Node      | Kategori              | Konfigurasi IP  |
|-----------|-----------------------|-----------------|
| Aura      | Router (DHCP Relay)   | Dynamic         |
| Himmel    | DHCP Server           | Static          |
| Heiter    | DNS Server            | Static          |
| Denken    | Database Server       | Static          |
| Eisen     | Load Balancer         | Static          |
| Frieren   | Laravel Worker        | Static          |
| Flamme    | Laravel Worker        | Static          |
| Fern      | Laravel Worker        | Static          |
| Lawine    | PHP Worker            | Static          |
| Linie     | PHP Worker            | Static          |
| Lugner    | PHP Worker            | Static          |
| Revolte   | Client                | Dynamic         |
| Richter   | Client                | Dynamic         |
| Sein      | Client                | Dynamic         |
| Stark     | Client                | Dynamic         |

Sehingga berikut adalah konfigurasi untuk tiap node:
- **Aura**
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.213.1.14
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.213.2.14
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.213.3.14
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.213.4.14
	netmask 255.255.255.0
```
- **Himmel**
```
auto eth0
iface eth0 inet static
	address 192.213.1.1
	netmask 255.255.255.0
	gateway 192.213.1.14
```
- **Heiter**
```
auto eth0
iface eth0 inet static
	address 192.213.1.2
	netmask 255.255.255.0
	gateway 192.213.1.14
```
- **Denken**
```
auto eth0
iface eth0 inet static
	address 192.213.2.1
	netmask 255.255.255.0
	gateway 192.213.2.14
```
- **Eisen**
```
auto eth0
iface eth0 inet static
	address 192.213.2.2
	netmask 255.255.255.0
	gateway 192.213.2.14
```
- **Frieren**
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 72:07:14:c2:de:6a
```
- **Flamme**
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 16:dd:11:71:e2:f1
```
- **Fern**
```
auto eth0
iface eth0 inet dhcp
hwaddress ether ee:0d:fc:5c:c5:2c
```
- **Lawine**
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 1e:99:c9:88:bf:09
```
- **Linie**
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 6e:05:14:42:e7:77
```
- **Lugner**
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 52:fc:fc:9e:82:51
```
- **Revolte**
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 3e:6c:9e:d0:88:fe
```
- **Richter**
```
auto eth0
iface eth0 inet dhcp
```
- **Sein**
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 46:05:70:39:71:8f
```
- **Stark**
```
auto eth0
iface eth0 inet dhcp
```

Terdapat beberapa node yang dibuat menjadi `fixed address`, yaitu Laravel worker, PHP worker, client Revolte dan Sein (untuk testing nomor 12). Sehingga pada node Himmel (DHCP Server) ditambahkan konfigurasi dhcp berikut:

```sh
echo '

...

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
```

## Soal 2
> Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80.

Solusinya dengan mengatur field `range` pada konfigurasi subnet di node Himmel (DHCP Server) sebagai berikut:

```sh
echo '

...

subnet 192.213.3.0 netmask 255.255.255.0 {
    range 192.213.3.16 192.213.3.32;
    range 192.213.3.64 192.213.3.80;
    option routers 192.213.3.14;
    option broadcast-address 192.213.3.255;
    option domain-name-servers 192.213.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

...

' > /etc/dhcp/dhcpd.conf 
```

Berikut IP yang diperoleh client pada subnet 3:
![Screenshot 2023-11-18 144638](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/00cbe572-0c24-43e4-834c-362b2b85482f)

## Soal 3
> Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168.

Solusinya dengan mengatur field `range` pada konfigurasi subnet di node Himmel (DHCP Server) sebagai berikut:

```sh
echo '

...

subnet 192.213.4.0 netmask 255.255.255.0 {
    range 192.213.4.12 192.213.4.20;
    range 192.213.4.160 192.213.4.168;
    option routers 192.213.4.14;
    option broadcast-address 192.213.4.255;
    option domain-name-servers 192.213.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}

...

' > /etc/dhcp/dhcpd.conf 
```

Berikut IP yang diperoleh client pada subnet 4:
![Screenshot 2023-11-18 144743](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/846c8e9b-e5c8-44b5-9b38-a186453279b1)

## Soal 4
> Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut.

Solusinya dengan mengatur field `option domain-name-servers` pada konfigurasi subnet di node Himmel (DHCP Server) sebagai berikut:

```sh
echo '

...

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

...

' > /etc/dhcp/dhcpd.conf 
```

Selain itu, pada node Heiter (DNS Server) ditambahkan `forwarder` sebagai berikut:

```sh
echo 'options {
        directory "/var/cache/bind";

        forwarders {
                   192.168.122.1;
          };
        //dnssec-validation auto;
        allow-query{ any; };
        listen-on-v6 { any; };
};' > /etc/bind/named.conf.options
```

Berikut nameserver yang terdapat pada node client, serta percobaan untuk ping google.com:
![Screenshot 2023-11-18 144851](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/037b68bf-5468-4a7b-bf01-94e0394c2cdc)

## Soal 5
> Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit.

Solusinya dengan mengatur field `default-lease-time` dan `max-lease-time` pada konfigurasi subnet di node Himmel (DHCP Server) sebagai berikut:

```sh
echo '

...

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

...

' > /etc/dhcp/dhcpd.conf 
```

Pada subnet 3 defaultnya adalah 3 menit atau 180 detik dab pada subnet 4 defaultnya adalah 12 menit atau 720 detik. Sedangkan pada kedua subnet maxnya adalah 96 menit atau 5760 detik. Berikut hasil lease time pada client:
![Screenshot 2023-11-18 144638](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/00cbe572-0c24-43e4-834c-362b2b85482f)
![Screenshot 2023-11-18 144743](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/846c8e9b-e5c8-44b5-9b38-a186453279b1)

## Soal 6
> Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3.

## Soal 7
> Kepala suku dari Bredt Region memberikan resource server sebagai berikut: Lawine, 4GB, 2vCPU, dan 80 GB SSD. Linie, 2GB, 2vCPU, dan 50 GB SSD. Lugner 1GB, 1vCPU, dan 25 GB SSD. aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second.

## Soal 8
> Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut: Nama Algoritma Load Balancer, Report hasil testing pada Apache Benchmark, Grafik request per second untuk masing masing algoritma, Analisis.

## Soal 9
> Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire.

## Soal 10
> Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/rahasisakita/

Untuk menambahkan autentikasi pada Load Balancer dengan htpasswd, pertama-tama dilakukan instalasi `apache2-utils`. Kemudian dibuat directory sesuai keinginan soal, yaitu `/etc/nginx/rahasisakita/`. Selanjutnya tambahkan user dan password dengan command `htpasswd -bc`. Berikut scriptnya:

```sh
apt-get install apache2-utils -y
mkdir /etc/nginx/rahasisakita/
htpasswd -bc /etc/nginx/rahasisakita/.htpasswd netics ajkE14
```

Selain potongan kode diatas, perlu ditambahkan juga `auth_basic_user_file` pada location / yang menuju ke file htpasswd, sebagai berikut:

```sh
location / {
    ...

    auth_basic "Restricted";
    auth_basic_user_file /etc/nginx/rahasisakita/.htpasswd;

    ...
}
```

Berikut hasil autentikasi:
![Screenshot 2023-11-18 145641](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/3e4d068f-7d51-45ba-bcf2-b096fb8d9255)
![Screenshot (409)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/79006902-4aa6-43b3-8da9-70a82761d40c)
![Screenshot (411)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/f46e4588-2433-4710-a7ec-74e399a0d3f2)
![Screenshot (412)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/6884b65d-1adb-4cac-8bf1-074e20405dbf)
![Screenshot (413)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/8cd70e1b-5902-4382-a025-8656d90642ab)

## Soal 11
> Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id.

Solusinya dengan menggunakan `proxy_pass` pada location /its, sebagai berikut:

```sh
location /its {
    proxy_pass https://www.its.ac.id;
}
```

Berikut hasil akses /its:
![Screenshot 2023-11-18 145744](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/e2062819-c12a-4a36-b62c-f79a65b95e01)
![Screenshot (414)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/85643940-3db8-4c52-af3b-6c2c5849ae85)

## Soal 12
> Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].3.69, [Prefix IP].3.70, [Prefix IP].4.167, dan [Prefix IP].4.168.

Solusinya dengan menggunakan `allow` dan `deny` pada location /, sebagai berikut:

```sh
location / {
    ...

    allow 192.213.3.69;
    allow 192.213.3.70;
    allow 192.213.4.167;
    allow 192.213.4.168;
    deny all;
}
```

Selain IP `192.213.3.69`, `192.213.3.70`, `192.213.4.167`,  dan `192.213.4.168` tidak diberikan akses. Testing dilakukan dengan memberikan fixed address 192.213.3.69 pada `Revolte` dan 192.213.4.167 pada `Sein`, sementara itu dua client lainnya dibiarkan dinamis. Berikut hasil testing pada keempat client:
![Screenshot 2023-11-18 150704](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/6a42f2e2-b8a6-45ae-9b39-33c8c6e520a8)
![Screenshot (415)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/bfb12871-7e30-4dff-a7a0-24937ba6ce7e)
![Screenshot 2023-11-18 151133](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/e6ebbb77-ec6e-430b-aba5-d9d3cf87ed24)
![Screenshot (417)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/f5309fa7-5f9d-4edf-9f7a-0b4647649889)
![Screenshot 2023-11-18 150749](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/052a9c80-2543-4a16-9c86-8d75f137484b)
![Screenshot (416)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/3cdaab1f-d302-4790-bec0-a1cb79c81d18)
![Screenshot 2023-11-18 151053](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/d8d4c427-637c-45c3-bf33-422180fb9a01)
![Screenshot (418)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/4357753e-a542-448a-a0a5-a4106dd157ee)

## Soal 13
> Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren, Flamme, dan Fern.

## Soal 14
> Frieren, Flamme, dan Fern memiliki Riegel Channel sesuai dengan [quest guide](https://github.com/martuafernando/laravel-praktikum-jarkom) berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer.

## Soal 15
> Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. POST /auth/register

## Soal 16
> Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. POST /auth/login

## Soal 17
> Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. GET /me

## Soal 18
> Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur Riegel Channel maka implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Frieren, Flamme, dan Fern.

## Soal 19
> Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Frieren, Flamme, dan Fern. Untuk testing kinerja naikkan pm.max_children, pm.start_servers, pm.min_spare_servers, pm.max_spare_servers sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada Grimoire.

## Soal 20
> Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa dari worker maka implementasikan Least-Conn pada Eisen. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second.
