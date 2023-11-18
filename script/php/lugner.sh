echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update && apt-get install nginx git php7.3 php7.3-fpm -y
service php7.3-fpm start
service nginx start
git clone https://github.com/rosyhaqqy/granz.channel.yyy.com.git
mv granz.channel.yyy.com /var/www
echo 'server {
    listen 80;
    root /var/www/granz.channel.yyy.com;
    index index.php index.html index.htm;
    server_name _;

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

ln -s /etc/nginx/sites-available/granz.channel.yyy.com /etc/nginx/sites-enabled
unlink /etc/nginx/sites-enabled/default
service php7.3-fpm restart
service nginx restart
apt-get install htop -y
echo nameserver 192.213.1.2 > /etc/resolv.conf