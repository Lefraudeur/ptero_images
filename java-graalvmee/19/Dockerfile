FROM        oraclelinux:9-slim

LABEL       author="Lefraudeur" maintainer="karlbouisseren@gmail.com"
LABEL       org.opencontainers.image.source="https://github.com/Lefraudeur/ptero_images"
LABEL       org.opencontainers.image.licenses="MIT"

COPY        ./graalvmee19 /usr/lib/jvm

RUN         microdnf update -y \
            && microdnf install -y curl ca-certificates openssl git tar iproute zip unzip \
            && microdnf clean all \
            && adduser --home-dir /home/container container \
            && cd /usr/lib/jvm \
            && if [[ $(uname -m) = aarch64 ]]; then arch=aarch64; else arch=amd64; fi \
            && zip -FF graalvm-ee-java19-22.3.1-${arch}.zip --out graalvm-ee-java19-22.3.1-${arch}-full.zip \
            && unzip -o graalvm-ee-java19-22.3.1-${arch}-full.zip \
            && rm -f graalvm-ee-java19-22.3.1* \
            && chown -R container /usr/lib/jvm/graalvm-ee-java19-22.3.1/* \
            && chmod -R 077 /usr/lib/jvm/graalvm-ee-java19-22.3.1/*


ENV         PATH=/usr/lib/jvm/graalvm-ee-java19-22.3.1/bin:$PATH
ENV         JAVA_HOME=/usr/lib/jvm/graalvm-ee-java19-22.3.1

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
