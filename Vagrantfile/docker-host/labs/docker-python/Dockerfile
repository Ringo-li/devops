FROM ubuntu
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list  /etc/apt/
RUN apt-get update && apt-get install -y  python3.6 && apt-get install -y python3-pip
RUN mkdir -p /root/.config/pip/
COPY pip.conf /root/.config/pip/

