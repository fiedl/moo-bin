#!/usr/bin/sh
## Autostart Script - ran after startx
## Author pdq 11-27-2012 - 04-18-2013 07-30-2013

## pdq@alice

## Path to video directory queue
VID_QUEUE="/home/pdq/Videos/24 Complete Series DVDRip XviD"
#VID_QUEUE="/home/pdq/Videos/tempvideo"
#VID_QUEUE="/home/pdq/Videos/movies"
#VID_QUEUE="/home/pdq/Videos/Star Trek TNG"

## Ensure rxvt-unicode daemon is running
[ -z "$(pidof urxvtd)" ] && urxvtd -q -o -f

## Screencast start (edit for your specific needs/hardware configuration)
#urxvtc -name "Screencaster" -e ffmpeg -f alsa -ac 2 -i pulse -f x11grab -r 30 -s 1920x1080 -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 startx.mkv

## Start drop down urxvtc terminal console
[ -z "$(pidof yeahconsole)" ] && yeahconsole &

## Start system information display
#[ -z "$(pidof conky)" ] && conky -d -c "$HOME"/.config/conky/.conkye17 &

if [ ! -d "/mnt/linux-pdq/home" ] ; then
	## Remote applications (pdq@linux / pdq@192.168.0.10 - ssh keys read by keychain from ~/.zprofile
	## Main term
	urxvtc -name "ssh Term" -e ssh 192.168.0.10 -p34567
	## Start SSH top (terminal task manager)
	#urxvtc -name "ssh top" -e ssh -t 192.168.0.10 -p34567 top
	## Mount server filesystem to localhost
	sshfs pdq@192.168.0.10:/ /mnt/linux-pdq -C -p 34567
fi

## Start dmenu clipboard (dmenuclip/dmenurl)
#killall -q clipbored
#clipbored 

## Start IM server and IRC client
[ -z "$(pidof weechat-curses)" ] && urxvtc -name "IRC1" -e weechat-curses && urxvtc -name "IRC2" -e weechat-curses -d ~/.weechat-priv

## Start custom keyboard shortcuts
[ -z "$(pidof xbindkeys)" ] && xbindkeys &

## Main terms
urxvtc -name "Term"
urxvtc -name "tERM"

## Terminal applications
## Start top (terminal task manager)
#[ -z "$(pidof top)" ] && urxvtc -name "TOP" -e top
## Start music on console player
urxvtc -name "MOCP" -e mocp
## Start CPU frequency monitor
[ -z "$(pidof watch)" ] && urxvtc -name "CPU Freq" -e watch grep \"cpu MHz\" /proc/cpuinfo
## Start GPU monitor
[ -z "$(pidof nvidia-smi)" ] && urxvtc -name "GPU" -e nvidia-smi -l 5 -q -d "MEMORY,TEMPERATURE"
## Start local logs
[ -z "$(pidof multitail)" ] && urxvtc -name "More Logs" -e multitail -ci red -n 6 -f "/mnt/linux-pdq/media/truecrypt1/private/transmission-daemon/posttorrent.log"
## Start system logs
urxvtc -name "Logs" -e sudo journalctl -f
## Start RSS reader
[ -z "$(pidof canto-curses)" ] && urxvtc -name "RSS" -e canto-curses
## Start weather monitor
#[ -z "$(pidof ctw)" ] && urxvtc -name "Weather" -e ctw CAXX0548
## Start clock
[ -z "$(pidof tty-clock)" ] && urxvtc -name "Clock" -e tty-clock -tc
## Start CPU temperature monitor
[ -z "$(pidof cpus_temp)" ] && urxvtc -name "CPUS" -e cpus_temp
## Start Internet radio player
[ -z "$(pidof pyradio)" ] && urxvtc -name "Radio" -e pyradio 

## GUI applications
## Start vlc media player and playlist
if [ -d "$HOME/Videos/tempvideo" ] ; then
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
## Start dolphin
#[ -z "$(pidof dolphin)" ] && dolphin &
## Start steam
#[ -z "$(pidof steam)" ] && steam &
## Start youtube viewer
[ -z "$(pidof youtube-viewer)" ] && urxvtc -name "youtube" -e youtube-viewer --prefer-https --prefer-webm --use-colors --quiet -7 -S -C --mplayer="/usr/bin/vlc" --mplayer-args="-q"
## Start dropbox
[ -z "$(pidof dropbox)" ] && dropboxd &
## Start Arch Linux update notifier
[ -z "$(pidof aarchup)" ] && /usr/bin/aarchup --loop-time 60 --aur --icon "$HOME/.icons/pacman_icon_48x48.png" &
## Start email client (start delay of 30 seconds to give proxy time to start)
#[ -z "$(pidof claws-mail)" ] && sleep 30s && usewithtor claws-mail &
[ -z "$(pidof mutt)" ] && sleep 3m && urxvtc -name "Mail" -e torsocks mutt

## Start sillyness
#[ -z "$(pidof cmatrix)" ] && urxvtc -name "Shall we play a game" -e cmatrix -C cyan
#mplayer ~/nude.mp4 -noconsolecontrols -loop 0 &

exit 0
