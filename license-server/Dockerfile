FROM ubuntu:18.04

WORKDIR /tmp
ADD licenseserver8511linux.x86_64.tar.gz /tmp
ADD in.txt /tmp
RUN cd /tmp && cat in.txt | ./install.sh

RUN DEBIAN_FRONTEND=noninteractive \
    && apt -y update && apt install -y apt-utils \
    && apt install -y --no-install-recommends \
    ca-certificates \
    less \
    nano \
    gcc-multilib \
    lsb-core \
    file libc6-i386 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# libfreetype6 libxpm4 libxext6 libxmu-dev libidn11 x11-apps

# lsb-core is essential for binary support for the executables!!

COPY license-faizan.dat /usr/local/exelis/license/license.dat

ENV PATH=$PATH:/usr/local/exelis/idl/bin

