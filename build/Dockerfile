FROM debian:bookworm-slim

LABEL org.opencontainers.image.authors="lacbenedek@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN \
    apt update && apt upgrade -y && \
    apt install -y --no-install-recommends \
        qemu-system qemu-utils qemu-kvm \
        samba mkisofs mount netcat-traditional \
    && apt autoremove -y && apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
COPY install.sh /install.sh
COPY autounattend.xml /autounattend.xml

ENV BASE=/base.qcow2
ENV BASE_FORMAT=qcow2
ENV BASE_SIZE=40GB

ENV SETUP_ISO=/setup.iso
ENV CUSTOM_SETUP_ISO=/custom_setup.iso
ENV AUTOUNATTEND_XML=/autounattend.xml

ENV KEYBOARD=en-gb
ENV MEMORY=4096
ENV CPU=host
ENV SMP=cores=2,threads=1,sockets=1

ENV VNC_DISPLAY=0
ENV MONITOR_PORT=5801

EXPOSE 5801/tcp
EXPOSE 5900/tcp

ENTRYPOINT [ "/start.sh" ]