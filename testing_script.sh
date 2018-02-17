#!/bin/bash

#### setting variables ####
#PLAYBOOK=$2
TOGGLE_CHECK=$1

SOURCE_DIR=/var/log/ansible
DESTINATION_DIR=/etc/ansible
LOGFILE=$SOURCE_DIR/ansible.log
PLAYBOOK_PATH=/etc/ansible/playbooks/enforcement_test.yml
#PLAYBOOK_PATH=/etc/ansible/playbooks/$PLAYBOOK.yml

if [ $TOGGLE_CHECK -eq "-h" ] || [ $TOGGLE_CHECK -eq "--help" ]
	then
	echo "Only argument allowed is --check or no argument"

elif [$TOGGLE_CHECK -ne "--check"] || [$TOGGLE_CHECK -ne ""]
	then
	echo "Only argument allowed is --check or no argument"

elif [$TOGGLE_CHECK -eq "--check"] || [$TOGGLE_CHECK -eq ""]
	then
	cd $DESTINATION_DIR
	ansible-playbook $PLAYBOOK_PATH --syntax-check ## >> $LOGFILE
	if [ $? -eq 0 ]
		then
		echo "Check completed without error running full command" ## >> $LOGFILE
		cd $DESTINATION_DIR
		ansible-playbook $PLAYBOOK_PATH $TOGGLE_CHECK ## >> $LOGFILE
	else
	echo "Check Failed please review ansible syntax" ## >> $LOGFILE
	fi
fi