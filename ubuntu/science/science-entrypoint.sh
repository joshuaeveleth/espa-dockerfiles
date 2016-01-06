#!/bin/bash
set -e

# THE_USER is defined in the Dockerfile

THE_GID=$1
shift # past the argument
THE_UID=$1
shift # past the argument

# Add the user and group to the system
groupadd --gid $THE_GID $THE_USER
useradd -r --gid $THE_GID --uid $THE_UID --system --create-home $THE_USER

# Add the espa runtime installation directory to the path
export PATH=$PREFIX/bin:$PATH

# Corectly set these environment variables for the user
export USER=$THE_USER
export HOME=/home/$THE_USER

# Activate the python virtual environment
. /python-virtual/bin/activate

# Change to the working/data directory where any operation will be performed
cd /espa/data

# Now execute as the user
exec gosu $THE_USER $@
#exec gosu $THE_USER /bin/bash $@
#exec gosu root /bin/bash
#/bin/bash
