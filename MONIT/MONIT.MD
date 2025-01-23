# MONIT 
* Monit is a monitoring tool service on a unix system.
* It manages and monitor processes, files,directories, and file systems in linux. 
## THINGS MONIT CAN DO 
1. Start, restart, and stop a process.
2. Conducts automaticmaintenance and repair 
3. Execute meaninfful casual actions in error situtions 

## NOTES
* MONIT is controlled by its control file [~/.monitrc]
    Its found under [/etc/monitrc]
* MONIT logs are stored in its own log file and notifies you about an error conditions via CUSTOMIZABLE ALERT MESSAGES.

## General Options and Arguments

-c => file Use this control file

-d n Run as a daemon once per n seconds

-g => Set group name for start, stop, restart, monitor and unmonitor.

-l => logfile Print log information to this file

-p => pidfile Use this lock file in daemon mode

-s => statefile Write state information to this file

-I => Do not run in background (needed for run from init)

-t => Run syntax check for the control file

-v => Verbose mode, work noisy (diagnostic output)

-H [filename] => Print MD5 and SHA1 hashes of the file or of stdin if the filename is omitted; Monit will exit afterwards

-V => Print version number and patch level

-h => Print a help text

## ACTION ARGUEMRNT 
* start all => Start all services listed in the control file and enable monitoring for them. If the group option is set, only start and enable monitoring of services in the named group (no "all" verb is required in this case).

* start name => Start the named service and enable monitoring for it. The name is a service entry name from the monitrc file.

* stop all => Stop all services listed in the control file and disable their monitoring. If the group option is set, only stop and disable monitoring of the services in the named group (no "all" verb is required in this case).

* stop name => Stop the named service and disable its monitoring. The name is a service entry name from the monitrc file.

* restart all => Stop and start all services. If the group option is set, only restart the services in the named group (no "all" verb is required in this case).

* restart name => Restart the named service. The name is a service entry name from the monitrc file.

* monitor all => Enable monitoring of all services listed in the control file. If the group option is set, only start monitoring of services in the named group (no "all" verb is required in this case).

* monitor name => Enable monitoring of the named service. The name is a service entry name from the monitrc file. Monit will also enable monitoring of all services this service depends on.

* unmonitor all => Disable monitoring of all services listed in the control file. If the group option is set, only disable monitoring of services in the named group (no "all" verb is required in this case).

* unmonitor name => Disable monitoring of the named service. The name is a service entry name from the monitrc file. Monit will also disable monitoring of all services that depends on this service.

* status => Print full status information for each service.

* summary => Print short status information for each service.

* reload => Reinitialize a running Monit daemon, the daemon will reread its configuration, close and reopen log files.

* quit => Kill a Monit daemon process

* validate => Check all services listed in the control file. This action is also the default behavior when Monit runs in daemon mode.

## INSTALLING MONIT
yum install monit -y

* Rename the monitrc file 
    mv monitrc  monitrc_original







    