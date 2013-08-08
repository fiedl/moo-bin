#!/usr/bin/sh
## pdq@archlinux
## Part of vb-pdq 0.0.1
## vb is for launching tabbed vimb as vb and/or vbp(roxy)
## vb accepts -u(rl) $URL, -p(roxy), -h(elp), -m(anual)
## 08-04-2013

## edit proxy below if differs
PROXY_URL="http://127.0.0.1:8118"

## no need to edit below
WEBBROWSER=/usr/bin/vimb
MANPAGE=usr/local/share/man/man1/vimb.1
PROXY_CONFIG=$HOME/.config/vimb/config_proxy
THIS_SCRIPT=$(basename $0)

if [ ! -f $WEBBROWSER ]; then
	echo "Missing package: vb-pdq [Package for Arch Linux which includes tabbed-git and vimb-git]"
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
	http_proxy=$PROXY_URL tabbed -c -n proxy $WEBBROWSER -c $PROXY_CONFIG "$URL" -e
else
	tabbed -c -n browser $WEBBROWSER "$URL" -e
fi

exit 0
