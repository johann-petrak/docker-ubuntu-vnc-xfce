#!/bin/bash
set -e

echo Executing execute.sh

if [[ $1 =~ -s|--skip ]]; then
    echo -e "\n\n------------------ SKIP VNC STARTUP -----------------"
    echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
    echo "Executing command: '${@:2}'"
    exec "${@:2}"
fi


cleanup () {
    kill -s SIGTERM $!
    exit 0
}
trap cleanup SIGINT SIGTERM

echo killing any existing VNC server
vncserver -kill &> /dev/null || true
rm -rf /tmp/.X* || true

VNC_IP=$(hostname -i)

export XAUTHORITY=$HOME/vnc-Xauthority

echo starting new VNC server 
tigervncserver $DISPLAY -localhost no -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -xstartup $HOME/.vnc/xstartup.sh &> /logs/vncserver_startup.log
echo VNC server started

if [ -z "$1" ] || [[ $1 =~ -w|--wait ]]; then
    echo waiting forever
    tail -f /dev/null
else
    # unknown option ==> call command
    echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
    echo "Executing command: '$@'"
    exec "$@"
fi
