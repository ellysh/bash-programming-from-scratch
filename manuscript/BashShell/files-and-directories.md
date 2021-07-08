## Actions on Files and Directories

You have learned how to find a file or directory on the disk. Now let's discuss what you can do with it. If you have an experience with Windows GUI, you know the following actions with file system objects:

* Create
* Delete
* Copy
* Move or rename

Each of these actions has a corresponding GNU utility. Call them to manage the file system objects. Table 2-7 describes these utilities.

{caption: "Table 2-7. Utilities for operating files and directories", width: "100%"}
| Utility | Feature | Examples |
| --- | --- | --- |
| `mkdir` | It creates the directory with the specified name and path. | `mkdir ~/tmp/docs` |
| | | `mkdir -p tmp/docs/report` |
|  | | |
| `rm` | It deletes the specified file or directory | `rm readme.txt` |
| |  | `rm -rf ~/tmp` |
|  | | |
| `cp` | It copies a file or directory. The first parameter | `cp readme.txt tmp/readme.txt` |
| | is the current path. The second parameter is the target path. | `cp -r /tmp ~/tmp` |
|  | | |
| `mv` | It moves or renames the file or directory | `mv readme.txt documentation.txt.` |
| | specified by the first parameter. | `mv ~/tmp ~/backup` |

Each of these utilities has the `--help` option. It displays a brief help. Please read it before using the utility the first time. You will find there some modes that this book misses. Refer to the `info` or `man` system if you need more details.

It is time to consider the utilities of Table 2-7.

### mkdir

The `mkdir` utility creates a new directory. Specify its target path in the first parameter of the command. Here is an example `mkdir` call for creating the `docs` directory:
{line-numbers: false, format: Bash}
```
mkdir ~/docs
```

We specified the absolute path to the `docs` directory. You can pass the relative path instead. There are two steps to take it:

1. Navigate the home directory.
2. Call the `mkdir` utility there.

Here are the corresponding commands:
{line-numbers: true, format: Bash}
```
cd ~
mkdir docs
```

The utility has an option `-p`. It creates the nested directories. Here is an example of when to use it. Suppose you want to move the documents into the ` ∼/docs/reports/2019` path. However, the `docs` and `reports` directories do not exist yet. If you use `mkdir` in the default mode, you should call it three times to create each of the nested directories. Another option is to call `mkdir` once with the `-p` option like this:
{line-numbers: false, format: Bash}
```
mkdir -p ~/docs/reports/2019
```

This command succeeds even if the `docs` and `reports` directories already exist. It creates only the missing `2019` directory in this case.

### rm

The `rm` utility deletes files and directories. Specify the object to delete by its absolute or relative path. Here are examples of `rm` calls:
{line-numbers: true, format: Bash}
```
rm report.txt
rm ~/docs/reports/2019/report.txt
```

The first call deletes the `report.txt` file in the current directory. The second one deletes it in the `~/docs/reports/2019` path.

The `rm` utility can remove several files at once. Specify a list of filenames separated by spaces in this case. Here is an example:
{line-numbers: false, format: Bash}
```
rm report.txt ~/docs/reports/2019/report.txt
```

If you want to delete dozens of files, listing them all is inconvenient. Use a Bash glob pattern in this case. For example, you need to delete all text files whose names begin with the word "report". The following `rm` call does it:
{line-numbers: false, format: Bash}
```
rm ~/docs/reports/2019/report*.txt
```

When removing a write-protected file, the `rm` utility shows you a warning. You can see how it looks like in Figure 2-26.

{caption: "Figure 2-26. The warning when deleting a write-protected file", width: "100%"}
![rm warning](images/BashShell/rm-warning.png)

When you see such a warning, there are two options. You can press the Y (short for yes) and Enter. Then the `rm` utility removes the file. Another option is to press N (no) and Enter. It cancels the operation.

If you want to suppress any `rm` warnings, use the `-f` or `--force` option. The utility removes files without confirmation in this case. Here is an example call:
{line-numbers: false, format: Bash}
```
rm -f ~/docs/reports/2019/report*.txt
```

