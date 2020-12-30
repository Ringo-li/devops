FROM python:2.7
COPY . /skeleton
WORKDIR /skeleton
RUN  mkdir -p /root/.config/pip && mv pip.conf /root/.config/pip/
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["/bin/bash", "/skeleton/scripts/dev.sh"]
