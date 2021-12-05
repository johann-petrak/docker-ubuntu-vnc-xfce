#!/usr/bin/env bash

set -e 

docker build -f Dockerfile -t johannpetrak/ubuntu-vnc-xfce:20.04-cpu .

docker build -f Dockerfile-nvidia -t johannpetrak/ubuntu-vnc-xfce:20.04-gpu11.3 .

docker build -f Dockerfile-21.04 -t johannpetrak/ubuntu-vnc-xfce:21.04-cpu .
