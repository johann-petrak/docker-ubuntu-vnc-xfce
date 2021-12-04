# vnc-ubuntu

Create docker container for running xfce in ubuntu on a headless device.

Adapted from https://github.com/ConSol/docker-headless-vnc-container

License: Apache 2.0 

## Usage


* First create a container: 
  * `docker create --name ${USER}-vnc -it -p 5901:5901  -e USER=$USER -e HOME=/home/$USER -e VNC_RESOLUTION=1280x1024 -v $HOME:/home/$USER johannpetrak/ubuntu-vnc-xfce:latest`
* Run container to start vnc:
  * `docker start -a -i ${USER}-vnc`
  * Ctrl-C to terminate
* Run bash for debugging: `docker run -it -p 5901:5901  -e USER=$USER -e HOME=/home/$USER -e VNC_RESOLUTION=1280x1024 -v $HOME:/home/$USER --entrypoint /bin/bash johannpetrak/ubuntu-vnc-xfce:latest`
