#!/bin/bash

#dhcpcd enp3s0
#ip link show | awk '/: / {print $2}'

upper_title="pdqOS Installer"

local net_list mynet
for mynet in $(ip link show | awk '/: / {print $2}' | tr -d :) ; do
	net_list+="${mynet} - "
done

my_networks=$(dialog --stdout --backtitle "${upper_title}" --title 'Network' --cancel-label "Go Back" \
--default-item "${my_networks}" --menu "Choose network or <Go Back> to return" 16 45 23 ${net_list} "Exit" "-" || echo "${my_networks}")

if [ "$my_networks" = "" ] || [ $? = 255 ] || [ "$my_networks" = "Exit" ] ; then
	installer_menu
	exit 0
fi

if [ "$my_networks" ] ; then # some better check should be here / placeholder
	#dhcpcd $my_networks
	dialog --clear --backtitle "$upper_title" --title "Network" --msgbox "Set network to $my_networks" 10 30
else
	dialog --clear --backtitle "$upper_title" --title "Network" --msgbox "Failed to set network...network does not exist/null?" 10 30
fi
