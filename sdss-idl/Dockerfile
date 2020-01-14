#FROM ubuntu:18.04
FROM idl

RUN apt -y update && apt install -y apt-utils && echo 2

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
    python-pip \
    nano \
    gcc-multilib \
    libfreetype6 libxpm4 libxext6 libxmu-dev \
    emacs rsync iputils-ping libidn11 x11-apps file libc6-i386 net-tools \
    strace lsb-core vim \
    fitsverify

RUN wget http://ftp.debian.org/debian/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb \
    && dpkg -i libxp6_1.0.2-2_amd64.deb

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

RUN apt install -y ssh-client

RUN . /usr/local/Modules/init/sh \
 && module use /src/sdss/github/modulefiles \
 && module use /src/sdss/svn/modulefiles \
 && git clone https://github.com/sdss/sdss_install.git github/sdss_install/master \
 && (cd github/sdss_install/master && git checkout 1.0.3) \
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

ENV IDL_DIR /usr/local/idl/idl85
ENV IDLUTILS_DIR /src/sdss/svn/idlutils/v5_5_33

RUN . /usr/local/Modules/init/sh \
 && module use /src/sdss/github/modulefiles \
 && module use /src/sdss/svn/modulefiles \
 && module load sdss_install \
 && sdss_install --public -v sdss/idlutils v5_5_33 \
 && echo 2

# RUN . /usr/local/Modules/init/sh \
#  && module use /src/sdss/github/modulefiles \
#  && module use /src/sdss/svn/modulefiles \
#  && module load sdss_install \
#  && sdss_install --public -v sdss/photoop v1_12_3
# 
# RUN . /usr/local/Modules/init/sh \
#  && module use /src/sdss/github/modulefiles \
#  && module use /src/sdss/svn/modulefiles \
#  && module load sdss_install \
#  && sdss_install --public -v sdss/platedesign v5_1
# 
# RUN . /usr/local/Modules/init/sh \
#  && module use /src/sdss/github/modulefiles \
#  && module use /src/sdss/svn/modulefiles \
#  && module load sdss_install \
#  && sdss_install --public -v data/sdss/catalogs/tycho2 v0_0

#&& sdss_install --public -v data/sdss/platelist trunk \
 
ENV SDSS4_PRODUCT_ROOT=/src/sdss

RUN . /usr/local/Modules/init/sh \
 && mkdir -p /src/sdss/modulefiles \
 && module use /src/sdss/modulefiles \
 && svn export https://svn.sdss.org/public/repo/sdss/sdss4tools/trunk/bin/sdss4bootstrap

RUN . /usr/local/Modules/init/sh \
 && ./sdss4bootstrap

ENV LC_ALL C
COPY setup.sh /src/sdss/

#RUN . /usr/local/Modules/init/sh \
# && module use /src/sdss/modulefiles \
# && module load sdss4tools \
RUN . /src/setup.sh \
&& sdss4install --public -v sdss/platedesign trunk

#sdss4install --public -v sdss/photoop v1_12_3 -r /project/rrg-wperciva/sdss_tiling_products_installed/

#ARG sdss_svn_user
#ARG sdss_svn_pass

RUN mkdir -p /root/.subversion/auth/svn.simple/
COPY secret.txt /root/.subversion/auth/svn.simple/74f8b04305ec6bed8d8275f32bea2475

ENV PATH $IDLUTILS_DIR/bin:$PATH
ENV IDL_PATH=+$IDLUTILS_DIR/goddard/pro:+$IDLUTILS_DIR/pro:$IDL_PATH

#RUN apt install -y gcc-multilib
# libc6-i386 libc6-dev-i386

RUN mkdir -p /uufs/chpc.utah.edu/sys/pkg/idl/7.1/idl/external/ \
 && ln -s $IDL_DIR/external/export.h /uufs/chpc.utah.edu/sys/pkg/idl/7.1/idl/external/

RUN . /usr/local/Modules/init/sh \
 && module use /src/sdss/modulefiles \
 && module load sdss4tools \
 && sdss4install -U dstn eboss/ebosstile v1_16

# platelist
# idlspec2d

# ebosstarget is big! (2.5 GB)
# RUN . /usr/local/Modules/init/sh \
#  && module use /src/sdss/modulefiles \
#  && module load sdss4tools \
#  && sdss4install -U dstn eboss/ebosstarget v9_1

# ebosstilelist (48 GB!!)
# sdss4install -U dstn eboss/ebosstilelist trunk

# ok: sdss4tools/0.2.7

# ok: sdss/idlutils trunk
#   ERROR: Unable to locate a modulefile for 'dust'
#   ERROR: Unable to locate a modulefile for 'photolog'
#   ERROR: Unable to locate a modulefile for 'twomass'
#   ERROR: Unable to locate a modulefile for 'usno'
# ok: eboss/ebosstarget v9_1
#   ERROR: Unable to locate a modulefile for 'platelist'

# sdss4install --public data/sdss/platelist trunk
# platelist/dev

# export PLATEDESIGN_DIR=/src/sdss/platedesign/trunk/
# sdss4install --public --force sdss/platedesign trunk
#    ERROR: Unable to locate a modulefile for 'platelist'
#    ERROR: Unable to locate a modulefile for 'fitsverify'
#    ERROR: Unable to locate a modulefile for 'mangacore'
#    ERROR: Unable to locate a modulefile for 'sdss_access'
#    ERROR: Unable to locate a modulefile for 'tree'
#    ERROR: Unable to locate a modulefile for 'tycho2'

# sdss4install eboss/ebosstilelist trunk
# ebosstilelist/trunk
# > 22 GB and counting...

