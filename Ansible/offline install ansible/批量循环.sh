for i in $(ls)
do 
    if [ ${i} == auto_install.sh ]
    then
        :
    elif [ ${i%.tar.gz} == yaml-0.1.5 ]
    then
        tar -xf $i
        cd ${i%.tar.gz}
        ./configure --prefix=/usr/local
        make --jobs=`grep processor /proc/cpuinfo | wc -l`
        make install
        echo ${i%.tar.gz}"编译安装中"
        cd ${home_path}
        rm -rf ${i%.tar.gz}
    else
        tar -xf $i
        cd ${i%.tar.gz}
        echo ${i%.tar.gz}"python安装中"
        python setup.py install
        cd ${home_path}
        rm -rf ${i%.tar.gz}
    fi
done