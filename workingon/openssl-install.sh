#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update package list and install build dependencies
apt update
apt install -y build-essential checkinstall zlib1g-dev

# Change to the /usr/local/src directory
cd /usr/local/src

# Download OpenSSL 3.1.6 source
wget https://www.openssl.org/source/openssl-3.1.6.tar.gz

# Extract the tarball
tar -xzf openssl-3.1.6.tar.gz

# Change to the OpenSSL source directory
cd openssl-3.1.6

# Configure the build
./config

# Compile the source
make

# Install the compiled binaries
make install

# Update the shared library cache
ldconfig

# Verify the installation
openssl version -a

echo "OpenSSL 3.1.6 installation is complete."
