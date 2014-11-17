#!/usr/bin/bash
## Autostart Script - ran after startx
## Author pdq 11-27-2012 - 04-18-2013 07-30-2013
## run moo from command line in terminal (urxvt)

## Start config

## Path to video directory queue
#VID_QUEUE="$HOME/Videos/24 Complete Series DVDRip XviD/Season.06"
#VID_QUEUE="$HOME/Videos/tempvideo"
VID_QUEUE="$HOME/Videos/movies"
#VID_QUEUE="$HOME/Videos/Star Trek TNG"
#VID_QUEUE="$HOME/Videos/Star Trek Voyager"
#VID_QUEUE="$HOME/Videos/Sliders"

#TERM_USED=terminology
TERM_USED=urxvtc

# Weather code
WEATHER_CODE=$(cat $HOME/.weather_key)

## LAN addresses
MOUNT_LAN1_FILESYSTEM=0 ## 1/0 (On/Off)
LAN1='192.168.0.10'
PORT1=34567
USER1='pdq'
PATH_TO_DATA=/mnt/linux-$USER1

## Mount encrypted drives
mounts="bc1 bc3"

## End config

## Start code
if [ $(id -u) -eq 0 ]; then
	echo "run this script as user..."
	exit 0
fi

## functions
ask_something() {
	echo -ne $question
	while read -r -n 1 -s yn; do
		if [[ $yn = [YyNn] ]]; then
			[[ $yn = [Yy] ]] && return=0
			[[ $yn = [Nn] ]] && return=1
			break
		fi
	done
	return $return
}

## Auth sshkey
echo "SSHkey Authorize:"
mplayer "${HOME}/.config/awesome/sounds/voice-please-confirm.ogg"
val $(keychain --eval --agents ssh -Q --quiet id_rsa)

## Define terminal titles, names and backgrounds
if [ "${TERM_USED}" == "urxvtc" ]; then
	## Ensure rxvt-unicode daemon is running
	[ -z "$(pidof urxvtd)" ] && urxvtd -q -o -f
	NAME='-name '
	TITLE='-title '
	BG1=BG2=BG3=BG4=BG5=BG6=BG7=BG8=BG9=BG10=BG11=BG12=BG13=BG14=BG15=''
else
	# assumes you're using terminology
	NAME='--name='
	TITLE='--title='
	BG1=" --background=/usr/share/backgrounds/wallpaper46.jpg "
	BG2=" --background=$HOME/Pictures/wallpaper/1085710-comic_characters_comics.jpg "
	BG3=" --background=$HOME/Pictures/wallpaper/V-for-Vendetta-v-for-vendetta-13512847-1440-900.jpg "
	BG4=" --background=$HOME/Pictures/wallpaper/1088274-pokemon.png "
	BG5=" --background=$HOME/Pictures/wallpaper/Archlinux_on_the_wall_by_Zildj4n.jpg "
	BG6=" --background=/usr/share/backgrounds/wallpaper43.jpg "
	BG7=" --background=$HOME/Pictures/wallpaper/1086093-wallpaper-2527221.jpg "
	BG8=" --background=$HOME/Pictures/wallpaper/1088466-samus_aran_metroid.png "
	BG9=" --background=/usr/share/backgrounds/wallpaper31.png "
	BG10=" --background=$HOME/Pictures/wallpaper/1081952-v_v_for_vendetta.png "
	BG11=" --background=$HOME/Pictures/wallpaper/example-02.png "
	BG12=" --background=$HOME/Pictures/wallpaper/1084835-SniperRifle.jpg "
	BG13=" --background=/usr/share/backgrounds/wallpaper28.png "
	BG14=" --background=/usr/share/backgrounds/wallpaper26.png "
	BG15=" --background=/usr/share/backgrounds/wallpaper11.png "
fi

## Mount encrypted drives
for mount in $mounts
do
	while true
	do
		if [ ! sudo $mount test ] ; then
			echo "Mount $mount:"
			mplayer "${HOME}/.config/awesome/sounds/voice-piy.ogg"
			sudo $mount open
		else
			echo "Mounted $mount"
			break
		fi
	done
done

## Start devilspie2 for client window rules
[ -z "$(pidof devilspie2)" ] && devilspie2 &

## Start xbindkeys for keyboard shortcuts for dmenu, dmenu_mocp, etc
#[ -z "$(pidof xbindkeys)" ] && xbindkeys &

## Start drop down urxvtc terminal console
#[ -z "$(pidof yeahconsole)" ] && yeahconsole &

## Start system information display
#[ -z "$(pidof conky)" ] && conky -d -c "$HOME"/.config/conky/.conkye17 &

