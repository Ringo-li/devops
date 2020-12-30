#!/bin/bash
cat > pip.conf <<EOF
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
EOF

mkdir -p /root/.config/pip && mv pip.conf /root/.config/pip/
