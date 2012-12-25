#!/bin/sh

upper_title="[ pdqOS environment configuration ] (chroot)"

    _TEMP=/tmp/chanswer$$


    gen_tz() {
        dialog --clear --backtitle "$upper_title" --title "[ TIMEZONE ]"  --yes-label "Continue" --no-label "Go Back" --yesno "Generate timezone/localtime" 10 35
    }


    chroot_menu() {
        echo "make it so"
        dialog \
            --colors --title "pdqOS Installer (chroot) for Arch Linux x86_64" \
            --menu "\ZbSelect action:" 20 60 9 \
            1 $clr"Generate hostname [${GEN_HOSTNAME}]" \
            2 $clr"Generate timezone [${GEN_TIMEZONE}]" \
            3 $clr"Generate locale [${GEN_LANG}]" \
            4 $clr"Set root password" \
            5 $clr"Create default user and add to sudoers" \
            6 $clr"Install Grub" \
            7 $clr"Configure Grub" \
            8 $clr"View/confirm generated data" \
            9 $clr"Exit chroot" 2>$_TEMP

        choice=$(cat $_TEMP)
        case $choice in
            1) gen_hostname=1;;
            2) gen_tz;;
            3) gen_locale=1;;
            4) set_root_pass=1;;
            5) add_user=1;;
            6) install_grub=1;;
            7) conf_grub=1;;
            8) conf_view=1;;
            9) exit;;
        esac
    }

    # utility execution
    while true
    do
        chroot_menu
        echo "end of chroot function"
    done