I> The GNU utility options have two forms. The short form consists of one letter and begins with a dash `-`. The full form is a word preceded by a double dash `--`. This option format is recommended by the [POSIX standard](https://www.gnu.org/software/libc/manual/html_node/Argument-Syntax.html) and its [GNU extension](https://www.gnu.org/prep/standards/html_node/Command_002dLine-Interfaces.html).

The `rm` utility cannot remove a directory unless you pass one of two possible options there. The first option is `-d` or `--dir`. Use it for removing an empty directory. Here is an example:
{line-numbers: false, format: Bash}
```
rm -d ~/docs
```

If the directory contains files or subdirectories, use the `-r` or `--recursive` option to remove it. Such a call looks like this:
{line-numbers: false, format: Bash}
```
rm -r ~/docs
```

The `-r` option removes empty directories too. Therefore, you can always use the `-r` option when calling `rm` for a directory.

### cp and mv

The `cp` and `mv` utilities copy and move file system objects. Their interfaces are almost the same. Specify the target file or directory in the first parameter. Pass the new path for the object in the second parameter.

Here is an example. You want to copy the `report.txt` file. First, you should come to its directory. Second, call the `cp` utility this way:
{line-numbers: false, format: Bash}
```
cp report.txt report-2019.txt
```

This command creates the new file `report-2019.txt` in the current directory. Both `report-2019.txt` and `report.txt` files have the same contents.

Suppose that you do not need the old file `report.txt`. You can remove it with the `rm` utility after copying. The second option is to combine copying and removing in a single command. The `mv` utility does that:
{line-numbers: false, format: Bash}
```
mv report.txt report-2019.txt
```

This command does two things. First, it copies the `report.txt` file with the new name `report-2019.txt`. Second, it removes the old file `report.txt`.

Both `cp` and `mv` utilities accept relative and absolute paths. For example, let's copy a file from the home directory to the `~/docs/reports/2019` path. Here is the command for that:
{line-numbers: false, format: Bash}
```
cp ~/report.txt ~/docs/reports/2019
```

This command copies the `report.txt` file into the `~/docs/reports/2019` directory. The copy has the same name as the original file.

You can repeat the copying command with relative paths. Come to the home directory and call the `cp` utility there. The following commands do it:
{line-numbers: true, format: Bash}
```
cd ~
cp report.txt docs/reports/2019
```

When copying a file between directories, you can specify the copy name. Here is an example:
{line-numbers: false, format: Bash}
```
cp ~/report.txt ~/docs/reports/2019/report-2019.txt
```

This command creates a file copy with the `report-2019.txt` name.

Moving files works the same way as copying. For example, the following command moves the `report.txt` file:
{line-numbers: false, format: Bash}
```
mv ~/report.txt ~/docs/reports/2019
```

The following command moves and renames the file at once:
{line-numbers: false, format: Bash}
```
mv ~/report.txt ~/docs/reports/2019/report-2019.txt
```

You can rename a directory using the `mv` utility too. Here is an example:
{line-numbers: false, format: Bash}
```
mv ~/tmp ~/backup
```

This command changes the name of the `tmp` directory to `backup`.

The `cp` utility cannot copy a directory when you call it in the default mode. Here is an example. Suppose you want to copy the directory `/tmp` with the temporary files to the home directory. You call `cp` this way:
{line-numbers: false, format: Bash}
```
cp /tmp ~
```

This command fails.

You must add the `-r` or `--recursive` option when copying directories. Then the `cp` utility can handle them. This is the correct command for our example:
{line-numbers: false, format: Bash}
```
cp -r /tmp ~
```

Suppose you copy or move a file. If the target directory already has the file with the same name, the `cp` and `mv` utilities ask you to confirm the operation. If you press the Y and Enter keys, utilities overwrite the existing file.

There is an option to suppress the confirmation when copying and moving files. Use the `-f` or `--force` option. It forces `cp` and `mv` utilities to overwrite the existing files. Here are examples:
{line-numbers: true, format: Bash}
```
cp -f ~/report.txt ~/tmp
mv -f ~/report.txt ~/tmp
```

Both commands overwrite the existing `report.txt` file in the `tmp` directory. You do not need to confirm these operations.

{caption: "Exercise 2-6. Operations with files and directories", format: text, line-numbers: false}
```
Handle your photos from the past three months using the GNU utilities.
Make a backup before you start.
Separate all photos by year and month.
You should get a directory structure like this:

~/
  photo/
        2019/
             11/
             12/
        2020/
             01/
```

#### File System Permissions

Each utility of Table 2-7 checks the [**file system permissions**](https://en.wikipedia.org/wiki/File-system_permissions) before acting. These permissions define if you are allowed to operate the target object. Let's consider this file system mechanism in detail.

The permissions restrict the user actions on the file system. The OS tracks these actions and checks their allowance. Each user can access only his files and directories, thanks to this feature. It also restricts access to the OS components.

I> Users can share files with each other, but they should allow it explicitly. This sharing does not work by default.

The permissions allow several people to share one computer. This workflow was widespread in the 1960s until the advent of PCs. Hardware resources were expensive at that time. Therefore, several users have to operate with one computer.

Today most users have their own PC or laptop. However, the file system permissions are still relevant. They protect your Linux or macOS system from unauthorized access and malware.

Have a look at Figure 2-26 again. There you see the output of the `ls` utility with the `-l` option. It is the table. Each row corresponds to a file or directory. The columns have the following meaning:

1. Permissions to the object.
2. The number of hard links to the file or directory.
3. Owner.
4. Owner's group.
5. The object's size in bytes.
6. Date and time of the last change.
7. File or directory name.

The permissions to the file `report.txt` equal the "-r--r--r--" string. What does it mean?

Unix stores permissions to a file object as a [**bitmask**](https://en.wikipedia.org/wiki/Mask_(computing)). The bitmask is a positive integer. When you store it in computer memory, the integer becomes a sequence of zeros and ones. Each bit of the mask keeps a value that is independent of the other bits. Therefore, you can pack several values into a single bitmask.

What values can you store in a bitmask? This is a set of object's properties, for example. Each bit of the mask corresponds to one property. If it is present, the corresponding bit equals one. Otherwise, the bit equals zero.

Let's come back to the file access rights. We can represent these rights as the following three attributes:

1. Read permission.
2. Write permission.
3. Permission to execute.

If you apply a mask of three bits, you can encode these attributes there. Suppose a user has full access to the file. He can read, change, copy, remove or execute it. It means that the user has read, write, and execute permissions to the file. The writing permission allows changing the file and removing it. Therefore, the file permissions mask looks like this:
{line-numbers: false}
```
111
```

Suppose the user cannot read or execute the file. The first bit of the mask corresponds to the read access. The third bit is execution permission. When you set both these bits to zero, you restrict the file access. Then you get the following mask:
{line-numbers: false}
```
010
```

You should know the meaning of each bit in the mask if you want to operate it properly. The mask itself does not provide this information.

Our mask with three bits is a simplified example of file permissions. The permissions in Unix follow the same idea. However, bitmasks there have more bits. The `ls` utility prints these access rights to the `report.txt` file:
{line-numbers: false}
```
-r--r--r--
```

This string is the bitmask. Here dashes correspond to zeroed bits. Latin letters match the set bits. If you follow this notation, you can convert the "-r--r--r--" string to the 0100100100 mask. If all bits of the mask equal ones, the `ls` prints it like the "drwxrwxrwx" string.

The Unix permissions string has four parts. Table 2-8 explains their meaning.

{caption: "Table 2-8. Parts of the permissions string in Unix", width: "100%"}
| d | rwx | rwx | rwx |
| --- | --- | --- | --- |
| The directory attribute. | The permissions of the object's owner. The owner is a user who has created the object. | The permissions of the user group that is attached to the object. By default, it is the group to which the owner belongs. | The permissions of all other users except the owner and the group attached to the object. |

I> The `groups` utility prints the list of groups that the current user belongs.

You can imagine the Unix permissions as four separate bitmasks. Each of them corresponds to one part of Table 2-8. All bitmasks have a size of four bits. Using this approach, you can represent the "-r--r--r--" string this way:
{line-numbers: false}
```
0000 0100 0100 0100
```

The Latin letters in the Unix permissions have special meaning. First of all, they match bits that are set to one. The position of each bit defines the allowed action to the object. You do not need to remember the meaning of each position. The Latin letters give you a hint. For example, "r" means read access. Table 2-9 explains the rest letters.

{caption: "Table 2-9. Letters in the Unix permissions string", width: "100%"}
| Letter | Meaning for a file | Meaning for a directory |
| --- | --- | --- |
| d | If the first character is a dash instead of `d`, the permissions correspond to a file. | The permissions correspond to a directory. |
|  | | |
| r | Access for reading. | Access for listing the directory contents. |
|  | | |
| w | Access for writing. | Access for creating, renaming or deleting objects in the directory. |
|  | | |
| x | Access for executing. | Access for navigating to the directory and accessing its nested objects. |
|  | | |
| — | The corresponding action is prohibited. | The corresponding action is prohibited. |

Suppose that all users of the system have full access to the file. Then its permissions look like this:
{line-numbers: false}
```
-rwxrwxrwx
```

If all users have full access to a directory, the permissions look this way:
{line-numbers: false}
```
drwxrwxrwx
```

The only difference is the first character. It is `d` instead of the dash.

Now you know everything to read the permissions of Figure 2-26. It shows two files: `report.txt` and `report1.txt`. All users can read the first one. Nobody can modify or execute it. All users can read the `report1.txt` file. Only the owner can change it. Nobody can execute it.

We have considered commands and utilities for operating the file system. When you call each of them, you specify the target object. You should have appropriate permissions to the object. Otherwise, your command fails. Table 2-10 shows the required permissions.

{caption: "Table 2-10. Commands and required file system permissions for them", width: "100%"}
| Command | Required Bitmask | Required Permissions | Comment |
| --- | --- | --- | --- |
| `ls` | `r--` | Reading | Applied for directories only. |
|  | | | |
| `cd` | `--x` | Executing | Applied for directories only. |
|  | | | |
| `mkdir` | `-wx` | Writing and executing | Applied for directories only. |
|  | | | |
| `rm` | `-w-` | Writing | Specify the `-r` option for the directories. |
|  | | | |
| `cp` | `r--` | Reading | The target directory should have writing and executing permissions. |
|  | | | |
| `mv` | `r--` | Reading | The target directory should have writing and executing permissions. |
|  | | | |
| Execution | `r-x` | Reading and executing. | Applied for files only. |

### Files Execution

Windows has strict rules for executable files. The file extension defines its type. The Windows loader runs only files with the EXE and COM extensions. These are compiled executable of programs. Besides them, you can run scripts. The script's extension defines the interpreter that launches it. Windows cannot run the script if there is no installed interpreter for it. The possible extensions of the scripts are BAT, JS, PY, RB, etc.

Unix rules for executing files differ from Windows ones. Here you can run any file if it has permissions for reading and executing. Its extension does not matter, unlike Windows. For example, the file called `report.txt` can be executable.

There is no convention for extensions of the executable files in Unix. Therefore, you cannot deduce the file type from its name. Use the `file` utility to get it. The command receives the file path on input and prints its type. Here is an example of calling `file`:
{line-numbers: false, format: Bash}
```
file /usr/bin/ls
```

If you launch the command in the MSYS2 environment, it prints the following information:
{line-numbers: false, format: Bash}
```
/usr/bin/ls: PE32+ executable (console) x86-64 (stripped to external PDB), for MS Windows
```

The output says that the `/usr/bin/ls` file has the [PE32](https://en.wikipedia.org/wiki/Portable_Executable) type. Files of this type are executable and contain machine code. The Windows loader can run them. The output also shows the bitness of the file "x86-64". It means that this version of `ls` utility works on 64-bit Windows only.

If you run the same `file` command on Linux, it gives another output. For example, it might look like this:
{line-numbers: false, format: Bash}
```
/bin/ls: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=d0bc0fb9b3f60f72bbad3c5a1d24c9e2a1fde775, stripped
```

This is the executable file with machine code. It has the [ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format) type. Linux loader can run it. The file bitness "x86-64" is the same as in MSYS2.

We have learned to distinguish executable and non-executable files in the Unix environment. Now let's find out where you can find them.

GNU utilities are part of OS. Therefore, they are available right after installing the system. You do not need to install them separately. Their executable files are located in the `/bin` and `/usr/bin` directories. The Bash variable `PATH` stores these paths. Now the question is, where can you find newly installed applications?

Windows installs new applications in the `Program Files` and `Program Files (x86)` directories on the system drive. Each application has its own subdirectory. For example, it can be `C:\Program Files (x86)\Notepad++`. The installer program copies executables, libraries, configuration and resource files into that subdirectory. The application requires all these files to work properly. You can specify another installation directory than `Program Files` and `Program Files (x86)`. Then the installer program creates the application subdirectory there.

There are two approaches to install applications in the Unix environment. The first one resembles the Windows way. There is the system directory `/opt`. The installer program creates an application subdirectory with all its files there.

Here is an example. Suppose that you are installing the TeamViewer application. Its installer creates the `/opt/teamviewer` subdirectory. You can find the `TeamViewer` executable there. Developers of proprietary applications prefer this way of installing programs.

Developers of open-source programs follow another approach. An application requires files of various types. Each file type has a separate system directory in Unix. It means that the executable files of all applications occupy the same directory. The documentation for them is in another directory and so on. The POSIX standard dictates the purposes of all system directories.

Table 2-11 explains the purposes of Unix system directories.

{caption: "Table 2-11. Unix system directories", width: "70%"}
| Directory | Purpose |
| --- | --- |
| `/bin` | It stores executable files of system utilities. |
|  | |
| `/etc` | It stores configuration files of applications and system utilities. |
|  | |
| `/lib` | It stores libraries of system utilities. |
|  | |
| `/usr/bin` | It stores executable files of user applications. |
|  | |
| `/usr/lib` | It stores libraries of user applications. |
|  | |
| `/usr/local` | It stores applications that the user compiled on his own. |
|  | |
| `/usr/share` | It stores architecture-independent resource files of user applications (e.g. icons). |
|  | |
| `/var` | It stores files created by applications and utilities while running (e.g. log files). |

Copying all files of the same type into one directory sounds like a controversial solution. Its disadvantage is the complexity of maintenance. Suppose that the application updates to the next version. It should update all its files in all system directories. If the application misses one of the files, it cannot run anymore.

However, the Unix system directories have an advantage. When you install an application in Windows, it brings all files it needs. There are libraries with subroutines among these files. Some applications require the same libraries to run. When each application has its own copy of the same library, it causes the file system overhead.

The Unix way gets rid of library copies. Suppose that all applications respect the agreement and install their files in the proper system directories. Then applications can locate files of each other. Therefore, they can use the same library if they require it. A single instance of each library is enough for supporting all dependent applications.

Suppose that you have installed a new application (e.g., a browser). Its executable file (for example, `firefox`) comes to the `/usr/bin` path according to Table 2-11. How to run this application in Bash? There are several ways for that:

1. By the name of the executable file.
2. By the absolute path.
3. By the relative path.

Let's consider each way in detail.

You have used the first approach when calling GNU utilities. For example, the following command runs the `find` utility:
{line-numbers: false, format: Bash}
```
find --help
```

It launches the `/usr/bin/find` executable file.

Use a similar command to run a newly installed application. Here is an example for the Firefox browser:
{line-numbers: false, format: Bash}
```
firefox
```

Why does this command work? The executable file `firefox` is located in the `/usr/bin` system directory. The Bash variable `PATH` stores this path. When Bash receives the "firefox" command, it searches the executable with that name. The shell takes searching paths from the `PATH` variable. This way, Bash finds the `/usr/bin/firefox` file and launches it.

The paths have a specific order in the `PATH` variable. Bash follows this order when searching for an executable. There is an example.  Suppose that both `/usr/local/bin` and `/usr/bin` directories contain the `firefox` executable. If the path `/usr/local/bin` comes first in the `PATH` list, Bash always runs the file from there. Otherwise, Bash calls the `/usr/bin/firefox` executable.

The second way to run an application reminds the first one. Instead of the executable filename, you type its absolute path. For example, the following command runs the Firefox browser:
{line-numbers: false, format: Bash}
```
/usr/bin/firefox
```

You would need this approach when launching proprietary applications. They are installed in the `/opt` system directory. The `PATH` variable does not contain this path by default. Therefore, Bash cannot find executables there. You can help Bash by specifying an absolute path to the program.

The third approach to run an application is something in between the first and second ways. You use a relative executable path instead of the absolute one. Here is an example for the Firefox browser:
{line-numbers: true, format: Bash}
```
cd /usr
bin/firefox
```

The first command navigates to the `/usr` directory. Then the second command launches the browser by its relative path.

Now let's change the first command. Suppose that you navigate the `/opt/firefox/bin` directory. The following try to launch the browser fails:
{line-numbers: true, format: Bash}
```
cd /opt/firefox/bin
firefox
```

Bash reports that it cannot find the `firefox` file. It happens because you are launching the application by the executable filename here. It is the first way to run applications. Bash looks for the `firefox` executable in the paths of the `PATH` variable. However, the application is located in the `/opt` directory, which is not there.

You should specify the relative path to the executable instead of its filename. If the current directory contains the file, mention it in the relative path. The dot symbol indicates the current directory. Thus, the following commands run the browser properly:
{line-numbers: true, format: Bash}
```
cd /opt/firefox/bin
./firefox
```

Now Bash follows your hint and searches the executable in the current directory.

Suppose that you have installed a new application. You are going to use it in your daily work frequently. Add its installation path to the `PATH` variable in this case. The following steps explain how to do it for the `/opt/firefox/bin` directory:

1. Navigate the home directory:
{line-numbers: false, format: Bash}
```
cd ~
```

2. Print its Windows path:
{line-numbers: false, format: Bash}
```
pwd -W
```

3. Open the file `~/.bash_profile` in the text editor (for example, Notepad).

4. Add the following line at the end of the file:
{line-numbers: false, format: Bash}
```
PATH="/opt/firefox/bin:${PATH}"
```

You have redefined the `PATH` variable this way. The next chapter considers Bash variables in detail. There you will know how to operate them.

Restart the MSYS2 terminal for applying changes. Now you can run the browser by the name. Bash finds the corresponding executable in the `/opt/firefox/bin` path correctly.
