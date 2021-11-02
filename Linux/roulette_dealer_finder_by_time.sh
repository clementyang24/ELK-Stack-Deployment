#!/bin/bash
cd /home/sysadmin/Dealer_Schedules_0310
cat $1_Dealer_schedule | grep $2 | grep -iw $3 | awk -F" " '{print $1" "$2" "$5" "$6}'
