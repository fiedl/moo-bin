#!/usr/bin/bash
## Autostart Script - ran after startx
## Author pdq 11-27-2012 - 04-18-2013 07-30-2013
if [ $(id -u) -eq 0 ]; then
	echo "run this script as user..."
	exit 0
fi

## run moo from command line or Everything Launcher/dmenu/etc

## Path to video directory queue
#VID_QUEUE="/home/$USER/Videos/24 Complete Series DVDRip XviD/Season.06"
#VID_QUEUE="/home/$USER/Videos/tempvideo"
#VID_QUEUE="/home/$USER/Videos/movies"
#VID_QUEUE="/home/$USER/Videos/Star Trek TNG"
VID_QUEUE="/home/$USER/Videos/Star Trek Voyager"
#VID_QUEUE="/home/$USER/Videos/Sliders"

#TERM_USED=terminology
TERM_USED=urxvtc

WEATHER_CODE=$(cat /home/$USER/.weather_key)

## LAN addresses
MOUNT_LAN1_FILESYSTEM=1 ## 1/0 (On/Off) 
LAN1='192.168.0.10'
PORT1=34567
USER1='pdq'
PATH_TO_DATA=/mnt/linux-$USER1

## Private data (Encrypted data)
PRIV_ENABLED=1 ## 1/0 (On/Off) 

## 
if [ "${TERM_USED}" == "urxvtc" ]; then
	## Ensure rxvt-unicode daemon is running
	[ -z "$(pidof urxvtd)" ] && urxvtd -q -o -f
	NAME='-name '
	TITLE='-title '
	BG1=''
	BG2=''
	BG3=''
	BG4=''
	BG5=''
	BG6=''
	BG7=''
	BG8=''
	BG9=''
	BG10=''
	BG11=''
	BG12=''
	BG13=''
	BG14=''
	BG15=''
else
	NAME='--name='
	TITLE='--title='
	BG1=" --background=/usr/share/backgrounds/wallpaper46.jpg "
	BG2=" --background=/home/$USER/Pictures/wallpaper/1085710-comic_characters_comics.jpg "
	BG3=" --background=/home/$USER/Pictures/wallpaper/V-for-Vendetta-v-for-vendetta-13512847-1440-900.jpg "
	BG4=" --background=/home/$USER/Pictures/wallpaper/1088274-pokemon.png "
	BG5=" --background=/home/$USER/Pictures/wallpaper/Archlinux_on_the_wall_by_Zildj4n.jpg "
	BG6=" --background=/usr/share/backgrounds/wallpaper43.jpg "
	BG7=" --background=/home/$USER/Pictures/wallpaper/1086093-wallpaper-2527221.jpg "
	BG8=" --background=/home/$USER/Pictures/wallpaper/1088466-samus_aran_metroid.png "
	BG9=" --background=/usr/share/backgrounds/wallpaper31.png "
	BG10=" --background=/home/$USER/Pictures/wallpaper/1081952-v_v_for_vendetta.png "
	BG11=" --background=/home/$USER/Pictures/wallpaper/example-02.png "
	BG12=" --background=/home/$USER/Pictures/wallpaper/1084835-SniperRifle.jpg "
	BG13=" --background=/usr/share/backgrounds/wallpaper28.png "
	BG14=" --background=/usr/share/backgrounds/wallpaper26.png "
	BG15=" --background=/usr/share/backgrounds/wallpaper11.png "
	# BG16=" --background=/home/$USER/Pictures/wallpaper/"
fi

## Screencast start (edit for your specific needs/hardware configuration)
#${TERM_USED} $NAME"Screencaster" $TITLE""Screencaster -e ffmpeg -f alsa -ac 2 -i pulse -f x11grab -r 30 -s 1920x1080 -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 startx.mkv

## Start drop down urxvtc terminal console
#[ -z "$(pidof yeahconsole)" ] && yeahconsole &

## Start system information display
#[ -z "$(pidof conky)" ] && conky -d -c "$HOME"/.config/conky/.conkye17 &

## path to your LAN secure shell file system mount
if [ $MOUNT_LAN1_FILESYSTEM -eq 1 ]; then
	## Remote applications, ssh keys read by keychain from ~/.zprofile

	## Main term
	${TERM_USED}${BG1} $NAME"ssh $LAN1" $TITLE"ssh $LAN1" -e ssh $LAN1 -p$PORT1

	## Start SSH top (terminal task manager)
	#${TERM_USED}${BG2} $NAME"htop $LAN1" $TITLE"htop $LAN1" -e ssh -t $LAN1 -p$PORT1 htop

	## Start SSH journalctl (systemlog)
	#${TERM_USED}${BG2} $NAME"Log $LAN1" $TITLE"Log $LAN1" -e ssh -t $LAN1 -p$PORT1 sudo journalctl -f

	## Mount server filesystem to localhost
	#if [ ! -d "$PATH_TO_DATA/home" ] ; then
		[ ! -d "$PATH_TO_DATA/home" ] && sshfs $USER1@$LAN1:/ $PATH_TO_DATA -C -p $PORT1
	#fi
fi

