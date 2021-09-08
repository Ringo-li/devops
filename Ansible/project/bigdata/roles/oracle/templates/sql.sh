#!/bin/bash
sqlplus / as sysdba << EOF
@/home/oracle/init.sql
EOF
