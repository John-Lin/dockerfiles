# Snort in Docker

FROM ubuntu:14.04

MAINTAINER John Lin <linton.tw@gmail.com>

RUN apt-get update && apt-get -y install \
        wget \
        build-essential \
        bison \
        flex \
        libpcap-dev \
        libpcre3-dev \
        libdumbnet-dev \
        zlib1g-dev \
        iptables-dev \
        libnetfilter-queue1 && \
    apt-get clean

# Define working directory.
WORKDIR /opt

ENV DAQ_VERSION 2.0.4
RUN wget https://www.snort.org/downloads/snort/daq-${DAQ_VERSION}.tar.gz \
    && tar xvfz daq-${DAQ_VERSION}.tar.gz \
    && cd daq-${DAQ_VERSION} \
    && ./configure; make; make install

ENV SNORT_VERSION 2.9.7.2
RUN wget https://www.snort.org/downloads/snort/snort-${SNORT_VERSION}.tar.gz \
    && tar xvfz snort-${SNORT_VERSION}.tar.gz \
    && cd snort-${SNORT_VERSION} \
    && ./configure; make; make install

ENV SNORT_RULES_SNAPSHOT 2972
ADD snortrules-snapshot-${SNORT_RULES_SNAPSHOT}.tar.gz /opt
RUN mkdir /var/log/snort && \
    mkdir /etc/snort && \
    touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules && \
    mkdir /usr/local/lib/snort_dynamicrules && \
    mv /etc/snort/etc/* /etc/snort/ && \
    tar zxvf snortrules-snapshot-${SNORT_RULES_SNAPSHOT}.tar.gz -C /etc/snort/ && \

RUN ldconfig

CMD ["snort", "-V"]
