#!/bin/bash
set -euo pipefail

# 1.检查依赖
set +e
check(){
    rpm -qa |  grep python-devel > /dev/null
    if [ $? != 0 ]
    then
        echo "please install python-devel"
        exit 1
    else
        echo "start install "
    fi
}
echo "-----检查依赖-----"
check
echo "-----检查依赖完毕-----"

set -e
home_path=$(pwd)




# 2.setuptools模块安装

# https://pypi.python.org/packages/source/s/setuptools/setuptools-7.0.tar.gz
tar xvzf setuptools-7.0.tar.gz 
cd setuptools-7.0
python setup.py install
cd ${home_path}


# 3.pycrypto模块安装

# https://pypi.python.org/packages/source/p/pycrypto/pycrypto-2.6.1.tar.gz

tar xvzf pycrypto-2.6.1.tar.gz  
cd pycrypto-2.6.1 
python setup.py install  
cd ${home_path}

# 4.PyYAML模块安装

# http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz

tar xvzf yaml-0.1.5.tar.gz 
cd yaml-0.1.5
./configure --prefix=/usr/local 
make --jobs=`grep processor /proc/cpuinfo | wc -l` 
make install 
cd ${home_path}
# https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.11.tar.gz

tar xvzf PyYAML-3.11.tar.gz
cd PyYAML-3.11
python setup.py install
cd ${home_path}
# 5.Jinja2模块安装

# https://pypi.python.org/packages/source/M/MarkupSafe/MarkupSafe-0.9.3.tar.gz

tar xvzf MarkupSafe-0.9.3.tar.gz
cd MarkupSafe-0.9.3
python setup.py install 
cd ${home_path}
# https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.7.3.tar.gz

tar xvzf Jinja2-2.7.3.tar.gz
cd Jinja2-2.7.3 
python setup.py install
cd ${home_path}
# 6.paramiko模块安装

# https://pypi.python.org/packages/source/e/ecdsa/ecdsa-0.11.tar.gz


tar xvzf ecdsa-0.11.tar.gz 
cd ecdsa-0.11
python setup.py install
cd ${home_path}
# https://pypi.python.org/packages/source/p/paramiko/paramiko-1.15.1.tar.gz

tar xvzf paramiko-1.15.1.tar.gz 
cd paramiko-1.15.1
python setup.py install 
cd ${home_path}
# 7.simplejson模块安装

# https://pypi.python.org/packages/source/s/simplejson/simplejson-3.6.5.tar.gz


tar xvzf simplejson-3.6.5.tar.gz 
cd simplejson-3.6.5
python setup.py install 
cd ${home_path}
# 8.ansible安装

# https://github.com/ansible/ansible/archive/v1.7.2.tar.gz


tar xvzf ansible-1.7.2.tar.gz 
cd ansible-1.7.2
python setup.py install 
mkdir -p /etc/ansible/
cp examples/ansible.cfg /etc/ansible/
cp examples/hosts /etc/ansible/
sed -i.bak 's/#log_path/log_path/' /etc/ansible/ansible.cfg
cd ${home_path}

# 9.删除安装包
for i in $(ls |  grep -v tar)
do
    if [ ${i} == auto_install.sh ]
    then
        :
    else
        rm -rf ${i}
    fi
done
