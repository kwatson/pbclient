FROM debian:11

RUN apt-get update \
    && apt-get -y install \
      wget \
      vim \
    ; \
    wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg \
    && echo "deb http://download.proxmox.com/debian/pbs-client bullseye main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get -y install proxmox-backup-client
    