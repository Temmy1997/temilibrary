# Ansible

- This is a free opensource tool that can automate the configuration of several servers
- We use ansible to write codes in YAML
- This codes are deployed on to several servers

## Installation of Ansible

- yum install ansible -y

# Understand Core Components of Ansible

* Ansible ia a free opensource automation plateform.
* It enables to manage and control mutiple servers from one location.
* Other alternatives of Ansilble are (Puppet, Chef, and Salt)
* Ansible is simole to learn.
* Ansible used YAML(Yet Another Markup Language)
* YAML uses SSH protocol to communicate with remote servers

## YAML 
1. lIST 
   * Order of items has to be in order 
   * EXMAPLE
Frui: 
- carrot
- mango 
- orage 
2. Dictionaries 
   * Items does nnot have to be in order 
   * EXAMPLE
Banana:
  Calories: 105
  Fat: 0.4g
  Carbs: 27g

3. List of Dictionaries 
   * This contains list and dictionariues 
   * EXAMPLE

 -   Color: Blue 
     Model:
       Name: Corvettee
       Model: 1995
     Transmission : Manual
     
## Inventory

* Inventory is a text file that contains  a list of servers that are being managed and configured.
* These servers are listed based on their hostnames and ip addresses
* In this file, the servers can be listed in groups.( WEb Servers and Datebases )
* When placed into groups, the servers can be refrenced with their groiup names, but not ip addresses.

## Playbook

* This is a set of set of configuration management scripts / instructions that define how tasks are to be executed on remote hosts or a group of host machines.
* The scripts or instructions are written in YAML format
* A YAML file begins with 3 hyphens [---]
* PLAY: Defines a set of ativities to be run on hst. 
* Task : An action to be performeed on the host ( Installing, running a script, executing a command)

## Assignment\Project

*i create a virtual machines
*one of the vitual credated on the server
*find a way to ssh into a vitual machine that i created
*i should be abale to access the vitrual machines from anywhere from the public internet

## Modules

* Modules are discret units of code uswed in playbooks for executing command on remote hosts
* The basic format of a module is key: value.

- name: Install apache packages
  yum:   name=httpd  state=present

## Projects

* Use ansible to configure two web servers
* Concent of website running on Vm 1 - I am running on web server one, configured by ansible
* Concent of website running on Vm 2 - I am running on web server two, configured by ansible
