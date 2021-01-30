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
| `ls` | Display the contents of the directory. | `ls` |
| | If no directory is specified, the contents of the current one are displayed. | `ls /c/Windows` |
|  | | |
| `pwd` | Display the path to the current directory. | `pwd` |
| | When using the `-W` key, the command displays the path in the Windows directory structure. |
|  | | |
| `cd` | Go to the directory at the specified | `cd tmp` |
| | relative or absolute path. | `cd /c/Windows` |
| | | `cd ..` |
|  | | |
| `mount` | Mount the disk to the root file system. When you call the command without parameters, it displays a list of all mounted disks.  | `mount` |
|  | | |
| `find` | Find a file or directory. The first parameter | `find . -name vim` |
| | of the command is the directory where the search starts. If it is not specified, the current directory is chosen. | `find /c/Windows -name *vim*` |
|  | | |
| `grep` | Find a file by its contents. | `grep "PATH" *` |
| | | `grep -Rn "PATH" .` |
| | | `grep "PATH" * .*` |

Bash handles by itself the following commands from Table 2-1:

* `pwd`
* `cd`

These commands are called [**builtins**](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html). If Bash cannot execute the command by itself, it looks for a suitable utility or program to do it.

The MSYS2 environment includes a set of GNU utilities. These are auxiliary highly specialized programs. They give access to OS features. They also allow you to work with the file system. GNU utilities execute the following commands from Table 2-1:

* `ls`
* `mount`
* `find`
* `grep`

Often no distinction is made between commands and utilities. Any text after the command line prompt is called a command.

#### pwd

Let's consider the commands in Table 2-1. We have just started the terminal. The first thing we do is to find out the current directory. The MSYS2 terminal prints it before the command prompt. This output depends on the terminal configuration. If you are running Linux or macOS, the terminal does not print the current directory with the default setup.

After starting the MSYS2 terminal, the home directory of the current user opens. It has the abbreviation that is the tilde symbol ~. You see this symbol before the command line prompt. You can work with the abbreviation ~ in the same way as with an absolute path.

Run the `pwd` built-in command to get the current directory. Figure 2-7 shows how it looks like. The command prints the absolute path to the user's home directory: `/home/ilya.shpigor`.

If you add an **option** `-W` to the `pwd` call, it prints the path in the Windows directory structure. It is useful when you create a file in the MSYS2 environment and open it in a Windows application. Figure 2-7 shows the output of the `pwd` command with the `-W` option.

{caption: "Figure 2-7. The output of the `pwd` command"}
![Output pwd](images/BashShell/pwd-command.png)

