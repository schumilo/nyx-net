echo "Executing nginx Setup Script" | ./hcat 
mkdir conf
mkdir /var
mkdir /var/tmp

mkdir /usr/
mkdir /usr/local/
mkdir /usr/local/nginx/
mkdir /usr/local/nginx/logs/
mkdir /usr/local/nginx/html/

./hget setup/web_data/data.txt /usr/local/nginx/html/data.txt
./hget setup/web_data/example.jpg /usr/local/nginx/html/example.jpg
./hget setup/web_data/example.png /usr/local/nginx/html/example.png
./hget setup/web_data/index.html /usr/local/nginx/html/index.html



./hget setup/nginx.conf nginx.conf
./hget setup/mime.types conf/mime.types





echo "nginx Setup Script finished" | ./hcat 

