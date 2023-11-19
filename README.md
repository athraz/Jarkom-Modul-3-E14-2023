# Jarkom-Modul-3-E14-2023

| Nama                      | NRP           |Username      |
|---------------------------|---------------|--------------|
|Muhammad Razan Athallah    |5025211008     |athraz        |
|Moh rosy haqqy aminy       |5025211012     |hqlco         |

**Link Grimoire: [Grimoire](https://drive.google.com/file/d/1zChUzalCJndfac-gKQjm-3kgpmdJ4AWn/view?usp=sharing)**  
**Link GNS3Project: [GNS3](https://drive.google.com/file/d/1SpXkl_FOKMBtRn8KNYYvLfIDx5LOnWje/view?usp=sharing)**

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

Kita dapat mendeploy di nginx. Pertama clone project sebagai berikut:
```
git clone https://github.com/rosyhaqqy/granz.channel.yyy.com.git
```

Lakukan deployment di nginx, sebagai berikut:

```sh
echo 'server {
    listen 80;
    root /var/www/granz.channel.yyy.com;
    index index.php index.html index.htm;
    server_name granz.channel.E14.com;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # pass PHP scripts to FastCGI server
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log /var/log/nginx/jarkom_error.log;
    access_log /var/log/nginx/jarkom_access.log;
}' > /etc/nginx/sites-available/granz.channel.yyy.com
```

Setelah itu dapat diimplementasikan kesetiap worker php. Berikut hasil konfigurasi pada ketiga worker php:
![6](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/9bca19b6-cad5-4d72-bc9e-bdbb349d7e86)

## Soal 7
> Kepala suku dari Bredt Region memberikan resource server sebagai berikut: Lawine, 4GB, 2vCPU, dan 80 GB SSD. Linie, 2GB, 2vCPU, dan 50 GB SSD. Lugner 1GB, 1vCPU, dan 25 GB SSD. aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second.

Melakukan config Load balancer di server Eisen sebagai berikut:

```sh
echo '#LB
upstream backend  {
    # Default menggunakan Round Robin
    server 192.213.3.1 weight=640;
    server 192.213.3.2 weight=200;
    server 192.213.3.3 weight=25;
}

server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://backend;
    }
    error_log /var/log/nginx/lb_error.log;
    access_log /var/log/nginx/lb_access.log;
}
```

Weight didapat dari perkalian semua spesifikasi dari server. Berikut hasil menggunakan load balancer:
![7](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/5b1a9c34-b8f0-43c1-98cc-760bebce1a4c)

Berikut hasil testing dengan 1000 request dan 100 request/second:
![Screenshot 2023-11-19 125128](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/0442dae8-d1fc-4fd5-bf47-b236958d6188)

## Soal 8
> Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut: Nama Algoritma Load Balancer, Report hasil testing pada Apache Benchmark, Grafik request per second untuk masing masing algoritma, Analisis.

Dalam implementasinya kelompok kami menerapkan 5 algoritma.

```sh
upstream backend  {
    # weight Round Robin
    server 192.213.3.1 weight=640;
    server 192.213.3.2 weight=200;
    server 192.213.3.3 weight=25;

    # Round Robin
    # server 192.213.3.1;
    # server 192.213.3.2;
    # server 192.213.3.3;

    # least_conn;
    # server 192.213.3.1;
    # server 192.213.3.2;
    # server 192.213.3.3;

    # ip_hash;
    # server 192.213.3.1;
    # server 192.213.3.2;
    # server 192.213.3.3;

    # hash $request_uri consistent;
    # server 192.213.3.1;
    # server 192.213.3.2;
    # server 192.213.3.3;
}
```

- **Round Robin**  
Merupakan algoritma load balancing default yang ada di Nginx, cara kerjanya yaitu jika kita memiliki 3 buah node, maka urutannya adalah dari node pertama, kemudian node kedua, dan ketiga. Setelah node ketiga menerima beban, maka akan diulang kembali dari node ke satu.
Berikut hasil htop dan benchmark:
![round-robin](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/1afc5a46-0d41-4736-aa45-e1da99f28a84)

- **Weighted Round Robin**  
Cukup dengan menetapkan weight atau beban ke masing-masing server di kumpulan server yang telah ditentukan sebelumnya. Server yang memiliki weight paling besar akan dijadikan prioritas ketika menerima request dari client. Berikut hasil htop dan benchmark:
![weighted-round-robin](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/e35f26f7-0db8-4f74-b1b9-8526135800f0)

- **Least Connection**  
Jika Round robin akan mendistribusikan berdasarkan nomor dan urutan server, maka least-connection akan melakukan prioritas pembagian dari beban kinerja yang paling rendah. Berikut hasil htop dan benchmark:
![least-conn](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/2bfc4b6d-2040-4f43-bf35-99a24bf8545d)

- **IP Hash**  
Algoritma ini akan melakukan hash berdasarkan request dari pengguna (menggunakan alamat IP dari pengguna). Sehingga server akan selalu menerima request dari alamat IP yang berbeda. Ketika server ini tidak tersedia, permintaan dari klien ini akan dilayani oleh server lain. Berikut hasil htop dan benchmark:
![ip-hash](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/2320dfb4-1f89-48fd-8efb-ad013b844248)

- **Generic Hash**  
Generic hash adalah jenis load balancing yang menggunakan algoritma hash untuk mendistribusikan lalu lintas ke server backend. Algoritma hash ini menggunakan hash dari nilai tertentu untuk menentukan server backend atau worker mana yang akan menangani permintaan. Berikut hasil htop dan benchmark:
![generic-hash](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/11fa9d32-ea38-4e38-a1be-4f3461601c10)

Diperoleh request per second tertinggi adalah IP Hash, disusul dengan Generic Hash dan Least Connection. Sehingga dapat disimpulkan algoritma yang paling efisien untuk kasus praktikum ini adalah IP Hash.

## Soal 9
> Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire.

Dalam penerapanya kita hanya perlu mengurangi jumlah worker di Load Balancer.

```sh
upstream backend  {
    # Round Robin
    server 192.213.3.1;
    server 192.213.3.2;
    server 192.213.3.3;

}
upstream backend  {
    # Round Robin
    server 192.213.3.1;
    server 192.213.3.2;
}
upstream backend  {
    # Round Robin
    server 192.213.3.1;
}
```

- **3 Worker**
Berikut hasil benchmark:
![3worker](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/20f28025-7582-431f-b812-8e9e93b2e18d)

- **2 Worker**
Berikut hasil benchmark:
![2worker](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/72b23dc1-5e4b-4dc5-91ca-94800d2b44e0)

- **1 Worker**
Berikut hasil benchmark:
![1worker](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/ec234e29-12b2-484a-9ab8-f9cff9275349)

Dapat disimpulkan bahwa pada algoritma Round Robin semakin banyak worker maka semakin sedikit request per secondnya. Hal ini karena request diterima oleh worker secara merata.

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

Untuk mysql server kita dapat melakukan konfigurasi sebagai berikut:

```sh
echo '#!/bin/bash

# MySQL connection parameters
MYSQL_USER="root"
MYSQL_PASSWORD=""
# MySQL commands
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD <<EOF
CREATE USER '\''kelompokE14'\''@'\''%'\'' IDENTIFIED BY '\''passwordE14'\''; 
CREATE USER '\''kelompokE14'\''@'\''localhost'\'' IDENTIFIED BY '\''passwordE14'\''; 
CREATE DATABASE dbkelompokE14; 
GRANT ALL PRIVILEGES ON *.* TO '\''kelompokE14'\''@'\''%'\''; 
GRANT ALL PRIVILEGES ON *.* TO '\''kelompokE14'\''@'\''localhost'\''; 
FLUSH PRIVILEGES; 
EOF' > /run.sh
chmod +x /run.sh
./run.sh

echo '[mysqld]
skip-networking=0
skip-bind-address' >> /etc/mysql/my.cnf

service mysql restart
```

Untuk setiap client kita hanya perlu menginstall mysql-client.

```sh
apt-get update && apt-get install mariadb-client -y
```

Berikut hasil ketika data diakses dari Denken (Database Server) dan Frieren (Laravel Worker):
![13](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/fd963326-c2db-4e3f-8a21-6d14e4ba4658)

## Soal 14
> Frieren, Flamme, dan Fern memiliki Riegel Channel sesuai dengan [quest guide](https://github.com/martuafernando/laravel-praktikum-jarkom) berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer.

Untuk melakukan deployment pada nginx ada beberapa hal yang perlu disiapkan yaitu ```composer```,```nginx```,dan ```php```. Adapun full config untuk mendeploy sebagai berikut:

```sh
composer update
composer install

echo 'APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=192.213.2.1
DB_PORT=3306
DB_DATABASE=dbkelompokE14
DB_USERNAME=kelompokE14
DB_PASSWORD=passwordE14

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"' > /var/www/laravel-praktikum-jarkom/.env

php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate
php artisan jwt:secret

echo 'server {
    listen 80;

    root /var/www/laravel-praktikum-jarkom/public;

    index index.php index.html index.htm;
    server_name riegel.canyon.E14.com;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # pass PHP scripts to FastCGI server
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        # fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
        fastcgi_pass unix:/var/run/php/php8.0-fpm-eisen-site.sock;
    }

    location ~ /\.ht {
        deny all;
    }
    

    error_log /var/log/nginx/implementasi_error.log;
    access_log /var/log/nginx/implementasi_access.log;
}' > /etc/nginx/sites-available/implementasi


ln -s /etc/nginx/sites-available/implementasi /etc/nginx/sites-enabled/
unlink /etc/nginx/sites-enabled/default
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage
chmod -R 777 public
chmod -R 777 storage
```

Berikut hasil lynx menggunakan IP ketiga Laravel worker:
![14](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/6201868c-ba6a-4257-957f-41a7bc138059)

## Soal 15
> Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. POST /auth/register

Untuk mendapatkan response dari endpoint dapat menggunakan command sebagai berikut:
```sh
curl -s -X POST -H "Content-Type: application/json" -d '{"username":"username1", "password":"password1"}' http://192.213.4.1/api/auth/register
```

Berikut response yang didapat:
![Screenshot 2023-11-15 213531](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/86727281-3c7f-451b-81a7-5dd705dc7c0b)
![Screenshot 2023-11-15 213519](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/f21692ac-a837-4c58-8cfc-8d5d386fb0a9)

Untuk mendapatkan hasil testing benchmark dapat menggunakan command sebagai berikut:
```sh
echo '{"username":"username2", "password":"password2"}' > register.json
ab -n 100 -c 10 -p register.json -T "application/json" -H "Content-Type:application/json" http://192.213.4.1/api/auth/register
```

Berikut hasil testing benchmark:
![Screenshot 2023-11-16 194918](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/ad513903-498e-4daa-9928-aff8d4be994f)

## Soal 16
> Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. POST /auth/login

Untuk mendapatkan response dari endpoint dapat menggunakan command sebagai berikut:
```sh
curl -s -X POST -H "Content-Type: application/json" -d '{"username":"username1", "password":"password1"}' http://192.213.4.1/api/auth/login
```

Berikut response yang didapat:
![Screenshot (395)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/61d736c6-c48c-489b-8c40-3be30d0119c7)

Untuk mendapatkan hasil testing benchmark dapat menggunakan command sebagai berikut:
```sh
echo '{"username":"username1", "password":"password1"}' > login.json
ab -n 100 -c 10 -p login.json -T "application/json" -H "Content-Type:application/json" http://192.213.4.1/api/auth/login
```

Berikut hasil testing benchmark:
![Screenshot 2023-11-16 195123](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/6951e036-4236-4345-8449-385440a542e1)

## Soal 17
> Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. GET /me

Untuk mendapatkan response dari endpoint dapat menggunakan command sebagai berikut:
```sh
curl -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjIxMy40LjEvYXBpL2F1dGgvcmVnaXN0ZXIiLCJpYXQiOjE3MDAxMzkwMjUsImV4cCI6MTcwMDE0MjYyNSwibmJmIjoxNzAwMTM5MDI1LCJqdGkiOiJ2cGVpN3F6NVBRZkdrcWkwIiwic3ViIjoiNSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.wGOnFRgCxbQ6xSJ25x_WQaiTSFdXjOykARHRvO9peHM" http://192.213.4.1/api/me
```

Berikut response yang didapat:
![Screenshot (396)](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/425c13fb-e5ba-4794-a7c6-bd057a8a9fe4)

Untuk mendapatkan hasil testing benchmark dapat menggunakan command sebagai berikut:
```sh
ab -n 100 -c 10 -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjIxMy40LjEvYXBpL2F1dGgvcmVnaXN0ZXIiLCJpYXQiOjE3MDAxMzkwMjUsImV4cCI6MTcwMDE0MjYyNSwibmJmIjoxNzAwMTM5MDI1LCJqdGkiOiJ2cGVpN3F6NVBRZkdrcWkwIiwic3ViIjoiNSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.wGOnFRgCxbQ6xSJ25x_WQaiTSFdXjOykARHRvO9peHM" http://192.213.4.1/api/me
```

Berikut hasil testing benchmark:
![Screenshot 2023-11-16 200841](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/96915efb-d268-4899-bda5-00670f4272d1)

## Soal 18
> Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur Riegel Channel maka implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Frieren, Flamme, dan Fern.

Kita dapat melakukannya dengan melakukan konfigurasi tambahan didalam load balancer, sebagai berikut:

```sh
pstream backend-laravel {
    # Default menggunakan Round Robin
    server 192.213.4.1;
    server 192.213.4.2;
    server 192.213.4.3;

    # least_conn;
    # server 192.213.4.1;
    # server 192.213.4.2;
    # server 192.213.4.3;
}

server {
    listen 8000;
    server_name _;

    location / {
        proxy_pass http://backend-laravel;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;
    }

    location /frieren/ {
        proxy_bind 192.213.2.2;
        proxy_pass http://192.213.4.1/index.php;
    }

    location /flamme/ {
        proxy_bind 192.213.2.2;
        proxy_pass http://192.213.4.2/index.php;
    }

    location /fern/ {
        proxy_bind 192.213.2.2;
        proxy_pass http://192.213.4.3/index.php;
    }

    error_log /var/log/nginx/lb_error.log;
    access_log /var/log/nginx/lb_access.log;
}' > /etc/nginx/sites-available/lb-jarkom
```
Semua request terhadap ```ip/flamme/```,```ip/fern/```,dan ```ip/frieren/``` akan ter-redirect ke ```ip/```, berikut hasilnya:
![18](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/00f71b6e-d601-4c84-aef1-20105edd34f7)

## Soal 19
> Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Frieren, Flamme, dan Fern. Untuk testing kinerja naikkan pm.max_children, pm.start_servers, pm.min_spare_servers, pm.max_spare_servers sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada Grimoire.

Kita dapat menambahkan konfigurasi secara manual php-fpm yang akan running di server kita dengan config sebagai berikut:

```sh
echo '
[eisen_site]
user = eisen_user
group = eisen_user
listen = /var/run/php/php8.0-fpm-eisen-site.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

pm = dynamic
; pm.max_children = 5
; pm.start_servers = 3
; pm.min_spare_servers = 1
; pm.max_spare_servers = 5

; pm.max_children = 35
; pm.start_servers = 5
; pm.min_spare_servers = 3
; pm.max_spare_servers = 10

pm.max_children = 75
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 20

pm.process_idle_timeout = 10s
' > /etc/php/8.0/fpm/pool.d/eisen.conf

groupadd eisen_user
useradd -g eisen_user eisen_user
```

Jangan lupa mengubah php-fpm pada konfigurasi nginx menjadi ```fastcgi_pass unix:/var/run/php/php8.0-fpm-eisen-site.sock;```

- **Testing 1**
```
pm.max_children = 5
pm.start_servers = 3
pm.min_spare_servers = 1
pm.max_spare_servers = 5
```
Berikut hasil benchmark:
![Screenshot 2023-11-16 164322](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/9794d3c5-48c3-4a8d-9776-7cfe4155b389)

- **Testing 2**
```
pm.max_children = 35
pm.start_servers = 5
pm.min_spare_servers = 3
pm.max_spare_servers = 10
```
Berikut hasil benchmark:
![Screenshot 2023-11-16 164045](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/d744a430-76c4-4d79-99a1-9094a2a896f6)

- **Testing 3**
```
pm.max_children = 75
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 20
```
Berikut hasil benchmark:
![Screenshot 2023-11-16 164514](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/f5a30564-bb1a-4d21-a33e-0180347dcfa3)

## Soal 20
> Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa dari worker maka implementasikan Least-Conn pada Eisen. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second.

Dapat mengubah konfigurasi di load balancer menjadi Least-Conn pada Eisen mmenjadi sebagai berikut.

```sh
upstream backend-laravel {
    least_conn;
    server 192.213.4.1;
    server 192.213.4.2;
    server 192.213.4.3;
}
```
Berikut hasil benchmark:
![Screenshot 2023-11-16 170739](https://github.com/athraz/Jarkom-Modul-3-E14-2023/assets/96050618/12713608-83a5-4361-9f67-544fdc403cf6)

## Kendala Pengerjaan
Kebanyakan revisi soal mas mbak sampe rosy marah marah awkakwowokw.  
![Screenshot 2023-09-18 213304](https://github.com/athraz/Jarkom-Modul-1-E14-2023/assets/96050618/df994f2b-f814-4243-bfa6-0a242a345774)

