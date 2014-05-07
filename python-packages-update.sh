#! /usr/bin/env bash

# Updating Python packages
# ========================
#
# C. Marquardt, Darmstadt
#
# 07 May 2014
#
# Notes:
#  - nose is not installed centrally as it needs to be
#    placed into virtual environments, so it's part of
#    the postmkvirtualenv hook
#  - same for iPython
#  - iPython requires (for its notebook functionality)
#    pyzmq and tornado which can be installed centrally,
#    so I made them part of this general update script.

# 1. Shell variables
# ------------------

EGENIX_URL=https://downloads.egenix.com/python/index/ucs2

# 2. Update pip and setuptools
# ----------------------------

pip install --upgrade pip
pip install --upgrade setuptools

# 3. Development tools
# --------------------

pip install --upgrade six
pip install --upgrade stevedore
pip install --upgrade virtualenv
pip install --upgrade virtualenv-clone
pip install --upgrade virtualenvwrapper

pip install --upgrade cython
pip install --upgrade Zconfig

pip install --upgrade -i $EGENIX_URL egenix-mx-base

# 4. Documentation tools
# ----------------------

pip install --upgrade Sphinx
pip install --upgrade Cheetah

# 5. Internet
# -----------

pip install --upgrade pycurl
pip install --upgrade ftputil
pip install --upgrade urlgrabber

# 6. Databases
# ------------

pip install --upgrade SQLAlchemy
pip install --upgrade Alembic
pip install --upgrade sqlitebck

# 7. Support for iPython
# ----------------------

pip install --upgrade --install-option="--zmq=bundled" pyzmq
pip install --upgrade tornado

# 8. NetCDF4
# ----------

export USE_NCCONFIG=1
pip install --upgrade netCDF4
unset USE_NCCONFIG
