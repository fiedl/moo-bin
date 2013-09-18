#!/bin/bash

git_repos=~/github

while true :
	do
	project=$git_repos/$(grep -v '(pdq|pdq-server|mooOS-dev-tools|pdq-utils|zsh|systemd|eggdrop-scripts|qdm|gh|etc|weechat-X)' $git_repos/projects.list | shuf -n 1 )/.git
	hash=$(git --git-dir="$project" ls-tree -r HEAD | egrep -i '.*\.(lua|c|h|cpp|hpp|cxx|hxx|cc|hh|js|py|rb|sh|cgi|bash|txt|php|htm|html|shtml|java|pro|pri|nsi|bat|vbs|asp|cs|hs|sln|xml|xhtml|csproj|rst|m|mm|Makefile|css|md|mk|asm|s)$' | shuf -n 1 | cut -f 1 | cut -d ' ' -f 3)
	if [ "$hash" != "" ]; then
		git --git-dir="$project" cat-file -p "$hash"
	fi
	#echo $project
	#echo $hash
	sleep 0.05s
done