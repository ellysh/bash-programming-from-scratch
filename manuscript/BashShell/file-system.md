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

#### pwd

Let's consider the commands in Table 2-1. We have just started the terminal. The first thing we do is to find out the current directory. The MSYS2 terminal prints it before the command prompt. This output depends on the terminal configuration. If you are running Linux or macOS, the terminal does not print the current directory with the default setup.

After starting the MSYS2 terminal, the home directory of the current user opens. It has the abbreviation that is the tilde symbol ~. You see this symbol before the command line prompt. You can work with the abbreviation ~ in the same way as with an absolute path.

Run the pwd built-in command to get the current directory. Figure 2-7 shows how it looks like. The command prints the absolute path to the user's home directory: `/home/ilya.shpigor`.

If you add an **option** `-W` to the pwd call, it prints the path in the Windows directory structure. It is useful when you create a file in the MSYS2 environment and open it in a Windows application. Figure 2-7 shows the output of the pwd command with the `-W` option.

{caption: "Figure 2-7. The output of the pwd command"}
![Output pwd](images/BashShell/pwd-command.png)

What is a command option? If an application has only a text interface, the ways of interacting with it are limited. The application needs some input data to work. An example of data is the path to a file or directory. The command interpreter offers a simple way to pass this information. You can specify it after the command for launching the application. [**Parameter**](https://en.wikipedia.org/wiki/Command-line_interface#Arguments) or program argument is the word or character passed to it for input. An **Option** or key is an argument that switches the mode of a program. The format of options is standardized. They usually start with a dash -- or a double dash --.

The built-in interpreter commands are called just like programs. They have parameters and options too.

Typing long commands is inconvenient. That is why Bash has an autocomplete feature. Press the Tab key for using it. Type the first letters of the command and press Tab. If Bash finds the command by its first letters, it will complete it.  If several commands start the same way, autocomplete does not happen. In this case, press Tab again. Bash will list all available commands.

Figure 2-8 shows a list of available commands. Bash printed it after typing `pw` and pressing Tab twice.

{caption: "Figure 2-8. Autocomplete for the `pw` command"}
![Autocomplete pw](images/BashShell/pw-autocompletion.png)

#### ls

We know the current directory. Now let's print its contents. The utility called ls does it. Suppose you have just installed the MSYS2 environment. Launch the "ls" command without parameters in the user's home directory. It prints nothing. The second line in Figure 2-9 demonstrates this result. Such output usually means that the directory is empty.

{caption: "Figure 2-9. The output of the ls utility"}
![Output ls](images/BashShell/ls-command.png)

Windows has a concept of hidden files and directories. They also exist in the Unix environment. Such files are created by applications and operating systems for their own needs. They are used for storing configuration or temporary information. Windows Explorer does not display hidden files in normal mode. Change [Explorer settings](https://support.microsoft.com/en-us/windows/show-hidden-files-0320fe58-0117-fd59-6851-9b7f9840fdb2) to see hidden files.

Names of hidden files and directories begin with a dot in the Unix environment. The ls utility does not show them by default. To change this behavior, run the ls utility with the `-a` option. Then you will see eight files in the home directory. They all start with a dot, as Figure 2-9 shows.

You can get the contents of a directory without going into it. Pass an absolute or relative path to the directory when launching the ls utility. For example, there is the command to show the contents of the root directory:
{line-numbers: false, format: Bash}
```
ls /
```

Figure 2-10 shows the output of this command.

{caption: "Figure 2-10. The output of the ls utility"}
![Output ls](images/BashShell/ls-root-command.png)

There are no directories `/c` and `/d` in Figure 2-10. According to Listing 2-2, these are the mount points of disks C and D. They are in the root directory. Why does not ls output them? The problem is that the Windows file system has no concept of mount points. For that reason, it does not have directories `/c` and `/d`. They are present in the Unix environment only. Through these directories, you access the contents of the disks. The ls utility reads the contents of directories in the Windows file system. Thus, it does not show the mount points. Linux and macOS do not have this problem. The ls utility displays all mount points correctly there.