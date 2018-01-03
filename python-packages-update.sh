#! /usr/bin/env bash

# Updating Python packages
# ========================
#
# C. Marquardt, Darmstadt
#
# 30 May 2015
#
# Notes:
#  - nose is not installed centrally as it needs to be
#    placed into virtual environments, so it's part of
#    the postmkvirtualenv hook;
#  - same used to be true for iPython; it's nowk installed
#    on an experimental basis;
#  - numpy and scipy are installed via homebrew;
#  - pandas, pillow, matplotlib, matplotlib-basemap, cartopy,
#    seaborn and ggplot are installed via pip;
#  - the version for matplotlib-basemap is currently hardcoded
#    as the script needs to fetch the released file from github;
#  - iPython requires (for its notebook functionality)
#    pyzmq and tornado which can be installed centrally,
#    so I made them part of this general update script.

# 1. Shell variables
# ------------------

ARGS="--upgrade --upgrade-strategy only-if-needed"
PREFIX=`brew --prefix`

# 2. Command line arguments
# -------------------------

while getopts "fh" Option
do
  case $Option in
    f ) ARGS="--upgrade --upgrade-strategy only-if-needed --force-reinstall" ;;
    h ) echo "Usage: `basename $0` [-f]" ; exit ;;
    * ) echo "Unknown option...";;   # Default.
  esac
done

shift $(($OPTIND - 1))

# 3. Update pip and setuptools
# ----------------------------

python -m ensurepip --upgrade

# 4. Development tools
# --------------------

pip install ${ARGS} six
pip install ${ARGS} stevedore
pip install ${ARGS} pbr

pip install ${ARGS} virtualenv
pip install ${ARGS} virtualenv-clone
pip install ${ARGS} virtualenvwrapper

pip install ${ARGS} cython
pip install ${ARGS} Zconfig

#pip install ${ARGS} nose

pip install ${ARGS} egenix-mx-base
pip install ${ARGS} python-dateutil

# 5. Documentation tools
# ----------------------

pip install ${ARGS} Sphinx
pip install ${ARGS} Cheetah

# 6. Internet
# -----------

pip install ${ARGS} pycurl
pip install ${ARGS} ftputil
pip install ${ARGS} urlgrabber

# 7. Databases
# ------------

pip install ${ARGS} SQLAlchemy
pip install ${ARGS} Alembic
pip install ${ARGS} sqlitebck

if [ "x$ORACLE_HOME" != "x" ]; then
    FORCE_RPATH=yes pip install ${ARGS} --no-binary :all: cx_Oracle
fi

# 8. HDF5, NetCDF4
# ----------------

pip install ${ARGS} h5py
pip install ${ARGS} netCDF4

# 9. Graphics and numerial libraries
# ----------------------------------

pip install ${ARGS} pandas
CPPFLAGS="-I${PREFIX}/include" LDFLAGS="-L${PREFIX}/lib" pip install ${ARGS} pyfftw

pip install ${ARGS} pillow
pip install ${ARGS} matplotlib
pip install ${ARGS} cartopy
pip install ${ARGS} seaborn
pip install ${ARGS} ggplot

GEOS_DIR=`brew --prefix geos` pip install ${ARGS} https://github.com/matplotlib/basemap/archive/v1.1.0.tar.gz


# 8. iPython
# ----------

pip install ${ARGS} --install-option="--zmq=bundled" pyzmq
pip install ${ARGS} tornado
pip install ${ARGS} jsonschema
pip install ${ARGS} ptyprocess
pip install ${ARGS} terminado
pip install ${ARGS} jupyter[all]
