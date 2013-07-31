#!/bin/sh
# autostart script - ran after startx
# author pdq 11-27-2012 - 04-18-2013 07-30-2013
#urxvtc -name "Screencaster" -e ffmpeg -f alsa -ac 2 -i pulse -f x11grab -r 30 -s 1920x1080 -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 startx.mkv

# Drop down urxvtc terminal console
[ -z "$(pidof yeahconsole)" ] && yeahconsole &

# Start system information display
#[ -z "$(pidof conky)" ] && conky -d -c "$HOME"/.config/conky/.conkye17 &

# If data is mounted, ie: 
if [ -f "/mnt/linux-pdq/media/truecrypt1/test" ] ; then
	killall -9 cmatrix
	killall -9 mplayer

	# Mount @linux, term, htop and top - ssh keys read by keychain from ~/.zprofile
	urxvtc -name "ssh Term" -e ssh 192.168.0.10 -p34567
	#urxvtc -name "ssh htop" -e ssh -t 192.168.0.10 -p34567 htop
	urxvtc -name "ssh top" -e ssh -t 192.168.0.10 -p34567 top
	[ ! -d "/mnt/linux-pdq/home" ] && sshfs pdq@192.168.0.10:/ /mnt/linux-pdq -C -p 34567

	# Start dmenu clipboard (dmenuclip/dmenurl)
	#killall -q clipbored
	#clipbored 

	# Start IM server and IRC client
	[ -z "$(pidof weechat-curses)" ] && urxvtc -name "IRC1" -e weechat-curses && urxvtc -name "IRC2" -e weechat-curses -d ~/.weechat-priv

	# Start custom keyboard shortcuts
	[ -z "$(pidof xbindkeys)" ] && xbindkeys &

	# Main terminals
	urxvtc -name "Term"
	urxvtc -name "tERM" # large font size

	# Terminal applications
	#[ -z "$(pidof htop)" ] && urxvtc -name "HTOP" -e htop 
	[ -z "$(pidof top)" ] && urxvtc -name "TOP" -e top
	urxvtc -name "MOCP" -e mocp
	[ -z "$(pidof watch)" ] && urxvtc -name "CPU Freq" -e watch grep \"cpu MHz\" /proc/cpuinfo
	[ -z "$(pidof nvidia-smi)" ] && urxvtc -name "GPU" -e nvidia-smi -l 5 -q -d "MEMORY,TEMPERATURE"
	[ -z "$(pidof multitail)" ] && urxvtc -name "More Logs" -e multitail -ci green -n 5 -f "/mnt/linux-pdq/media/truecrypt1/private/transmission-daemon/posttorrent.log" -ci yellow -n 5 -f "/var/log/pacman.log"
	urxvtc -name "Logs" -e sudo journalctl -f
	[ -z "$(pidof canto-fetch)" ] && canto-fetch -db

	# Start vlc media player and playlist
	if [ -d "$HOME/Videos/tempvideo" ] ; then
		[ -z "$(pidof vlc)" ] && vlc "/home/pdq/Videos/24 Complete Series DVDRip XviD" &
	fi

	# Start text editor
	[ -z "$(pidof sublime_text)" ] && subl3 &

	# Start gui applications
	#[ -z "$(pidof kdenlive)" ] && kdenlive &
	#[ -z "$(pidof firefox)" ] && firefox &
	#[ -z "$(pidof dolphin)" ] && dolphin &
	[ -z "$(pidof steam)" ] && steam &
	[ -z "$(pidof gtk-youtube-viewer)" ] && gtk-youtube-viewer &

	# Start systray applications
	[ -z "$(pidof dropbox)" ] && dropboxd &

	# Start update notifier
	#killall -q aarchup && sleep 1s
	#[ -z "$(pidof aarchup)" ] && /usr/bin/aarchup --loop-time 60 --aur --icon "$HOME/.config/awesome/icons/pacman_icon_48x48.png" &

	# Email client (start delay of 30 seconds to give proxy time to start)
	[ -z "$(pidof claws-mail)" ] && sleep 30s && usewithtor claws-mail &
else
	[ -z "$(pidof cmatrix)" ] && urxvtc -name "Shall we play a game" -e cmatrix -C cyan
	mplayer ~/nude.mp4 -noconsolecontrols -loop 0 &
	#notify-send "Shall we play a game?" && sleep 5s
	#MOO='blue'
	#while true
	#do
		#notify-send "Shall we play a game?" && sleep 5s
		# urxvtc -name "" -e cmatrix -C $MOO
		# if [[ "$MOO" == "white" ]]; then
		# 	MCOLOR='yellow'
		# elif [[ "$MOO" == "blue" ]]; then
		# 	MOO="red"
		# elif [[ "$MOO" == "green" ]]; then
		# 	MCOLOR='white'
		# elif [[ "$MOO" == "red" ]]; then
		# 	MCOLOR='green'
		# elif [[ "$MOO" == "cyan" ]]; then
		# 	MCOLOR='magenta'
		# elif [[ "$MOO" == "yellow" ]]; then
		# 	MCOLOR='cyan'
		# elif [[ "$MOO" == "magenta" ]]; then
		# 	MCOLOR='blue'
		# fi
	#done
fi
