#!/bin/bash
set -e

# options: -w/--wait, -s/--skip cmd, cmd


# we expect $HOME and $USER to be set as environment variables when running the container and we 
# expect $HOME to be mounted into the container

if [[ x"$HOME" == x ]]
then
  echo Environment variable HOME not set
  exit 1
fi

if [[ x"$USER" == x ]]
then
  echo Environment variable USER not set
  exit 1
fi

if [[ x"$USERID" == x ]]
then
  echo Environment variable USERID not set
  exit 1
fi

if [[ ! -d "$HOME" ]]
then
  echo $HOME not a mounted directory
  exit 1
fi

if [[ ! -x "$HOME/.vnc/xstartup.sh" ]]
then
  echo $HOME/.vnc/xstartup.sh must exist and be executable
  exit 1
fi

echo Config checks OK


# add the user we want, if not already there
if [[ ! -f /install/haveuser ]]
then
    echo adding user $USER
    touch /install/haveuser
    mv /etc/sudoers.new /etc/sudoers
    chown root /etc/sudoers
    chgrp root /etc/sudoers
    chmod o-rwx /etc/sudoers
    chmod g-wx /etc/sudoers
    chmod u-wx /etc/sudoers

    adduser --disabled-password --gecos NA --uid $USERID $USER
    usermod -aG sudo $USER
else
    echo user $USER already added
fi

echo Switching to user $USER

su $USER - -c /install/execute.sh -- "$@"

