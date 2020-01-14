#! /bin/bash

unset MODULEPATH
unset MODULEPATH_ROOT
unset MODULERCFILE
unset NIXUSER_PROFILE
unset PERL5LIB
unset PERL5OPT
unset PIP_CONFIG_FILE
unset _LMFILES_
unset __LMOD_REF_COUNT_MODULEPATH
unset __LMOD_REF_COUNT__LMFILES_
unset LMOD_RC
unset LMOD_PKG
unset LMOD_ADMIN_FILE
unset LMOD_CMD
unset LMOD_DIR
unset LMOD_PACKAGE_PATH
unset LOADEDMODULES
unset LIBRARY_PATH

. /usr/local/Modules/init/sh

module use /src/sdss/modulefiles
module use /src/sdss/svn/modulefiles
module load sdss4tools

# Faizan's
module use /project/rrg-wperciva/sdss_tiling_products/modulefiles
# Dustin's
module use /project/rrg-wperciva/sdss_tiling_products_installed/modulefiles

export LC_ALL=C
export HOME=/home/$(whoami)

