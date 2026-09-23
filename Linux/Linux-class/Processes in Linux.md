# Processes In Linux
* Process means a program in execution 
* It is a running instance of a program
## Types of Processes 
    1. Foreground Process: 
- Also known as interactive process
- These processes are initialized and controlled through a terminal session.
    2. Backgroud Process: 
-Also known as non-interactive or automatic processes
-This Process is connected to a terminal.
-It does not expect any user input.

What is Daemons
These are special types of background processes that start at system startup and keep running forever as a service; they don’t die. They are started as system tasks (run as services), spontaneously. However, they can be controlled by a user via the init process.


## How Linux Identify Processes?
-Each running instance of a program must be identified uniquely by the kernel.
-It is identified by its process ID (PID) as well as it’s parent processes ID (PPID)

* Parent processes: These processes create other processes during run-time.
* Child processes – These processes are created by other processes(parent process) during run-time.

## The Init Process
- Mother (parent) of all processes on the system.
- First program that is executed when the Linux system boots up.
- Manages all other processes on the system. 
- It is started by the kernel itself.
- It does not have a parent process.

NOTE:
*The init process always has process ID of 1. 

## Command to find the ID of a process:
* pidof systemd
* pidof top
* pidof httpd

## Command to view the active process
* ps
* top 

## States of a Process in Linux
* Running – The process in running (it is the current process in the system).
* Waiting – The process is waiting for an event to occur or for a system resource.
* Stopped – The process has been stopped, usually by receiving a signal. 
* Zombie – The process is dead, it has been halted but it’s still has an entry in the process table.

## How to Control Processes in Linux
Commands for controlling processes are:
kill, pkill, 
* pgrep/pkill: look up or signal processes based on name and other attributes
* Kill: Terminate a process 


SYNOPSIS

 and killall.
