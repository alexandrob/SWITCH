#!/usr/bin/env bash

SSHPASS=`which sshpass`
SSH=`which ssh`
MV=`which mv`
USER="admin"
PASS="SENHA"
KEX="diffie-hellman-group1-sha1"
CIPHER="aes128-cbc"
PATH01="/mnt/tftp"
HOSTGROUP=("IP1" "IP2" "...")
DATE=$(date +"%Y%m%d%H%M%S")


for HOST in ${HOSTGROUP[@]} ; do
    echo ""
    echo ""
    echo "### 3COM 2928  -  HPEV1910  #########################################################################"
    echo "### BACKUP - $HOST"
    echo ""
    sleep 2
    $SSHPASS -p $PASS $SSH -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o KexAlgorithms=$KEX -c $CIPHER $USER@$HOST < commands3com1910.txt
    sleep 5
    $MV $PATH01/ALTERAR.cfg $PATH01/$HOST-$DATE-startup-config.cfg
    echo ""
done
