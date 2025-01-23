#!/bin/bash

yum update -y 
yum install epel-release -y   
for i in wget vim
do
  yum -y install $i  
done