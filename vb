#!/usr/bin/sh
## pdq@archlinux
## Part of vb-pdq 0.0.1
## This script is for launching vimb as vb and vbp(roxy)
## This script accepts -u(rl) $URL, -p(roxy), -h(elp), -m(anual)
## 08-04-2013

WEBBROWSER=$HOME/abs/vimb/vimb
MANPAGE=$HOME/abs/vimb/compiled/usr/local/share/man/man1/vimb.1
PROXY_CONFIG=$HOME/.config/vimb/config_proxy
THIS_SCRIPT=$(basename $0)

if [ ! -f $WEBBROWSER ]; then
	echo "Missing package: vimb [Vimb is a WebKit-based web browser]"
	exit 1
elif [ ! -f /usr/bin/tabbed ]; then
	echo "Missing package: tabbed [Simple generic tabbed fronted to xembed aware applications]"
	exit 1
fi

while getopts u:phmd option
do
        case "${option}"
        in
                u) URL=${OPTARG};;
                p) PROXY=YES;;
                h) HELP=YES;;
                m) MANUAL=YES;;
				d) DEBUG=YES;;
        esac
done

if [ "$DEBUG" != "" ]; then
	foo=bar
elif [ "$HELP" != "" ]; then
	$WEBBROWSER -h
elif [ "$MANUAL" != "" ]; then
	man $MANPAGE
elif [ "$PROXY" != "" ] || [ "$THIS_SCRIPT" == "vbp" ] ; then
	http_proxy=http://127.0.0.1:8118 tabbed -c -n proxy $WEBBROWSER -c $PROXY_CONFIG "$URL" -e
else
	tabbed -c -n browser $WEBBROWSER "$URL" -e
fi

exit 0
