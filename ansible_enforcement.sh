#!/bin/bash

#### setting variables ####
#PLAYBOOK=$2
TOGGLE_CHECK=$1

SOURCE_DIR=/var/log/ansible
DESTINATION_DIR=/etc/ansible
LOGFILE=$SOURCE_DIR/ansible.log
PLAYBOOK_PATH=/etc/ansible/playbooks/enforcement_test.yml
#PLAYBOOK_PATH=/etc/ansible/playbooks/$PLAYBOOK.yml

if [$TOGGLE_CHECK -ne "--check"]
	then
	echo "Only argument allowed is --check"
elif [ $TOGGLE_CHECK "-eq -h" ]
	then
	echo "Only argument allowed is --check"
elif [ $TOGGLE_CHECK -eq --help ]
	then
	echo "Only argument allowed is --check"
elif [ $TOGGLE_CHECK -eq --check ]
	then
	cd $DESTINATION_DIR
	ansible-playbook $PLAYBOOK_PATH --syntax-check ## >> $LOGFILE
elif [ $? -eq 0 ]
	then
	echo "Check completed without error running full command" ## >> $LOGFILE
	cd $DESTINATION_DIR
	ansible-playbook $PLAYBOOK_PATH $TOGGLE_CHECK ## >> $LOGFILE
else
  echo "Check Failed please review ansible syntax" ## >> $LOGFILE
fi

#echo "Running... " >> $LOGFILE
#cd $DESTINATION_DIR
#ansible-playbook $PLAYBOOK_FILE >> $LOGFILE
#SORTIDA=$?
#echo OK >> $LOGFILE

#if arg = check do wh atever; elseif arg =-h do something else elseif arg=--help" do smethhing..

#!
#### ansible command run ####
#
#if "ansible-playbook --check /etc/ansible/playbooks/enforcement_test.yml"; then
#        "ansible-playbook /etc/ansible/playbooks/enforcement_test.yml"
#else
#        echo "Check Failed!"
#fi

