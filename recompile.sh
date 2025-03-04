#!/bin/bash

set -e

# Configure the build.
cd ~/os161/src
./configure --ostree=$HOME/os161/root

# Build userland.
bmake -j 10
bmake install

# Configure a kernel.
cd kern/conf
./config DUMBVM

# Compile and install the kernel
cd ~/os161/src/kern/compile/DUMBVM
bmake depend -j 10
bmake -j 10
bmake install

echo "Kernel + Userland baked fresh ! :)"
