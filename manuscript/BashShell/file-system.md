## Navigating the File System

We start our introduction to the Unix environment and Bash with [**file system**](https://en.wikipedia.org/wiki/File_system) (FS). A file system is a way of storing and reading information from disks. First, we will look at the differences between the directory structure in Unix and Windows. Then we will learn the Bash commands for navigating the file system.

### Directory Structure

There is an address bar at the top of the Windows Explorer window. It displays the absolute path to the current directory. In Windows terminology, directories are called [**folders**](https://en.wikipedia.org/wiki/Directory_(computing)#Folder_metaphor). Both names refer to the same file system object.

Figure 2-6 shows an Explorer window. It opens the path `This PC > Local Disk (C:) > msys64`. This path matches the `msys64` directory on the `C` drive. The letter `C` denotes the local system disk. Local means physically connected to the computer. The system disk is the one where Windows is installed. If you translate the string in the Explorer address bar to an absolute path, you get `C:\msys64`.

{caption: "Figure 2-6. Windows Explorer"}
![Windows Explorer](images/BashShell/explorer.png)

The terminal window shows the current absolute path. It behaves like the Explorer address bar. But the paths in the terminal and Explorer differ. The reason is the different directory structure of Unix environment and Windows.

In Windows, each disk has a letter in the Latin alphabet. The drive opens in Explorer as an ordinary folder. Then you can access its contents. For example, consider the `C` system drive. After installation, Windows creates a [standard set of directories](https://en.wikipedia.org/wiki/Directory_structure#Windows_10) there:

* `Windows`
* `Program Files`
* `Program Files (x86)`
* `Users`
* `PerfLogs`

These directories store OS components and their temporary files.

Besides the system disk, you can connect extra disks to the computer. Windows designates them with the following letters of the Latin alphabet: `D`, `E`, `F` etc. The user sets the directory structure of the additional disks. Windows does not impose any restrictions on it.

The Windows directory structure is defined by the [File Allocation Table](https://en.wikipedia.org/wiki/File_Allocation_Table) (FAT) file system. Microsoft developed it for the [MS-DOS](https://en.wikipedia.org/wiki/MS-DOS) operating system. The principles of FAT became the basis of the [ECMA-107](http://www.ecma-international.org/publications/standards/Ecma-107.htm) standard. [NTFS](https://en.wikipedia.org/wiki/NTFS) replaced the obsolete FAT in modern versions of Windows. But due to backward compatibility requirements, the directory structure of NTFS remained unchanged.

The Unix directory structure is defined by [the POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap10.html#tag_10). According to the standard, there is a top-level directory in the system. It is called the [**root directory**](https://en.wikipedia.org/wiki/Root_directory) and is denoted by a slash /. The directories and files of all disks connected to your computer are inside the root directory.

To access the contents of a disk, you should mount it. **Mounting** means embedding the contents of a disk in the root directory. Once mounted, the contents of the disk are accessible via some path. That path is called a [**mount point**](https://en.wikipedia.org/wiki/Mount_(computing)). If you go to the mount point, you access the disk's file system.

Let's compare the directory structure of Windows and Unix using an example. Suppose that two local disks, `C` and `D` are connected to the Windows computer. Then, the first level of the directory structure looks like the one in Listing 2-1.

{caption: "Listing 2-1. The directory structure in Windows", line-numbers: false}
```
C:\
    PerfLogs\
    Windows\
    Program Files\
    Program Files (x86)\
    Users\

D:\
    Documents\
    Install\
```

The same directory structure looks different in Unix. Listing 2-2 shows it.

{caption: "Listing 2-2. The directory structure in Unix", line-numbers: false}
```
/
    c/
        PerfLogs/
        Windows/
        Program Files/
        Program Files (x86)/
        Users/

    d/
        Documents/
        Install/
```

When you launch the MSYS2 terminal, you enter the Unix environment. Windows paths don't work there. You should use Unix paths instead. For example, the directory `C:\Windows` is now accessible by the path `/c/Windows`.

In a Unix environment, the [character case](https://en.wikipedia.org/wiki/Case_sensitivity) is important. It means that the strings `Documents` and `documents` are not equal. Windows has no case sensitivity. So if you write the path `c:\windows` in the Explorer address bar, you go to the system directory `C:\Windows`. This approach does not work in a Unix environment. You should enter all characters in the correct case.

In addition to the character case, there is another difference. In Unix, directory and file names are separated by a slash /. Windows use a backslash \ for that.

### File System Navigation Commands

How to execute a command in a terminal emulator? There are three steps: 

1. Switch to the terminal window.
2. Type the command.
3. Press Enter.

The shell will process your input.

The shell notifies you that it is ready by printing a [**command prompt**](https://en.wikipedia.org/wiki/Command-line_interface#Command_prompt). The prompt is a special character or string of characters. If there is no prompt, the shell is busy and cannot execute your command.

The prompt is denoted by the dollar sign $ in Figure 2-4.

When using Windows Explorer, you can do the following actions to navigate the file system:

* Display the current directory.
* Go to a specified directory.
* Find a directory or file on the disk.

The command-line interface allows you to do the same actions. There are special commands for each kind of action. Table 2-1 shows these commands.

{caption: "Table 2-1. Commands and utilities for navigating the file system", width: "100%"}
| Command | Description | Examples |
| --- | --- | --- |
| ls | Display the contents of the directory. | `ls` |
| | If no directory is specified, the contents of the current one are displayed. | `ls /c/Windows` |
|  | | |
| pwd | Display the path to the current directory. | `pwd` |
| | When using the `-W` key, the command displays the path in the Windows directory structure. |
|  | | |
| cd | Go to the directory at the specified | `cd tmp` |
| | relative or absolute path. | `cd /c/Windows` |
| | | `cd ..` |
|  | | |
| mount | Mount the disk to the root file system. When you call the command without parameters, it displays a list of all mounted disks.  | `mount` |
|  | | |
| find | Find a file or directory. The first parameter | `find . -name vim` |
| | of the command is the directory where the search starts. If it is not specified, the current directory is chosen. | `find /c/Windows -name *vim*` |
|  | | |
| grep | Find a file by its contents. | `grep "PATH" *` |
| | | `grep -Rn "PATH" .` |
| | | `grep "PATH" * .*` |

Bash handles by itself the following commands from Table 2-1:

* pwd
* cd

These commands are called [**builtins**](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html). If Bash cannot execute the command by itself, it looks for a suitable utility or program to do it.

The MSYS2 environment includes a set of GNU utilities. These are auxiliary highly specialized programs. They give access to OS features. They also allow you to work with the file system. GNU utilities execute the following commands from Table 2-1:

* ls
* mount
* find
* grep

Often no distinction is made between commands and utilities. Any text after the command line prompt is called a command.