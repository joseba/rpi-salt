FROM resin/rpi-raspbian:jessie

# Update System
RUN apt-get -y update && \
    apt-get -y upgrade -o DPkg::Options::=--force-confold && \
    apt-get -y install wget

# Install Salt
RUN wget -O - https://repo.saltstack.com/apt/debian/8/armhf/latest/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo 'deb http://repo.saltstack.com/apt/debian/8/armhf/latest jessie main' >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y install \
      salt-common \
      salt-master \
      salt-minion \
      salt-ssh \
      salt-cloud && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

VOLUME ["/etc/salt", \
        "/var/cache/salt", \
        "/var/logs/salt", \
        "/srv/salt"]

COPY run.sh /usr/local/bin/
RUN chmod +x \
    /usr/local/bin/run.sh

EXPOSE 4505 4506

CMD /usr/local/bin/run.sh
