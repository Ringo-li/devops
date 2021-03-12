#!/bin/bash
set -e

service_list=(
hbase-regionserver
hbase-master
hadoop-hdfs-datanode
hadoop-hdfs-journalnode
hadoop-hdfs-namenode
hadoop-hdfs-zkfc
)

function hbase(){
    echo -e "\n----------------  \033[32mHbase 集群开始关闭\033[0m ----------------"
    for service in ${service_list[*]}
    do
        for node in {1..8}
        do
            before=$(ssh gv100d0${node} "ps -ef |grep ${service} |grep -v grep |wc -l")
            if [ ${before} -ge 1 ]
            then
                ssh gv100d0${node} "systemctl status ${service}" > /dev/null
    #            sleep 1
                after=$(ssh gv100d0${node} "ps -ef |grep ${service} |grep -v grep |wc -l")
                if [ ${after} == 0 ]
                then
                    echo " status gv100d0${node} ${service} finished "
                else
                    echo " status gv100d0${node} ${service} failed, please check "
                    return 1
                fi
            fi
        done
    done

    for node in {1..3}; do ssh gv100d0${node} "systemctl status zookeeper-server" > /dev/null; done
    echo " status zookeeper-server finished "
    echo -e "\n---------------- \033[32mHbase 集群已关闭\033[0m -----------------"
}

function tile(){
    echo -e "\n----------------  \033[32m瓦片服务开始关闭\033[0m ----------------"
    ssh gv100c01 "systemctl status tile-service.service" > /dev/null
    sleep 1
    pid_num=$(ssh gv100c01 "ps -ef |grep tile-service |grep -v grep |wc -l")
    if [ ${pid_num} == 0 ]
    then
        echo " status tile-service finished "
    else
        echo " status tile-service failed, please check "
    fi
    echo -e "\n-----------------  \033[32m瓦片服务已关闭\033[0m -----------------"
}

function oracle(){
    echo -e "\n--------------  \033[32moracle数据库开始关闭\033[0m --------------"
    ssh gv100c05 "systemctl status oracle.service" > /dev/null
    sleep 1
    port_num=$(ssh gv100c05 "ss -nlp | grep :1521 | wc -l")
    if [ ${port_num} == 0 ]
    then
        echo " status oracle.service finished "
    else
        echo " status oracle.service failed, please check "
    fi
    echo -e "\n--------------  \033[32moracle数据库已关闭\033[0m  ---------------"
}


function kafka(){
    echo -e "\n---------------  \033[32mkafka集群开始关闭\033[0m ----------------"
    for node in {1..6}
    do
        ssh gv100i0${node} "/home/cluster/cluster.sh status" > /dev/null
        sleep 1
        pid_num=$(ssh gv100i0${node} "ps -ef |  grep kafka | grep -v grep | wc -l")
        if [ ${pid_num} == 0 ]
        then
            echo " status gv100i0${node} kafka finished "
        else
            echo " status gv100i0${node} kafka failed, please check "
        fi
    done
    echo -e "\n--------------  \033[32mkafka集群已关闭\033[0m  ----------------"
}

function kafka_zookeeper(){
    echo -e "\n------------  \033[32mzookeeper集群开始关闭\033[0m -------------"
    for node in {2..4}
    do
        ssh gv100i0${node} "/volumes/sdb/zookeeper-3.4.5/bin/zkServer.sh  status" &> /dev/null
        sleep 1
        pid_num=$(ssh gv100i0${node} "ps -ef |  grep zookeeper | grep -v grep | wc -l")
        if [ ${pid_num} -le 1 ]
        then
            echo " status gv100i0${node} zookeeper finished "
        else
            echo " status gv100i0${node} zookeeper failed, please check "
        fi
    done
    echo -e "\n------------  \033[32mzookeeper集群已关闭\033[0m  -------------"
}

function main(){
#    hbase
#    tile
#    oracle
    kafka
    kafka_zookeeper
}

main