## Default applications to start with moo
cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(1 "Terminals local" on    # any option can be set to default to "on"
	 2 "Terminals remote" off
	 3 "System info" on
	 4 "System logs" on
	 5 "Extra logs" off
	 6 "Text editors" on
	 7 "IRC" on
	 8 "Web Browsers" off
	 9 "Steam" on
	 10 "RSS reader" off
	 11 "Video players" on
	 12 "Sillyness" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
	case $choice in
		1)
			${TERM_USED}${BG3} $NAME"Term" $TITLE"Term"
			${TERM_USED}${BG7} $NAME"tERM" $TITLE"tERM"
			## Start root term
			${TERM_USED}${BG5} $NAME"Sysadmin" $TITLE"Sysadmin" -e sudo su
			## Start top (terminal task manager)
			#[ -z "$(pidof htop)" ] && ${TERM_USED} $NAME"HTOP" $TITLE"HTOP" -e htop
		;;
		2)
			echo "Second Option"
		;;
		3)
			[ -z "$(pidof cpu_freq)" ] && ${TERM_USED}${BG1} $NAME"CPU Freq" $TITLE"CPU Freq" -e cpu_freq
			## Start GPU monitor
			[ -z "$(pidof nvidia-smi)" ] && ${TERM_USED}${BG14} $NAME"GPU" $TITLE"GPU" -e nvidia-smi -l 5 -q -d "MEMORY,TEMPERATURE"
			## Start CPU temperature monitor
			[ -z "$(pidof cpus_temp)" ] && ${TERM_USED}${BG13} $NAME"CPUS" $TITLE"CPUS" -e cpus_temp
			## Start glances
			#[ -z "$(pidof glances)" ] && ${TERM_USED}${BG12} $NAME"Glances" $TITLE"Glances" -e glances -e
			## Start weather monitor
			#[ -z "$(pidof ctw)" ] && ${TERM_USED}${BG10} $NAME"Weather" $TITLE"Weather" -e ctw $WEATHER_CODE
			## Start clock
			#[ -z "$(pidof tty-clock)" ] && ${TERM_USED} $NAME"Clock" $TITLE"Clock" -e tty-clock -tc
		;;
		4)	
			if [ -d "$PATH_TO_DATA/home" ] || [ $PRIV_ENABLED -eq 0 ]; then
				${TERM_USED}${BG5} $NAME"Logs" $TITLE"Logs" -e sudo journalctl -f
			fi
		;;
		5)	if [ -d "$PATH_TO_DATA/home" ] || [ $PRIV_ENABLED -eq 0 ]; then
				[ -d "$PATH_TO_DATA/media/truecrypt1/private/transmission-daemon" ] && [ -z "$(pidof multitail)" ] && ${TERM_USED}${BG11} $NAME"More Logs" $TITLE"More Logs" -e more_logs
			fi
		;;
		6)
			subl3 &
			#sudo subl3
		;;
		7)	if [ -d "$PATH_TO_DATA/home" ] || [ $PRIV_ENABLED -eq 0 ]; then
				## Start IM server and IRC client
				#[ -z "$(pidof bitlbee)" ] && ${TERM_USED} $NAME"bitlbee" -e sudo bitlbee -D
				[ -z "$(pidof weechat)" ] && ${TERM_USED}${BG4} $NAME"IRC1" $TITLE"IRC1" -e weechat && ${TERM_USED}${BG8} $NAME"IRC2" $TITLE"IRC2" -e weechat -d ~/.weechat-priv
			fi
		;;
		8)	if [ -d "$PATH_TO_DATA/home" ] || [ $PRIV_ENABLED -eq 0 ]; then
				if [ -z "$(pidof firefox)" ]; then
					firefox --profilemanager &
					firefox -P tubefox -no-remote &
				fi
				#if [ -z "$(pidof vimb)" ]; then
				#	vb -u "https://wiki.archlinux.org/index.php/User:Pdq" &
				#	vbp -u "https://www.linuxdistrocommunity.com/forums/index.php" &
				#fi
			fi
		;;
		9)
			if [ -d "$PATH_TO_DATA/home" ] || [ $PRIV_ENABLED -eq 0 ]; then
				SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 steam --console &
			fi
		;;
		10)
			export http_proxy=http://127.0.0.1:8118
			[ -z "$(pidof canto-curses)" ] && ${TERM_USED}${BG15} $NAME"RSS" $TITLE"RSS" -e canto-curses
			export http_proxy=
		;;
		11)	
			if [ -d "$PATH_TO_DATA/home" ] || [ $PRIV_ENABLED -eq 0 ]; then
				if [ -d "$VID_QUEUE" ] ; then
					[ -z "$(pidof vlc)" ] && vlc "$VID_QUEUE" &
				fi
			fi
		;;
		12)	
			[ -z "$(pidof cmatrix)" ] && ${TERM_USED} $NAME"Shall we play a game" $TITLE"Shall we play a game" -e cmatrix -C cyan
			#mplayer ~/nude.mp4 -noconsolecontrols -loop 0 &
		;;
	esac
done

## Daemons examples

## redshift screen brightness softening
## Usage: xflux [-z zipcode | -l latitude] [-g longitude] [-k colortemp (default 3400)] [-nofork]
## protip: Say where you are (use -z or -l).
#[ -z "$(pidof xflux)" ] && xflux -z 37213 -k 3800

exit 0
