# WHEN CONTION 
1. Ansible when condition allows you to specify conditions under which a task should be executed or skipped.
2. It acts as a conditional statement that controls the flow of your playbook based on the evaluated condition.

## FOR EXAMPLE: 

tasks:
  - name: Perform a task
    some_module:
      # Module options
    when: some_condition

## NOTE
1. When some_condition is true, the task is executed. When some_condition is false, the task is skipped. 
2. Ansible provides a wide range of variables and facts that you can use to create conditions, such as 
    A. ansible_distribution
    B. ansible_os_family
    C. ansible_facts
    D. custom variables you define in your playbooks.
3. If a task is skipped due to a "when" condition, it won't be marked as failed but rather as "skipped" in the playbook's output.

---
- name: Install Apache on Amazon Linux
  hosts: all
  remote_user: ec2-user
  become: yes
  vars:
    ansible_python_interpreter: /usr/bin/python3
  tasks:
  - name: Install Apache on CentOS
      package:
        name: httpd
        state: present


- name: Install Apache
      yum:
        name: httpd
        state: latest

    - name: Start Apache
      ansible.builtin.service:
        name: httpd
        state: started

    - name: Ensure Apache service is enabled and running
      systemd:
        name: httpd
        enabled: yes
        state: started

    - name: Copy website files
      copy:
        src: index.html
        dest: /var/www/html/index.html

    - name: Restart Apache
      ansible.builtin.service:
        name: httpd


---
- name: Install Apache on Amazon Linux
  hosts: all
  remote_user: ec2-user
  become: yes
  vars:
    ansible_python_interpreter: /usr/bin/python3
  tasks:

    - name: Install Apache 
      yum:
        name: httpd
        state: present
      when: ansible_distribution == "CentOS" 
      become_user: ec2-user
    
    - name: Install Apache 
      yum:
        name: apache2
        state: present
      when: ansible_distribution == "Ubuntu" 
      become_user: ubuntu
  
    - name: Start Apache 
      ansible.builtin.service:
        name: httpd
        state: started
      when: ansible_distribution == "CentOS" 
      become_user: ec2-user

    - name: Start Apache 
      ansible.builtin.service:
        name: apache2
        state: started
      when: ansible_distribution == "Ubuntu" 
      become_user: ubuntu
        
    - name: Ensure Apache service is enabled and running 
      systemd:
        name: httpd
        enabled: yes
        state: started
      when: ansible_distribution == "CentOS" 
      become_user: ec2-user
        
    - name: Ensure Apache service is enabled and running 
      systemd:
        name: apache2
        enabled: yes
        state: started
      when: when: ansible_distribution == "Ubuntu"
      become_user: ubuntu
    
    - name: Copy website files
      copy:
        src: index.html
        dest: /var/www/html/index.html
      when: ansible_distribution == "CentOS" 
      become_user: ec2-user

    - name: Copy website files
      copy:
        src: index.html
        dest: /var/www/html/index.html
      when: ansible_distribution == "Ubuntu"
      become_user: ubuntu

    - name: Restart Apache 
      ansible.builtin.service:
        name: httpd
        state: restarted
      when: ansible_distribution == "CentOS" 
      become_user: ec2-user
      
    - name: Restart Apache 
      ansible.builtin.service:
        name: apache2
        state: restarted
      when: ansible_distribution == "Ubuntu"
      become_user: ubuntu



 ## More consie playbook 
---
- name: Install and Configure Apache
  hosts: all
  remote_user: ec2-user
  become: yes
  vars:
    ansible_python_interpreter: /usr/bin/python3
  tasks:
    - name: Install Apache
      package:
        name: "{{ 'httpd' if ansible_distribution == 'CentOS' else 'Ubuntu' }}"
        state: present

    - name: Start Apache
      ansible.builtin.service:
        name: "{{ 'httpd' if ansible_distribution == 'CentOS' else 'Ubuntu' }}"
        state: started

    - name: Ensure Apache service is enabled and running
      systemd:
        name: "{{ 'httpd' if ansible_distribution == 'CentOS' else 'Ubuntu' }}"
        enabled: yes
        state: started

    - name: Copy website files
      copy:
        src: index.html
        dest: "/var/www/html/index.html"

    - name: Restart Apache
      ansible.builtin.service:
        name: "{{ 'httpd' if ansible_distribution == 'CentOS' else 'Ubuntu' }}"
        state: restarted