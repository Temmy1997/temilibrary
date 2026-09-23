## Linux Boot Process
There are six stages in Linux Boot Porcess 

# 1. BIOS (Basic input output system)
-It performes intergirty checks 
- It performs a Power On Self Test(POST)
-The POST checks the hardware operability like Keyboard,RAM,USB port.
- It loads and execute the (MBR)boot loader program 
- Once the boot loader is detected and loaded in to the memory, BIOS gives the boot loader control 

# 2. MBR (Master Boot Record)
-It is located in the first sector of the bootabale disk  (dev/sda or /dev/hda)
-It contains information about the GRUB
-It loads and exceutes the GRUB boot loader

# 3. GRUB(Grand Unified Bootloader)
- GRUB2 is the latest and primary bootloader moderin in linux.
- It helps in selecting linux kernel version that you want to use. 
- It displays a splash screen. If you wait for few seconds you do not need tp enter anything
- It loads the defualt kernel image beaucse it was specified in the GRUB configuration file. 
- GRUB configuration file is /boot/grub2/grub.cfg
- It loads and exceutes Kernel and intrid images onto the main memory.
-Types of bootloaders: 
LILO
GEUB
Grub2

# 4. Kernel 
- This is the core of nay linux system. 
- It interact the PC's hardware with the underlying processes.
- The selected linux kernel mounts the root file system
- The kernel also set the /sbin/init prigram (INIT)
    -Init is alwsys the first program to be executed and given a process ID(PID) 
- The kernel also mounts the Initail RAM disk (initrd)
    -Initrd is a temporary root file system until the real root file system is mounted. 
- All kernels are located in the /boot directory with the initrd image.

# 5. INIT 
- It looks at the /etc/inittab file to decide the linux run level 
- RUNLEVELS 
 -0: Poweroff/shutdown                  -- 
 -1: singleuser mode/ rescue mode 
 -2: Multiuser, without NFS      
 -3: Full multiuser mode   ---- Configures the system to a non-graphical console.
 -4: unused 
 -5: X11/Graphical mode    ----Configures the system to a graphical multiuser interface 
 -6: reboot 

 To check the runlevel runlevel:
        Command: [runlevel]
To check the current target on your system, run the command:
        systemctl get-default

# RUNLEVELS
 -> This is the specific run level mode chosen by the inittab file 
 -> This is where the login prompt: 

 Website: https://www.tecmint.com/linux-boot-process/
