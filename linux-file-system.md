# Linux File System

A beginner-friendly and practical guide to understanding the Linux file system, directories, file types, permissions, disk usage, mounting, and common administration commands.

---

## Table of Contents

1. [What is a Linux File System?](#what-is-a-linux-file-system)
2. [Linux File System Hierarchy](#linux-file-system-hierarchy)
3. [Important Linux Directories](#important-linux-directories)
4. [Understanding the Root Directory](#understanding-the-root-directory)
5. [Linux File Types](#linux-file-types)
6. [Absolute and Relative Paths](#absolute-and-relative-paths)
7. [Basic File and Directory Commands](#basic-file-and-directory-commands)
8. [File Permissions](#file-permissions)
9. [Ownership](#ownership)
10. [Disk and File System Management](#disk-and-file-system-management)
11. [Mounting and Unmounting](#mounting-and-unmounting)
12. [The `/etc/fstab` File](#the-etcfstab-file)
13. [Inodes](#inodes)
14. [Links](#links)
15. [Special File Systems](#special-file-systems)
16. [Finding Files and Disk Usage](#finding-files-and-disk-usage)
17. [Important Troubleshooting Commands](#important-troubleshooting-commands)
18. [Practical Linux File System Lab](#practical-linux-file-system-lab)
19. [Common Interview Questions](#common-interview-questions)
20. [Quick Command Cheat Sheet](#quick-command-cheat-sheet)

---

## What is a Linux File System?

A **file system** is the method Linux uses to organize, store, access, and manage files and directories on storage devices.

Linux treats almost everything as a file. This includes:

- Regular files
- Directories
- Devices
- Sockets
- Named pipes
- Symbolic links
- Virtual kernel information

The Linux file system is organized as a **hierarchical tree**.

The top of the tree is:

```text
/
```

This is called the **root directory**.

A simplified structure looks like this:

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

# Linux File System Hierarchy

Linux follows a standard directory structure. Each directory has a specific purpose.

| Directory | Purpose |
|---|---|
| `/` | Root of the complete file system |
| `/bin` | Essential user commands |
| `/boot` | Bootloader and kernel files |
| `/dev` | Device files |
| `/etc` | System configuration |
| `/home` | Normal users' home directories |
| `/lib` | Essential shared libraries |
| `/media` | Mount point for removable media |
| `/mnt` | Temporary mount point |
| `/opt` | Optional/third-party software |
| `/proc` | Process and kernel information |
| `/root` | Home directory of root user |
| `/run` | Runtime process information |
| `/sbin` | System administration commands |
| `/srv` | Data provided by services |
| `/sys` | Kernel and hardware information |
| `/tmp` | Temporary files |
| `/usr` | Applications, libraries, and documentation |
| `/var` | Variable data such as logs and cache |

> Note: On many modern Linux distributions, `/bin`, `/sbin`, and `/lib` may be symbolic links into `/usr`. The traditional meanings remain useful for understanding the hierarchy.

---

# Important Linux Directories

## 1. `/` — Root Directory

`/` is the starting point of the Linux file system.

Everything is located below `/`.

Example:

```bash
cd /
ls
```

You may see:

```text
bin  boot  dev  etc  home  lib  media  mnt  opt  proc
root  run  sbin  srv  sys  tmp  usr  var
```

Do not confuse:

- `/` → root directory
- `root` → root user's home directory

---

## 2. `/home` — User Home Directories

Normal users usually have their personal directories under `/home`.

Example:

```text
/home/tushar
/home/ubuntu
/home/user1
```

Check:

```bash
ls -l /home
```

Go to your home directory:

```bash
cd ~
```

or:

```bash
cd $HOME
```

The `~` symbol represents the current user's home directory.

---

## 3. `/root` — Root User's Home

`/root` is the home directory of the `root` user.

```bash
ls -ld /root
```

A normal user may not be able to access it.

Important distinction:

```text
/       = root of file system
/root   = root user's home directory
```

---

## 4. `/etc` — Configuration Files

`/etc` contains system-wide configuration files.

Examples:

```text
/etc/passwd
/etc/shadow
/etc/hosts
/etc/fstab
/etc/hostname
/etc/ssh/
/etc/systemd/
```

View the hostname:

```bash
cat /etc/hostname
```

View hosts configuration:

```bash
cat /etc/hosts
```

List SSH configuration:

```bash
ls -l /etc/ssh
```

### Important `/etc` files

| File | Purpose |
|---|---|
| `/etc/passwd` | User account information |
| `/etc/shadow` | Password hashes and password aging information |
| `/etc/group` | Group information |
| `/etc/hosts` | Local hostname-to-IP mappings |
| `/etc/hostname` | System hostname |
| `/etc/fstab` | File systems mounted during boot |
| `/etc/resolv.conf` | DNS resolver configuration |

---

## 5. `/var` — Variable Data

`/var` contains data that changes frequently while the system operates.

Common directories:

```text
/var/log
/var/cache
/var/lib
/var/tmp
/spool
```

### `/var/log`

Stores system and application logs.

Examples:

```bash
ls -lh /var/log
```

On systems using systemd:

```bash
journalctl
```

Check the size of logs:

```bash
du -sh /var/log
```

A full `/var` partition can cause applications or services to fail.

---

## 6. `/tmp` — Temporary Files

`/tmp` is used for temporary data.

Example:

```bash
cd /tmp
touch test.txt
ls -l test.txt
```

Temporary files may be automatically removed depending on the Linux distribution and cleanup configuration.

For temporary files that should survive reboot more reliably, `/var/tmp` is commonly used.

---

## 7. `/boot` — Boot Files

`/boot` contains files required during system startup.

Examples can include:

```text
vmlinuz-...
initramfs-...
grub/
```

Check:

```bash
ls -lh /boot
```

The Linux kernel is commonly stored here.

If `/boot` becomes full, kernel updates can fail.

---

## 8. `/dev` — Device Files

Linux represents hardware and virtual devices using files under `/dev`.

Examples:

```text
/dev/sda
/dev/sda1
/dev/nvme0n1
/dev/null
/dev/zero
/dev/random
/dev/tty
```

Check block devices:

```bash
lsblk
```

Example:

```text
NAME        SIZE TYPE MOUNTPOINT
sda          20G disk
├─sda1       19G part /
└─sda2        1G part [SWAP]
```

### Common special devices

`/dev/null`

Discards data:

```bash
echo "hello" > /dev/null
```

`/dev/zero`

Provides zero bytes:

```bash
head -c 10 /dev/zero | od -An -t x1
```

---

## 9. `/proc` — Process and Kernel Information

`/proc` is a virtual file system provided by the Linux kernel.

It does not behave like a normal disk directory.

Examples:

```bash
cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/uptime
cat /proc/version
```

Process information is exposed using directories named after process IDs.

For example:

```text
/proc/1
/proc/100
/proc/1234
```

Check running process information:

```bash
ps aux
```

---

## 10. `/sys` — Hardware and Kernel Information

`/sys` is another virtual file system that exposes information about devices, drivers, and the kernel.

Example:

```bash
ls /sys
```

Useful for understanding:

- Hardware devices
- Kernel drivers
- Device attributes
- CPU information
- Block devices

---

## 11. `/usr` — User Applications and Data

`/usr` contains a large portion of installed operating system software.

Common directories:

```text
/usr/bin
/usr/sbin
/usr/lib
/usr/local
/usr/share
```

Examples:

```bash
ls /usr/bin
ls /usr/local
```

`/usr/local` is commonly used for software installed manually by administrators.

---

## 12. `/opt` — Optional Software

`/opt` is commonly used for third-party or optional applications.

Example:

```text
/opt/application
/opt/oracle
/opt/custom-app
```

---

## 13. `/media` — Removable Media

Modern Linux systems commonly use `/media` for automatically mounted removable devices.

Examples:

```text
/media/user/USB
/media/user/CDROM
```

---

## 14. `/mnt` — Temporary Mount Point

`/mnt` is commonly used by administrators as a temporary mount point.

Example:

```bash
sudo mount /dev/sdb1 /mnt
```

---

## 15. `/run` — Runtime Data

`/run` contains runtime information created after the system boots.

Examples include:

- PID files
- Unix sockets
- Service runtime information

Check:

```bash
ls -lah /run
```

---

## 16. `/srv` — Service Data

`/srv` can contain data provided by system services.

For example:

```text
/srv/www
/srv/ftp
```

Its exact usage depends on the application and administrator.

---

# Linux File Types

Use:

```bash
ls -l
```

Example:

```text
-rw-r--r-- 1 user user 1024 Sep  7 10:00 file.txt
drwxr-xr-x 2 user user 4096 Sep  7 10:01 mydir
lrwxrwxrwx 1 user user   12 Sep  7 10:02 link -> file.txt
```

The first character identifies the file type.

| Symbol | Type |
|---|---|
| `-` | Regular file |
| `d` | Directory |
| `l` | Symbolic link |
| `c` | Character device |
| `b` | Block device |
| `s` | Socket |
| `p` | Named pipe/FIFO |

---

# Regular Files

Regular files contain normal data.

Examples:

```text
file.txt
script.sh
config.conf
application.log
image.jpg
```

Create one:

```bash
touch file.txt
```

---

# Directories

Directories organize files and other directories.

Create:

```bash
mkdir mydir
```

Nested directories:

```bash
mkdir -p project/logs/archive
```

---

# Symbolic Links

A symbolic link points to another file or directory.

Create:

```bash
ln -s /var/log/app.log app.log
```

Check:

```bash
ls -l app.log
```

Example:

```text
app.log -> /var/log/app.log
```

---

# Absolute and Relative Paths

## Absolute Path

An absolute path starts from `/`.

Example:

```text
/home/tushar/project/file.txt
```

It always identifies the location from the root.

Example:

```bash
cat /etc/hosts
```

---

## Relative Path

A relative path starts from the current directory.

Example:

```text
project/file.txt
```

If you are already inside `/home/tushar`, then:

```bash
cat project/file.txt
```

---

## Special Path Symbols

| Symbol | Meaning |
|---|---|
| `/` | Root directory |
| `.` | Current directory |
| `..` | Parent directory |
| `~` | Current user's home directory |
| `-` | Previous working directory in commands such as `cd -` |

Examples:

```bash
pwd
cd .
cd ..
cd ~
cd -
```

---

# Basic File and Directory Commands

## `pwd`

Shows the current working directory.

```bash
pwd
```

Example:

```text
/home/tushar
```

---

## `ls`

Lists files and directories.

```bash
ls
```

Detailed listing:

```bash
ls -l
```

Show hidden files:

```bash
ls -la
```

Human-readable file sizes:

```bash
ls -lh
```

---

## `cd`

Changes the current directory.

```bash
cd /etc
```

Go to parent:

```bash
cd ..
```

Go home:

```bash
cd ~
```

---

## `mkdir`

Creates directories.

```bash
mkdir test
```

Create nested directories:

```bash
mkdir -p project/app/logs
```

---

## `touch`

Creates an empty file or updates its timestamp.

```bash
touch test.txt
```

---

## `cp`

Copies files or directories.

File:

```bash
cp file.txt backup.txt
```

Directory:

```bash
cp -r project project_backup
```

---

## `mv`

Moves or renames files.

Rename:

```bash
mv old.txt new.txt
```

Move:

```bash
mv new.txt /tmp/
```

---

## `rm`

Removes files.

```bash
rm file.txt
```

Remove an empty directory:

```bash
rmdir test
```

Remove a directory and its contents:

```bash
rm -r project
```

> Be very careful with `rm -rf`. It can permanently delete large amounts of data.

---

## `cat`

Displays file contents.

```bash
cat /etc/hostname
```

---

## `less`

Useful for reading large files.

```bash
less /var/log/syslog
```

Exit with:

```text
q
```

---

## `head`

Displays the beginning of a file.

```bash
head file.txt
```

First 20 lines:

```bash
head -n 20 file.txt
```

---

## `tail`

Displays the end of a file.

```bash
tail file.txt
```

Follow a log file:

```bash
tail -f /var/log/application.log
```

---

# File Permissions

Linux uses permissions to control access to files and directories.

Example:

```text
-rwxr-xr--
```

This can be divided into:

```text
-   rwx   r-x   r--
    |     |     |
    |     |     └── Others
    |     └──────── Group
    └────────────── Owner
```

Permissions:

| Permission | Symbol | Numeric value |
|---|---|---:|
| Read | `r` | 4 |
| Write | `w` | 2 |
| Execute | `x` | 1 |
| No permission | `-` | 0 |

---

## Permission Example

```text
-rwxr-xr--
```

Owner:

```text
rwx = 4 + 2 + 1 = 7
```

Group:

```text
r-x = 4 + 0 + 1 = 5
```

Others:

```text
r-- = 4 + 0 + 0 = 4
```

Therefore:

```text
754
```

---

## `chmod`

Changes permissions.

Example:

```bash
chmod 755 script.sh
```

Equivalent symbolic form:

```bash
chmod u=rwx,g=rx,o=rx script.sh
```

Make a script executable:

```bash
chmod +x script.sh
```

---

# Ownership

Each file normally has:

- Owner
- Group

Check:

```bash
ls -l file.txt
```

Example:

```text
-rw-r--r-- 1 tushar developers 1200 Sep 7 10:00 file.txt
```

Here:

```text
Owner = tushar
Group = developers
```

---

## `chown`

Changes ownership.

```bash
sudo chown user file.txt
```

Change owner and group:

```bash
sudo chown user:developers file.txt
```

Recursive:

```bash
sudo chown -R user:developers /opt/application
```

Use recursive ownership changes carefully.

---

## `chgrp`

Changes group ownership.

```bash
sudo chgrp developers file.txt
```

---

# Disk and File System Management

## `df`

Displays free and used disk space for mounted file systems.

```bash
df -h
```

Example:

```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        20G   12G  7.0G  64% /
```

Important columns:

| Column | Meaning |
|---|---|
| Filesystem | Storage device/file system |
| Size | Total size |
| Used | Used space |
| Avail | Available space |
| Use% | Percentage used |
| Mounted on | Mount point |

---

## `du`

Shows disk usage of files and directories.

Check current directory:

```bash
du -sh .
```

Check `/var`:

```bash
du -sh /var
```

Show sizes of immediate subdirectories:

```bash
du -h --max-depth=1 /var
```

---

## `lsblk`

Lists block devices.

```bash
lsblk
```

More details:

```bash
lsblk -f
```

The `-f` option displays file system information such as:

- File system type
- UUID
- Mount point

---

## `blkid`

Displays block device attributes.

```bash
sudo blkid
```

Example:

```text
/dev/sda1: UUID="xxxx-xxxx" TYPE="ext4"
```

---

# Mounting and Unmounting

A storage device becomes accessible through a **mount point**.

Example:

```text
/dev/sdb1
    |
    | mount
    v
/mnt/data
```

Create mount point:

```bash
sudo mkdir -p /mnt/data
```

Mount:

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

Unmount:

```bash
sudo umount /mnt/data
```

> You must use `umount`, not `unmount`.

---

# The `/etc/fstab` File

`/etc/fstab` defines file systems that Linux can mount automatically, commonly during boot.

View it:

```bash
cat /etc/fstab
```

A typical entry looks like:

```text
UUID=xxxx-xxxx  /mnt/data  ext4  defaults  0  2
```

Meaning:

| Field | Meaning |
|---|---|
| `UUID=...` | Device/file system identifier |
| `/mnt/data` | Mount point |
| `ext4` | File system type |
| `defaults` | Mount options |
| `0` | Dump setting |
| `2` | File system check order |

After modifying `/etc/fstab`, test it carefully:

```bash
sudo mount -a
```

If there is a configuration error, fix it before rebooting.

---

# Inodes

An **inode** stores metadata about a file.

An inode can contain information such as:

- File type
- Permissions
- Owner
- Group
- File size
- Timestamps
- Pointers to file data

The filename itself is stored in a directory entry that points to the inode.

Check inode usage:

```bash
df -i
```

---

## Why Inodes Matter

A file system can have free disk space but still fail to create new files if all inodes are consumed.

Example:

```text
Disk usage:   40%
Inode usage: 100%
```

In this situation, creating new files may fail.

Find directories containing many files:

```bash
find /var -xdev -type f | cut -d/ -f1-4 | sort | uniq -c | sort -nr | head
```

---

# Links

Linux supports two major types of links:

1. Hard links
2. Symbolic links

---

## Hard Link

Create:

```bash
ln original.txt hardlink.txt
```

Both names refer to the same inode.

Check inode numbers:

```bash
ls -li original.txt hardlink.txt
```

---

## Symbolic Link

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

### Hard Link vs Symbolic Link

| Feature | Hard Link | Symbolic Link |
|---|---|---|
| Points to | Inode | Path/name |
| Different filesystem | Usually no | Yes |
| Can link directories | Normally no | Yes |
| Breaks if target name is removed | No | Yes |
| Same inode as target | Yes | No |

---

# Special File Systems

Linux includes several virtual or special file systems.

## `/proc`

Provides process and kernel information.

```bash
cat /proc/meminfo
```

## `/sys`

Provides device and kernel information.

```bash
ls /sys/class
```

## `/dev`

Provides device nodes.

```bash
ls /dev
```

## `tmpfs`

A temporary file system generally stored in memory and/or swap.

Check mounted file systems:

```bash
findmnt
```

---

# Finding Files and Disk Usage

## `find`

Find files based on different conditions.

Find a file by name:

```bash
find /home -name "test.txt"
```

Find all `.log` files:

```bash
find /var/log -name "*.log"
```

Find files larger than 100 MB:

```bash
find /var -type f -size +100M
```

Find files modified within the last day:

```bash
find /tmp -type f -mtime -1
```

Find files owned by a user:

```bash
find /home -user tushar
```

---

## `locate`

`locate` searches an indexed database.

```bash
locate nginx.conf
```

The database may need updating:

```bash
sudo updatedb
```

`locate` is usually faster than `find`, but its database may not immediately reflect newly created files.

---

# File Information

## `file`

Identifies the type of a file.

```bash
file script.sh
```

Example:

```text
script.sh: Bourne-Again shell script
```

---

## `stat`

Displays detailed file information.

```bash
stat file.txt
```

Information includes:

- Size
- Inode
- Permissions
- Owner
- Access time
- Modify time
- Change time

---

# Timestamps

Linux files commonly have three important timestamps.

| Timestamp | Meaning |
|---|---|
| atime | Last access time |
| mtime | Last modification of file contents |
| ctime | Last change to file metadata/inode information |

Check them:

```bash
stat file.txt
```

Important:

**ctime does not mean creation time.**

Some Linux file systems support a birth/creation time, but availability depends on the file system and tools.

---

# File System Types

Linux supports many file system types.

Common examples:

| File System | Typical Use |
|---|---|
| ext4 | General-purpose Linux file system |
| XFS | Enterprise/server workloads |
| Btrfs | Advanced Linux file system with features such as snapshots |
| tmpfs | Temporary memory-backed storage |
| NFS | Network file system |
| CIFS/SMB | Windows-compatible network shares |

Check the file system type:

```bash
df -T
```

or:

```bash
lsblk -f
```

---

# File System Troubleshooting

When a Linux server reports low disk space, follow a structured approach.

## Step 1: Check overall disk usage

```bash
df -h
```

Look for partitions above approximately 80–90% usage.

---

## Step 2: Find large directories

```bash
sudo du -xhd1 / | sort -h
```

Then investigate the largest directory.

For example:

```bash
sudo du -xhd1 /var | sort -h
```

---

## Step 3: Find large files

```bash
sudo find /var -xdev -type f -size +500M -ls
```

---

## Step 4: Check inode usage

```bash
df -i
```

If inode usage is 100%, look for directories containing huge numbers of small files.

---

## Step 5: Check deleted files still held open

Sometimes `df -h` shows high usage while `du` does not.

A common reason is a deleted file that is still open by a running process.

Check:

```bash
sudo lsof +L1
```

You may need to restart the process holding the deleted file, depending on the application.

---

# Common Disk Troubleshooting Scenario

Suppose:

```bash
df -h
```

shows:

```text
/dev/sda1   20G   19G   1G   95% /
```

First identify large directories:

```bash
sudo du -xhd1 / | sort -h
```

Suppose `/var` is large:

```bash
sudo du -xhd1 /var | sort -h
```

Suppose `/var/log` is large:

```bash
sudo du -xhd1 /var/log | sort -h
```

Then inspect large log files:

```bash
sudo find /var/log -type f -size +500M -ls
```

Do not blindly delete logs. First determine whether they are managed by `logrotate`, `journald`, or the application itself.

---

# Practical Linux File System Lab

The following lab can be performed on a Linux VM.

## Step 1: Check your current location

```bash
pwd
```

---

## Step 2: Explore the root directory

```bash
cd /
ls -lah
```

---

## Step 3: Explore `/etc`

```bash
cd /etc
ls -lah
```

Read hostname:

```bash
cat /etc/hostname
```

---

## Step 4: Create a practice directory

Go to your home directory:

```bash
cd ~
```

Create:

```bash
mkdir -p linux-lab/project/logs
```

Verify:

```bash
tree linux-lab
```

If `tree` is not installed:

```bash
find linux-lab
```

---

## Step 5: Create files

```bash
touch linux-lab/project/app.txt
touch linux-lab/project/logs/app.log
```

---

## Step 6: Add content

```bash
echo "Linux file system lab" > linux-lab/project/app.txt
echo "Application started" >> linux-lab/project/logs/app.log
```

Check:

```bash
cat linux-lab/project/app.txt
cat linux-lab/project/logs/app.log
```

---

## Step 7: Check permissions

```bash
ls -l linux-lab/project
```

---

## Step 8: Change permissions

```bash
chmod 640 linux-lab/project/app.txt
```

Verify:

```bash
ls -l linux-lab/project/app.txt
```

---

## Step 9: Create a symbolic link

```bash
ln -s ../app.txt linux-lab/project/logs/app-link.txt
```

Check:

```bash
ls -l linux-lab/project/logs
```

---

## Step 10: Check inode numbers

```bash
ls -li linux-lab/project/app.txt
```

---

## Step 11: Check disk usage

```bash
du -sh linux-lab
```

---

## Step 12: Find the files

```bash
find linux-lab -type f
```

---

# Important Commands for Linux Administrators

A Linux administrator should be comfortable with these commands:

```bash
pwd
ls
cd
mkdir
touch
cp
mv
rm
cat
less
head
tail
find
locate
file
stat
df
du
lsblk
blkid
mount
umount
findmnt
chmod
chown
chgrp
ln
```

---

# Common Interview Questions

## 1. What is the Linux root directory?

`/` is the top-level directory of the Linux file system. All other directories and mounted file systems are organized below it.

---

## 2. What is the difference between `/` and `/root`?

```text
/       = root of the entire file system
/root   = home directory of the root user
```

---

## 3. What is `/etc` used for?

`/etc` contains system-wide configuration files.

---

## 4. What is `/var` used for?

`/var` stores variable data such as logs, cache, application state, spool data, and databases depending on the system.

---

## 5. What is `/proc`?

`/proc` is a virtual file system that exposes process and kernel information.

---

## 6. What is the difference between `df` and `du`?

`df` reports file system-level disk usage.

```bash
df -h
```

`du` reports the space consumed by files and directories.

```bash
du -sh /var
```

---

## 7. What is an inode?

An inode stores metadata about a file, including permissions, ownership, timestamps, size, and references to its data blocks.

---

## 8. Can a disk have free space but fail to create files?

Yes. The file system may have exhausted its available inodes.

Check:

```bash
df -i
```

---

## 9. What is mounting?

Mounting attaches a file system to a directory in the Linux directory tree.

Example:

```bash
sudo mount /dev/sdb1 /mnt/data
```

---

## 10. What is `/etc/fstab`?

`/etc/fstab` contains persistent file system mount configuration.

---

## 11. What is the difference between a hard link and a symbolic link?

A hard link references the same inode as the original file. A symbolic link references a path/name.

---

## 12. How do you find large files?

Example:

```bash
find /var -type f -size +500M -ls
```

---

## 13. How do you check mounted file systems?

```bash
findmnt
```

or:

```bash
df -h
```

---

## 14. How do you check disk partitions?

```bash
lsblk
```

For partition details, depending on the environment:

```bash
sudo fdisk -l
```

---

# Quick Command Cheat Sheet

| Requirement | Command |
|---|---|
| Current directory | `pwd` |
| List files | `ls` |
| Detailed listing | `ls -l` |
| Hidden files | `ls -la` |
| Change directory | `cd` |
| Create directory | `mkdir` |
| Create nested directories | `mkdir -p` |
| Create file | `touch` |
| Copy | `cp` |
| Move/Rename | `mv` |
| Delete file | `rm` |
| Read file | `cat` |
| Read large file | `less` |
| First lines | `head` |
| Last lines | `tail` |
| Follow log | `tail -f` |
| Find file | `find` |
| File type | `file` |
| File metadata | `stat` |
| Disk space | `df -h` |
| Directory size | `du -sh` |
| Block devices | `lsblk` |
| Device UUID/type | `blkid` |
| Mounted filesystems | `findmnt` |
| Mount filesystem | `mount` |
| Unmount filesystem | `umount` |
| Change permissions | `chmod` |
| Change owner | `chown` |
| Change group | `chgrp` |
| Create hard link | `ln` |
| Create symbolic link | `ln -s` |
| Check inode usage | `df -i` |
| Process/kernel info | `/proc` |
| Device information | `/sys` |
| Device files | `/dev` |

---

# Linux File System — Mental Model

A useful way to remember the Linux file system is:

```text
                         /
                         |
        +----------------+----------------+
        |                |                |
       /etc             /home            /var
        |                |                |
   Configuration      User data         Logs/data
        |
        +-----------------------------+
                                      |
                                     /tmp
                                  Temporary data

       /boot       -> Boot and kernel files
       /dev        -> Devices
       /proc       -> Processes/kernel
       /sys        -> Hardware/kernel
       /usr        -> Applications/libraries
       /opt        -> Optional software
       /mnt        -> Temporary mounts
       /media      -> Removable media
       /run        -> Runtime information
```

---

# Recommended Learning Path

After understanding the Linux file system, continue with:

1. Linux users and groups
2. Linux permissions and ACLs
3. Processes and services
4. Package management
5. Systemd
6. Disk partitions
7. LVM
8. File system creation and formatting
9. Mounting and `/etc/fstab`
10. Disk and inode troubleshooting
11. Log management and `logrotate`
12. SSH administration
13. Cron jobs
14. Linux networking
15. Bash scripting
16. Linux server hardening
17. Monitoring and troubleshooting

---

## Summary

The Linux file system is a hierarchical structure beginning at `/`. Understanding the purpose of directories such as `/etc`, `/home`, `/var`, `/boot`, `/dev`, `/proc`, `/sys`, `/usr`, and `/tmp` is fundamental for Linux administration and DevOps.

The most important operational commands to master are:

```bash
ls
cd
pwd
cp
mv
rm
find
cat
less
tail
chmod
chown
df
du
lsblk
mount
umount
findmnt
```

For real-world Linux administration, combine these commands with knowledge of **permissions, ownership, inodes, file systems, partitions, LVM, mounting, logs, and troubleshooting**.

