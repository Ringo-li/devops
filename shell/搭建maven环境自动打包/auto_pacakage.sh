#!/usr/bin/env bash
set -e

mv /root/webmanager/target/src.tar /root/webmanager
rm -rf /root/webmanager/src
tar -xf /root/webmanager/src.tar
rm -rf /root/webmanager/src.tar
#sed -i 's/218.84.107.50/172.29.155.34/' /root/webmanager/src/main/resources/static/static/urls.js
# sed -i 's/icenter.geovis.online/172.29.155.75:8310/' /root/webmanager/src/main/resources/static/static/urls.js
python replace_file_text.py
mvn package
