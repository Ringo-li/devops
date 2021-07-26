#!/bin/bash

df_lines=$(df -P | wc -l)

max_dir=''
max_siz=0

for i in $(seq 2 $df_lines)
do
    temp_siz=$(df -P | awk -v i=$i 'NR==i{print $4}')
    if [ $temp_siz -gt $max_siz ];then
        max_siz=$temp_siz
        max_dir=$(df -P | awk -v i=$i 'NR==i{print $NF}')
    fi
done

echo $max_dir
