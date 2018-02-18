#!/bin/bash

#### setting variables ####
PLAYBOOK=$2 
TOGGLE_CHECK=$1
SOURCE_DIR=/var/log/ansible
DESTINATION_DIR=/etc/ansible
LOGFILE=$SOURCE_DIR/ansible.log
PLAYBOOK_PATH=/etc/ansible/playbooks/enforcement_test.yml
PLAYBOOK_PATH=/etc/ansible/playbooks/$PLAYBOOK

if { [ "$TOGGLE_CHECK" = "-h" ] || [ "$TOGGLE_CHECK" = "--help" ] || [ "$TOGGLE_CHECK" = "" ]; };
	then
	echo -e "\e[1;37m


-----------------------------------------------------------------------------------------------
############### THIS SCRIPT WILL RUN THE PLAYBOOK IN TWO MODES ###############
SYNTAX:			[script] [options] [playbook]


OPTIONS:
-h, --help		This will show you this message.

--dry_run    		This will NOT enforce the playbook just displays a 'dry' run
			which shows the difference of the changes that would take place.

--stateful		This enforces the changes specified in the playbook.

PLAYBOOK:

[playbook]		Name of existing playbook in $ANSIBLE_HOME/playbooks/ directory.

-----------------------------------------------------------------------------------------------


\e[0m"

elif [ "$TOGGLE_CHECK" = "--dry_run" ];
	then
	echo -e "\e[1;32m	
**************************************
**************************************
*** Running Playbook in check mode ***
**************************************
**************************************
\e[0m"
	cd $DESTINATION_DIR
	ansible-playbook $PLAYBOOK_PATH --syntax-check ## >> $LOGFILE
	if [ $? -eq 0 ]
		then
		echo -e "\e[1;36m

Check completed without error running full command

\e[0m" ## >> $LOGFILE
		cd $DESTINATION_DIR
		ANSIBLE_NOCOWS=1 ansible-playbook $PLAYBOOK_PATH --check --diff ## >> $LOGFILE
	else
	echo -e "\e[1;36m

Check Failed please review ansible syntax

\e[0m" ## >> $LOGFILE
	fi
elif [ "$TOGGLE_CHECK" = "--stateful" ];
	then
	echo -e "\e[1;32m
**************************************
**************************************
********* Running Playbook ***********
**************************************
**************************************
\e[0m"
	cd $DESTINATION_DIR
	ANSIBLE_NOCOWS=1 ansible-playbook $PLAYBOOK_PATH --syntax-check ## >> $LOGFILE
	if [ $? -eq 0 ]
		then
		echo -e "\e[1;36m

Check completed without error running full command

\e[0m" ## >> $LOGFILE
		cd $DESTINATION_DIR
		ANSIBLE_NOCOWS=1 ansible-playbook $PLAYBOOK_PATH ## >> $LOGFILE
	else
	echo -e "\e[1;31m

Check Failed please review ansible syntax

\e[0m" ## >> $LOGFILE
	fi
elif [ "$TOGGLE_CHECK" != "--dry_run" ];
	then
	echo -e "\e[1;31m


!!!!!!!!!! Please use -h, --help to see a list of accepted arguments !!!!!!!!!!


\e[0m"
fi

### --diff			when changing (small) files and templates, show the differences in those files
### DIFF_CHECK=$2

#elif { [ "$TOGGLE_CHECK" != "--check" ] || [ "$TOGGLE_CHECK" != "" ]; };
#	then
#	echo "
#!!!!!!!!!! Please use -h, --help to see a list of accepted arguments !!!!!!!!!!
#"