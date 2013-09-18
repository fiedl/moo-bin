#!/usr/bin/sh
## Autostart Script - ran after startx
## Author pdq 11-27-2012 - 04-18-2013 07-30-2013

## run moo from command line or Everything Launcher/dmenu/etc

## Path to video directory queue
#VID_QUEUE="/home/$USER/Videos/24 Complete Series DVDRip XviD"
#VID_QUEUE="/home/$USER/Videos/tempvideo"
#VID_QUEUE="/home/$USER/Videos/movies"
VID_QUEUE="/home/$USER/Videos/Star Trek TNG"

## LAN addresses
MOUNT_LAN1_FILESYSTEM=1 ## 1/0 (On/Off) 
LAN1='192.168.0.10'
PORT1=34567
USER1='pdq'
PATH_TO_DATA=/mnt/linux-$USER1

## Private data (Encrypted data)
PRIV_ENABLED=1 ## 1/0 (On/Off) 


## Ensure rxvt-unicode daemon is running
[ -z "$(pidof urxvtd)" ] && urxvtd -q -o -f

## Screencast start (edit for your specific needs/hardware configuration)
#urxvtc -name "Screencaster" -title ""Screencaster -e ffmpeg -f alsa -ac 2 -i pulse -f x11grab -r 30 -s 1920x1080 -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 startx.mkv

## Start drop down urxvtc terminal console
[ -z "$(pidof yeahconsole)" ] && yeahconsole &

## Start system information display
#[ -z "$(pidof conky)" ] && conky -d -c "$HOME"/.config/conky/.conkye17 &

## path to your LAN secure shell file system mount
if [ $MOUNT_LAN1_FILESYSTEM -eq 1 ]; then
	## Remote applications, ssh keys read by keychain from ~/.zprofile

	## Main term
	urxvtc -name "ssh $LAN1" -title "ssh $LAN1" -e ssh $LAN1 -p$PORT1

	## Start SSH top (terminal task manager)
	urxvtc -name "htop $LAN1" -title "htop $LAN1" -e ssh -t $LAN1 -p$PORT1 htop

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
[ -z "$(pidof xflux)" ] && xflux -z 37213 -k 3800

## Start dmenu clipboard (dmenuclip/dmenurl)
#killall -q clipbored
#clipbored

## Terminal applications

## Main terms
urxvtc -name "Term" -title "Term"
urxvtc -name "tERM" -title "tERM"

## Start system logs
urxvtc -name "Logs" -title "Logs" -e sudo journalctl -f

## Start top (terminal task manager)
#[ -z "$(pidof htop)" ] && urxvtc -name "HTOP" -title "HTOP" -e htop

## Start CPU frequency monitor
[ -z "$(pidof watch)" ] && urxvtc -name "CPU Freq" -title "CPU Freq" -e watch grep \"cpu MHz\" /proc/cpuinfo

## Start GPU monitor
[ -z "$(pidof nvidia-smi)" ] && urxvtc -name "GPU" -title "GPU" -e nvidia-smi -l 5 -q -d "MEMORY,TEMPERATURE"

## Start RSS reader
[ -z "$(pidof canto-curses)" ] && urxvtc -name "RSS" -title "RSS" -e canto-curses

## Start weather monitor
#[ -z "$(pidof ctw)" ] && urxvtc -name "Weather" -title "Weather" -e ctw CAXX0548

## Start clock
#[ -z "$(pidof tty-clock)" ] && urxvtc -name "Clock" -title "Clock" -e tty-clock -tc

## Start CPU temperature monitor
[ -z "$(pidof cpus_temp)" ] && urxvtc -name "CPUS" -title "CPUS" -e cpus_temp

## Start Internet radio player
#[ -z "$(pidof pyradio)" ] && urxvtc -name "Radio" -title "Radio" -e pyradio 

## Start dolphin
#[ -z "$(pidof dolphin)" ] && dolphin &

## Start steam
#[ -z "$(pidof steam)" ] && steam &

## Start youtube viewer
[ -z "$(pidof youtube-viewer)" ] && urxvtc -name "youtube" -e youtube-viewer --prefer-https --prefer-webm --use-colors --quiet -7 -S -C --mplayer="/usr/bin/vlc" --mplayer-args="-q"

## Start Arch Linux update notifier
[ -z "$(pidof aarchup)" ] && /usr/bin/aarchup --loop-time 60 --aur --icon "$HOME/.icons/pacman_icon_48x48.png" &

## Start sillyness
#[ -z "$(pidof cmatrix)" ] && urxvtc -name "Shall we play a game" -title "Shall we play a game" -e cmatrix -C cyan
#mplayer ~/nude.mp4 -noconsolecontrols -loop 0 &

## Default startup applications (If private data is mounted or there is no private data to be mounted)
if [ -d "$PATH_TO_DATA/home" ] || [ $PRIV_ENABLED -eq 0 ]; then

	## Daemons

	## Start IM server and IRC client
	[ -z "$(pidof bitlbee)" ] && urxvtc -name "bitlbee" -e sudo bitlbee -D
	[ -z "$(pidof weechat-curses)" ] && urxvtc -name "IRC1" -title "IRC1" -e weechat-curses && urxvtc -name "IRC2" -title "IRC2" -e weechat-curses -d ~/.weechat-priv

	## Start custom keyboard shortcuts
	[ -z "$(pidof xbindkeys)" ] && xbindkeys &

	## Terminal applications

	## Start music on console player
	urxvtc -name "MOCP" -e mocp

	## Start local logs
	[ -d "$PATH_TO_DATA/media/truecrypt1/private/transmission-daemon" ] && [ -z "$(pidof multitail)" ] && urxvtc -name "More Logs" -title "More Logs" -e multitail -ci red -n 6 -f "$PATH_TO_DATA/media/truecrypt1/private/transmission-daemon/posttorrent.log"

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
	[ -z "$(pidof mutt)" ] && sleep 3m && urxvtc -name "Mail" -title "Mail" -e torsocks mutt
fi

exit 0
