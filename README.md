# ![tachometer](https://cdn.emojidex.com/emoji/seal/tachometer.png "tachometer") Readline is a simple framework for building RPMs under Docker and/or Vagrant.

Place your RPM spec files in the `SPECS` directory and all local sources (sources that can't be downloaded via spectool) in the `SOURCES` directory.  Then just build as described below.

# Building

The RPMs may be built with [Docker](#with-docker), [Vagrant](#with-vagrant), or [manual](#manual).  The default [`Vagrantfile`](Vagrantfile) and [`Dockerfile`](Dockerfile) in the project use the lastest CentOS 7 image.  Change this if needed for your build requirements.  The actual build logic is contained in the [`build.sh`](build.sh) script which should also be modified if needed for your particular use case.

## With Docker

```bash
docker build -t redline .                                 ## build the image
docker run -v $PWD/artifacts:/tmp/artifacts -it redline   ## run the image and build the RPMs
```

## With Vagrant

```bash
vagrant up        ## provision and build the RPMs
```

## Manual

```bash
cat build.sh      ## read the script
```

## Result

Your RPMs and SRPMs will be copied to the `artifacts` folder.  Congratulations.  You just built RPMs in a controlled environment in an easily reproducible manner.
