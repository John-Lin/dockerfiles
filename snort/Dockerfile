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
        libnetfilter-queue1 \
        vim \
        tmux && \
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

RUN ldconfig

ENV SNORT_RULES_SNAPSHOT 2972
ADD snortrules-snapshot-${SNORT_RULES_SNAPSHOT}.tar.gz /opt
RUN mkdir /var/log/snort && \
    mkdir -p /usr/local/lib/snort_dynamicrules && \
    mkdir -p /etc/snort && \
    cp -r /opt/rules /etc/snort/rules && \
    cp -r /opt/preproc_rules /etc/snort/preproc_rules && \
    cp -r /opt/so_rules /etc/snort/so_rules && \
    cp -r /opt/etc /etc/snort/etc && \
    touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules

# Clean up
RUN rm -f /opt/snort-${SNORT_VERSION}.tar.gz /opt/daq-${DAQ_VERSION}.tar.gz

# Expose all port for snort promiscuous mode
# http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml
EXPOSE 0-65535

ENV NETWORK_INTERFACE eth0
# Validate an installation
# snort -T -i eth0 -c /etc/snort/etc/snort.conf
CMD ["snort", "-T", "-i", "echo ${NETWORK_INTERFACE}", "-c", "/etc/snort/etc/snort.conf"]


# For testing add this rule in the file at /etc/snort/rules/local.rules
# alert icmp any any -> any any (msg:"Pinging...";sid:1000004;)

# Running Snort and alerts to the console (screen).
# snort -i eth0 -c /etc/snort/etc/snort.conf -A console

# Ping in the container the alert message will show on the console
