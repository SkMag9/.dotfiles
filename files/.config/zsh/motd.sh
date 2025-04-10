#!/bin/zsh

AVAILABLE_UPDATES=$(apt-get -s -o Debig::NoLocking=true upgrade | grep -c ^Inst)

whoami | figlet | lolcat -S 27

printf '%s\n' "${(r[20])$(print "Host:")}$(hostname)"
printf '%s\n' "${(r[20])$(print "Available Updates:")}$(print $AVAILABLE_UPDATES)"
