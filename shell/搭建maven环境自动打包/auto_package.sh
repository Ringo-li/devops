#!/usr/bin/env bash

mv /root/webmanager/target/src.tar /root/webmanager
rm -rf /root/webmanager/src
tar -xf /root/webmanager/src.tar
rm -rf /root/webmanager/src.tar
sed -i 's/218.84.107.50/172.29.155.34/' /root/webmanager/src/main/resources/static/static/urls.js
mvn package