FROM docker-host:5000/python:3.6
LABEL maintaner="ry.li@qq.com"
COPY . /app
WORKDIR /app
RUN pip3 install flask redis
EXPOSE 5000
CMD [ "python3", "app.py" ]
