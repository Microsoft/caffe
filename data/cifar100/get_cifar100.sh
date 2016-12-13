#!/usr/bin/env sh
# This scripts downloads the CIFAR100 (binary version) data and unzips it.
# After executing this script, and files being extracted, you need to head to 
# examples/cifar100 and then execute create_cifar100 
DIR="$( cd "$(dirname "$0")" ; pwd -P )"
cd $DIR

echo "Downloading..."

wget --no-check-certificate http://www.cs.toronto.edu/~kriz/cifar-100-binary.tar.gz

echo "Unzipping..."

tar -xf cifar-100-binary.tar.gz && rm -f cifar-100-binary.tar.gz

# Creation is split out because leveldb sometimes causes segfault
# and needs to be re-created.

echo "Done."
