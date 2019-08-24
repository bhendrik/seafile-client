FROM phusion/baseimage:0.11
MAINTAINER Bram Hendriks <bhendrik@gmail.com>

RUN groupadd -r -g 1000 sfuser \
  && useradd -r -m -u 1000 -g 1000 sfuser
COPY sync.sh /sync.sh
COPY status.sh /status.sh
RUN touch /etc/apt/sources.list.d/seaf.list \
  && echo deb [trusted=yes] http://ppa.launchpad.net/seafile/seafile-client/ubuntu bionic main >> /etc/apt/sources.list.d/seaf.list \
  && echo deb-src [trusted=yes] http://ppa.launchpad.net/seafile/seafile-client/ubuntu bionic main >> /etc/apt/sources.list.d/seaf.list \
  && apt-get update \
  && install_clean --install-recommends seafile-cli \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /etc/service/seafile
COPY seaf.sh /etc/service/seafile/run
RUN chmod +x /etc/service/seafile/run
USER sfuser
RUN mkdir /home/sfuser/seafile-client
RUN seaf-cli init -d  /home/sfuser/seafile-client
USER root
VOLUME ["/data"]
VOLUME ["/home/sfuser/seafile-client/seafile-data"]
CMD ["/sbin/my_init"]
