FROM resin/rpi-raspbian:latest
MAINTAINER Michele Preti <lelmarir@gmail.com>

RUN apt-get update
RUN apt-get -y install wget
RUN wget http://packages.ntop.org/apt/ntop.key
RUN apt-key add ntop.key
RUN echo "deb http://apt.ntop.org/jessie_pi armhf/" > /etc/apt/sources.list.d/ntop.list
RUN echo "deb http://apt.ntop.org/jessie_pi all/" >> /etc/apt/sources.list.d/ntop.list
RUN apt-get update
RUN apt-get install ntopng nprobe libpcap0.8 libmysqlclient18

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000

RUN echo '#!/bin/bash\n/etc/init.d/redis-server start\nntopng "$@"' > /tmp/run.sh
RUN chmod +x /tmp/run.sh

ENTRYPOINT ["/tmp/run.sh"]