FROM ubuntu:20.04

MAINTAINER Johann Petrak "johann.petrak@gmail.com"

ENV TERM=xterm \
  EDITOR=vi \
  DISPLAY=:1 \
  DESKTOP_SESSION=xfce \  
  VNC_PORT=5901 \
  VNC_COL_DEPTH=24 \
  VNC_RESOLUTION=1280x1024 \
  VNC_PW=vncpassword \
  VNC_VIEW_ONLY=false

EXPOSE $VNC_PORT

RUN mkdir /logs
RUN chmod 777 /logs
RUN mkdir /install
  
ADD ./src/install.sh /install/
ADD ./src/startup.sh /install/
ADD ./src/execute.sh /install/
ADD ./src/sudoers.new /etc
RUN chmod a+x /install/install.sh
RUN chmod a+x /install/startup.sh
RUN chmod a+x /install/execute.sh

# Run the installation script
RUN /install/install.sh

# ENV LANG='en_GB.UTF-8' LANGUAGE='en_GB:en' LC_ALL='en_GB:en'

ENTRYPOINT ["/install/startup.sh"]
CMD ["--wait"]

