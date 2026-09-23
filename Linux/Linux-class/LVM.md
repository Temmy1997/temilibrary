# LOGICAL VOLUME MANAGEMENT(LVM) 
Logical Volume Mangement is used to manage disk space.
* Firstly add a new hard disk form the linux box.
* fdisk - to create partition 
    - fdisk /dev/sdb
df -h  -To check file system 
fdisk - to create partition 

## Volume Groups 
* vgs--To display the current volume groups
* To Create volume group:
    vgcreate temi_add_vg /dev/sdb1 /dev/sdc1
* Option 
    -s :physicalextentsize Size
* vgs -v :Display more info about the volume group command. 
* vgdisplay temi_add_vg : To get more info about a new volume group. 
    
    ## vgs command output meaning:
    * VG - Volume group name
    * #PV - Physical Volumes used in this Volume Group.
    * VFree - Shows free space available in this volume group.
    * VSize - Total Size of the Volume Group.
    * LV - Logical Volumes inside this volume group, 
       Mine is not yet created so there is 0.
    * SN - Number of Snapshots the volume group contains.
    * Attr - Status of the Volume group as Writeable, readable, resizeable, exported, partial and clustered.
    Mine is wz-–n- that means w = Writable, z = resizeable..
    * PV - Number of Physical Volume (PV) used in this Volume Group.

## Logical Volumes
* lvs :list the Current Logical Volumes
* Volume group size is 15.99GB and its unused, So i can Create LV in it. 
* To create 3 LV, I will divide volume group into 3 equal size to . 
* That means 15.99GB/3 = 5.33gb
* A single Logical Volume will be 5.33GB in Size after Creation.

    ## Check for the Total PE and PE Size using the [vgdisplay temi_add_vg] command 
    * PE Size: 4.00 MB [4.00MB IS A SINGLE PE SIZE]
    * Total Avaliable Pe: 4094

    ## Create 3 Logical Volume
    * Firstly, divide total PE/ 3
    * 4094/3 =1364
    * Now create using:
    lvcreate -l (Extend size) -n (name_of_logical_volume) (volume_group)
        -l : Creating Extent size 
        -n : Give a logical volume name 
    * lvcreate -l 1364 -n temi_document temi_add_vg
    * lvcreate -l 1364 -n temi_manager temi_add_vg
    * lvcreate -l 1364 -n temi_public temi_add_vg

    ## Another method
    * Creating logical volume using GB size with the -L option 
    * But we will not get an exact size.
    * lvcreate -L 18G -n tecmint_documents tecmint_add_vg
    * The option -L : 
    * But its better to use the -l option 
    
    Difference between lvcreate -l/-L
  * -l: we use the PE size to calculate the extent size      
  * -L: we specify the GB directly 

## Creating File System
* Using ext4 file-system to create the volumes
* It has to be mounted under /mnt/
* Using the following command 
    * mkfs.ext4 /dev/temi_add_vg/temi_document
    * mkfs.ext4 /dev/temi_add_vg/temi_public
    * mkfs.ext4 /dev/temi_add_vg/temi_manager

## Creating directoroes in /mnt and mount LV 
Firstly create  these directories
                /mnt/temi_document/
                /mnt/temi_public/
                /mnt/temi_manager/
Secondly, mount the lv to the directories
 * mount /dev/temi_add_vg/temi_document /mnt/temi_document/
 * mount /dev/temi_add_vg/temi_public /mnt/temi_public/
 * mount /dev/temi_add_vg/temi_manager /mnt/temi_manager/
Finally, run the df -h command 

## Permanent Mounting 
* When i mount, it is temporarily mounted
* Therfore i will have to permanently mount by adding it to my fstab 
* Edit the fstab file 
    vim /etc/fstab 
* Enter 
    /dev/mapper/temi_add_vg-temi_document   /mnt/temi_document  ext4    defaults 0 0
    /dev/mapper/temi_add_vg-temi_public       /mnt/temi_public     ext4    defaults 0 0
    /dev/mapper/temi_add_vg-temi_manager      /mnt/temi_manager    ext4    defaults 0 0
* Execute the [mount -av] command 

