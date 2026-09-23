# LVM 

- Logical Volume Management
- It makes it easier to manage disk space 
- if a filesystem needs more space, we first add the space to it's volume group, then we resize the filesystem from the space in it's Volume group 

## Hierarchy of LVM 

PARTITION (lvm type) >> PV >> VG >> LV 

- PV: Physical Volume
- VG: Volume Group
- LV: Logical volume

## Features of Logical Volume

- it is flexible to expand the space at any time
- any filesystems can be installed and handled
- Migrations can be used to recover faulty disk
- restore the filesystem using snapshot features

## Creating LVM Disk storage in Linux

- Commands to check vg, pv and lv 
  - vgs/ vgdisplay
  - pvs/ pvdisplay
  - lvs/ lvdisplay
- pvcreate: command to create a physical volume
- vgcreate: command to create a volume group   
- lvcreate: command to create a logical volume 
   - lvcreate -l (Extend size) -n (name_of_logical_volume) (volume_group)

- Create vg name: swags_add_vg
- create 3 lv 
  - swags_documents
  - swags_manager
  - swags_public 

- Difference between lvcreate -l/-L
  - -l: we use the PE size to calculate the extent size      
  - -L: we specify the GB directly

- Next we create the filesystem 
- mkfs.ext4 /dev/<vg-name>/<lv-name> 
- create a directory for the mount point    
  - e.g mkdir /mnt/swags_documents 

- mount the filesystem on the mount point 
  - mount 
- Default PE size of every vg is 4MB ( command: vgdisplay)


## hierrachy of Filesystem storage 

HARD DRIVE PARTITION ( sda1 ) >> FILESYSTEM ( /dev/sda1 ) >> DATA ( /boot )

- Command to check filesytem disk space usage 
  - df -h 
  - du -h <folder>