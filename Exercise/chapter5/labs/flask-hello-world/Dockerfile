FROM python:2.7-alpine
LABEL maintainer="Ringo"
COPY . /app/
WORKDIR /app
EXPOSE 5000
RUN ["sh", "init.sh"]
RUN pip install flask Flask-Script
ENTRYPOINT [ "python", "manage.py" ]
CMD []
