#!/bin/sh
 
# Archlinux Power User And Developer Spin Installer
# Maintainer: Setkeh <setkeh@gmail.com>
# Please Report All Bugs on Github Bug Tracker
# Bug Tracker Link: Link Place Holder
 
# This Script Aims to install a base Archlinux Setup,
# And add some Custom modifications to make installation
# Uniform and Simple.
 
set -e
 
WELCOME="Maintainer: Setkeh <setkeh@gmail.com>
Bug Tracker: Url Place holder
This is an Archlinux Spin with Little Modification Besides
Some preinstalled Packages and configs there ar no custom
Repo's and all current ArchWiki Documentation Aplies.
Also any bugs reported on topics covered in the ArchWiki
Will be marked 'Will Not Solve' For Obvious Reasons."
 
 
echo "$WELCOME"
echo
echo
 
#FUNCTIONS
 
#Partintion
part() {
	fdisk -l
}
 
#END FUNCTIONS
 
echo "Continue With Installation ??"
read CONTINUE
if [ $CONTINUE = "y" ]; then
part
else
echo "Exiting"
fi

