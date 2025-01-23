# CRON
* cron is a time based job scheduler that allows user to schedule command or script to run at specific date and time.
* It allows lunix users to run command or script at a given time or date 
* con service (daemon) runs in the backgroup and is costanstly checks the /etc/crontab file 
* 
* crontab is the command line utility for cron 
* Each user can have their own crontab file.
* cron does not need to be restarted whenever a crontab file is modified. 
## INSATLL CRON 
yum insatll cron

## Check status
sudo systemctl styatus crond


## SHEDULE JOBS WITH CRON
TO EDIT or CREATE A CRONTAB FILE 
crontab -l : displays the current crontab (job from the current user)
crontab -r : removes the current crontab (Job from the current user)
crontab -e: Edit the current crontab (job from] th curent user)



## SYNTAX OF CRONTAB FILE
SYNTAX 
1 2 3 4 5 /path/script or /path/to/command 

1 = minutes
2 = hour (0-23)
3 = Day of the month (1-31)
4 = Month of the year (1-12)
5 = Day of the week 








* Standard input 



#!/bin/bash
directory="/tmp"

find /tmp -type f -mmin +1 -delete
