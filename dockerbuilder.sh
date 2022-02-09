#!/bin/bash

docker build -t redlinebuilder .
docker run -v $PWD:/tmp/build -it redlinebuilder
