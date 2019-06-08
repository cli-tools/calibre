ARG build=production
ARG service=auth

FROM ubuntu:18.04 AS base
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y curl python python-pyqt5 \
 && rm -rf /var/lib/apt/lists/*
RUN curl -s https://download.calibre-ebook.com/linux-installer.sh | sh -
RUN mkdir /books /config
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR /config
EXPOSE 8080

FROM base AS auth
CMD calibre-server --enable-auth --auth-mode=basic --userdb=user.db $CALIBRE_LIBRARIES

FROM base AS mobile
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python-pip supervisor \
 && rm -rf /var/lib/apt/lists/* \
 && pip --no-cache-dir install superfsmon
COPY conf.d/* /etc/supervisor/conf.d/
CMD ["/usr/bin/supervisord","-n","-c","/etc/supervisor/supervisord.conf"]

FROM $service
