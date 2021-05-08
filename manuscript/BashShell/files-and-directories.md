## Actions on Files and Directories

You have learned how to find a file or directory on the disk. Now let's discuss what you can do with it. If you have an experience with Windows GUI, you know the following actions with a file system object:

* Create
* Delete
* Copy
* Move or rename

Each of these actions has a corresponding GNU utility. Call them to manage the file system objects. Table 2-7 describes these utilities.

{caption: "Table 2-7. Utilities for operating files and directories", width: "100%"}
| Utility | Feature | Examples |
| --- | --- | --- |
| `mkdir` | It creates the directory with the specified name and path. | `mkdir /tmp/docs` |
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

The utility has an option `-p`. It creates the nested directories. Here is an example of when to use it. Suppose you want to move the documents into the `∼/docs/reports/2019` path. However, the `docs` and `reports` directories do not exist yet. If you use `mkdir` in the default mode, you should call it three times to create each of the nested directories. Another option is to call `mkdir` once with the `-p` option like this:
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

Permissions restrict the user actions on the file system. The OS tracks these actions and checks their allowance. Each user can access only his files and directories, thanks to this feature. It also restricts access to the OS components.

The permissions allow several people to share one computer. This workflow was widespread in the 1960s before appearing PCs. Hardware resources were expensive at that time. Therefore, several users have to operate with one computer.

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

Windows has strict rules about what files a user can run. The file extension defines the file type. The Windows loader runs files of certain types only. They have the EXE and COM extensions. These are compiled executable files of programs. In addition to them, you can run scripts. These are possible extensions of the scripts: BAT, JS, PY, etc. Each script type relates to one of the installed interpreters. OS cannot run the script if there is no appropriate interpreter for it.

Unix environment has other rules for execution files than Windows. Here you can run any file if it has permissions for reading and executing. Unlike Windows, its extension does not matter. For example, a file named `report.txt` can be executable.

There is no convention about extensions of the executable files in Unix. Therefore, the file type is not clear from its name. There is a utility called `type`. It takes the path to the file and prints its type. Here is an example of calling `type`:
{line-numbers: false, format: Bash}
```
file /usr/bin/ls
```

The command prints the following information when called in the MSYS2 environment:
{line-numbers: false, format: Bash}
```
/usr/bin/ls: PE32+ executable (console) x86-64 (stripped to external PDB), for MS Windows
```

