## Archive/Compress Files & Directories
* File archiving tool is used to set of files into a single standalone file 
* The command (tar) is the most used archiving utility tool used in linux. 

# Tar 
-Use to bundle group of files togehter into a single archive called (TAR FILE of TARBALL)

Syntax: tar [options] [pathname ...]

# Opions: 
    c - Create a tar achieve
    A - Concatenate        Appends tar files to an archive
    R –append              Appends files to the end of an archive
    U –update              Appends files newer than copy in archive
    d- –diff or –compare	Find differences between archive and file system
    f –file archive	    use archive file or device ARCHIVE
    t –list	 	        Lists the contents of a tarball
    x –extract or –get	    Extracts files from an archive
    v-                     Shows the operation of command and how its running. 

# Normally used operation modifiers
    C –directory dir	     C	 Changes to directory dir before performing operations
    p –same-permissions	 p	 Preserves original permissions
    v–verbose	             v	 Lists all files read or extracted. When this flag is used along with –list, the file sizes, ownership, and time stamps are displayed.
    w –verify	             W	 Verifies the archive after writing it
    - –exclude file	     —	 Excludes file from the archive
    X –exclude=pattern	     X	 Exclude files, given as a PATTERN
    z –gzip or –gunzip	     z	 Processes an archive through gzip
    j –bzip2	             j	 Processes an archive through bzip2
    J –xz	                 J	 Processes an archive through xz

# Gzip is the oldest compression tool, but provides the least compression.
# bzip2 provides improved compression.
# xz is the newest that provides the best compression. 
    
# Note- Tar files compressed with theses utilites have 
`     .gz
        .bz2 or .xz

# Create a Tarball
1. To create a backup file 
    # Syntax: tar -(options) [Backupfile.tar.gz] [Original-file] 
        tar -czf Tar-dir-backup.tar.gz Tar-dir

2. Create and add a file to a New Tarball
    # Syntax: tar -(options) [New-Tarfile] [File added to the Tarfile]
        tar -czf myfiles.tar.gz file8 -- [gzip compression tool]
        tar -cjf myfiles.tar.bz2 file8 -- [bzip2 compression tool must be installed]
        tar -cjf myfiles.tar.xz file8  -- [xz compression tool]

3. List the content of a tarball
    tar tvf [tarball or tarfile]
4. Delete and Update/Append file inside the tarball 
    # Note: To update/append a tar file, the tarfile or tarball has to uncompressed

    To Uncompress tarfile 
      #  gzip -d myfiles.tar.gz	
      #  bzip2 -d myfiles.tar.bz2	
      #  xz -d myfiles.tar.xz

# When you uncompress a tarfile it removes the compression at the end.
        E.g: Uncompressed myfiles.tar.gz turns to myfiles.tar 
    
    Delete file in tarball:
        tar --delete --file myfiles.tar file8
    
    Update tarball with a new file:
        tar --update --file myfiles.tar file9
# After deleteing or updating a tarfile/tarball, it has to be compressed back 
    
    To Compress tarfile 
      # gzip myfiles.tar	
      # bzip2 myfiles.tar		
      # xz myfiles.tar

List the tarfile/tarball to check for update
    tar -tvf [tarball]

## Link to website: https://www.tecmint.com/compress-files-and-finding-files-in-linux/