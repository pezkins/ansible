#!/bin/bash

#### setting variables ####
#PLAYBOOK=$2
TOGGLE_CHECK=$1

SOURCE_DIR=/var/log/ansible
DESTINATION_DIR=/etc/ansible
LOGFILE=$SOURCE_DIR/ansible.log
PLAYBOOK_PATH=/etc/ansible/playbooks/enforcement_test.yml
#PLAYBOOK_PATH=/etc/ansible/playbooks/$PLAYBOOK.yml

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

#echo "Running... " >> $LOGFILE
#cd $DESTINATION_DIR
#ansible-playbook $PLAYBOOK_FILE >> $LOGFILE
#SORTIDA=$?
#echo OK >> $LOGFILE

#!
#### ansible command run ####
#
#if "ansible-playbook --check /etc/ansible/playbooks/enforcement_test.yml"; then
#        "ansible-playbook /etc/ansible/playbooks/enforcement_test.yml"
#else
#        echo "Check Failed!"
#fi

