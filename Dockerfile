FROM ubuntu:16.04

COPY package.json ./

RUN apt-get update -y && \
    apt-get install -yqq \
        python \
        build-essential \
        apt-transport-https \
        ca-certificates \
        curl \
        locales \
        nodejs \
        npm \
        nodejs-legacy \
        sudo \
        git

## NodeJS and MeteorJS
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN curl https://install.meteor.com/ | sh

## Dependencies
RUN npm install -g eslint eslint-plugin-react
RUN npm install

## Locale
ENV OS_LOCALE="en_US.UTF-8"
RUN locale-gen ${OS_LOCALE}
ENV LANG=${OS_LOCALE} LANGUAGE=en_US:en LC_ALL=${OS_LOCALE}

## User
RUN useradd ubuntu && \
    usermod -aG sudo ubuntu && \
    mkdir -p /builds/core/.meteor /home/ubuntu && \
    chown -Rh ubuntu:ubuntu /builds/core/.meteor && \
    chown -Rh ubuntu:ubuntu /home/ubuntu
USER ubuntu