The output means that the file type is [PE32](https://en.wikipedia.org/wiki/Portable_Executable). Files of this type are executable and contain machine code. The Windows loader runs them. The output also shows the bitness of the file (x86-64). It means that this `ls` utility version works on the 64-bit Windows versions only.

If you run the same `file` command on Linux, it prints another information. For example, it might look like this:
{line-numbers: false, format: Bash}
```
/bin/ls: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=d0bc0fb9b3f60f72bbad3c5a1d24c9e2a1fde775, stripped
```

Executable files with machine code have [ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format) type in Linux. Linux loader runs them. The file bitness is the same as in MSYS2 (x86-64).

We have learned to distinguish executable and non-executable files in the Unix environment. Now let's find out where they are located.

GNU utilities are considered as part of OS. That is why they are available right after installing the system. The executable files of the utilities are located in the directories `/bin` and `/usr/bin`. The Bash variable `PATH` stores these paths. The question is, where are new applications installed in a Unix environment?

Windows has `Program Files` and `Program Files (x86)` directories on the system drive. New applications are installed there by default. Each application has a subdirectory (for example, `C:\Program Files (x86)\Notepad++`). The installer program copies executable files, libraries, configuration and resource files into the subdirectory. All these files are required to run the application. You can specify other directories than `Program Files` and `Program Files (x86)`. Then the installer program creates the application subdirectory and copies its files there.

There are two approaches to install applications in the Unix environment. The first one resembles the Windows approach. There is the system directory `/opt`. The installer program creates a subdirectory and copies all application files there. For example, the TeamViewer application is installed in the `/opt/teamviewer` subdirectory. Developers of proprietary applications prefer this approach.

The second approach is for utilities and open source programs. An application requires files of various types to run. Each file type has a separate system directory in Unix. It means that the executable files of all applications occupy the same directory. The documentation for them is in another directory. The resource files are in the third directory and so on.

Table 2-11 explains the purposes of Unix system paths.

{caption: "Table 2-11. Unix system paths", width: "70%"}
| Path | Purpose |
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
| `/var` | It stores files created by applications and utilities while they are running (e.g. log files). |

Copying all files of the same type into one directory seems to be a controversial solution. Its disadvantage is the complexity of maintenance. Suppose that the application updates to the next version. It should update all its files in all system directories. If one of the files is missing, the application cannot run anymore.

The solution with special system directories has an advantage. When you install an application in Windows, it brings all files it needs. There are libraries with subroutines among these files. Some applications require the same libraries to run. As a result, dozens of copies of these libraries accumulate in the file system. It happens because each application has its own copy of the libraries.

The Unix way gets rid of most libraries copies. Suppose that all applications respect the agreement and install their files in the corresponding system paths. In this case, applications can easily locate files of each other. Therefore, all applications can use the same file if they require it. It is enough to keep a single instance of each library in the file system.

Suppose that we have installed an application (e.g., a browser). According to Table 2-11, the `/usr/bin` path contains its executable file (for example, `firefox`). Which Bash command runs this application? There are several ways to run it:

1. By the name of the executable file.
2. By absolute path.
3. By relative path.

Let's look at each way in detail.

We are already familiar with the first approach. We call GNU utilities in this way. Here is a command for calling the `find` utility:
{line-numbers: false, format: Bash}
```
find --help
```

You can use a similar command to run a newly installed application. For example, the Firefox browser runs like this:
{line-numbers: false, format: Bash}
```
firefox
```

Why does this command work? The executable file `firefox` is located in the system path `/usr/bin`. The Bash variable `PATH` stores this path. When Bash receives the "firefox" command, it searches the executable with that name. The shell takes paths for searching from the `PATH` variable. This way, Bash finds the `/usr/bin/firefox` file and launches it.

The paths have a specific order in the `PATH` variable. Bash follows this order when searching an executable file for the received command. There is an example.  Suppose the `firefox` executable presents in both `/usr/local/bin` and `/usr/bin` paths. If the path `/usr/local/bin` comes first in the `PATH` list, Bash always runs the file from there. Otherwise, Bash always runs the executable from the `/usr/bin` path.

The second way to run an application reminds the first one. Instead of the name of the executable file, we type its absolute path. For example, the following command runs the Firefox browser:
{line-numbers: false, format: Bash}
```
/usr/bin/firefox
```

Users prefer this approach to run proprietary applications. Such applications are installed in the system path `/opt`. The `PATH` variable does not contain it by default. Therefore, Bash cannot find the executable there. To solve this issue, you should specify an absolute path to the executable in the call.

The third approach for launching the application is something in between the first and second ways. Instead of the absolute path to the executable, you can use its relative path. Here is an example for the Firefox browser:
{line-numbers: true, format: Bash}
```
cd /usr
bin/firefox
```

The first command navigates to the `/usr` directory. Then the second command starts the browser by the relative path.

Now suppose that the executable file `firefox` is located in the `/opt/firefox/bin` path. Let's navigate there with the `cd` command and run the browser this way:
{line-numbers: true, format: Bash}
```
cd /opt/firefox/bin
firefox
```

In this case, Bash reports that it cannot find the `firefox` file. It happens because we are starting the application by the name of the executable. It is the first way to run applications. Bash looks for the `firefox` executable in the paths of the `PATH` variable. But the application is installed in the `/opt` path, which is not there.

The right way is to specify the relative path to the executable. If the current directory contains the file, you should specify it. The dot symbol indicates the current directory. Thus, the following commands run the browser properly:
{line-numbers: true, format: Bash}
```
cd /opt/firefox/bin
./firefox
```

Now Bash searches the executable in the current directory.

It can be useful to add a new path (for example, `/opt/firefox/bin`) to the `PATH` variable. Here are the steps for doing it:

1. Navigate to the user's home directory:
{line-numbers: false, format: Bash}
```
cd ~
```

2. Print the Windows path of the home directory:
{line-numbers: false, format: Bash}
```
pwd -W
```

3. Open the file `~/.bash_profile` in the text editor (for example, Notepad).

4. At the end of the file, add the following line:
{line-numbers: false, format: Bash}
```
PATH="/opt/firefox/bin:${PATH}"
```

We redefine the `PATH` variable. We will consider the variables in the next chapter.

Restart the MSYS2 terminal for applying changes. Now you can run the browser by the name. In this case, Bash finds its executable in the `/opt/firefox/bin` path.
