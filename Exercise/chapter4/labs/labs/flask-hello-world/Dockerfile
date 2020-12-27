FROM docker-host:5000/python:3.6
LABEL maintainer="Ringo<ry.li@qq.com>"
RUN pip install flask Flask-Script
COPY . /app/
WORKDIR /app
EXPOSE 5000
ENTRYPOINT [ "python", "manage.py" ]
CMD []
