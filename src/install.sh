#!/usr/bin/env bash
set -e

apt-get update
ln -snf /usr/share/zoneinfo/Europe/London /etc/localtime 
# && echo $CONTAINER_TIMEZONE > /etc/timezone
# NOTE: indicator-applet-complete not available under 21.10 any more
DEBIAN_FRONTEND=noninteractive apt-get install -y vim wget curl net-tools bzip2 locales  tigervnc-standalone-server firefox  xfce4 xfce4-terminal xterm less synaptic htop git subversion indicator-applet  xfce4-indicator-plugin 
apt-get update 
apt-get install sudo
apt-get purge -y pm-utils xscreensaver*
apt-get clean -y

locale-gen en_GB.UTF-8


