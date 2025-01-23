# ANSIBLE MODULES 

1. System modules 

2. Command modules: 
* Execute a command on a remote node 

3. Script modeule:
* Use to copy script on a remote server 

4. Service modules:
* used to manage services 

5. Line in file module
* Used to search for a line and replace it or add it if it does not exit 
* 

6. File modules 

7. Database Modules 

8.  Cloud modules

9. Windows modules 

10. Ansible Template Modules 
* Use to create files by dynamically redering the content of the files from a template files.
* It used to generate files, scripts or rother text-based files.

## Here's how the template module works:
a. Create a Jinja2 template file that includes variables for values you want to customize in your configuration files.
b. In the Ansible playbook, use the template module to render the template file, providing values for the placeholders via Ansible variables.

The template module processes the template, replaces the placeholders with the provided values, and deploys the resulting configuration file to the remote server.

## EXAMPLES 






# ANSIBLE VARIBALES 
vars:
    dns-servers: 10.0.0.1
-----
tasks:
    line : nameserver '{{dns-servers}}'

* No apostrophe when the varible is in a sentence 


# CONDITIONAL
WHEN 

# LOOPS 
 
 #