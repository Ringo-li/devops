#!/usr/bin/env python

import os
import re

WORKDIR = 'src/main/resources/static/static/'
#WORKDIR = ''

def replace_file_template(file_in, file_out):
    f=open(file_in,'r')
    alllines=f.readlines()
    f.close()
    f=open(file_out,'w+')
    for eachline in alllines:
        if 'window.location.host' in eachline:
            eachline = re.sub(r'^\s{2}//\s(.*?)$', r'  \1', eachline)
        if 'icenter.geovis.online' in eachline:
            eachline = re.sub(r'^\s{2}(.*?)$', r'  // \1', eachline)
        f.writelines(eachline)
    f.close()

replace_file_template(WORKDIR+'urls.js',WORKDIR+'urls.js')
