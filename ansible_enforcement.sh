#!/bin/bash

#### setting variables ####

PLAYBOOK_FILE="enforcement_test.yml"
SOURCE_DIR=/var/log/ansible
DESTINATION_DIR=/etc/ansible
LOGFILE=$SOURCE_DIR/ansible.log
PLAYBOOK_FILE=/etc/ansible/playbook

echo "Running... " >> $LOGFILE
cd $DESTINATION_DIR
ansible-playbook $PLAYBOOK_FILE >> $LOGFILE
SORTIDA=$?
echo OK >> $LOGFILE

#!
#### ansible command run ####
#
#if "ansible-playbook --check /etc/ansible/playbooks/enforcement_test.yml"; then
#        "ansible-playbook /etc/ansible/playbooks/enforcement_test.yml"
#else
#        echo "Check Failed!"
#fi

