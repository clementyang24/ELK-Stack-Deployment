#!/bin/bash
cd /home/sysadmin/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis
awk -F" " '{print $1" "$2" "$5" "$6}' 0310_Dealer_schedule | grep '05:00:00 AM\|08:00:00 AM\|02:00:00 PM\|08:00:00 PM\|11:00:00 PM' >> Dealers_working_during_losses
awk -F" " '{print $1" "$2" "$5" "$6}' 0312_Dealer_schedule | grep '05:00:00 AM\|08:00:00 AM\|02:00:00 PM\|08:00:00 PM\|11:00:00 PM' >> Dealers_working_during_losses
awk -F" " '{print $1" "$2" "$5" "$6}' 0315_Dealer_schedule | grep '05:00:00 AM\|08:00:00 AM\|02:00:00 PM' >> Dealers_working_during_losses

