#!/usr/bin/env bash
set -ex  ## we like things verbose

## ensure we have a full dev stack
sudo yum groupinstall -y "Development Tools"

## install other helpers
sudo yum install -y epel-release

sudo dnf config-manager --set-enabled powertools

sudo yum upgrade -y
sudo yum install -y mock rpmdevtools rpm-devel

## setup our build path
rpmdev-setuptree

## link the specs
ln -sf /tmp/build/SPECS/*.spec $HOME/rpmbuild/SPECS/

## link the sources
find /tmp/build/SOURCES -type f -o -type l -exec ln -sf {} $HOME/rpmbuild/SOURCES/ \;



## download sources
for spec in $HOME/rpmbuild/SPECS/*.spec; do
    spectool -g -R $spec
done

## install build dependencies
sudo yum-builddep -y $HOME/rpmbuild/SPECS/*.spec

## build packages
rpmbuild -ba $HOME/rpmbuild/SPECS/*.spec

## copy built files out of the vagrant/docker environment
## skip if you are doing this manually
if [ -f /.dockerenv ]; then
    sudo mkdir -p /tmp/build/artifacts
    sudo cp -rf $HOME/rpmbuild/RPMS $HOME/rpmbuild/SRPMS /tmp/build/artifacts/
fi
