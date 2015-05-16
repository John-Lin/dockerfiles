# Ryu SDN Framework
#
# Fork from https://registry.hub.docker.com/u/osrg/ryu/dockerfile/

FROM ubuntu:14.04

MAINTAINER John Lin <linton.tw@gmail.com>

# Download Ryu source code
RUN apt-get update &&
    apt-get install -qy --no-install-recommends python-setuptools python-pip \
        python-eventlet python-lxml python-msgpack python-netaddr \
        python-oslo.config python-paramiko python-routes python-six
        python-webob unzip wget vim git && \
        apt-get clean && \
    wget --no-check-certificate https://github.com/osrg/ryu/archive/master.zip && \
    unzip master.zip && \
    mv ryu-master ryu && \
    rm ./ryu-master.zip && \
    cd ryu-master && \
    python ./setup.py install

# 6633 - OpenFlow
EXPOSE 6633

ENV HOME /root
WORKDIR /root


# Execute simple_siwtch_13.py
CMD ["ryu-manager", "ryu/app/simple_switch_13.py"]

# Download customize SDN applications
# RUN wget --no-check-certificate url
