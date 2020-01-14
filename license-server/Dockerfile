FROM ubuntu:18.04

WORKDIR /tmp
ADD licenseserver8511linux.x86_64.tar.gz /tmp

#SHELL ["/bin/bash", "-c"]

ADD in.txt /tmp

# UGH I could not figure out how to 
#RUN ["/bin/bash", "-c", "/bin/echo", "-e", "y\n/usr/local\ny\ny\nn\n", "|", "./install.sh"]

RUN cd /tmp && cat in.txt | ./install.sh

RUN apt -y update && apt install -y apt-utils

RUN DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    ca-certificates \
    less \
    nano \
    gcc-multilib \
    libfreetype6 libxpm4 libxext6 libxmu-dev \
    libidn11 x11-apps file libc6-i386

# This is essential for binary support for the executables!!
RUN apt install -y lsb-core

COPY license-faizan.dat /usr/local/exelis/license/license.dat
#ENV LM_LICENSE_FILE=/scratch/dstn/license-faizan.dat

ENV PATH=$PATH:/usr/local/exelis/idl/bin


# docker build -t license-server .
