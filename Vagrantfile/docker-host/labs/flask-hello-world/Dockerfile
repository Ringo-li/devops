FROM python:3.6
LABEL maintainer="Ringo<ry.li@qq.com>"
RUN pip3 install flask
COPY app.py /app/
WORKDIR /app
EXPOSE 5000
CMD ["python3", "app.py"]
