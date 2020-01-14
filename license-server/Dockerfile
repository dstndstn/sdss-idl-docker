FROM ubuntu:18.04

WORKDIR /tmp
ADD licenseserver8511linux.x86_64.tar.gz /tmp

#SHELL ["/bin/bash", "-c"]

ADD in.txt /tmp

# UGH I could not figure out how to 
#RUN ["/bin/bash", "-c", "/bin/echo", "-e", "y\n/usr/local\ny\ny\nn\n", "|", "./install.sh"]

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

# libfreetype6 libxpm4 libxext6 libxmu-dev \
# libidn11 x11-apps
    
# lsb-core is essential for binary support for the executables!!

COPY license-faizan.dat /usr/local/exelis/license/license.dat
#ENV LM_LICENSE_FILE=/scratch/dstn/license-faizan.dat

ENV PATH=$PATH:/usr/local/exelis/idl/bin


# docker build -t dstndstn/license-server .
# docker login
# docker push

# on symmetry:
# dlang@mn001:~$ singularity build --docker-login license.sif docker://dstndstn/license-server:latest
# copy to graham...

# screen -R license
# singularity exec --hostname container license.sif bash

## $ lmstat
## lmstat - Copyright (c) 1989-2014 Flexera Software LLC. All Rights Reserved.
## Flexible License Manager status on Tue 1/14/2020 14:37
## 
## License server status: 1700@gra-login1
##     License file(s) on gra-login1: /cvmfs/soft.computecanada.ca/config/licenses/intel/graham.lic:/usr/local/exelis/idl85/../license/license.dat:
## 
## lmgrd is not running: Cannot connect to license server system. (-15,570:115 "Operation now in progress")

# lmgrd
14:38:13 (lmgrd) Can't make directory /usr/tmp/.flexlm, errno: 2(No such file or directory)
dstn@container:/scratch/dstn$ 14:38:13 (lmgrd) "container": Not a valid server hostname, exiting.
14:38:13 (lmgrd) Valid license server system hosts are: "gra-login1"
14:38:13 (lmgrd) Using license file "/usr/local/exelis/idl85/../license/license.dat"

# singularity exec /scratch/dstn/license.sif bash
# 14:40:28 (lmgrd) Can't make directory /usr/tmp/.flexlm, errno: 2(No such file or directory)
# 14:40:28 (idl_lmgrd) FlexNet Licensing version v11.13.1.3 build 176483 x64_lsb
14:40:28 (idl_lmgrd) Cannot create lock file. Old lockfile exists. errno=13 (/var/tmp/lockidl_lmgrd): Permission denied

# mkdir /tmp/dstn-idl-lm
# mkdir /tmp/dstn-idl-lm/usr-tmp
# mkdir /tmp/dstn-idl-lm/var-tmp
# singularity exec -B /tmp/dstn-idl-lm/usr-tmp:/usr/tmp -B /tmp/dstn-idl-lm/var-tmp/:/var/tmp license.sif bash
# lmgrd

# Works!

# singularity exec --hostname container $SCRATCH/sdss-idl.sif bash
# export LM_LICENSE_FILE=58639@gra-login1
# idl

# Works!
