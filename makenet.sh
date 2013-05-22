#!/bin/bash
# wget http:// -O makenet.sh && sh makenet.sh

## figure out architecture type
grep -q "^flags.*\blm\b" /proc/cpuinfo && archtype="x86_64" || archtype="i686"

if [ "$archtype" = "x86_64" ]; then
    dialog --backtitle "pdq OS internet setup for Arch Linux" --title "Information" --msgbox "Your architecture type is x86_64, this installer assumes you are using the x86_64 livecd option...\nproceeding (press ESC to exit)" 20 70
    archtype="x86_64"
    not_archtype="i686"
else
    dialog --backtitle "pdq OS internet setup for Arch Linux" --title "Information" --msgbox "Your architecture type is i686, this installer assumes you are using the i686 livecd option... proceeding\n(press ESC to exit)" 20 70
    archtype="i686"
    not_archtype="x86_64"
fi

if [ $? = 255 ] ; then
    exit 0
fi

dialog --clear --backtitle "$upper_title" --title "Architecture type" --yes-label "$archtype" --no-label "$not_archtype" --yesno "Double check. [Select Arch type]" 20 70
if [ $? = 0 ] ; then
        archtype=$archtype
    else
        archtype=$not_archtype
fi

upper_title="pdqOS internet setup for Arch Linux $archtype"
setterm -blank 0

## root script
if [ $(id -u) -eq 0 ]; then

    ## styling
    clr=""

    ## temporary files
    _TEMP=/tmp/answer$$
    mkdir -p /tmp/tmp 2>/dev/null
    TMP=/tmp/tmp 2>/dev/null

    ## functions
    exiting_() {
        clear
        rm -f $_TEMP
        dialog --clear --backtitle "$upper_title" --title "Exiting Script" --msgbox "type: sh makenet.sh to re-run" 10 40
        exit 0
    }

    net_menu() {
        dialog \
            --colors --backtitle "$upper_title" --title "$upper_title" \
            --menu "Select action: (Do them in order)" 20 30 10 \
            1 $clr"Create internet connection" \
            2 $clr"Exit" 2>$_TEMP

        if [ $? = 1 ] || [ $? = 255 ] ; then
            exiting
            return 0
        fi

        choice=$(cat $_TEMP)
        case $choice in
            1) make_internet;;
            2) exiting_;;
        esac
    }

 make_internet() {
        dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "Test/configure internet connection" 10 70
        if [ $? = 255 ] ; then
            installer_menu
            return 0 
        fi

        dialog --clear --backtitle "$upper_title" --title "Internet" --yesno "Configure wired connection?" 10 70
        if [ $? = 0 ] ; then
            local net_list mynet
            for mynet in $(ip link show | awk '/: / {print $2}' | tr -d :) ; do
                net_list+="${mynet} - "
            done

            my_networks=$(dialog --stdout --backtitle "$upper_title" --title 'Internet' --cancel-label "Go Back" \
            --default-item "${my_networks}" --menu "Choose network or <Go Back> to return" 16 45 23 ${net_list} "Exit" "-" || echo "${my_networks}")

            if [ "$my_networks" = "" ] || [ $? = 255 ] || [ "$my_networks" = "Exit" ] ; then
                installer_menu
                return 0
            fi

            if [ "$my_networks" ] ; then # some better check should be here / placeholder
                dhcpcd $my_networks
                dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "Set network to $my_networks" 10 30
            else
                dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "Failed to set network...network does not exist/null?" 10 30
            fi

            wget -q --tries=10 --timeout=5 http://www.google.com -O /tmp/index.google &> /dev/null

            if [ ! -s /tmp/index.google ] ; then
                dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "It appears you have no internet connection, refer to for instructions on loading your required wireless kernel modules.\n\nhttps://wiki.archlinux.org/index.php/Wireless_Setup" 10 40
            else
                dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "It appears you have an internet connection, huzzah for small miracles. :p" 10 30
            fi
        else
            dialog --clear --backtitle "$upper_title" --title "Internet" --radiolist "Choose your preferred wireless setup tool" 10 70 30 \
            "1" "wifi-menu" on \
            "2" "wpa_supplicant" off \
            2> $TMP/pwifi
            if [ $? = 1 ] || [ $? = 255 ] ; then
                installer_menu
                return 0 
            fi

            local net_list mynet
            for mynet in $(ip link show | awk '/: / {print $2}' | tr -d :) ; do
                net_list+="${mynet} - "
            done

            my_networks=$(dialog --stdout --backtitle "$upper_title" --title 'Internet' --cancel-label "Go Back" \
            --default-item "${my_networks}" --menu "Choose network or <Go Back> to return" 16 45 23 ${net_list} "Exit" "-" || echo "${my_networks}")

            if [ "$my_networks" = "" ] || [ $? = 255 ] || [ "$my_networks" = "Exit" ] ; then
                installer_menu
                return 0
            fi

            if [ "$my_networks" ] ; then # some better check should be here / placeholder
                dhcpcd $my_networks
                dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "Set network to $my_networks" 10 30
            else
                dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "Failed to set network...network does not exist/null?" 10 30
            fi

            pwifi=$(cat $TMP/pwifi)
            if [ "$pwifi" == "1" ] ; then
                wifi-menu $my_networks
            else
                dialog --clear --backtitle "$upper_title" --title "Internet" --inputbox "Please enter your SSID" 10 70 2> $TMP/pssid
                pssid=$(cat $TMP/pssid)

                dialog --clear --backtitle "$upper_title" --title "Internet" --passwordbox "Please enter your wireless passphrase" 10 70 2> $TMP/ppassphrase
                ppassphrase=$(cat $TMP/ppassphrase)
                wpa_passphrase "$pssid" "$ppassphrase" >> /etc/wpa_supplicant.conf
                wpa_supplicant -B -Dwext -i $my_networks -c /etc/wpa_supplicant.conf & >/dev/null
            fi

            #dhcpcd $my_networks
            wget -q --tries=10 --timeout=5 http://www.google.com -O /tmp/index.google &> /dev/null
            if [ ! -s /tmp/index.google ] ; then
                dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "It appears you have no internet connection, refer to for instructions on loading your required wireless kernel modules.\n\nhttps://wiki.archlinux.org/index.php/Wireless_Setup" 20 30
            else
                dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "It appears you have an internet connection, huzzah for small miracles. :p" 10 30
            fi
        fi

        dialog --clear --backtitle "$upper_title" --title "Internet" --msgbox "Internet configuration complete.\n\n Hit enter to return to menu" 10 30
    }

    # utility execution
    while true
    do
        net_menu
    done
else
	echo "Must be root to use script, Ctrl-C to exit."
fi
