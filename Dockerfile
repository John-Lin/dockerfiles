# Ryu SDN Framework
#
# Fork from https://registry.hub.docker.com/u/osrg/ryu/dockerfile/

FROM ubuntu:14.04

MAINTAINER John Lin <linton.tw@gmail.com>

RUN apt-get update
RUN apt-get install -qy --no-install-recommends python-setuptools python-pip python-eventlet python-lxml python-msgpack python-netaddr python-oslo.config python-paramiko python-routes python-six python-webob unzip wget vim git

ENV HOME /root
WORKDIR /root

# Download Ryu source code
RUN wget --no-check-certificate https://github.com/osrg/ryu/archive/master.zip
RUN unzip master.zip
RUN cd ryu-master && python setup.py install

# Download customize SDN applications
# RUN wget --no-check-certificate url
