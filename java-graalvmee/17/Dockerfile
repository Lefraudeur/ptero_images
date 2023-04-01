FROM        oraclelinux:9-slim as build

LABEL       author="Lefraudeur" maintainer="karlbouisseren@gmail.com"
LABEL       org.opencontainers.image.source="https://github.com/Lefraudeur/ptero_images"
LABEL       org.opencontainers.image.licenses="MIT"

COPY        ./graalvmee17 /usr/lib/jvm

RUN         microdnf install -y zip unzip \
            && microdnf clean all \
            && cd /usr/lib/jvm \
            && if [[ $(uname -m) = aarch64 ]]; then arch=aarch64; else arch=amd64; fi \
            && zip -FF graalvm-ee-java17-22.3.1-${arch}.zip --out graalvm-ee-java17-22.3.1-${arch}-full.zip \
            && unzip -o graalvm-ee-java17-22.3.1-${arch}-full.zip \
            && rm -f graalvm-ee-java17-22.3.1-* \
            && chmod -R 775 /usr/lib/jvm/graalvm-ee-java17-22.3.1/*
            
            
FROM        oraclelinux:9-slim as main

COPY        --from=build /usr/lib/jvm/graalvm-ee-java17-22.3.1 /usr/lib/jvm/graalvm-ee-java17-22.3.1

RUN         microdnf install -y iproute \
            && microdnf clean all \
            && adduser --home-dir /home/container container

ENV         PATH=/usr/lib/jvm/graalvm-ee-java17-22.3.1/bin:$PATH
ENV         JAVA_HOME=/usr/lib/jvm/graalvm-ee-java17-22.3.1

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