# Extending(Logical Volume Management) in Linux
* 
## How to Extend Volume Group
* Imagine there is no free space avalibale in Physical Volume and Volume group.
* Becuase of this, we would not be able to extend the lvm size. 
* Therfore in other to extend the lvm size:
    * * Add one physical volume(PV)
    * * Then extend the Volume Group(VG) 
    * * This will give enough space to extend the Logical Volume size.
## Step 1:Add a new PV 
* Firstly add a new hard disk 
* Create an LVM partition 
    Command: fdisk -cu /dev/sdd

## Step 2:List and Check the Partition 
* Command: fdisk -l /dev/sdd 

## Step 3: Create a new PV 
* Command: pvcreate /dev/sdd1
* To Verify Command: pvs 

## Step 4: Extend the size of Volume Group(VG)
* Command: vgextend [Old VG] [New PV]
    vgextend temi_add_vg /dev/sdd1
* To verify :vgs 
* To see which PV is used to create a VG use: pvscan

## Step 5: Get the free Physical Extend size
* Command: vgdisplay
* There are 1066 free PE available = 4.16 GiB Free space available
* I can expand the logical volume up to 4.16 GiB

## Step 6: Use the PE size to extend the LV
* I will be extend the temi_document logical volume.
* I will divide the free PE by 2 to get half of the free space avaliable. 
* Command: lvextend -l +533 /dev/temi_add_vg/temi_document

## Step 7: Resize the file-system 
* Note: We do not need to unmount the file-system when extending logical volumes. 
* Command: resize2fs /dev/temi_add_vg/temi_document

# REDUCING LOGICAL VOLUME(LVM)
* Before reducing LVM, it is good to BACKUP the data
* When reducing LVM, we need to unmount the file system before reducing LVM. 

## Step 1:[Unmount the file system]
* Use the lvs command to show the file system i want to reduce. 
I will be reducing temi_document 7.41GB to 5.41GB
I will reduce 2GB out of 7.41GB
* Use df -h to show the :
Size of the volume: 7.2GB
Used up to: 24M
Available space: 6.8GB
* Now Unmount using: umount -v /mnt/temi_document/

## Step 2: Check the filesystem afater unmount
* Check for the file-system error using following command.
e2fsck -ff /dev/temi_add_vg/temi_document]
* Options f -- Force checking even if filesystem is marked clean

Note: The output of this command must pass in every 5 steps of file-system check, if not there might be an issuse with the file system.

## Step 3: Reduce file-system
* Use this command to reduce the file system
resize2fs /dev/temi_add_vg/temi_document 5.41GB

## Step 4: Reduce the Logical volume using GB size 
* Use this command 
 lvreduce -L -2G /dev/temi_add_vg/temi_document
                    or 
## Reduce the logical volume using PE Size 
* We need to k
Size of default PE size
Total PE size of a Volume Group
* Calculation
1024MB x 5.41GB = 5539.84MB
5539.84MB / 4PE = 1384.96PE
* Use this command 
lvreduce -l -1384.96 /dev/temi_add_vg/temi_document

## Step 5: Re-size the file-system back 
* If there is an error here, then er have messed up our file system.
* Use this command 
resize2fs  /dev/temi_add_vg/temi_document
 
## Step 6: Mount the file-system back 
* Use this command 
mount /dev/temi_add_vg/temi_document /mnt/temi_document/

# LVM Snapshots



## Command to investigate file systems
- This command is used to check which file system is using more space.
- du -h --max-depth=1


## How to have two mount point on one file system
Mount /var/cache on /mnt/temi_vibes
1. Make sure any process writing to /var/cache is stopped. (Check with this command lsof | grep /var/cache)
2. Use this commnad : rsync -va /var/cache /mnt/temi_vibes/var/cache
    * rsync - Used for copying and synchronizing files and directories remotely and locally. 
    * Syntax: rysnc [options] source destination 
    * Options: v - verbose: Provides comment on the current operation as it occurs 
                a - achive mode: allows copying of file resursively 
3. Move & Rename /var/cache
coammnd -  mv /var/cache /var/cache.old_one
4. Remove {/var/cache.old_one} to reclaim space 
command -  rm -rf /var/cache.old_one
5. Create a new /var/cache directory 
command - mkdir -p /var/cache
6. Mount -o bind /mnt/temi_vibes/var/cache /var/cache
Bind mounts in Linux enable you to mount an already-mounted file system to another location within the file system.

