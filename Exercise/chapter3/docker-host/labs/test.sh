#！/bin/bash

list=(
a_service
b_service
c_service
d_service
e_service
f_service
g_service
)
echo "----------- stop ${list[0]} ---------" 
for node in {3..8}
do
    echo "node$node ${list[0]} has stoped"
    echo "node$node ${list[1]} has stoped"
done
echo "----------- ${list[0]} stoped ---------" 

for node in {1..3}
do
    echo node$node ${list[3]} has stoped
done
