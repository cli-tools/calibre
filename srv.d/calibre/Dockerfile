ARG build=auth

FROM ubuntu:18.04 AS base
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y curl python python-pyqt5 \
 && rm -rf /var/lib/apt/sources/*
RUN curl -s https://download.calibre-ebook.com/linux-installer.sh | sh -
RUN mkdir /books /config
WORKDIR /config
EXPOSE 8080

FROM base AS auth
CMD calibre-server --enable-auth --userdb user.db /books/*

FROM base AS mobile
CMD calibre-server --disable-local-write /books/*

FROM $build