## path to your LAN secure shell file system mount
if [ $MOUNT_LAN1_FILESYSTEM -eq 1 ]; then
	## Main remote terminal
	${TERM_USED}${BG1} $NAME"ssh $LAN1" $TITLE"ssh $LAN1" -e ssh $LAN1 -p$PORT1

	## Start SSH top (terminal task manager)
	#${TERM_USED}${BG2} $NAME"htop $LAN1" $TITLE"htop $LAN1" -e ssh -t $LAN1 -p$PORT1 htop

	## Start SSH journalctl (systemlog)
	#${TERM_USED}${BG2} $NAME"Log $LAN1" $TITLE"Log $LAN1" -e ssh -t $LAN1 -p$PORT1 sudo journalctl -f

	## Mount server filesystem to localhost
	if [ ! -d "$PATH_TO_DATA/home" ] ; then
		sshfs $USER1@$LAN1:/ $PATH_TO_DATA -C -p $PORT1
	fi
fi

## Start terminals
${TERM_USED}${BG3} $NAME"Term" $TITLE"Term"
${TERM_USED}${BG7} $NAME"tERM" $TITLE"tERM"

## Start root term
${TERM_USED}${BG5} $NAME"Sysadmin" $TITLE"Sysadmin" -e sudo su

## Start top (terminal task manager)
[ -z "$(pidof htop)" ] && ${TERM_USED} $NAME"HTOP" $TITLE"HTOP" -e htop

## Start CPU frequency monitor
[ -z "$(pidof cpu_freq)" ] && ${TERM_USED}${BG1} $NAME"CPU Freq" $TITLE"CPU Freq" -e firejail cpu_freq

## Start GPU monitor
[ -z "$(pidof nvidia-smi)" ] && ${TERM_USED}${BG14} $NAME"GPU" $TITLE"GPU" -e firejail nvidia-smi -l 5 -q -d "MEMORY,TEMPERATURE"

## Start CPU temperature monitor
[ -z "$(pidof cpus_temp)" ] && ${TERM_USED}${BG13} $NAME"CPUS" $TITLE"CPUS" -e firejail cpus_temp

## Start clock
#[ -z "$(pidof tty-clock)" ] && ${TERM_USED} $NAME"Clock" $TITLE"Clock" -e firejail tty-clock -tc

## Start System log
${TERM_USED}${BG5} $NAME"Logs" $TITLE"Logs" -e sudo journalctl -f

## Start IRC clients
if [ -d "$HOME/.weechat/logs" ]; then
	## Start IM server and IRC client
	#[ -z "$(pidof bitlbee)" ] && ${TERM_USED} $NAME"bitlbee" -e sudo bitlbee -D
	[ -z "$(pidof weechat)" ] && ${TERM_USED}${BG4} $NAME"IRC1" $TITLE"IRC1" -e firejail weechat && ${TERM_USED}${BG8} $NAME"IRC2" $TITLE"IRC2" -e firejail weechat -d ~/.weechat-priv
fi

## Start RSS feed reader and daemon, using proxy
export http_proxy=http://127.0.0.1:8118
[ -z "$(pidof canto-curses)" ] && ${TERM_USED}${BG15} $NAME"RSS" $TITLE"RSS" -e firejail canto-curses
export http_proxy=

## Start email client (start delay of 5 seconds to give proxy time to start)
#[ -z "$(pidof claws-mail)" ] && sleep 5s && usewithtor claws-mail &
#[ -z "$(pidof mutt)" ] && sleep 5s && ${TERM_USED} $NAME"Mail" $TITLE"Mail" -e torsocks mutt

## Start web browsers
question="Start web browsers (Y/N)?\n"
if ask_something; then
	## Start firefox profiles
	if [ -d "$HOME/.mozilla/firefox" ]; then
		if [ -z "$(pidof firefox)" ]; then
			#firejail firefox --profilemanager &
			#firejail firefox -P tubefox -no-remote &
			firejail firefox -P noproxyfox -no-remote &
		fi
	fi

	## Start tor-browser-en
	if [ -d "$HOME/.tor-browser-en/INSTALL" ]; then
			firejail tor-browser-en &
		fi
	fi
fi

## Start steam
question="Start steam (Y/N)?\n"
if ask_something; then
	if [ -d "/media/Storage/games" ]; then
		SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 [ -z "$(pidof steam)" ] && steam --console &
	fi
fi

## Start vlc playlist
if [ -d "$HOME/Videos/tempvideo" ]; then
	if [ -d "$VID_QUEUE" ] ; then
		[ -z "$(pidof vlc)" ] && firejail vlc "$VID_QUEUE" &
	fi
fi

## Loaded desktop conformation sounds
mplayer "${HOME}/.config/awesome/sounds/voice-accepted.ogg"

## Reload and refresh client windows
kill $(pidof devilspie2)
devilspie2 &

## Daemons examples
## redshift screen brightness softening
## Usage: xflux [-z zipcode | -l latitude] [-g longitude] [-k colortemp (default 3400)] [-nofork]
## protip: Say where you are (use -z or -l).
#[ -z "$(pidof xflux)" ] && xflux -z 37213 -k 3800

exit 0
