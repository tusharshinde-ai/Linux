# Linux File System

A focused and practical guide to the **Linux file system**. This document covers the Linux directory hierarchy, file systems, partitions, mount points, inodes, storage concepts, links, file metadata, and filesystem troubleshooting.

---

## Table of Contents

1. [What Is a File System?](#1-what-is-a-file-system)
2. [Linux File System Architecture](#2-linux-file-system-architecture)
3. [Root Directory `/`](#3-root-directory-)
4. [Linux Directory Hierarchy](#4-linux-directory-hierarchy)
5. [Important Linux Directories](#5-important-linux-directories)
6. [Linux Paths](#6-linux-paths)
7. [Linux File Types](#7-linux-file-types)
8. [File System vs Directory](#8-file-system-vs-directory)
9. [Storage Device, Partition, and File System](#9-storage-device-partition-and-file-system)
10. [Block Devices](#10-block-devices)
11. [Partitions](#11-partitions)
12. [File System Types](#12-file-system-types)
13. [Creating a File System](#13-creating-a-file-system)
14. [Mount Points](#14-mount-points)
15. [Mounting a File System](#15-mounting-a-file-system)
16. [Unmounting a File System](#16-unmounting-a-file-system)
17. [`/etc/fstab`](#17-etcfstab)
18. [UUID and File System Labels](#18-uuid-and-file-system-labels)
19. [Inodes](#19-inodes)
20. [Superblock](#20-superblock)
21. [Data Blocks](#21-data-blocks)
22. [File System Metadata](#22-file-system-metadata)
23. [File Timestamps](#23-file-timestamps)
24. [Hard Links](#24-hard-links)
25. [Symbolic Links](#25-symbolic-links)
26. [Hard Link vs Symbolic Link](#26-hard-link-vs-symbolic-link)
27. [Disk Space vs File System Space](#27-disk-space-vs-file-system-space)
28. [`df` Command](#28-df-command)
29. [`du` Command](#29-du-command)
30. [`lsblk` Command](#30-lsblk-command)
31. [`blkid` Command](#31-blkid-command)
32. [`findmnt` Command](#32-findmnt-command)
33. [`mount` Command](#33-mount-command)
34. [`umount` Command](#34-umount-command)
35. [`stat` Command](#35-stat-command)
36. [Finding Large Files](#36-finding-large-files)
37. [Inode Troubleshooting](#37-inode-troubleshooting)
38. [Deleted Files Still Using Disk Space](#38-deleted-files-still-using-disk-space)
39. [File System Checks](#39-file-system-checks)
40. [Read-Only File System](#40-read-only-file-system)
41. [File System Troubleshooting Workflow](#41-file-system-troubleshooting-workflow)
42. [Practical File System Lab](#42-practical-file-system-lab)
43. [Interview Questions](#43-interview-questions)
44. [Quick Reference](#44-quick-reference)
45. [Summary](#45-summary)

---

# 1. What Is a File System?

A **file system** is a method used by an operating system to organize, store, retrieve, and manage data on storage.

Examples of storage:

- HDD
- SSD
- NVMe
- USB storage
- Virtual disks
- Network storage

A file system defines how files and directories are stored and how their metadata is maintained.

Common Linux file systems include:

```text
ext4
XFS
Btrfs
tmpfs
NFS
```

Without a file system, a storage device is simply a collection of raw blocks. A file system provides the structure required to store files and directories.

---

# 2. Linux File System Architecture

Linux presents storage as a **single hierarchical directory tree**.

The top of the tree is:

```text
/
```

A simplified view:

```text
                              /
                              |
       +----------------------+----------------------+
       |          |           |          |           |
     /boot      /etc        /home       /var        /usr
       |          |           |          |            |
     Kernel   Config files  Users      Logs       Applications

       +------------------------------------------------+
       |          |          |          |        |       |
      /dev      /proc      /sys       /tmp     /mnt    /opt
       |          |          |          |        |       |
    Devices    Kernel     Hardware   Temp     Mounts   Apps
              information information
```

Unlike Windows, Linux does not normally represent each disk as a separate drive letter such as `C:` or `D:`.

Instead, additional storage is attached to directories using **mount points**.

Example:

```text
/
├── etc
├── home
├── var
└── data
      |
      └── /dev/sdb1 mounted here
```

---

# 3. Root Directory `/`

The `/` directory is the root of the Linux file system hierarchy.

Everything accessible through the normal Linux namespace starts below `/`.

Example:

```bash
cd /
ls
```

Typical directories:

```text
bin
boot
dev
etc
home
lib
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var
```

### Important distinction

```text
/       = root directory
/root   = root user's home directory
```

They are not the same thing.

---

# 4. Linux Directory Hierarchy

Linux directories have conventional purposes.

```text
/
├── bin
├── boot
├── dev
├── etc
├── home
├── lib
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin
├── srv
├── sys
├── tmp
├── usr
└── var
```

---

# 5. Important Linux Directories

## `/boot`

Contains files required for system boot.

Common contents:

```text
/boot/vmlinuz-...
/boot/initramfs-...
/boot/grub/
```

Check:

```bash
ls -lh /boot
```

A full `/boot` file system can prevent kernel updates.

---

## `/dev`

Contains device files.

Examples:

```text
/dev/sda
/dev/sda1
/dev/sdb
/dev/nvme0n1
/dev/null
/dev/zero
```

Check:

```bash
ls -l /dev
```

Block devices:

```bash
lsblk
```

---

## `/etc`

Contains system-wide configuration files.

Filesystem-related examples:

```text
/etc/fstab
/etc/mtab
```

Other configuration examples:

```text
/etc/hostname
/etc/hosts
/etc/passwd
```

For this topic, `/etc/fstab` is especially important.

---

## `/home`

Contains home directories of normal users.

Example:

```text
/home/user1
/home/user2
/home/tushar
```

---

## `/lib`

Contains libraries required by system software.

On modern distributions, `/lib` may be a symbolic link to a directory under `/usr`.

---

## `/media`

Commonly used as a mount location for removable media.

Example:

```text
/media/user/USB
```

---

## `/mnt`

Traditionally used as a temporary mount point.

Example:

```bash
sudo mount /dev/sdb1 /mnt
```

---

## `/opt`

Commonly used for optional or third-party application software.

Example:

```text
/opt/application
```

---

## `/proc`

A virtual file system containing process and kernel information.

Examples:

```bash
cat /proc/meminfo
cat /proc/cpuinfo
```

`/proc` is not a normal disk-based directory.

---

## `/root`

Home directory of the root user.

```text
/root
```

Again:

```text
/      = file system root
/root  = root user's home
```

---

## `/run`

Contains runtime data created after boot.

Examples include:

- PID information
- Runtime sockets
- Service runtime data

---

## `/sbin`

Traditionally contains system administration commands.

On many modern distributions, `/sbin` may be linked into `/usr`.

---

## `/srv`

Contains data served by system services.

For example:

```text
/srv/www
/srv/ftp
```

Its actual use depends on the system.

---

## `/sys`

A virtual file system that exposes kernel and hardware/device information.

Example:

```bash
ls /sys
```

---

## `/tmp`

Contains temporary files.

Example:

```bash
touch /tmp/test.txt
```

Temporary files may be automatically cleaned based on system configuration.

---

## `/usr`

Contains a large amount of operating system software, libraries, documentation, and utilities.

Common directories:

```text
/usr/bin
/usr/sbin
/usr/lib
/usr/share
/usr/local
```

---

## `/var`

Contains data that changes frequently.

Important file system-related areas:

```text
/var/log
/var/lib
/var/cache
/var/tmp
```

`/var/log` commonly contains log files.

---

# 6. Linux Paths

A path identifies the location of a file or directory.

## Absolute Path

An absolute path starts from `/`.

Example:

```text
/home/tushar/project/app.log
```

Another example:

```bash
cat /etc/fstab
```

---

## Relative Path

A relative path starts from the current working directory.

Example:

```text
project/app.log
```

If the current directory is:

```text
/home/tushar
```

then:

```text
project/app.log
```

refers to:

```text
/home/tushar/project/app.log
```

### Special path symbols

| Symbol | Meaning |
|---|---|
| `/` | Root directory |
| `.` | Current directory |
| `..` | Parent directory |
| `~` | Current user's home directory |

---

# 7. Linux File Types

Linux supports several types of files.

Use:

```bash
ls -l
```

Example:

```text
-rw-r--r--  file.txt
drwxr-xr-x  directory
lrwxrwxrwx  link
```

The first character indicates the type.

| Symbol | File Type |
|---|---|
| `-` | Regular file |
| `d` | Directory |
| `l` | Symbolic link |
| `b` | Block device |
| `c` | Character device |
| `s` | Socket |
| `p` | Named pipe |

---

## Regular File

Contains normal data.

Examples:

```text
file.txt
application.log
script.sh
database.db
```

---

## Directory

Contains references to files and other directories.

Example:

```text
/home
/etc
/var
```

---

## Block Device

Represents storage devices that work with blocks.

Examples:

```text
/dev/sda
/dev/sdb
/dev/nvme0n1
```

---

## Character Device

Handles data character-by-character.

Examples include:

```text
/dev/tty
/dev/random
```

---

# 8. File System vs Directory

A **directory** is part of the file system hierarchy and is used to organize file names.

A **file system** is the storage structure that manages files, directories, metadata, and data blocks.

Example:

```text
/dev/sdb1
     |
     | ext4 file system
     |
     v
/mnt/data
     |
     +-- app.log
     +-- database/
     +-- backup/
```

The directory `/mnt/data` is the **mount point**.

The ext4 structure is the **file system**.

---

# 9. Storage Device, Partition, and File System

These concepts are often confused.

Consider:

```text
Physical/Virtual Disk
        |
        v
      /dev/sdb
        |
        v
     Partition
     /dev/sdb1
        |
        v
   File System
      ext4
        |
        v
   Mount Point
    /data
        |
        v
      Files
```

### Storage Device

Example:

```text
/dev/sdb
```

### Partition

Example:

```text
/dev/sdb1
```

### File System

Example:

```text
ext4
```

### Mount Point

Example:

```text
/data
```

---

# 10. Block Devices

Linux exposes disks and partitions as block devices under `/dev`.

Examples:

```text
/dev/sda
/dev/sda1
/dev/sdb
/dev/sdb1
/dev/nvme0n1
/dev/nvme0n1p1
```

Check:

```bash
lsblk
```

Example:

```text
NAME        SIZE TYPE MOUNTPOINT
sda          50G disk
├─sda1       49G part /
└─sda2        1G part [SWAP]
sdb         100G disk
└─sdb1      100G part
```

---

# 11. Partitions

A physical or virtual disk can be divided into partitions.

Example:

```text
/dev/sda
│
├── /dev/sda1
├── /dev/sda2
└── /dev/sda3
```

Each partition can contain a different file system.

For example:

```text
/dev/sda1 -> ext4 -> /
/dev/sda2 -> ext4 -> /home
/dev/sda3 -> XFS  -> /data
```

Modern systems may use GPT partition tables, while older systems may use MBR.

Check partition information:

```bash
lsblk
```

or:

```bash
sudo fdisk -l
```

---

# 12. File System Types

## ext4

`ext4` is a widely used Linux file system.

Example:

```bash
mkfs.ext4 /dev/sdb1
```

Common characteristics:

- General-purpose Linux file system
- Journaling
- Good compatibility
- Common on Linux servers

---

## XFS

XFS is widely used in enterprise Linux environments.

Create:

```bash
mkfs.xfs /dev/sdb1
```

Common characteristics:

- Designed for large file systems
- Good scalability
- Common on enterprise Linux systems

---

## Btrfs

Btrfs is a modern Linux file system with advanced features.

Examples of features include:

- Copy-on-write
- Snapshots
- Subvolumes
- Checksums

---

## tmpfs

`tmpfs` is a temporary file system typically backed by memory and/or swap.

Example:

```bash
df -T
```

You may see:

```text
tmpfs
```

---

## NFS

NFS allows a remote file system to be mounted over a network.

Example concept:

```text
NFS Server
    |
    | Network
    v
Linux Client
    |
    v
/mnt/shared
```

---

# 13. Creating a File System

A new partition or block device normally needs a file system before it can be used for regular file storage.

Example:

```bash
sudo mkfs.ext4 /dev/sdb1
```

For XFS:

```bash
sudo mkfs.xfs /dev/sdb1
```

> **WARNING:** `mkfs` can destroy existing data on the specified device or partition. Always verify the device with `lsblk` before formatting.

Verify:

```bash
lsblk -f
```

---

# 14. Mount Points

Linux makes a file system available by attaching it to a directory called a **mount point**.

Example:

```text
/dev/sdb1
   |
   | ext4
   |
   v
/mnt/data
   |
   +-- file1.txt
   +-- file2.txt
```

Create a mount point:

```bash
sudo mkdir -p /mnt/data
```

The directory must normally exist before mounting.

---

# 15. Mounting a File System

Mount a partition:

```bash
sudo mount /dev/sdb1 /mnt/data
```

Verify:

```bash
df -h
```

or:

```bash
findmnt /mnt/data
```

Check the file system type:

```bash
df -T /mnt/data
```

---

## Mount Using UUID

Instead of:

```bash
sudo mount /dev/sdb1 /mnt/data
```

you can mount using its UUID:

```bash
sudo mount UUID=<uuid> /mnt/data
```

UUID-based configuration is commonly preferred in `/etc/fstab` because device names can change depending on the system and hardware configuration.

---

# 16. Unmounting a File System

Use:

```bash
sudo umount /mnt/data
```

You can also specify the device:

```bash
sudo umount /dev/sdb1
```

Check whether it is mounted:

```bash
findmnt /mnt/data
```

### Common error

```text
target is busy
```

This usually means a process has an open file or its current working directory is inside the mount.

Investigate:

```bash
sudo lsof +f -- /mnt/data
```

or:

```bash
sudo fuser -vm /mnt/data
```

Move your shell out of the directory:

```bash
cd /
```

Then try:

```bash
sudo umount /mnt/data
```

---

# 17. `/etc/fstab`

`/etc/fstab` contains persistent mount configuration.

View it:

```bash
cat /etc/fstab
```

Example:

```text
UUID=xxxx-xxxx  /data  ext4  defaults  0  2
```

The fields are:

```text
<device> <mount-point> <filesystem-type> <options> <dump> <fsck-order>
```

Example:

```text
UUID=1234-5678  /data  ext4  defaults  0  2
```

| Field | Meaning |
|---|---|
| UUID | File system identifier |
| `/data` | Mount point |
| `ext4` | File system type |
| `defaults` | Mount options |
| `0` | Dump setting |
| `2` | File system check order |

---

## Test `/etc/fstab`

After modifying `fstab`, test the configuration:

```bash
sudo mount -a
```

If no error is returned, the entries were generally accepted by `mount`.

Always verify:

```bash
findmnt
```

> A mistake in `/etc/fstab` can cause boot or mounting problems. Make a backup before editing production systems.

Backup:

```bash
sudo cp /etc/fstab /etc/fstab.backup
```

---

# 18. UUID and File System Labels

## UUID

UUID means **Universally Unique Identifier**.

Each file system normally has a UUID.

Check:

```bash
sudo blkid
```

Example:

```text
/dev/sdb1: UUID="abcd-1234" TYPE="ext4"
```

---

## File System Label

A file system can also have a label.

Check:

```bash
lsblk -f
```

Example:

```text
NAME   FSTYPE LABEL UUID
sdb1   ext4   DATA  abcd-1234
```

Labels and UUIDs can be used when identifying file systems.

---

# 19. Inodes

An **inode** is a data structure used by a file system to store metadata about a file.

An inode can contain information such as:

- File type
- Permissions
- Owner
- Group
- File size
- Timestamps
- Link count
- References to file data

The file name itself is associated with a directory entry that references an inode.

Check inode information:

```bash
ls -li file.txt
```

Example:

```text
123456 -rw-r--r-- 1 user user 100 file.txt
```

Here:

```text
123456
```

is the inode number.

---

# 20. Superblock

The **superblock** contains important information about a file system.

Depending on the file system, it can include information such as:

- File system type
- File system size
- Block size
- Number of blocks
- Number of inodes
- File system state
- Other file-system-specific metadata

A damaged superblock can make a file system difficult or impossible to mount.

For ext4, tools such as:

```bash
dumpe2fs
```

can display detailed file system information.

Example:

```bash
sudo dumpe2fs /dev/sdb1
```

> Use filesystem-specific tools carefully, especially on production systems.

---

# 21. Data Blocks

File systems divide storage into blocks.

Conceptually:

```text
File
 |
 +---- Metadata -> inode
 |
 +---- Data ----> data blocks
```

For example:

```text
file.txt
   |
   +--> inode
          |
          +--> block 100
          +--> block 101
          +--> block 102
```

The exact implementation differs between file systems.

---

# 22. File System Metadata

Metadata describes a file rather than being the file's normal content.

Common metadata includes:

- File size
- Owner
- Group
- Permissions
- Inode number
- Timestamps
- Link count

Check metadata:

```bash
stat file.txt
```

Example information:

```text
File: file.txt
Size: 1024
Inode: 123456
Links: 1
Access: (0644/-rw-r--r--)
Uid: (1000/user)
Gid: (1000/user)
```

---

# 23. File Timestamps

Linux files commonly expose:

### atime

Last access time.

### mtime

Last modification time of file contents.

### ctime

Last change to file metadata/inode information.

Check:

```bash
stat file.txt
```

Example:

```text
Access: 2026-09-07
Modify: 2026-09-07
Change: 2026-09-07
```

> `ctime` is **not necessarily file creation time**. Creation/birth time support depends on the file system and tools.

---

# 24. Hard Links

A hard link is another directory entry referring to the same inode.

Create:

```bash
touch original.txt
ln original.txt hardlink.txt
```

Check:

```bash
ls -li original.txt hardlink.txt
```

The inode numbers should be the same.

Conceptually:

```text
original.txt ----+
                 |
                 v
               inode
                 |
                 v
             data blocks
                 ^
                 |
hardlink.txt ----+
```

Removing one name does not remove the data while another hard link still references the inode.

---

# 25. Symbolic Links

A symbolic link stores a reference to another path.

Create:

```bash
ln -s original.txt symlink.txt
```

Check:

```bash
ls -l symlink.txt
```

Example:

```text
symlink.txt -> original.txt
```

Conceptually:

```text
symlink.txt
     |
     v
original.txt
     |
     v
   inode
     |
     v
 data blocks
```

If the target is removed, the symbolic link may become broken.

---

# 26. Hard Link vs Symbolic Link

| Feature | Hard Link | Symbolic Link |
|---|---|---|
| References | Same inode | Path/name |
| Same inode as target | Yes | No |
| Cross file systems | Normally no | Yes |
| Can normally link directories | No | Yes |
| Target removed | Other hard link still works | Link may become broken |
| Created with | `ln` | `ln -s` |

---

# 27. Disk Space vs File System Space

There are two different concepts administrators must understand:

### Disk/device capacity

The total capacity of a disk or partition.

### File system usage

How much of the file system's available space is being consumed.

Example:

```text
Disk/Partition
+--------------------------------------+
|              100 GB                  |
+--------------------------------------+

File System
+--------------------------------------+
| Used 70 GB | Free 30 GB              |
+--------------------------------------+
```

Check file system usage:

```bash
df -h
```

---

# 28. `df` Command

`df` reports free and used space on mounted file systems.

Use:

```bash
df -h
```

Example:

```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   35G   15G  70% /
/dev/sdb1       100G   60G   40G  60% /data
```

### Important options

Human-readable:

```bash
df -h
```

Show file system type:

```bash
df -T
```

Check a particular mount:

```bash
df -h /data
```

Check inode usage:

```bash
df -i
```

---

# 29. `du` Command

`du` estimates space used by files and directories.

Current directory:

```bash
du -sh .
```

Specific directory:

```bash
du -sh /var
```

Immediate subdirectories:

```bash
du -h --max-depth=1 /var
```

Sort by size:

```bash
du -xh --max-depth=1 /var | sort -h
```

### `df` vs `du`

```text
df
 |
 +--> File system level usage

du
 |
 +--> Files/directories consuming space
```

---

# 30. `lsblk` Command

`lsblk` lists block devices.

Basic:

```bash
lsblk
```

With file system information:

```bash
lsblk -f
```

Example:

```text
NAME   FSTYPE LABEL UUID      MOUNTPOINT
sda
├─sda1 ext4         xxxx      /
└─sda2 swap         yyyy      [SWAP]
sdb
└─sdb1 xfs          DATA      zzzz      /data
```

This is one of the most useful commands for storage troubleshooting.

---

# 31. `blkid` Command

`blkid` displays block-device attributes.

```bash
sudo blkid
```

Example:

```text
/dev/sda1: UUID="xxxx" TYPE="ext4"
/dev/sdb1: UUID="yyyy" TYPE="xfs"
```

Useful for:

- UUID identification
- File system type
- Labels

---

# 32. `findmnt` Command

`findmnt` displays mounted file systems.

Run:

```bash
findmnt
```

Check a specific mount:

```bash
findmnt /data
```

Check a device:

```bash
findmnt /dev/sdb1
```

This is often easier to read than raw `mount` output.

---

# 33. `mount` Command

List mounts:

```bash
mount
```

Mount a file system:

```bash
sudo mount /dev/sdb1 /data
```

Mount using `/etc/fstab`:

```bash
sudo mount /data
```

After mounting:

```bash
findmnt /data
```

---

# 34. `umount` Command

Unmount a file system:

```bash
sudo umount /data
```

or:

```bash
sudo umount /dev/sdb1
```

If it reports:

```text
target is busy
```

check:

```bash
sudo lsof +f -- /data
```

or:

```bash
sudo fuser -vm /data
```

Then stop/move the responsible process if appropriate.

---

# 35. `stat` Command

`stat` displays detailed information about a file.

```bash
stat file.txt
```

Useful information:

```text
File
Size
Blocks
IO Block
Inode
Links
Access
Modify
Change
Birth
```

The availability of `Birth` depends on the file system and platform.

---

# 36. Finding Large Files

A common filesystem administration problem is:

```text
No space left on device
```

Start with:

```bash
df -h
```

Find large directories:

```bash
sudo du -xhd1 / | sort -h
```

Investigate the largest directory.

For example:

```bash
sudo du -xhd1 /var | sort -h
```

Find files larger than 500 MB:

```bash
sudo find /var -xdev -type f -size +500M -ls
```

Find files larger than 1 GB:

```bash
sudo find /var -xdev -type f -size +1G -ls
```

---

# 37. Inode Troubleshooting

Sometimes:

```bash
df -h
```

shows plenty of free space, but applications cannot create files.

Example:

```text
Filesystem      Size  Used Avail Use%
/dev/sda1        50G   20G   30G  40%
```

But:

```bash
df -i
```

shows:

```text
Filesystem      Inodes  IUsed  IFree IUse%
/dev/sda1       1000000 1000000 0     100%
```

The file system has run out of inodes.

This commonly happens when there are huge numbers of small files.

Find file counts:

```bash
find /var -xdev -type f | wc -l
```

Investigate directories with many files:

```bash
find /var -xdev -type f | cut -d/ -f1-4 | sort | uniq -c | sort -nr | head
```

---

# 38. Deleted Files Still Using Disk Space

A common Linux filesystem troubleshooting scenario:

```text
df -h
```

shows high disk usage, but:

```bash
du -sh /*
```

does not explain the usage.

A process may still have a deleted file open.

Check:

```bash
sudo lsof +L1
```

Example concept:

```text
application
    |
    +--> deleted log file
             |
             +--> disk blocks still allocated
```

The space is normally released after the process closes the file.

Depending on the application, restarting the process may release the space.

---

# 39. File System Checks

Linux provides file-system-specific checking tools.

For ext2/ext3/ext4:

```bash
fsck.ext4
```

or:

```bash
e2fsck
```

For XFS, use the appropriate XFS tools such as:

```bash
xfs_repair
```

> **Important:** Do not run repair tools casually on a mounted production file system. Follow the file-system-specific documentation and ensure the file system is in an appropriate state before repair.

---

# 40. Read-Only File System

Sometimes Linux reports:

```text
Read-only file system
```

Possible causes include:

- File system errors
- Storage/device problems
- Kernel protection after detecting corruption
- Intentional read-only mounting
- Mount options

Check:

```bash
findmnt /
```

Look for mount options:

```bash
findmnt -no TARGET,FSTYPE,OPTIONS /
```

Check kernel messages:

```bash
dmesg | tail -50
```

On systemd-based systems:

```bash
journalctl -k
```

Do not immediately remount read-write without understanding why the file system became read-only.

---

# 41. File System Troubleshooting Workflow

Use the following workflow when a server reports disk-space problems.

## Step 1 — Check mounted file systems

```bash
df -hT
```

---

## Step 2 — Check inode usage

```bash
df -i
```

---

## Step 3 — Identify the affected mount point

Example:

```text
/dev/sda1  50G  48G  2G  96% /
```

Affected mount:

```text
/
```

---

## Step 4 — Find large directories

```bash
sudo du -xhd1 / | sort -h
```

---

## Step 5 — Investigate the largest directory

For example:

```bash
sudo du -xhd1 /var | sort -h
```

---

## Step 6 — Find large files

```bash
sudo find /var -xdev -type f -size +500M -ls
```

---

## Step 7 — Check deleted-but-open files

```bash
sudo lsof +L1
```

---

## Step 8 — Check mount status

```bash
findmnt
```

---

## Step 9 — Check kernel/storage errors

```bash
dmesg | tail -100
```

or:

```bash
journalctl -k -n 100
```

---

# 42. Practical File System Lab

This lab demonstrates the basic storage → file system → mount point relationship.

## Lab Objective

Create a practice file system, mount it, create files, inspect it, and unmount it.

> Use a test VM and an empty disk/partition. **Do not run formatting commands against a production disk.**

---

## Step 1 — Identify disks

```bash
lsblk
```

Example:

```text
sda    50G
sdb   100G
```

Assume the test disk is:

```text
/dev/sdb
```

---

## Step 2 — Inspect the device

```bash
sudo fdisk -l /dev/sdb
```

---

## Step 3 — Create a partition

On a disposable test disk, use your preferred partitioning tool.

For example:

```bash
sudo fdisk /dev/sdb
```

Then create a Linux partition.

Afterward:

```bash
lsblk
```

Assume the new partition is:

```text
/dev/sdb1
```

---

## Step 4 — Create an ext4 file system

```bash
sudo mkfs.ext4 /dev/sdb1
```

Verify:

```bash
lsblk -f
```

---

## Step 5 — Create a mount point

```bash
sudo mkdir -p /data
```

---

## Step 6 — Mount the file system

```bash
sudo mount /dev/sdb1 /data
```

Verify:

```bash
findmnt /data
```

---

## Step 7 — Check disk usage

```bash
df -hT /data
```

---

## Step 8 — Create test data

```bash
sudo touch /data/file1.txt
sudo mkdir /data/logs
sudo touch /data/logs/app.log
```

Add data:

```bash
echo "Linux filesystem lab" | sudo tee /data/file1.txt
```

---

## Step 9 — Inspect the file system

```bash
ls -lah /data
```

Check inode numbers:

```bash
ls -li /data/file1.txt
```

Check metadata:

```bash
stat /data/file1.txt
```

---

## Step 10 — Check UUID

```bash
sudo blkid /dev/sdb1
```

or:

```bash
lsblk -f
```

---

## Step 11 — Unmount

First leave the mount point:

```bash
cd /
```

Then:

```bash
sudo umount /data
```

Verify:

```bash
findmnt /data
```

---

# 43. Interview Questions

## Q1. What is a Linux file system?

A Linux file system is the structure and set of rules used to organize, store, locate, and manage files and directories on storage.

---

## Q2. What is the root of the Linux file system?

```text
/
```

It is the top-level directory of the Linux file-system hierarchy.

---

## Q3. What is the difference between `/` and `/root`?

```text
/      = root of the file system
/root  = home directory of the root user
```

---

## Q4. What is a mount point?

A mount point is a directory where a file system is attached to the Linux directory tree.

Example:

```text
/dev/sdb1 -> /data
```

---

## Q5. What is the difference between a disk and a partition?

A disk is the storage device. A partition is a logical section of that disk.

Example:

```text
/dev/sdb       -> disk
/dev/sdb1      -> partition
```

---

## Q6. What is a file system?

A file system organizes data, files, directories, metadata, and storage blocks on a device or logical storage area.

---

## Q7. What is an inode?

An inode stores metadata and references associated with a file, such as permissions, ownership, timestamps, size, and data-block references.

---

## Q8. What is a superblock?

A superblock contains important metadata describing a file system, such as its size, block information, inode information, and state.

---

## Q9. What is the difference between `df` and `du`?

```text
df -> file system-level space usage
du -> files/directories consuming space
```

---

## Q10. How do you check file system type?

```bash
df -T
```

or:

```bash
lsblk -f
```

---

## Q11. How do you check UUID?

```bash
blkid
```

or:

```bash
lsblk -f
```

---

## Q12. How do you mount a file system?

```bash
sudo mount /dev/sdb1 /data
```

---

## Q13. How do you unmount a file system?

```bash
sudo umount /data
```

---

## Q14. What is `/etc/fstab`?

It is the configuration file used for persistent file-system mounts.

---

## Q15. Why use UUID in `/etc/fstab`?

UUID provides a stable identifier for a file system and avoids relying only on device names such as `/dev/sdb1`.

---

## Q16. Can a file system have free disk space but still fail to create files?

Yes. It may have exhausted its inodes.

Check:

```bash
df -i
```

---

## Q17. Why can `df` and `du` show different usage?

Possible reasons include:

- Deleted files still held open by processes
- Different mount points
- Files hidden underneath another mounted file system
- File-system metadata/reserved space
- Differences in what each command measures

A useful check for deleted open files:

```bash
sudo lsof +L1
```

---

## Q18. What does "target is busy" mean during `umount`?

It generally means a process is using the mount point, such as having an open file or current working directory there.

Check:

```bash
sudo lsof +f -- /data
```

---

## Q19. What is the difference between ext4 and XFS?

Both are Linux file systems, but they have different architectures and features. ext4 is a general-purpose, widely supported Linux file system, while XFS is designed with strong scalability and is widely used in enterprise environments.

---

## Q20. What is the difference between a hard link and symbolic link?

A hard link references the same inode. A symbolic link references another path.

---

# 44. Quick Reference

| Requirement | Command |
|---|---|
| List block devices | `lsblk` |
| List block devices + filesystem | `lsblk -f` |
| Show UUID | `blkid` |
| Show mounted filesystems | `findmnt` |
| Show disk usage | `df -h` |
| Show filesystem type | `df -T` |
| Show inode usage | `df -i` |
| Directory disk usage | `du -sh DIR` |
| Find large files | `find ... -size +500M` |
| Mount filesystem | `mount` |
| Unmount filesystem | `umount` |
| File metadata | `stat` |
| File/inode number | `ls -li` |
| Filesystem config | `/etc/fstab` |
| Format ext4 | `mkfs.ext4` |
| Format XFS | `mkfs.xfs` |
| Check ext filesystem | `fsck.ext4` / `e2fsck` |
| Repair XFS | `xfs_repair` |
| Check open deleted files | `lsof +L1` |

---

# 45. Summary

The Linux file system is a hierarchical structure beginning at:

```text
/
```

The most important concepts are:

```text
Storage Device
      |
      v
   Partition
      |
      v
  File System
      |
      v
  Mount Point
      |
      v
Files / Directories
```

For example:

```text
/dev/sdb
   |
   +-- /dev/sdb1
          |
          +-- ext4
                |
                +-- /data
                      |
                      +-- application.log
                      +-- backup/
                      +-- database/
```

For Linux system administration and DevOps, the most important file-system commands to master are:

```bash
lsblk
blkid
findmnt
df
du
mount
umount
stat
find
ls -li
```

And the most important concepts to understand are:

```text
Root directory
Directory hierarchy
Paths
File types
Block devices
Partitions
File systems
Mount points
/etc/fstab
UUID
Inodes
Superblock
Data blocks
Metadata
Hard links
Symbolic links
Disk usage
Inode usage
Filesystem troubleshooting
```

Once these concepts are clear, the next logical storage topics are:

```text
Linux File System
       |
       +-- Partitions
       |
       +-- Filesystem Types
       |
       +-- Mounting
       |
       +-- /etc/fstab
       |
       +-- Inodes
       |
       +-- Filesystem Troubleshooting
       |
       +-- LVM
       |
       +-- RAID
       |
       +-- Disk Expansion
```

This document intentionally focuses on **Linux file-system and storage concepts**, rather than general Linux administration.

