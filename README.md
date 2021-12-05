# docker-ubuntu-vnc-xfce 

Create docker container for running xfce in ubuntu on a headless device. 

Unlike other images, the approach implemented here does not pre-configure either VNC or the xfce4 session inside the container
but expects the container to use the user's home directory on the headless machine:

* `$HOME/.vnc` is assumed to exist and to contain a file `passwd` for the password to use for the VNC session and a file `xstartup.sh` that 
  contains commands for how to start up the xfce4 session.
  * there is an example [xstartup.sh](examples/xstartup.sh)  file
* `$HOME/.config/xfce4` is assumed to contain your favourite initial screen setup. If that directory does not exist when the VNC server is
  started for the first time, the XFCE4 default is created.
  * my own preferred initial setup is available as [a ZIP file](examples/xfce4-config.zip)


License: Apache 2.0 

## Usage

* Choose your version: images are available based on different Ubuntu versions and with or without CUDA of some version. The version
  is assumed to be set in variable `$imgversion` below:
  * `20.04-gpu11.3`: Ubuntu version 20.04, CUDA 11.3
  * `20.04-cpu`: Ubuntu version 20.04, no CUDA
  * `21.10-cpu`: Ubuntu version 21.10, no CUDA
* Pull image: `docker pull johannpetrak/ubuntu-vnc-xfce:$imgversion` 
* Create a container: 
  * `docker create --name ${USER}-vnc-$imgversion -it -p 5901:5901  -e USER=$USER -e USERID=$UID -e HOME=/home/$USER -e VNC_RESOLUTION=1280x1024 -v $HOME:/home/$USER johannpetrak/ubuntu-vnc-xfce:$imgversion`
  * for GPU images: `docker create --name ${USER}-vnc-$imgversion --gpus all -it -p 5901:5901  -e USER=$USER -e USERID=$UID -e HOME=/home/$USER -e VNC_RESOLUTION=1280x1024 -v $HOME:/home/$USER johannpetrak/ubuntu-vnc-xfce:$imgversion`
  * To use a different port for connecting to vnc, e.g. 55901, use -o 5901:55901 instead
* Run container to start vnc:
  * `docker start -a -i ${USER}-vnc-$imgversion`
  * Ctrl-C to terminate
* Run bash for debugging: `docker run -it -p 5901:5901  -e USER=$USER -e USERID=$UID -e HOME=/home/$USER -e VNC_RESOLUTION=1280x1024 -v $HOME:/home/$USER --entrypoint /bin/bash johannpetrak/ubuntu-vnc-xfce:$imgversion`

Alternately, simply create your own image by using a modified Dockerfile and adapting the build command from docker-biold.sh to use the correct Dockerfile and tag.

See https://hub.docker.com/repository/docker/johannpetrak/ubuntu-vnc-xfce

NOTES:
* If the screen seems to be locked up, kill the process that is running `light-locker` using `-9`
* To prevent lightlocker to run, start `usr/bin/light-locker-settings` and disable

~~~~

Some of the code for this was adapted from https://github.com/ConSol/docker-headless-vnc-container
