#!/bin/sh
case "${1:-''}" in
'start')
sudo systemctl start httpd
tput bold;
echo ":: Starting Apache Daemon [DONE]"
sudo systemctl start mysqld
tput bold;
echo ":: Starting MySQL Daemon [DONE]"
sudo /usr/bin/memcached -d -m 512 -l 127.0.0.1 -p 11211 -u nobody
tput bold;
echo ":: Starting Memcached Daemon [DONE]"

;;

'stop')
sudo systemctl stop httpd
tput bold;
echo ":: Stopping Apache Daemon [DONE]"
sudo systemctl stop mysqld
tput bold;
echo ":: Stopping MySQL Daemon [DONE]"
sudo killall memcached
tput bold;
echo ":: Stopping Memcached Daemon [DONE]"
;;

'restart')
lamp stop
lamp start
;;
*)
echo "start, stop or restart, please"
;;
esac
