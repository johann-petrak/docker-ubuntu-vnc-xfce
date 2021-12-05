#!/bin/sh

set -e

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
dbus-launch startxfce4 --replace &
xfce4-terminal &

vncconfig -iconic -nowin &
~                                                                               

