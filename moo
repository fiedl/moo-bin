#!/usr/bin/sh
## Autostart Script - ran after startx
## Author pdq 11-27-2012 - 04-18-2013 07-30-2013

## run moo from command line or Everything Launcher/dmenu/etc

## Path to video directory queue
#VID_QUEUE="/home/$USER/Videos/24 Complete Series DVDRip XviD"
#VID_QUEUE="/home/$USER/Videos/tempvideo"
#VID_QUEUE="/home/$USER/Videos/movies"
#VID_QUEUE="/home/$USER/Videos/Star Trek TNG"
VID_QUEUE="/home/$USER/Videos/Sliders"

TERM_USED=terminology
#TERM_USED=urxvtc

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
else
	NAME='--name='
	TITLE='--title='
	BG1=" --background=/home/$USER/Pictures/wallpaper/star_wars_ds.jpg "
	BG2=" --background=/home/$USER/Pictures/wallpaper/1085710-comic_characters_comics.jpg "
	BG3=" --background=/home/$USER/Pictures/wallpaper/V-for-Vendetta-v-for-vendetta-13512847-1440-900.jpg "
	BG4=" --background=/home/$USER/Pictures/wallpaper/o1089025.jpg "
	BG5=" --background=/home/$USER/Pictures/wallpaper/Archlinux_on_the_wall_by_Zildj4n.jpg "
	BG6=" --background=/home/$USER/Pictures/wallpaper/1085640-TF2SpyWallpaper.jpg "
	BG7=" --background=/home/$USER/Pictures/wallpaper/1086093-wallpaper-2527221.jpg "
	BG8=" --background=/home/$USER/Pictures/wallpaper/1088466-samus_aran_metroid.png "
	BG9=" --background=/home/$USER/Pictures/wallpaper/1085878-majoras_mask_legend_of_zelda.jpg "
	BG10=" --background=/home/$USER/Pictures/wallpaper/1084835-Sniper Rifle.jpg "
	BG11=" --background=/home/$USER/Pictures/wallpaper/example-02.png "
	# BG12="--background=/home/$USER/Pictures/wallpaper/"
	# BG13="--background=/home/$USER/Pictures/wallpaper/"
	# BG14="--background=/home/$USER/Pictures/wallpaper/"
	# BG15="--background=/home/$USER/Pictures/wallpaper/"
	# BG16="--background=/home/$USER/Pictures/wallpaper/"
fi

## Screencast start (edit for your specific needs/hardware configuration)
#${TERM_USED} $NAME"Screencaster" $TITLE""Screencaster -e ffmpeg -f alsa -ac 2 -i pulse -f x11grab -r 30 -s 1920x1080 -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 startx.mkv

## Start drop down urxvtc terminal console
[ -z "$(pidof yeahconsole)" ] && yeahconsole &

## Start system information display
#[ -z "$(pidof conky)" ] && conky -d -c "$HOME"/.config/conky/.conkye17 &

## path to your LAN secure shell file system mount
if [ $MOUNT_LAN1_FILESYSTEM -eq 1 ]; then
	## Remote applications, ssh keys read by keychain from ~/.zprofile

	## Main term
	${TERM_USED}${BG1} $NAME"ssh $LAN1" $TITLE"ssh $LAN1" -e ssh $LAN1 -p$PORT1

	## Start SSH top (terminal task manager)
	${TERM_USED}${BG2} $NAME"htop $LAN1" $TITLE"htop $LAN1" -e ssh -t $LAN1 -p$PORT1 htop

	## Mount server filesystem to localhost
	if [ ! -d "$PATH_TO_DATA/home" ] ; then
		sshfs $USER1@$LAN1:/ $PATH_TO_DATA -C -p $PORT1
	fi
fi

## Default applications to start with moo

## Daemons

## redshift screen brightness softening
## Usage: xflux [-z zipcode | -l latitude] [-g longitude] [-k colortemp (default 3400)] [-nofork]
## protip: Say where you are (use -z or -l).
#[ -z "$(pidof xflux)" ] && xflux -z 37213 -k 3800

## Start dmenu clipboard (dmenuclip/dmenurl)
#killall -q clipbored
#clipbored

## Terminal applications

## Main terms
${TERM_USED}${BG3} $NAME"Term" $TITLE"Term"
${TERM_USED}${BG7} $NAME"tERM" $TITLE"tERM"

## Start system logs
${TERM_USED}${BG5} $NAME"Logs" $TITLE"Logs" -e sudo journalctl -f

## Start top (terminal task manager)
#[ -z "$(pidof htop)" ] && ${TERM_USED} $NAME"HTOP" $TITLE"HTOP" -e htop

## Start CPU frequency monitor
#[ -z "$(pidof watch)" ] && ${TERM_USED} $NAME"CPU Freq" $TITLE"CPU Freq" -e watch grep \"cpu MHz\" /proc/cpuinfo

