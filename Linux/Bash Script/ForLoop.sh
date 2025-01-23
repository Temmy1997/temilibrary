#!/bin/bash

for i in `cat servers`;
do 
    echo "Uptime"
    ssh -l root -n $i -t "uptime"
done  