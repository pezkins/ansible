#!/bin/bash

#### setting variables ####
#PLAYBOOK=$2
TOGGLE_CHECK=$1

SOURCE_DIR=/var/log/ansible
DESTINATION_DIR=/etc/ansible
LOGFILE=$SOURCE_DIR/ansible.log
PLAYBOOK_PATH=/etc/ansible/playbooks/enforcement_test.yml
#PLAYBOOK_PATH=/etc/ansible/playbooks/$PLAYBOOK.yml

if { [ "$TOGGLE_CHECK" = "-h" ] || [ "$TOGGLE_CHECK" = "--help" ]; };
	then
	echo "
-h --help		This will show you this message
--check    		This will NOT enforce the playbook just displays a dry run
no-argument		This WILL enforce the playbook
"

elif { [ "$TOGGLE_CHECK" != "--check" ] || [ "$TOGGLE_CHECK" -ne 0 ]; };
	then
	echo "
!!!!!!!!!!Please use -h, --help to see a list of accepted arguments !!!!!!!!!!
"

elif { [ "$TOGGLE_CHECK" = "--check" ] || [ "$TOGGLE_CHECK" -eq 0 ]; };
	then
	echo "Running Playbook"
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

### --diff			when changing (small) files and templates, show the differences in those files
### DIFF_CHECK=$2