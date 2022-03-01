#!/usr/bin/env bash

SSHPASS=`which sshpass`
SSH=`which ssh`
MV=`which mv`
USER="admin"
PASS="SENHA"
KEX="diffie-hellman-group1-sha1"
CIPHER="aes128-cbc"
DATE=$(date +"%Y%m%d%H%M%S")
PATH01="/mnt/tftp"
HOSTGROUP=("IP1" "IP2" "...")


for HOST in $HOSTGROUP ; do
    echo ""
    echo ""
    echo "### HPEV1920  #########################################################################"
    echo "### BACKUP - $HOST"
    echo ""
    sleep 1
    $SSHPASS -p $PASS $SSH -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o KexAlgorithms=$KEX -c $CIPHER $USER@${HOST} < commandshp.txt
    sleep 8
    $MV $PATH01/ALTERAR.cfg $PATH01/$HOST-$DATE-startup-config.cfg
    echo ""
done