## Start GPU monitor
[ -z "$(pidof nvidia-smi)" ] && ${TERM_USED} $NAME"GPU" $TITLE"GPU" -e nvidia-smi -l 5 -q -d "MEMORY,TEMPERATURE"

## Start RSS reader
[ -z "$(pidof canto-curses)" ] && ${TERM_USED} $NAME"RSS" $TITLE"RSS" -e canto-curses

## Start weather monitor
#[ -z "$(pidof ctw)" ] && ${TERM_USED} $NAME"Weather" $TITLE"Weather" -e ctw CAXX0548

## Start clock
#[ -z "$(pidof tty-clock)" ] && ${TERM_USED} $NAME"Clock" $TITLE"Clock" -e tty-clock -tc

## Start CPU temperature monitor
[ -z "$(pidof cpus_temp)" ] && ${TERM_USED} $NAME"CPUS" $TITLE"CPUS" -e cpus_temp

## Start torrent client
#[ -z "$(pidof transmission-remote-cli)" ] && ${TERM_USED} $NAME"Transmission" $TITLE"Transmission" -e transmission-remote-cli -c 192.168.0.10:9091 

## Start system monitor
[ -z "$(pidof gkrellm)" ] && gkrellm &

## Start Internet radio player
#[ -z "$(pidof pyradio)" ] && ${TERM_USED} $NAME"Radio" $TITLE"Radio" -e pyradio 

## Start dolphin
#[ -z "$(pidof dolphin)" ] && dolphin &

## Start steam
#[ -z "$(pidof steam)" ] && steam &

## Start youtube viewer
[ -z "$(pidof youtube-viewer)" ] && ${TERM_USED}${BG6} $NAME"youtube" $TITLE"youtube" -e youtube-viewer --prefer-https --prefer-webm --use-colors --quiet -7 -S -C --mplayer="/usr/bin/vlc" --mplayer-args="-q"

## Start Arch Linux update notifier
[ -z "$(pidof aarchup)" ] && /usr/bin/aarchup --loop-time 60 --aur --icon "$HOME/.icons/pacman_icon_48x48.png" &

## Start sillyness
#[ -z "$(pidof cmatrix)" ] && ${TERM_USED} $NAME"Shall we play a game" $TITLE"Shall we play a game" -e cmatrix -C cyan
#mplayer ~/nude.mp4 -noconsolecontrols -loop 0 &

## Default startup applications (If private data is mounted or there is no private data to be mounted)
if [ -d "$PATH_TO_DATA/home" ] || [ $PRIV_ENABLED -eq 0 ]; then

	## Daemons

	## Start IM server and IRC client
	[ -z "$(pidof bitlbee)" ] && ${TERM_USED} $NAME"bitlbee" -e sudo bitlbee -D
	[ -z "$(pidof weechat-curses)" ] && ${TERM_USED}${BG4} $NAME"IRC1" $TITLE"IRC1" -e weechat-curses && ${TERM_USED}${BG8} $NAME"IRC2" $TITLE"IRC2" -e weechat-curses -d ~/.weechat-priv

	## Start custom keyboard shortcuts
	[ -z "$(pidof xbindkeys)" ] && xbindkeys &

	## Terminal applications

	## Start music on console player
	${TERM_USED}${BG9} $NAME"MOCP" -e mocp

	## Start local logs
	[ -d "$PATH_TO_DATA/media/truecrypt1/private/transmission-daemon" ] && [ -z "$(pidof multitail)" ] && ${TERM_USED}${BG11} $NAME"More Logs" $TITLE"More Logs" -e multitail -ci red -n 6 -f "$PATH_TO_DATA/media/truecrypt1/private/transmission-daemon/posttorrent.log"

	## GUI applications

	## Start vlc media player and playlist
	if [ -d "$VID_QUEUE" ] ; then
		[ -z "$(pidof vlc)" ] && vlc "$VID_QUEUE" &
	fi

	## Start text editor
	[ -z "$(pidof sublime_text)" ] && subl3 &

	## Start video editor
	#[ -z "$(pidof kdenlive)" ] && kdenlive &

	## Start web browser
	#[ -z "$(pidof firefox)" ] && firefox &
	if [ -z "$(pidof vimb)" ]; then
		vb -u "https://wiki.archlinux.org/index.php/User:Pdq" &
		vbp -u "https://www.linuxdistrocommunity.com/forums/index.php" &
	fi

	## Start dropbox
	#[ -z "$(pidof dropbox)" ] && dropboxd &

	## Start email client (start delay of 30 seconds to give proxy time to start)
	#[ -z "$(pidof claws-mail)" ] && sleep 30s && usewithtor claws-mail &
	[ -z "$(pidof mutt)" ] && sleep 3m && ${TERM_USED} $NAME"Mail" $TITLE"Mail" -e torsocks mutt
fi

exit 0
