#FROM ubuntu:18.04
FROM idl

RUN apt -y update && apt install -y apt-utils

RUN DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    ca-certificates \
    less \
    gcc \
    gfortran \
    wget \
    git \
    subversion \
    tcl-dev \
    python \
    python-pip

RUN mkdir /src \
 && cd /src \
 && wget https://astuteinternet.dl.sourceforge.net/project/modules/Modules/modules-4.2.4/modules-4.2.4.tar.gz

WORKDIR /src

RUN tar xzf modules-4.2.4.tar.gz \
 && cd modules-4.2.4 \
 && ./configure \
 && make \
 && make install

RUN ln -s /usr/local/Modules/init/profile.sh /etc/profile.d/modules.sh \
 && ln -s /usr/local/Modules/init/profile.csh /etc/profile.d/modules.csh \
 && echo "source /usr/local/Modules/init/bash" >> ~/.bashrc \
 && echo "source /usr/local/Modules/init/bash" >> ~/.bash_profile \
 && echo ". /usr/local/Modules/init/sh" >> ~/.profile

RUN mkdir -p /src/sdss/github/modulefiles \
 && mkdir -p /src/sdss/svn/modulefiles

WORKDIR /src/sdss

ENV SDSS_INSTALL_PRODUCT_ROOT /src/sdss
ENV SDSS_GITHUB_KEY 25a31ae42d49e6c7317ada0875dab41c1ce5f90e

RUN pip install setuptools wheel \
 && pip install pyyaml pygments requests

RUN . /usr/local/Modules/init/sh \
 && module use /src/sdss/github/modulefiles \
 && module use /src/sdss/svn/modulefiles \
 && git clone https://github.com/sdss/sdss_install.git github/sdss_install/master \
 && ./github/sdss_install/master/bin/sdss_install_bootstrap \
 && module load sdss_install \
 && svn export https://svn.sdss.org/public/repo/sdss/idlutils/tags/v5_5_33/bin/ \
 && export PATH=${PATH}:/src/sdss/bin \
 && sdss_install --public -v data/sdss/catalogs/dust v0_2

SHELL ["/bin/bash", "-c"]
ENV HOME /root
RUN echo "module use /src/sdss/github/modulefiles" >> ~/.bashrc \
 && echo "module use /src/sdss/svn/modulefiles" >> ~/.bashrc \
 && echo "module load sdss_install" >> ~/.bashrc

ENV PATH ${PATH}:/src/sdss/bin

RUN svn export https://svn.sdss.org/public/repo/sdss/idlutils/tags/v5_5_33 /src/sdss/idlutils-v5_5_33

#ADD idl85envi53sp1linux.x86_64.tar.gz /tmp
#ADD in.txt /tmp
#RUN cd /tmp && cat in.txt | ./install.sh

ENV IDL_DIR /usr/local/idl/idl85
ENV IDLUTILS_DIR /src/sdss/svn/idlutils/v5_5_33

#ENV CFLAGS -I/usr/local/idl/idl85/external
#ENV SDSS_CFLAGS -I/usr/local/idl/idl85/external
#ENV X_CFLAGS -I/usr/local/idl/idl85/external
# eg, idlutils/.../src/image/Makefile:
# CFLAGS = $(SDSS_CFLAGS) -DCHECK_LEAKS -I$(INC)


RUN . /usr/local/Modules/init/sh \
 && module use /src/sdss/github/modulefiles \
 && module use /src/sdss/svn/modulefiles \
 && module load sdss_install \
 && sdss_install --public -v sdss/idlutils v5_5_33 \
 && echo 2

# 
#sdss_install --public -v sdss/photoop v1_12_3