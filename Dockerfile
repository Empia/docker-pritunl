FROM ubuntu:14.04
MAINTAINER Oleg Poyaganov <oleg@poyaganov.com>
ENV REFRESHED_AT 2016-03-15-01-24

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y 'deb http://repo.pritunl.com/stable/apt trusty main' && \
    apt-add-repository -y 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse' && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7F0CEB10 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A && \    
    apt-get -y update && \
    apt-get install -y pritunl mongodb-org python-pip iptables && \
    pip install supervisor && \
    mkdir -p /data/db && \
    mkdir -p /data/run && \
    mkdir -p /data/log

COPY supervisord.conf /supervisord.conf
COPY pritunl.conf /pritunl.conf
COPY run-pritunl.sh /run-pritunl.sh

VOLUME ["/data/db", "/data/run", "/data/log"]

EXPOSE 443
EXPOSE 80
EXPOSE 1194/udp

CMD ["supervisord", "-c", "/supervisord.conf"]
