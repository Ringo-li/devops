FROM ubuntu
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list  /etc/apt/
RUN apt-get update && apt-get install -y python3.7