What is a command option? If an application has only a text interface, the ways of interacting with it are limited. The application needs some input data to work. An example of data is the path to a file or directory. The command interpreter offers a simple way to pass this information. You can specify it after the command for launching the application. [**Parameter**](https://en.wikipedia.org/wiki/Command-line_interface#Arguments) or program argument is the word or character passed to it for input. An **Option** or key is an argument that switches the mode of a program. The format of options is standardized. They usually start with a dash `-` or a double dash `--`.

The built-in interpreter commands are called just like programs. They have parameters and options too.

Typing long commands is inconvenient. That is why Bash has an autocomplete feature. Press the Tab key for using it. Type the first letters of the command and press Tab. If Bash finds the command by its first letters, it will complete it.  If several commands start the same way, autocomplete does not happen. In this case, press Tab again. Bash will list all available commands.

Figure 2-8 shows a list of available commands. Bash printed it after typing `pw` and pressing Tab twice.

{caption: "Figure 2-8. Autocomplete for the `pw` command"}
![Autocomplete pw](images/BashShell/pw-autocompletion.png)

#### ls

We know the current directory. Now let's print its contents. The utility called `ls` does it. Suppose you have just installed the MSYS2 environment. Launch the "ls" command without parameters in the user's home directory. It prints nothing. The second line in Figure 2-9 demonstrates this result. Such output usually means that the directory is empty.

{caption: "Figure 2-9. The output of the `ls` utility"}
![Output ls](images/BashShell/ls-command.png)

Windows has a concept of hidden files and directories. They also exist in the Unix environment. Such files are created by applications and operating systems for their own needs. They are used for storing configuration or temporary information. Windows Explorer does not display hidden files in normal mode. Change [Explorer settings](https://support.microsoft.com/en-us/windows/show-hidden-files-0320fe58-0117-fd59-6851-9b7f9840fdb2) to see hidden files.

Names of hidden files and directories begin with a dot in the Unix environment. The `ls` utility does not show them by default. To change this behavior, run the `ls` utility with the `-a` option. Then you will see eight files in the home directory. They all start with a dot, as Figure 2-9 shows.

You can get the contents of a directory without going into it. Pass an absolute or relative path to the directory when launching the `ls` utility. For example, there is the command to show the contents of the root directory:
{line-numbers: false, format: Bash}
```
ls /
```

Figure 2-10 shows the output of this command.

{caption: "Figure 2-10. The output of the `ls` utility"}
![Output ls](images/BashShell/ls-root-command.png)

There are no directories `/c` and `/d` in Figure 2-10. According to Listing 2-2, these are the mount points of disks C and D. They are in the root directory. Why does not `ls` output them? The problem is that the Windows file system has no concept of mount points. For that reason, it does not have directories `/c` and `/d`. They are present in the Unix environment only. Through these directories, you access the contents of the disks. The `ls` utility reads the contents of directories in the Windows file system. Thus, it does not show the mount points. Linux and macOS do not have this problem. The `ls` utility displays all mount points correctly there.

#### mount

If several disks are attached to your computer, it is useful to display their mount points. The [`mount`](https://en.wikipedia.org/wiki/Mount_(Unix)) utility does it. Run the utility without parameters. It will print all mount points, as Figure 2-11 shows.

{caption: "Figure 2-11. The output of the `mount` utility"}
![Output mount](images/BashShell/mount-command.png)

Consider this output as a table with four columns. Their values are the following:

1. The disk, its partition or directory. It means the thing that is mounted to the root file system. 

2. Mount point. It is the path where the mounted disk is accessible.

3. The file system type of the disk.

4. Mounting parameters. For example, access permissions to the drive.

Table 2-2 shows the output of the `mount` utility call in Figure 2-11. The output is divided into columns.

{caption: "Table 2-2. The output of the `mount` utility", width: "100%"}
| Mounted partition | Mount point | FS type | Mounting parameters |
| --- | --- | --- | --- |
| `C:/msys64` | `/` | `ntfs` | `binary,noacl,auto` |
| `C:/msys64/usr/bin` | `/bin` | `ntfs` | `binary,noacl,auto` |
| `C:` | `/c` | `ntfs` | `binary,noacl,posix=0,user,noumount,auto` |
| `Z:` | `/z` | `hgfs` | `binary,noacl,posix=0,user,noumount,auto` |

Table 2-2 can confuse Windows users. The `C:/msys64` directory is mounted as the root path in the Unix environment. Then the C and Z disks are mounted into the root at the paths `/c` and `/z`. From the Unix environment's point of view, drive C is available at the Windows path `C:/msys64/c`. But in the Windows file system, there is a reversed relationship. There `C:/msys64` is a subdirectory of disk C.

In the Unix environment, this contradiction is not a problem. The `/c` path is the mount point. It exists only in the Unix environment. It does not exist in the Windows file system. You can imagine that the `/c` directory in MSYS2 is a [shortcut](https://en.wikipedia.org/wiki/Shortcut_(computing)) to drive C.

The output of the `mount` utility took up a lot of screen space. Press Ctrl+L to clear the terminal window.

It happens that a running command takes a long time to execute or hangs. Press Ctrl+C to interrupt its execution.

#### cd

We know the current directory. Now we can change it. For example, we are looking for the Bash documentation. Let's check the system directory `/usr`. Installed applications keep their files there. There is a built-in command `cd` for changing the directory. Launch it in this way:
{line-numbers: false, format: Bash}
```
cd /usr
```

Don't forget about autocompletion. It works for both the command name and its parameters. Just type `cd /u` and press the Tab key. Bash will automatically add the directory name `usr`. Figure 2-12 shows the result of the command.

{caption: "Figure 2-12. The result of the `cd` command"}
![cd result](images/BashShell/cd-command.png)

The `cd` command does not output anything if it succeeds. The only effect is changing the current directory. Run the command and check the output before the command prompt. The current directory is `/usr` now.

The `cd` command accepts both absolute and relative paths. Relative paths are shorter and faster to type. That is why they are used often for file system navigation.

We have moved to the `/usr` directory. Now you can list its subdirectories and go to one of them. Suppose instead that you need to go one level higher to the root directory. There are two ways to do this: go to the absolute path `/` or the special relative path `..`. The path `..` always points to the parent directory for the current one. This is the `cd` command to go this path:
{line-numbers: false, format: Bash}
```
cd ..
```

I> In addition to `..`, there is another special path `.`. It stands for the current directory. If you execute the command "cd .", nothing happens. You stay in the same place. The path `.` is needed to run programs from the current directory.

We are in the `/usr` directory. Let's run the ls utility here. In its output, there is the subdirectory `share`. There you can find the subdirectory `doc` with the documentation for the installed applications. The full path of the Bash documentation is `share/doc/bash`. This is the command to go there:
{line-numbers: false, format: Bash}
```
cd share/doc/bash
```

Now the current directory is `/usr/share/doc/bash`. Let's run the command ls. There are several files. One of them has the `README` name. This file is the Bash documentation that we are looking for.

Print the content of file `README` with the cat utility. This is the command to do that:
{line-numbers: false, format: Bash}
```
cat README
```

Figure 2-13 shows the command result.

{caption: "Figure 2-13. The result of the `cd` command", height: "30%"}
![cat result](images/BashShell/cat-command.png)

I> Some Bash manuals do not recommend using the cat utility to output a file's contents. The utility's purpose is to merge several files and print the result to a standard output stream. Instead of calling cat for a single file, the manuals recommend combining the echo command with stream redirection. Here is an example of this approach:
{line-numbers: false, format: Bash}
```
echo "$(< README.txt)"
```

Figure 2-13 does not show the entire `README` file. There are the last lines only. The file is large. Therefore, the output of the cat utility does not fit the terminal window. To see the beginning of the file, use the scroll bar on the window's right side. Use the Shift+PageUp and Shift+PageDown hotkeys to scroll [pages](https://en.wikipedia.org/wiki/Page_Up_and_Page_Down_keys). Shift+↑ and Shift+↓ allow you to scroll lines.

#### Command History

When you execute a command in the terminal, it is saved in the [command history](https://en.wikipedia.org/wiki/Command_history). These are the keys to navigate the history:

1. Press the up arrow ↑ and Enter to repeat the previous command.
2. Press the up arrow several times to the beginning of the history.
3. Press the down arrow ↓ to move to the next command in the history.

For example, you have entered the command "cat README". To repeat it, press the up arrow and Enter.

The keyboard shortcut Ctrl+R brings up a history search. Press Ctrl+R and start typing. Bash will prompt you for the last command you typed, which starts the same way. Press Enter to execute it.

Type the following command to print the entire command history:
{line-numbers: false, format: Bash}
```
history
```

The command history accumulates only commands that have been executed. It does not store commands that you typed and then erased.

What should you do if you want to save a command to the history without executing it? For example, you are going to execute it later. There is the trick with a comment for that. If a command starts with a #, Bash treats it as a comment. When you press Enter, it will go into the history, but it won't be executed. Using this trick, you can launch the cat utility in this way:
{line-numbers: false, format: Bash}
```
#cat README
```

Now let's execute the command. For doing it, find the command in the history. Then erase the hash symbol at the beginning and press Enter.

The Alt+Shift+3 keyboard shortcut does the comment trick in most terminals. It works like this:

1. Type a command, but don't press Enter.
2. Press Alt+Shift+3.
3. The command has been saved in the history without being executed.

How to copy text from the terminal? Suppose that another document needs a part of the `README` file. Use [**clipboard**](https://en.wikipedia.org/wiki/Clipboard_(computing)) to copy it. The clipboard is temporary storage for strings. The text selected in the terminal is stored there. You can paste it into any other window.

These are the steps to copy text from the terminal:

1. Select the text with the mouse. For doing it, hold down the left mouse button and drag the cursor over the text.

2. Press the middle mouse button to paste the text from the clipboard into the terminal window. The text will be inserted at the current cursor position.

3. Right-click and select the Paste item to paste the text to the application other than the terminal.

#### find

It is not convenient to search for a file or directory with `cd` and `ls`. There is a special `find` utility for this purpose.

If you run the `find` utility without parameters, it traverses all subdirectories of the current one and prints their contents. The output also includes hidden objects. Figure 2-14 shows the result of running `find` for the user's `~` home directory.

{caption: "Figure 2-14. The output of the `find` utility", height: "30%"}
![find output](images/BashShell/find-command.png)

The first parameter of the find utility is the directory to search in. The utility accepts relative and absolute paths. For example, here is a command to search in the root directory:
{line-numbers: false, format: Bash}
```
find /
```

The search conditions start from the second utility parameter. If the found object does not meet the conditions, `find` does not print it. The conditions are combined with each other and form a single expression. A special interpreter is built into the utility to process this expression. For example, a search condition can be a filename. In this case, only files with this name will appear in the `find` output.

Table 2-3 shows commonly used conditions for the `find` utility.

{caption: "Table 2-3. Commonly used conditions for the `find` utility", width: "100%"}
| Condition | Meaning | Example |
| --- | --- | --- |
| `-type f` | Search files only. | `find -type f` |
|  | | |
| `-type d` | Search directories only. | `find -type d` |
|  | | |
| `-name <pattern>` | Search for a file or directory with the name | `find -name README` |
| | that matches a [**glob pattern**](https://en.wikipedia.org/wiki/Glob_(programming)). The pattern is case-sensitive. | `find -name READ*` |
| | | `find -name READ??` |
|  | | |
| `-iname <pattern>` | Search for a file or directory with the name that matches a glob pattern. The pattern is case-insensitive. | `find -iname readme` |
|  | | |
| `-path <pattern>` | Search for a file or directory with the path that matches a glob pattern. The pattern is case-sensitive. | `find -path */doc/bash/*` |
|  | | |
| `-ipath <pattern>` | Search for a file or directory with the path that matches a glob pattern. The pattern is case-insensitive. | `find . -ipath */DOC/BASH/*` |
|  | | |
| `-a` or `-and` | Combine several conditions using logical AND. Only files and directories that satisfy all combined conditions appear in the output. | `find -name README -a -path */doc/bash/* ` |
|  | | |
| `-o` or `-or` | Combine several conditions with a logical OR. If a file or directory matches at least one condition, it appears in the output. | `find -name README -o -path */doc/bash/* ` |
|  | | |
| `!` or `-not` | It is a logical negation (NOT) | `find -not -name README` |
| | of the condition. Only files and directories that do not satisfy the condition appear in the output. | `find ! -name README` |

A glob pattern is a search query that contains [**wildcard characters**](https://en.wikipedia.org/wiki/Wildcard_character). There are three wildcard characters in Bash: *, ? и [. The asterisk stands for any number of any characters. A question mark means a single character of any kind. For example, the string `README` matches the following patterns:

* `*ME`
* `READM?`
* `*M?`
* `R*M?`

Square brackets indicate a set of characters at a specific position. For example, the pattern `[cb]at.txt` matches the files `cat.txt` and `bat.txt`. Here is a call to the `find` utility that searches with this pattern:
{line-numbers: false, format: Bash}
```
find . -name "[cb]at.txt"
```

{caption: "Exercise 2-1. Glob patterns", line-numbers: false}
```
What of the following lines corresponds to the pattern "*ME.??" ?

* 00_README.txt
* README
* README.md
```

{caption: "Exercise 2-2. Glob patterns", line-numbers: false}
```
What of the following lines corresponds to the pattern "*/doc?openssl*" ?

* /usr/share/doc/openssl/IPAddressChoice_new.html
* /usr/share/doc_openssl/IPAddressChoice_new.html
* doc/openssl
* /doc/openssl
```

Let's apply glob patterns into practice. We will find the Bash `README` file with the `find` utility. Suppose that we don't know the disk where the file is stored. Then we pass the root directory as the first parameter to `find`. This way, the utility looks for the file on all mounted disks. In the Unix environment, documents are stored in directories named `doc`. With this in mind, we make the following search command:
{line-numbers: false, format: Bash}
```
find / -path */doc/*
```

The command lists all documentation files on all mounted disks. There are too many files. We can shorten the list with extra search conditions. Add the word `bash` to the path of the file that we are looking for. Then we get the following command:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -path */bash/*
```

Figure 2-15 shows the result. The following command provides the same result:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -a -path */bash/*
```

The commands differ by the `-a` option between conditions. The option means logical AND. It is used by default if no logical operation is specified between conditions.

{caption: "Figure 2-15. The output of the `find` utility", height: "30%"}
![find output](images/BashShell/find-path-path.png)

At the end of the list, the find utility reports an error. The problem is some subdirectories of the root are mount points of the Windows disks. For example, the C drive is mounted in `/c`. The utility cannot access their contents when searching from the root directory. To avoid the error, start the search from the mount point of the C drive. You can do it this way:
{line-numbers: false, format: Bash}
```
find /c -path */doc/* -a -path */bash/*
```

An alternative solution is to exclude mount points from the search. To do this, pass the `-mount` option:
{line-numbers: false, format: Bash}
```
find / -mount -path */doc/* -a -path */bash/*
```

As a result, the `find` utility displays a short list of documents. Among them, it is easy to find the `README` file you need.

There are other ways to search for a documentation file. Suppose that we know its name. We put the name together with an assumed path. Then we get the following command:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README
```

Figure 2-16 shows the result of the search.

{caption: "Figure 2-16. The output of the `find` utility", height: "30%"}
![find output](images/BashShell/find-path-name.png)

Again we get a short list of files. It is easy to locate the right file there.

The conditions of the `find` utility can be grouped together. For doing it, use [escaped](https://en.wikipedia.org/wiki/Escape_character) parentheses. For example, let's find `README` files with path `*/doc/*` or `LICENSE` files with an arbitrary path. The following command does it:
{line-numbers: false, format: Bash}
```
find / \( -path */doc/* -name README \) -o -name LICENSE
```

Why escape brackets in a `find` utility expression? The parentheses are part of the Bash syntax. They are used in language constructs. When Bash meets parentheses in a command, it performs **substitution**. Substitution is the replacement of a part of command with something else. Escaping characters forces the interpreter to ignore the parentheses.  In this case, Bash passes them as is to the `find` utility.

The find utility can search for files and directories. Also, it can process them. You can specify an action after a search condition. The utility applies the action to each object it finds.

Table 2-4 shows the options for specifying actions.

{caption: "Table 2-4. Options for specifying actions on found objects", width: "100%"}
| Option | Meaning | Example |
| --- | --- | --- |
| `-exec команда {} \;`| Execute the specified command on each found object. | `find -name README -type f -exec cp {} ~ \;` |
|  | | |
| `-exec команда {} +`| Execute the specified command once over all found objects. So, the command receives all objects on the input. | ` find -type d -exec cp -t ~ {} +` |
|  | | |
| `-delete`| Delete each of the found files. The directories are deleted if they are empty. | `find -name README -type f -delete` |

There are two variants of the `-exec` action. They differ in the characters at the end: an escaped semicolon `\;` or plus +. The second case with plus works if the called command can handle several input parameters. Most GNU utilities can do this. If the command accepts only one parameter, it processes the first found object only.

Let's apply the `-exec` action to solve a practical task. We should copy the Bash documentation files with an HTML extension into the home directory. First, we should find these files with the find utility. The search command looks like this:
{line-numbers: false, format: Bash}
```
find / -path "*/doc/bash/*" -name "*.html"
```

When you pass glob patterns to the `find` utility, enclose them in double-quotes. The quotation marks do the same as the backslash before parentheses. They prevent Bash from interpreting the patterns. Then the `find` utility gets them as is and interprets them itself.

Figure 2-17 shows the result of searching the HTML files.

{caption: "Figure 2-17. The output of the `find` utility", height: "30%"}
![find output](images/BashShell/find-html.png)

Let's add the `-exec` action to the search command. It calls the `cp` utility. This utility copies files and directories to the specified path. The first parameter of `cp` is the object to copy. The second parameter is the path to copy to.  The final command looks the following:
{line-numbers: false, format: Bash}
```
find / -path "*/doc/bash/*" -name "*.html" -exec cp {} ~ \;
```

This command prints a mount point error only.

Let's see what the command did. It calls the `cp` utility for each HTML file it finds. The first parameter of `cp` is the path to the file. It was put in place of the curly braces {}. The `find` utility found two files. That is why `cp` is called twice like this:
{line-numbers: true, format: Bash}
```
cp ./usr/share/doc/bash/bash.html ~
cp ./usr/share/doc/bash/bashref.html ~
```

Each call copies one HTML file to the user's home directory.

We have just written our first program in the language of the `find` utility interpreter. The program works according to the following algorithm:

1. Find files with an HTML extension on all disks. Their paths correspond to the pattern `*/doc/bash/*`.

2. Copy each found file into the user's directory.

The program algorithm consists of two steps only. But it is a scalable solution for finding and copying files. The program will process dozens of files as fast as a couple of them.

You can combine the `-exec` actions in the same way as the search conditions. To give you an example, let's print out each found HTML file's contents and count the number of lines in it. The `cat` utility can print the content of the file. The `wc` utility counts the number of lines. At the input, `wc` takes the name of the file to be processed. In this case, the `find` call looks like this:
{line-numbers: false, format: Bash}
```
find / -path "*/doc/bash/*" -name "*.html" -exec cat {} \; -exec wc -l {} \;
```

We have not specified a logical operation between the `-exec` actions. The default is to use logical AND. It means that the second action is only executed if the first one succeeds. If we apply the logical OR instead, the second action is always executed. It would not depend on the result of the first one.

You can group the `-exec` actions with escaped parentheses `\(` and `\)`. It works in the same way as grouping search conditions.

{caption: "Exercise 2-3. Searching for files with the `find` utility", line-numbers: false}
```
Write a find call to search for text files in a Unix environment.
Extend the command to print the total number of lines in these files.
```

#### Logic Expressions

The search conditions of the `find` utility are [**Boolean expressions**](https://en.wikipedia.org/wiki/Boolean_expression). A Boolean expression is a programming language statement. Its calculation gives one of two possible results: "true" or "false".

The `find` conditions are statements of the utility's built-in interpreter. If the condition is met for a found object, its result equals "true". Otherwise, the condition result is "false". If there are several conditions, they are combined into a compound Boolean expression.

We met Boolean algebra already when we have considered the binary numeral system. This section of mathematics studies [**logical operators**](https://en.wikipedia.org/wiki/Logical_connective). They are different from the usual arithmetic operations: addition, subtraction, multiplication, and division.

The result of calculating a Boolean expression can be two values only. Therefore, arithmetic operations on such an expression are trivial and yield nothing. If we apply logical operators instead, we get conditions with strict rules for calculations. This way, we write a search condition for a file with a given name and path for the `find` utility. The combination of such conditions with actions provides a program with complex behavior.

An **operand** is an object of a logical operator. An operand can be an expression or a single value.

For simplicity, let's consider Boolean expressions using an example not related to the `find` utility. Imagine that we are programming a robot for a warehouse. Its job is to move boxes from point A to point B. To do this, we would write the following straightforward algorithm for the robot:

1. Move to point A.

2. Pick up the box at point A.

3. Move to point B.

4. Put the box at point B.

There are no conditions in this algorithm. It means that the robot performs each step independently of external events.

Now imagine that there is an obstacle in the way of the robot to point B. For example, there is another robot. In this case, the execution of the algorithm leads to a collision. We can add a condition in our algorithm to prevent the collision. It would look this way:

1. Move to point A.

2. Take the box at point A.

3. If there is no obstacle, move to point B. Otherwise, stop.

4. Put the box at point B.

The third step of the algorithm is called [**conditional statement**](https://en.wikipedia.org/wiki/Conditional_(computer_programming)). All modern programming languages have such a statement.

The algorithm of the conditional statement looks like this:

1. Calculate the value of the operand.

2. If the result equals "true", perform the first action.

3. If the result is "false", perform the second action.

In our example, the robot calculates the value of the Boolean expression "there is no obstacle". If there is an obstacle, the expression returns false and the robot stops. Otherwise, the robot moves to point B.

Logical operators allow you to combine several expressions into one. For example, the robot tries to pick up a box at point A, but there is no box. Then there is no reason for him to move to point B. We can add this condition to the existing expression using [**logical AND**](https://en.wikipedia.org/wiki/Logical_conjunction) (conjunction). Now the robot algorithm looks like this:

1. Move to point A.

2. Take the box at point A.

3. If there is a box AND no obstacle, move to point B. Otherwise, stop.

4. Put the box at point B.

Calculating logical operators also yields "true" or "false". The result of a logical AND equals "true" when both operands are "true". For our examples, it means that the robot has a box and there is no obstacle. In any other case, the result of logical AND equals "false". Then the robot stops.

Working with the `find` utility, we got acquainted with two more logical operators: [**OR**](https://en.wikipedia.org/wiki/Logical_disjunction) (disjunction) and [**NOT**](https://en.wikipedia.org/wiki/Negation) (negation).

Actually, we already applied logical NOT in the robot algorithm. It stays implicitly in the expression "there is no obstacle". It equals to the following negation: "there is NOT an obstacle". Let's specify the logical NOT in the algorithm explicitly:

1. Move to point A.

2. Get the box at point A.

3. If there is a box AND there is NOT an obstacle, move to point B. Otherwise, stop.

4. Put the box at point B.

You can always replace logical AND by OR in the Boolean expression. Let's do it for our example. We want to change the operator but keep the robot's behavior the same. Then we would add negation to the first condition and remove it from the second one. Also, let's change the order of actions in the conditional statement. Now, if the expression is true, the robot stops. If it is false, the robot moves to point B. The final algorithm looks this way:

1. Move to point A.

2. Get the box at point A.

3. If there is NOT a box OR there is an obstacle, stop. Otherwise, move to point B.

4. Put the box at point B.

Read the new conditional statement carefully. The robot follows the same decisions. It still stops if it has no box or if there is an obstacle in the way.

In our example, we wrote the Boolean expression as a sentence in English. This sentence sounds unnatural. You have to read it several times to understand it. The reason is that the [**natural language**](https://en.wikipedia.org/wiki/Natural_language) (the language of human communication) is not suitable for writing Boolean expressions. This language is not accurate enough. That is why Boolean algebra uses mathematical notation instead.

We have considered logical AND, OR and NOT. Three other operations are used in programming often:

* Equivalence
* Non-equivalence
* Exclusive OR

Table 2-5 explains them.

{caption: "Table 2-5. Logical operators", width: "100%"}
| Operator | Calculation Result |
| --- | --- |
| AND | It returns "true" when both operands are "true". |
|  | |
| OR | It returns "true" when any of the operands is "true". It returns "false" when all operands are "false". |
|  | |
| NOT | It returns "true" when the operand is "false" and vice versa. |
|  | |
| Exclusive OR (XOR) | It returns "true" when the operands have different values (true-false or false-true). It returns "false" when the operands are the same (true-true, false-false). |
|  | |
| Equivalence | It returns "true" when the operands have the same values. |
|  | |
| Non-equivalence | It returns "true" when the values of the operands differ. |

Try to memorize this table. It is simple when you use logical operators often.

#### grep

The `grep` utility is another search tool. It searches for files based on their contents.

When to use the `find` utility and when to use `grep`? Use `find` for searching a file or directory by name, path or [**metadata**](https://en.wikipedia.org/wiki/Metadata). Metadata is additional information about an object. These are examples of the file metadata: size, time of creation and last modification, access rights. Use the `grep` utility to find a file when you know nothing about it except its contents.

Let's look at an example. It shows you how to choose the right utility for searching. We are looking for a documentation file. We know that it contains the phrase "free software". If we apply the `find` utility, the search algorithm looks following:

1. Find all the files with the name `README` using the `find` utility.

2. Open each file in a text editor and check if it has the phrase "free software".

When you use a text editor for checking the file content, it takes a long time. You should open the file, pick a search option, type the text for searching. The `grep` utility automates all these steps. The following command finds the line "free software" in the `README` file:
{line-numbers: false, format: Bash}
```
grep "free software" /usr/share/doc/bash/README
```

The first parameter of the utility is a string for searching. Do not forget to put it in the double-quotes. This way, we force Bash to pass the string to the utility unchanged. Without the quotes, space splits the phrase into two separate parameters. This Bash mechanism of splitting strings into words is called [**word splitting**](http://mywiki.wooledge.org/WordSplitting).

The second parameter of `grep` is a relative or absolute path to the file. If you specify a list of files separated by spaces, the utility handles them all. In the example, we passed only one path to the `README` file.

Figure 2-18 shows the result of the `grep` utility.

{caption: "Figure 2-18. The output of the `grep` utility", width: "100%"}
![grep output](images/BashShell/grep-command.png)

The utility outputs all lines of the file where it found the specified phrase. You can improve the output by adding the line numbers there. The `-n` option of `grep` does it. Add the option before the first parameter when calling the utility. Figure 2-18 shows the result of such a call.

We have learned how to use `grep` to find a phrase in the specified files. Now let's apply the utility to solve our task. We are looking for the documentation files with the phrase "free software". There are two ways to reach it with the `grep` utility:

* Use Bash search patterns.
* Use the file search mechanism of the `grep` utility.

Let's consider the first method. Suppose the user has two text files in his home directory: `bash.txt` and `xz.txt`. These are copies of `README` documents of the Bash and `xz` programs. Find out which one contains the phrase "free software". To do it, execute the following two commands:
{line-numbers: true, format: Bash}
```
cd ~
grep "free software" *
```

First, we navigate to the user's home directory. Then we call the `grep` utility.

When calling `grep`, we have specified the asterisk for the target file path. This wildcard means any string. Bash substitutes all wildcards in the command before launching it. In our case, we get the list of the home directory files instead of the pattern. The resulting `grep` call looks like this:
{line-numbers: false, format: Bash}
```
grep "free software" bash.txt xz.txt
```

Launch both versions of the `grep` call: with a `*` pattern and with a list of files. The utility gives the same result for both cases.

We can exclude the `cd` command from our solution. To do it, we add a path to the directory in the search pattern. Then the `grep` call becomes like this:
{line-numbers: false, format: Bash}
```
grep "free software" ~/*
```

You can check how the Bash substitutes the search pattern. Use the `echo` command for that. Let's check the patterns from our examples with the `grep` utility:
{line-numbers: true, format: Bash}
```
echo *
echo ~/*
```

Run these commands. They output the files in the home directory.

You should not enclose search patterns in double-quotes. There is an example of the wrong command:
{line-numbers: false, format: Bash}
```
grep "free software" "*"
```

Because of the quotes, Bash does not unfold the pattern. It passes the pattern as it is to the `grep` utility. It cannot unfold the pattern on its own as the `find` utility does. Therefore, such a call causes an error like in Figure 2-19.

{caption: "Figure 2-19. The result of processing a search pattern by `grep`", width: "100%"}
![grep error](images/BashShell/grep-error.png)

Bash does not include hidden files and directories when it substitutes the pattern `*`. Therefore, the `grep` utility does not get them as input in our example. The search pattern for hidden files is `.*`. You can search for all kinds of files at once. Specify two patterns separated by a space in this case. There is an example command:
{line-numbers: false, format: Bash}
```
grep "free software" * .*
```

There is an alternative for the Bash search patterns. You can use the built-in feature of the `grep` utility. It searches the files in the specified directory. The `-r` option enables this mode of the utility. If you use the option, specify the search directory instead of the file name in the last `grep` parameter.

The following command finds the "free software" phrase in the files of the current directory:
{line-numbers: false, format: Bash}
```
grep -r "free software" .
```

This `grep` call handles the hidden files in the current directory too. At the same time, it does not handle the files in the subdirectories. To do that, replace the `-r` option with `-R`. There is an example:
{line-numbers: false, format: Bash}
```
grep -R "free software" .
```

You can specify the target directory by a relative or absolute path. Here are the examples for both cases:
{line-numbers: true, format: Bash}
```
cd /home
grep -R "free software" ilya.shpigor/tmp
grep -R "free software" /home/ilya.shpigor/tmp
```

Suppose we are interested in a list of files that contain a phrase. In the normal mode, the grep utility outputs all occurrences of the search phrase. It is an extra output, which is not always needed. Let's remove it with the `-l` option. Here is an example:
{line-numbers: false, format: Bash}
```
grep -Rl "free software" .
```

Figure 2-20 shows the result of this command.

{caption: "Figure 2-20. The `grep` outputs filenames only"}
![grep output](images/BashShell/grep-files.png)

We got a list of files where the phrase "free software" occurs at least once. Suppose we want the opposite result: a list of files without the phrase. To do that, use the `L` option. There is an example:
{line-numbers: false, format: Bash}
```
grep -RL "free software" .
```

The program source code files contain text. The `grep` utility works with text files only. Therefore, grep does a good job of searching through the source code. Use it as an add-on to your editor.

You may have liked the grep utility. Now you want to process [PDF](https://en.wikipedia.org/wiki/PDF) and MS Office documents with it. Unfortunately, this approach does not work. The format of these files is not text. The data are encoded there. To process such files, you need another utility. Table 2-6 shows `grep` alternatives for non-text files.

{caption: "Table 2-6. Utilities for text searching in PDF and MS Office files", width: "100%"}
| Utility | Features |
| --- | --- |
| [pdftotext](http://www.xpdfreader.com) | It converts a PDF file into text format. |
|  | |
| [pdfgrep](https://pdfgrep.org) | It searches a PDF file by its content. |
|  | |
| [antiword](http://www.winfield.demon.nl) | It converts a MS Office document into text format. |
|  | |
| [catdoc](https://www.wagner.pp.ru/~vitus/software/catdoc) | It converts a MS Office document into text format. |
|  | |
| [xdoc2txt](https://documentation.help/xdoc2txt/xdoc2txt_en.html) | It converts PDF and MS Office files into text format. |

The package manager `pacman` can install some of these utilities in your MSYS2 environment. We will see how to do it in the last chapter of the book.

{caption: "Exercise 2-4. Searching for files with the `grep` utility", line-numbers: false}
```
Write a grep call to find system utilities with a free license.
The preferred licenses for open-source software are the following:

1. GNU General Public License
2. MIT license
3. Apache license
4. BSD license
```