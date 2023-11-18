apt-get update && apt-get install lynx -y
apt-get install apache2-utils -y

curl -s -X POST -H "Content-Type: application/json" -d '{"username":"username1", "password":"password1"}' http://192.213.4.1/api/auth/register
curl -s -X POST -H "Content-Type: application/json" -d '{"username":"username1", "password":"password1"}' http://192.213.4.1/api/auth/login
curl -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjIxMy40LjEvYXBpL2F1dGgvcmVnaXN0ZXIiLCJpYXQiOjE3MDAxMzkwMjUsImV4cCI6MTcwMDE0MjYyNSwibmJmIjoxNzAwMTM5MDI1LCJqdGkiOiJ2cGVpN3F6NVBRZkdrcWkwIiwic3ViIjoiNSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.wGOnFRgCxbQ6xSJ25x_WQaiTSFdXjOykARHRvO9peHM" http://192.213.4.1/api/me

echo '{"username":"username2", "password":"password2"}' > register.json
echo '{"username":"username1", "password":"password1"}' > login.json

ab -n 100 -c 10 -p register.json -T "application/json" -H "Content-Type:application/json" http://192.213.4.1/api/auth/register
ab -n 100 -c 10 -p login.json -T "application/json" -H "Content-Type:application/json" http://192.213.4.1/api/auth/login
ab -n 100 -c 10 -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjIxMy40LjEvYXBpL2F1dGgvcmVnaXN0ZXIiLCJpYXQiOjE3MDAxMzkwMjUsImV4cCI6MTcwMDE0MjYyNSwibmJmIjoxNzAwMTM5MDI1LCJqdGkiOiJ2cGVpN3F6NVBRZkdrcWkwIiwic3ViIjoiNSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.wGOnFRgCxbQ6xSJ25x_WQaiTSFdXjOykARHRvO9peHM" http://192.213.4.1/api/me