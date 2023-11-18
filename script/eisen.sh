echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update && apt-get install nginx git php7.3 php7.3-fpm htop -y
service php7.3-fpm start
service nginx start
echo '#LB
upstream backend  {
    # Default menggunakan Round Robin
    server 192.213.3.1 weight=640;
    server 192.213.3.2 weight=200;
    server 192.213.3.3 weight=25;
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

server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://backend;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;

        auth_basic "Restricted";
        auth_basic_user_file /etc/nginx/rahasisakita/.htpasswd;

        allow 192.213.3.69;
        allow 192.213.3.70;
        allow 192.213.4.167;
        allow 192.213.4.168;
        deny all;
    }

    location /its {
        proxy_pass https://www.its.ac.id;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log /var/log/nginx/lb_error.log;
    access_log /var/log/nginx/lb_access.log;
}

#LB
upstream backend-laravel {
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

ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled
unlink /etc/nginx/sites-enabled/default

apt-get install apache2-utils -y
mkdir /etc/nginx/rahasisakita/
htpasswd -bc /etc/nginx/rahasisakita/.htpasswd netics ajkE14

service nginx restart

echo nameserver 192.213.1.2 > /etc/resolv.conf