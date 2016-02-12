#! /bin/sh

### BEGIN INIT INFO
# Provides: vpn_switcher
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs $network
# Default-Start:     5
# Default-Stop:      5
# Short-Description: VPN switcher service
# Description: This script will enable starting and stopping of
#               OpenVPN tunnels  
### END INIT INFO

# /etc/init.d/vpn_switcher-server

PIDFILE="/var/run/vpn_switcher-server.pid"

if [ ! -f "$PIDFILE" ]; then
        touch $PIDFILE
fi

case "$1" in
start)
echo "Starting VPN Switcher Server... "
#killall vpn_switcher
start-stop-daemon --start --quiet --background \
        --pidfile $PIDFILE --make-pidfile \
        --chdir /srv/vpn_switcher-server/src \
        --exec /usr/local/bin/node server.js
echo $PIDFILE
#/usr/bin/vpn_switcher > /dev/null &
;;
stop)
echo "Killing VPN Switcher Server ..."
start-stop-daemon --stop --pidfile $PIDFILE
echo $PIDFILE
#killall vpn_switcher
;;
*)
echo "Usage: /etc/init.d/vpn_switcher-server {start|stop}"
exit 1
;;
esac
exit 0
