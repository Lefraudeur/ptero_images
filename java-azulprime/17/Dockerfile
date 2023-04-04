FROM        oraclelinux:9-slim as build

LABEL       author="Lefraudeur" maintainer="karlbouisseren@gmail.com"
LABEL       org.opencontainers.image.source="https://github.com/Lefraudeur/ptero_images"
LABEL       org.opencontainers.image.licenses="MIT"

COPY        ./azulprime17 /usr/lib/jvm

RUN         microdnf install -y zip unzip \
            && microdnf clean all \
            && cd /usr/lib/jvm \
            && if [[ $(uname -m) = aarch64 ]]; then arch=aarch64; else arch=amd64; fi \
            && zip -FF zing23.03.0.0-3-jdk17.0.6-linux-${arch}.zip --out zing23.03.0.0-3-jdk17.0.6-linux-${arch}-full.zip \
            && unzip -o zing23.03.0.0-3-jdk17.0.6-linux-${arch}-full.zip \
            && rm -f zing23.03.0.0-3-jdk17.0.6-linux-* \
            && chmod -R 775 /usr/lib/jvm/zing23.03.0.0-3-jdk17.0.6-linux/*
            
            
FROM        oraclelinux:9-slim as main

COPY        --from=build /usr/lib/jvm/zing23.03.0.0-3-jdk17.0.6-linux /usr/lib/jvm/zing23.03.0.0-3-jdk17.0.6-linux

RUN         microdnf install -y iproute \
            && microdnf clean all \
            && adduser --home-dir /home/container container

ENV         PATH=/usr/lib/jvm/zing23.03.0.0-3-jdk17.0.6-linux/bin:$PATH
ENV         JAVA_HOME=/usr/lib/jvm/zing23.03.0.0-3-jdk17.0.6-linux

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]