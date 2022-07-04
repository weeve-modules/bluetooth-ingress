FROM python:3.8-slim
WORKDIR /app
RUN mkdir -p /app
COPY ./image/requirements.txt /app
RUN   apt-get update -y && apt-get upgrade -y && apt-get install -y make
RUN apt-get install  libglib2.0-dev python3-pip  python3-dev -y
RUN  pip3 install -r requirements.txt
COPY . /app
SHELL ["/bin/bash", "-c"]
COPY ./image/entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 80