# yannytools/v1_5
# sdss4install -u https://svn.sdss.org/public/sdss3/ yannytools v1_5
# sdss4install - INFO - Creating Modules directory yannytools
# Traceback (most recent call last):
#   File "/src/sdss/sdss4tools/0.2.7/bin/sdss4install", line 45, in <module>
#     install.build()
#   File "/src/sdss/sdss4tools/0.2.7/python/sdss4tools/install/install.py", line 426, in build
#     if md or cf:
# UnboundLocalError: local variable 'md' referenced before assignment

# ebosstile/v1_16
# idlspec2d/v5_13_0
# yaplatedb/trunk
# speclog/trunk
# eboss/v5_13_0  <-- meta-package/module?

# sdss4install --public manga/mangacore v1_6_2
# sdss4install sdss/sdss_access 0.2.2

# sdss4install sdss/sas v1_27

# export SAS_BASE_DIR=/src/sdss/sas-base-dir
# sdss4install sdss/tree 2.15.1
# ((mess))

# sdss4install --public -v data/sdss/catalogs/tycho2 v0_0
# --> claims fail on installing module, and doesn't appear in 'module avail'
# -->
#   x  sdss_install --public --force data/sdss/catalogs/tycho2 v0_0
# docker run -it --mount type=bind,src=$HOME/sdss-products/,dst=/products dstndstn/sdss-idl bash
#     sdss_install --public -r /products/ data/sdss/catalogs/tycho2 v0_0
# sdssinstall - INFO - Installing in /products/svn/tycho2/v0_0
# sdssinstall - INFO - Done! (failed modules)
# sdssinstall - INFO - Nonexistent template u'/src/sdss/tycho2-v0_0/etc/tycho2.module'

# sdss4install eboss/ebosstarget v9_1

# cfitsio, fitsverify: manual

# module use /src/sdss/github/modulefiles
# module use /src/sdss/svn/modulefiles
# module load sdss_install

#RUN apt install -y libfreetype6 libxpm4 libxext6 libxmu-dev

#RUN apt update && apt install -y --no-install-recommends emacs rsync iputils-ping libidn11 x11-apps file libc6-i386 net-tools strace lsb-core vim

#RUN apt install -y fitsverify
RUN mkdir -p /src/sdss/fitsverify/4.18 && \
    ln -s /usr/bin/fitsverify /src/sdss/fitsverify/4.18 && \
    mkdir /src/sdss/modulefiles/fitsverify
COPY fitsverify-4.18.module /src/sdss/modulefiles/fitsverify/4.18

RUN echo "module use /src/sdss/modulefiles" >> ~/.bashrc

RUN rm /bin/sh; ln -s bash /bin/sh

ENV IDL_PATH +/usr/local/idl/idl85/lib:

COPY setup.sh /src/
# hack, setup.sh resets $HOME (because reasons?)
RUN ln -s /root /home

#RUN . /src/setup.sh && sdss4install --user dstn -v eboss/ebosstarget v9_1

RUN mkdir -p /src/sdss/yannytools/ && \
    svn export https://svn.sdss.org/public/sdss3/repo/yannytools/tags/v1_5 /src/sdss/yannytools/v1_5/ && \
    mkdir -p /src/sdss/modulefiles/yannytools
COPY yannytools-v1.5.module /src/sdss/modulefiles/yannytools/v1.5

# # module load ebosstarget
# Loading platedesign/trunk
#   ERROR: Unable to locate a modulefile for 'platelist'
#   ERROR: Requirement platelist is not loaded
# 
# Loading ebosstarget/v9_1
#   ERROR: Load of requirement platelist failed
#   ERROR: Load of requirement platedesign/trunk failed

#RUN . /src/setup.sh && sdss4install --public data/sdss/platelist trunk
#
# try:
#  $ sdss4install --public data/sdss/platelist trunk -r /project/rrg-wperciva/sdss_tiling_products_installed -v
# damn, it's 85 GB!

RUN mkdir -p /src/sdss/modulefiles/tree
COPY tree-dr16.module /src/sdss/modulefiles/tree/dr16
# link trunk -> dr16
RUN ln -s /src/sdss/modulefiles/tree/dr16 /src/sdss/modulefiles/tree/trunk

# sdss4install -v -r /project/rrg-wperciva/sdss_tiling_products_installed --public data/sdss/catalogs/tycho2 trunk
# tycho2 -- 375 MB... and no module file
RUN . /src/setup.sh && sdss4install -v --public data/sdss/catalogs/tycho2 trunk
RUN mkdir -p /src/sdss/modulefiles/tycho2
COPY tycho2.module /src/sdss/modulefiles/tycho2/trunk

# sdss4install --public -v sdss/photoop v1_12_3 -r /project/rrg-wperciva/sdss_tiling_products_installed/

# dstn@container:/scratch/dstn$ module load platedesign
# Loading platedesign/v5_1
#  Loading requirement: photoop/v1_12_3 platelist/trunk fitsverify/4.17 mangacore/trunk sdss_access/master tree/trunk tycho2/trunk

ENV LM_LICENSE_FILE=/scratch/dstn/license-faizan.dat

RUN ln -s /tmp /usr/tmp


# Be sure to run with singularity exec -B /scratch,/project .....
# singularity run -B /project/rrg-wperciva sdss-idl2.sif bash

# graham build:
# $ salloc --time=1:00:00 --account=def-dstn-ab --mem-per-cpu=16G
# $ singularity build $SCRATCH/sdss-idl2x.sif docker://dstndstn/sdss-idl:latest




# singularity exec --hostname container -B /project/rrg-wperciva /scratch/dstn/sdss-idl.sif bash
# . /src/setup.sh
# module use /project/rrg-wperciva/sdss_tiling_products_installed/modulefiles
# module load ebosstarget


