#!/bin/bash

function login(){
  curl -A 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36' -d 'une=liry&username=liry&pass_wd=Lry502901241&pass_word=Lry502901241&btlogin=%E7%99%BB%E5%BD%95' -X POST "http://192.168.100.2/webAuth/"
  echo "login successful!"
}
#curl \
#-H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" \
#-H "Accept-Encoding: gzip, deflate" \
#-H "Accept-Language: en-US,en;q=0.9" \
#-H "Cache-Control: max-age=0" \
#-H "Connection: keep-alive" \
#-H "Host: 192.168.100.2" \
#-H "If-Modified-Since: Thu, 11 May 2017 22:37:10 GMT" \
#-H "Referer: http://192.168.100.2/webAuth/" \
#-H "Upgrade-Insecure-Requests: 1" \
#-H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36" \
#http://192.168.100.2/logout.htm?pop=1
function keepAlive(){
curl \
-H "Accept: */*" \
-H "Accept-Encoding: gzip, deflate" \
-H "Accept-Language: en-US,en;q=0.9" \
-H "Connection: keep-alive" \
-H "Host: 192.168.100.2" \
-H "If-Modified-Since: Thu, 11 May 2017 22:37:09 GMT" \
-H "Referer: http://192.168.100.2/logout.htm?pop=1" \
-H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36" \
http://192.168.100.2/out.htm
}

function main(){
  login
  while ((0 <= 100)); do
    sleep 3
    keepAlive    
    echo "Ready to network!"
  done
}

main
while ((0 <= 100)); do
  sleep 3600
  main
done
