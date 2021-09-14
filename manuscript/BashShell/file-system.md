## Navigating the File System

Let's start introducing the Unix environment and Bash with a [**file system**](https://en.wikipedia.org/wiki/File_system). A file system is a software that dictates how to store and read data from disks. It covers the following topics:

* API to access data on the disk that programs can use.

* Universal way for accessing different storage devices.

* Physical operations on the disk storage.

First, we will look at the differences between the directory structure in Unix and Windows. Then we will learn the Bash commands for navigating the file system.

### Directory Structure

There is an address bar at the top of the Windows Explorer window. It displays the **absolute path** to the current directory. An absolute path shows the place of the file system object regardless of the current directory.

Another way to specify the file system object place is using the **relative path**. It shows you how to reach the object from the current directory.

A [directory](https://en.wikipedia.org/wiki/Directory_(computing)) is a file system cataloging structure. It can contain files and other directories. Windows terminology calls it [**folder**](https://en.wikipedia.org/wiki/Directory_(computing)#Folder_metaphor). Both names mean the same kind of file system object.

Figure 2-6 shows an Explorer window. The address bar equals `This PC > Local Disk (C:) > msys64` there. It matches the `C:\msys64` absolute path. Thus, we see the contents of the `msys64` directory on the `C` drive in the Explorer window.

The letter `C` in the path denotes the local system disk drive. The local drive means the device that is connected to your computer physically. You can also have a network drive. You access such a device via the network. The system disk means one that has the Windows installation on it.

{caption: "Figure 2-6. Windows Explorer"}
![Windows Explorer](images/BashShell/explorer.png)

If you run the MSYS2 terminal emulator, it shows you the current absolute path at the end of the first line. This line behaves like the address bar of Windows Explorer. When you change the current directory, the current path changes too. However, you have to consider that the terminal and Explorer show you different paths for the same current directory. It happens because directory structures of the Unix environment and Windows do not match.

Windows marks each disk drive with a Latin letter. You can open the drive using Explorer as a regular folder. Then you access its content.

For example, let's open the `C` system drive. It has a [standard set of directories](https://en.wikipedia.org/wiki/Directory_structure#Windows_10). Windows has created them during the installation process. If you open the `C` drive in Explorer, you see the following directories there:

* `Windows`
* `Program Files`
* `Program Files (x86)`
* `Users`
* `PerfLogs`

These directories store OS components, user applications and temporary files.

You can connect extra disk drives to your computer. Another option is to split a single disk into several logical partitions. Windows will assign the Latin letters (`D`, `E`, `F`, etc) to these extra disks and partitions. You are allowed to create any directory structure there. Windows does not restrict you in any way.

The [File Allocation Table](https://en.wikipedia.org/wiki/File_Allocation_Table) (FAT) file system dictates how Windows manages disks and provides you access to them. Microsoft developed this file system for the [MS-DOS](https://en.wikipedia.org/wiki/MS-DOS) OS. The principles of FAT became the basis of the [ECMA-107](http://www.ecma-international.org/publications/standards/Ecma-107.htm) standard. The next-generation file system from Microsoft is called [NTFS](https://en.wikipedia.org/wiki/NTFS). It replaced the obsolete FAT in modern versions of Windows. However, the basic principles of disks and directory structure are the same in NAT and FAT. The reason for that is the backward compatibility requirement.

The Unix directory structure follows the [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap10.html#tag_10). This structure gives you less freedom than the Windows one. It has several predefined directories that you cannot move or rename. You are allowed to put your data in the specific paths only.

The POSIX standard says that the file system should have a top-level directory. It is called the [**root directory**](https://en.wikipedia.org/wiki/Root_directory). The slash sign / denotes it. All directories and files of all connected disk drives are inside the root directory.

If you want to access the contents of a disk drive, you should mount it. **Mounting** means embedding the contents of a disk into the root directory. When mounting is done, you can access the disk contents through some path. This path is called a [**mount point**](https://en.wikipedia.org/wiki/Mount_(computing)). If you go to the mount point, you enter the file system of the disk.

Let's compare the Windows and Unix directory structures by example. Suppose that your Windows computer has two local disks `C` and `D`. Listing 2-1 shows their directory structure.

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

Suppose that you have installed the Unix environment on your Windows. Then you run the terminal emulator and get the directory structure from Listing 2-2.

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

Since you launch the MSYS2 terminal, you enter the Unix environment. Windows paths don't work there. You should use Unix paths instead. For example, you can access the `C:\Windows` directory via the `/c/Windows` path only.

There is another crucial difference between Unix and Windows file systems besides the directory structure. The [character case](https://en.wikipedia.org/wiki/Case_sensitivity) makes strings differ in the Unix environment. It means that two words with the same letters are not the same if their character case differs. For example, the `Documents` and `documents` words are not equal. Windows has no case sensitivity. If you type the `c:\windows` path in the Explorer address bar, it opens the `C:\Windows` directory. This approach does not work in the Unix environment. You should type all characters in the proper case.

Here is the last point to mention regarding Unix and Windows file systems. Use the slash sign / to separate directories and files in Unix paths. When you work with Windows paths, you use backslash \ for that.

### File System Navigation Commands

We are ready to learn our first Bash commands. Here are the steps to execute a shell command:

1. Open the terminal window.
2. Type the command there.
3. Press Enter.

The shell will execute your command.

When the shell is busy, it cannot process your input. You can distinguish the shell's state by the [**command prompt**](https://en.wikipedia.org/wiki/Command-line_interface#Command_prompt). It is a sequence of one or more characters. The default prompt is the dollar sign $. You can see it in Figure 2-4. If the shell prints the prompt, it is ready for executing your command.

Windows Explorer allows you the following actions to navigate the file system:

* Display the current directory.
* Go to a specified disk drive or directory.
* Find a directory or file on the disk.

You can do the same actions with the shell. It provides you a corresponding command for each action. Table 2-1 shows these commands.

{caption: "Table 2-1. Commands and utilities for navigating the file system", width: "100%"}
| Command | Description | Examples |
| --- | --- | --- |
| `ls` | Display the contents of the directory. | `ls` |
| | If you call the command without parameters, it shows you the contents of the current directory. | `ls /c/Windows` |
|  | | |
| `pwd` | Display the path to the current directory. | `pwd` |
| | When you add the `-W` parameter, the command displays the path in the Windows directory structure. |
|  | | |
| `cd` | Go to the directory at the specified | `cd tmp` |
| | relative or absolute path. | `cd /c/Windows` |
| | | `cd ..` |
|  | | |
| `mount` | Mount the disk to the root file system. If you call the command without parameters, it shows a list of all mounted disks. | `mount` |
|  | | |
| `find` | Find a file or directory. The first parameter | `find . -name vim` |
| | specifies the directory to start searching. | `find /c/Windows -name *vim*` |
|  | | |
| `grep` | Find a file by its contents. | `grep "PATH" *` |
| | | `grep -Rn "PATH" .` |
| | | `grep "PATH" * .*` |

Bash can perform `pwd` and `cd` commands of Table 2-1 only. They are called [**built-ins**](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html). Special utilities perform all other commands of the table. Bash calls an appropriate utility if it cannot execute your command on its own.

The MSYS2 environment provides a set of GNU utilities. These are auxiliary highly specialized programs. They give you access to the OS features in Linux and macOS. However, their capabilities are limited in Windows. Bash calls GNU utilities to execute the following commands of Table 2-1:

* `ls`
* `mount`
* `find`
* `grep`

When you read an article about Bash on the Internet, its author can confuse the "command" and "utility" terms. He names both things "commands". This is not a big issue. However, I recommend you to distinguish them. Calling a utility takes more time than calling Bash built-in. It causes performance overhead in some cases.

#### pwd

Let's consider the commands in Table 2-1. You have just started the terminal. The first thing you do is to find out the current directory. You can get it from the command prompt, but it depends on your Bash configuration. You do not have this feature enabled by default in Linux and macOS.

When you start the terminal, it opens the home directory of the current user. Bash abbreviates this path by the tilde symbol ~. You see this symbol before the command prompt. Use tilde instead of the home directory absolute path. It makes your commands shorter.

Call the `pwd` command to get the current directory. Figure 2-7 shows this call and its output. The command prints the absolute path to the user's home directory. It equals `/home/ilya.shpigor` in my case.

If you add the `-W` **option** to the call, the command prints the path in the Windows directory structure. It is useful when you create a file in the MSYS2 environment and open it in a Windows application afterward. Figure 2-7 shows you the result of applying the `-W` option.

{caption: "Figure 2-7. The output of the `pwd` command"}
![Output pwd](images/BashShell/pwd-command.png)

What is a command option? When the program has a CLI only, you have very limited ways to interact with it. The program needs some data on input to do its job. The shell provides you a simple way to pass these data. Just type them after the command name. These data are called **arguments** of the program. Bash terminology distinguishes two kinds of arguments: parameter and option. A [**parameter**](https://en.wikipedia.org/wiki/Command-line_interface#Arguments) is the regular word or character you pass to the program. An **option** or **key** is an argument that switches the mode of a program. The standard dictates the option format. It is a word or character that starts with a dash `-` or a double dash `--`.

You pass data to the CLI programs and Bash built-ins in the same way. Use parameters and options for doing that.

Typing long commands is inconvenient. Bash provides the autocomplete feature to save your time. Here are the steps for using it:

1. Type the first few letters of the command.

2. Press the Tab key.

3. If Bash finds the command you mean, it completes it.

4. If several commands start with the typed letters, autocomplete does not happen. Press Tab again to see the list of these commands.

Figure 2-8 demonstrates how the autocomplete feature works. Suppose that you type the "pw" word. Then you press the Tab key twice. Bash shows you the commands that start with "pwd" as Figure 2-8 shows.

{caption: "Figure 2-8. Autocomplete for the "pw" command"}
![Autocomplete pw](images/BashShell/pw-autocompletion.png)

#### ls

We got the current directory using the `pwd` command. The next step is checking the directory content. The `ls` utility does this task.

Suppose that you have just installed the MSYS2 environment. Then you launched the terminal first time. You are in the user's home directory. Call the "ls" command there. Figure 2-9 shows its result. The command output has nothing. It means that the directory is empty or has hidden files and directories only.

{caption: "Figure 2-9. The output of the `ls` utility"}
![Output ls](images/BashShell/ls-command.png)

Windows has a concept of hidden files and directories. The Unix environment also has it. Applications and OS create hidden files for their own needs. These files store configuration and temporary data.

I> Windows Explorer does not display hidden files and directories by default. Change the [Explorer settings](https://support.microsoft.com/en-us/windows/show-hidden-files-0320fe58-0117-fd59-6851-9b7f9840fdb2) to see them.

You can make the file hidden in Windows by changing its attribute. If you want to do the same in Unix, you should add a dot at the beginning of the filename.

When you launch the `ls` utility without parameters, it does not show you hidden objects. You can add the `-a` option to see them. Figure 2-9 shows a result of such a call.

The `ls` utility can show the contents of the specified directory. Pass a directory's absolute or relative path to the utility. For example, the following command shows the contents of the root directory:
{line-numbers: false, format: Bash}
```
ls /
```

Figure 2-10 shows the output of this command.

{caption: "Figure 2-10. The output of the `ls` utility"}
![Output ls](images/BashShell/ls-root-command.png)

There are no directories `/c` and `/d` in Figure 2-10. These are the mount points of C and D disk drives according to Listing 2-2. The mounting points are in the root directory. Why does not the `ls` utility print them? It happens because the Windows file system does not have a concept of mount points. Therefore, it does not have directories `/c` and `/d`. They are present in the Unix environment only. These are not real directories but paths where you can access the disk file systems. The `ls` utility reads the directory contents in the Windows file system. Thus, it does not show the mount points. The `ls` utility behaves differently in Linux and macOS. It shows mount points properly there.

#### mount

If your computer has several disk drives, you can read their mount points. Call the [`mount`](https://en.wikipedia.org/wiki/Mount_(Unix)) utility without parameters for doing that. Figure 2-11 shows its output.

{caption: "Figure 2-11. The output of the `mount` utility"}
![Output mount](images/BashShell/mount-command.png)

Consider this output as a table with four columns. The columns display the following values:

1. The disk drive, its partition or directory. It is the object that the OS has mounted to the root directory.

2. Mount point. It is the path where you can access the mounted disk drive.

3. The file system type of the disk drive.

4. Mounting parameters. An example is access permissions to the disk contents.

If we split the `mount` utility output into these columns, we get Table 2-2.

{caption: "Table 2-2. The output of the `mount` utility", width: "100%"}
| Mounted partition | Mount point | FS type | Mounting parameters |
| --- | --- | --- | --- |
| `C:/msys64` | `/` | `ntfs` | `binary,noacl,auto` |
| `C:/msys64/usr/bin` | `/bin` | `ntfs` | `binary,noacl,auto` |
| `C:` | `/c` | `ntfs` | `binary,noacl,posix=0,user,noumount,auto` |
| `Z:` | `/z` | `hgfs` | `binary,noacl,posix=0,user,noumount,auto` |

Table 2-2 confuses most Windows users. MSYS2 mounts `C:/msys64` as the root directory. Then it mounts the C and Z disks into the root. Their mount points are `/c` and `/z`. It means that you can access the C drive via the `C:/msys64/c` Windows path in the Unix environment. However, `C:/msys64` is the subdirectory of disk C in the Windows file system. We got a contradiction.

Actually, there is no contradiction. The `/c` path is the mount point that exists only in the Unix environment. It does not exist in the Windows file system. Therefore, Windows knows nothing about the `C:/msys64/c` path. It is just invalid if you try to open it via Explorer. You can imagine the mount point `/c` as the [shortcut](https://en.wikipedia.org/wiki/Shortcut_(computing)) to drive C that exists in the MSYS2 environment only.

The output of the `mount` utility took up a lot of screen space. You can clear the terminal window by the Ctrl+L keystroke.

Another useful keystroke is Ctrl+C. It interrupts the currently running command. Use it if the command hangs or you want to stop it.

#### cd

You have got everything about the current directory. Now you can change it. Suppose that you are looking for the Bash documentation. You can find it in the `/usr` system directory. Installed applications stores their non-executable files there. Call the `cd` command to go to the `/usr` path. Do it this way:
{line-numbers: false, format: Bash}
```
cd /usr
```

Do not forget about autocompletion. It works for both command and its parameters. Just type "cd /u" and press the Tab key. Bash adds the directory name `usr` automatically. Figure 2-12 shows the result of the command.

{caption: "Figure 2-12. The result of the `cd` command"}
![cd result](images/BashShell/cd-command.png)

The `cd` command does not output anything if it succeeds. It changes the current directory and that is it. You can read the new path in the line above the command prompt. This line shows the `/usr` path after our `cd` call.

The `cd` command accepts both absolute and relative paths. Relative paths are shorter. Therefore, you type them faster. Prefer them when navigating the file system using a command shell.

There is a simple rule to distinguish the type of path. An absolute path starts with a slash /. An example is `/c/Windows/system32`. A relative path starts with a directory name. An example is `Windows/system32`.

Now you are in the `/usr` directory. You can get a list of its subdirectories and go to one of them. Suppose that you want to go one level higher and reach the root directory. There are two ways for doing that: go to the absolute path `/` or the special relative path `..`. The `..` path always points to the parent directory of the current one. Use it in the `cd` call this way:
{line-numbers: false, format: Bash}
```
cd ..
```

I> In addition to `..`, there is another special path `.` (dot). It points to the current directory. If you execute the command "cd .", nothing happens. You stay in the same place. You need the `.` path to run programs from the current directory.

Come back to the `/usr` directory. Then run the `ls` utility there. It will show you the `share` subdirectory. Come to this directory and call `ls` again. You will find the `doc` directory there. It contains Bash documentation. Call the `cd` command this way to reach the documentation:
{line-numbers: false, format: Bash}
```
cd doc/bash
```

You are in the `/usr/share/doc/bash` directory now. Call the `ls` utility there. It will show you several files. One of them is `README`. It contains a brief description of the Bash interpreter.

You found the documentation file. The next step is to print its contents. The `cat` utility does that. Here is an example of how to run it:
{line-numbers: false, format: Bash}
```
cat README
```

Figure 2-13 shows the terminal window after the `cat` call.

{caption: "Figure 2-13. The result of the `cat` utility", height: "30%"}
![cat result](images/BashShell/cat-command.png)

I> Some Bash manuals do not recommend printing file contents using the `cat` utility. They said that the utility's purpose is to merge several files and print the result. The manuals suggest combining the `echo` command with a stream redirection. Here is an example of this approach:
{line-numbers: false, format: Bash}
```
echo "$(< README.txt)"
```

The `README` file contents do not fit in the terminal window. Therefore, you see the tail of the file in Figure 2-13. Use the scroll bar on the window's right side to check the head of the file. Also, use the Shift+PageUp and Shift+PageDown hotkeys to scroll [pages](https://en.wikipedia.org/wiki/Page_Up_and_Page_Down_keys) up and down. The Shift+↑ and Shift+↓ keystrokes scroll the lines.

#### Command History

Whenever you call a command, Bash saves it in the [command history](https://en.wikipedia.org/wiki/Command_history). You can navigate the history by up and down arrow keys. Bash automatically types the corresponding command. You just need to press Enter for launching it. For example, you have called the "cat README"  command. Press the up arrow and Enter to repeat it.

The Ctrl+R shortcut brings up a search over all command history. Press Ctrl+R and start typing. Bash will show you the last called command that begins with these characters. Press Enter to execute it.

The `history` command shows you the whole history. Run it without parameters this way:
{line-numbers: false, format: Bash}
```
history
```

The history stores the command that you have executed. It does not keep the command that you typed and then erased.

There is a trick to save the command to the history without executing it. Add the hash symbol # before the command and press Enter. Bash stores the typed line, but it does not execute it. This happens because the hash symbol means comment. When the interpreter meets a comment, it ignores this line. However, Bash adds the commented lines in the history because they are legal constructions of the language.

Here is an example of the trick with comment for our `cat` utility call:
{line-numbers: false, format: Bash}
```
#cat README
```

You have saved the commented command in the history. Now you can find it there by pressing the up arrow key. Remove the hash symbol at the beginning of the line and press Enter. Bash will execute your command.

You can do the comment trick by the Alt+Shift+3 shortcut. It works in most modern terminal emulators. Here are the steps for using the shortcut:

1. Type a command, but do not press Enter.
2. Press Alt+Shift+3.
3. Bash saves the command in the history without executing it.

Sometimes you need to copy text from the terminal window. It can be a command or its output. Here is an example. Suppose that some document needs a part of the Bash `README` file. Use the [**clipboard**](https://en.wikipedia.org/wiki/Clipboard_(computing)) to copy it. The clipboard is temporary storage for text data. When you select something in the terminal window with a mouse, the clipboard saves it automatically. Then you can paste this data to any other window.

These are the steps to copy text from the terminal window:

1. Select the text with the mouse. Hold down the left mouse button and drag the cursor over the required text.

2. Press the middle mouse button to paste the text from the clipboard into the same or another terminal window. You insert the text at the current cursor position.

3. Right-click and select the "Paste" item to paste the text to the application other than the terminal.

#### find

It is inconvenient to search for a file or directory with `cd` and `ls` commands. The special `find` utility does it better.

If you run the `find` utility without parameters, it traverses the contents of the current directory and prints it. The output includes hidden objects. Figure 2-14 shows the result of running `find` in the home directory.

{caption: "Figure 2-14. The output of the `find` utility", height: "30%"}
![find output](images/BashShell/find-command.png)

The first parameter of `find` is the directory to search in. The utility accepts relative and absolute paths. For example, the following command shows the contents of the root directory:
{line-numbers: false, format: Bash}
```
find /
```

You can specify search conditions starting from the second parameter. If the found object does not meet these conditions, `find` does not print it. The conditions form a single expression. The utility has an embedded interpreter that processes this expression.

An example of the `find` condition is the specific filename. When you call the utility with such a condition, it prints the found files with this name only.

Table 2-3 shows the format of commonly used conditions for the `find` utility.

{caption: "Table 2-3. Commonly used conditions for the `find` utility", width: "100%"}
| Condition | Meaning | Example |
| --- | --- | --- |
| `-type f` | Search files only. | `find -type f` |
|  | | |
| `-type d` | Search directories only. | `find -type d` |
|  | | |
| `-name <pattern>` | Search for a file or directory with the | `find -name README` |
| | name that matches a [**glob pattern**](https://en.wikipedia.org/wiki/Glob_(programming)). The | `find -name READ*` |
| | pattern is case-sensitive. | `find -name READ??` |
|  | | |
| `-iname <pattern>` | Search for a file or directory with the name that matches a glob pattern. The pattern is case-insensitive. | `find -iname readme` |
|  | | |
| `-path <pattern>` | Search for a file or directory with the path that matches a glob pattern. The pattern is case-sensitive. | `find -path */doc/bash/*` |
|  | | |
| `-ipath <pattern>` | Search for a file or directory with the path that matches a glob pattern. The pattern is case-insensitive. | `find . -ipath */DOC/BASH/*` |
|  | | |
| `-a` or `-and` | Combine several conditions using the logical AND. If the found object fits all conditions, the utility prints it. | `find -name README -a -path */doc/bash/* ` |
|  | | |
| `-o` or `-or` | Combine several conditions using the logical OR. If the found object fits at least one condition, the utility prints it. | `find -name README -o -path */doc/bash/* ` |
|  | | |
| `!` or `-not` | The logical negation (NOT) of the | `find -not -name README` |
| | condition. If the found object does not fit the condition, the utility prints it. | `find ! -name README` |

A glob pattern is a search query that contains [**wildcard characters**](https://en.wikipedia.org/wiki/Wildcard_character). Bash allows three wildcard characters: *, ? and [. The asterisk stands for any number of any characters. A question mark means a single character of any kind.

Here is an example of glob patterns. The string `README` matches all following patterns:

* `*ME`
* `READM?`
* `*M?`
* `R*M?`

Square brackets indicate a set of characters at a specific position. For example, the pattern "[cb]at.txt" matches the `cat.txt` and `bat.txt` files. You can apply this pattern to the `find` call this way:
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

Let's apply glob patterns into practice. Suppose that you do not know the Bash `README` file location and looking for it. Then you should use the `find` utility.

Start searching with the utility from the root directory. Now you need a search condition. It is a common practice to store documentation in directories called `doc` in Unix. Therefore, you can search files in these directories only. This way, you get the following `find` call:
{line-numbers: false, format: Bash}
```
find / -path */doc/*
```

The command shows you all documentation files on all mounted disks. This is a huge list. You can shorten it with an extra search condition. It should be a separate directory for the Bash documentation. The directory is called `bash`. Add this path as the second search condition. Then you get the following command:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -path */bash/*
```

Figure 2-15 shows the result of this command.

The following `find` call provides the same result:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -a -path */bash/*
```

Our `find` calls differ by the `-a` option between conditions. The option means logical AND. If you do not specify any logical operator between conditions, `find` inserts AND by default. This is a reason why both calls provide the same result.

{caption: "Figure 2-15. The output of the `find` utility", height: "30%"}
![find output](images/BashShell/find-path-path.png)

You can see that the `find` utility reports an error in Figure 2-15. The mount points of Windows disk drives cause it. The utility cannot access them when you start searching from the root directory. You can avoid the problem if you start searching from the `/c` mount point. Do it this way:
{line-numbers: false, format: Bash}
```
find /c -path */doc/* -a -path */bash/*
```

There is an alternative solution. You should exclude mount points from the search. The `-mount` option does this. Apply the option this way:
{line-numbers: false, format: Bash}
```
find / -mount -path */doc/* -a -path */bash/*
```

When you add the second search condition, the `find` utility shows a short list of documents. You can find the right `README` file easily there.

There are other ways to search for the documentation file. Suppose that you know its name. Then you can specify it together with an assumed path. You will get the `find` call like this:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README
```

Figure 2-16 shows the result of this command.

{caption: "Figure 2-16. The output of the `find` utility", height: "30%"}
![find output](images/BashShell/find-path-name.png)

Again you got a short list of files. It is easy to locate the right file there.

You can group the conditions of the `find` utility. Do it using the [escaped](https://en.wikipedia.org/wiki/Escape_character) parentheses. Here is an example of using them. Let's write the `find` call that searches `README` files with path `*/doc/*` or `LICENSE` files with an arbitrary path. This call looks like this:
{line-numbers: false, format: Bash}
```
find / \( -path */doc/* -name README \) -o -name LICENSE
```

Why should you apply backslashes to escape brackets here? The parentheses are part of the Bash syntax. Therefore, Bash treats them like language constructs. When Bash meets parentheses in a command, it performs an **expansion**. The expansion is the replacement of a part of the command with something else. When you escape parentheses, you force Bash to ignore them. Thus, Bash does not perform the expansion and passes all search conditions to the `find` utility as it is.

The `find` utility can process the found objects. You can specify an action to apply as an extra option. The utility will apply this action to each found object.

Table 2-4 shows the `find` options that specify actions.

{caption: "Table 2-4. Options for specifying actions on found objects", width: "100%"}
| Option | Meaning | Example |
| --- | --- | --- |
| `-exec command {} \;`| Execute the specified command on each found object. | `find -name README -type f -exec cp {} ~ \;` |
|  | | |
| `-exec command {} +`| Execute the specified command once over all found objects. The command receives all these objects on the input. | ` find -type d -exec cp -t ~ {} +` |
|  | | |
| `-delete`| Delete each of the found files. The utility deletes empty directories only. | `find -name README -type f -delete` |

Table 2-4 shows that there are two variants of the `-exec` action. They differ by the last symbol. It can be an escaped semicolon `\;` or a plus sign +. Use the plus sign only if the called command handles several input parameters. You will make a mistake if the command accepts one parameter only. It will process the first found object and skip the rest.

Let's apply the `-exec` action in practice. Suppose that you want to copy files with the Bash documentation into the home directory. You are interested in the HTML files only.

The first step is preparing the correct `find` call for searching the files. You should apply two conditions here. The first one checks the directory of the Bash documentation. The second condition checks the file extensions. If you combine these conditions, you get the following `find` call:
{line-numbers: false, format: Bash}
```
find / -path "*/doc/bash/*" -name "*.html"
```

When you pass the glob pattern to the `find` utility, always enclose it in double quotes. The quotes do the same as the backslash before parentheses. They prevent Bash from expanding the patterns. Instead, Bash passes them to the `find` utility.

Figure 2-17 shows the result of our `find` call. You can see that it found HTML files correctly.

{caption: "Figure 2-17. The output of the `find` utility", height: "30%"}
![find output](images/BashShell/find-html.png)

The second step for solving your task is adding the `-exec` action. The action should call the `cp` utility. This utility copies files and directories to the specified path. It takes two parameters. The first one is the source object to copy. The second parameter is the target path. When you apply the `-exec` action, you get the following `find` call:
{line-numbers: false, format: Bash}
```
find / -path "*/doc/bash/*" -name "*.html" -exec cp {} ~ \;
```

Run this command. It prints an error about the mount point. Despite the error, the command did its job. It copied the HTML files into the home directory.

How does the command work in detail? It calls the `cp` utility for each HTML file it found. When calling the utility, `find` inserts each found object instead of curly braces {}. Therefore, two `cp` calls happen here. They look like this:
{line-numbers: true, format: Bash}
```
cp ./usr/share/doc/bash/bash.html ~
cp ./usr/share/doc/bash/bashref.html ~
```

Each `cp` call copies one HTML file to the home directory.

Good job! You just wrote your first program in the language of the `find` utility. The program works according to the following algorithm:

1. Find HTML files starting from the root directory. Their paths match the `*/doc/bash/*` pattern.

2. Copy each found file into the home directory.

The program is quite simple and consists of two steps only. However, it is a scalable solution for finding and copying files. The program processes two or dozens of HTML files with the same speed.

You can combine the `-exec` actions in the same way as the search conditions. For example, let's print the contents of each found HTML file and count the number of its lines. You should call the `cat` utility to print the file contents. The `wc` utility counts the lines. It takes the filename as an input parameter. If you combine `cat` and `wc` calls, you get the following `find` command:
{line-numbers: false, format: Bash}
```
find / -path "*/doc/bash/*" -name "*.html" -exec cat {} \; -exec wc -l {} \;
```

There is no logical operation between the `-exec` actions. The `find` utility inserts logical AND by default. This has a consequence in our case. If the `cat` utility fails, `find` does not call the `wc` utility. It means that `find` executes the second action only if the first one succeeds. You can apply the logical OR explicitly. Then `find` always calls `wc`. Here is the command with logical OR:
{line-numbers: false, format: Bash}
```
find / -path "*/doc/bash/*" -name "*.html" -exec cat {} \; -o -exec wc -l {} \;
```

You can group the `-exec` actions with escaped parentheses `\(` and `\)`. It works the same way as grouping search conditions.

{caption: "Exercise 2-3. Searching for files with the `find` utility", line-numbers: false}
```
Write a find call to search for text files in a Unix environment.
Extend the command to print the total number of lines in these files.
```

#### Boolean Expressions

The search conditions of the `find` utility are [**Boolean expressions**](https://en.wikipedia.org/wiki/Boolean_expression). A Boolean expression is a programming language statement. It produces a Boolean value when evaluated. This value equals either "true" or "false".

The `find` condition is a statement of the utility's language. It produces the "true" value if the found object meets its requirement. Otherwise, the condition produces "false". If there are several conditions in the `find` call, they make a single compound Boolean expression.

When we have considered the binary numeral system, we already met Boolean algebra. This section of mathematics studies [**logical operators**](https://en.wikipedia.org/wiki/Logical_connective). They differ from the arithmetic operations: addition, subtraction, multiplication, and division.

You can apply a logical operator to Boolean values or expressions. Using an arithmetic operation does not make sense in this case. Addition or subtraction is trivial for Boolean values. It yields nothing. When you apply a logical operator, you get a condition with strict evaluation rules. This way, you wrote search conditions for the `find` utility. When you combine several conditions, you get a program with complex behavior.

An **operand** is an object of a logical operator. Boolean values and expressions can be operands.

Let's consider Boolean expressions using an example. The example is not related to the `find` utility or Bash for simplicity. Imagine that you are programming a robot for a warehouse. Its job is to move boxes from point A to point B. You can write the following straightforward algorithm for the robot:

1. Move to point A.

2. Pick up the box at point A.

3. Move to point B.

4. Put the box at point B.

This algorithm does not have any conditions. It means that the robot performs each step independently of external events.

Now imagine that an obstacle happens in the robot's way. For example, another robot stuck there. Executing your algorithm leads to the collision of the robots in this case. You should add a condition in the algorithm to prevent the collision. For example, it can look like this:

1. Move to point A.

2. Pick up the box at point A.

3. If there is no obstacle, move to point B. Otherwise, stop.

4. Put the box at point B.

The third step of the algorithm is called [**conditional statement**](https://en.wikipedia.org/wiki/Conditional_(computer_programming)). All modern programming languages have such a statement.

The conditional statement works according to the following algorithm:

1. Evaluate the Boolean expression in the condition.

2. If the expression produces "true", perform the first action.

3. If the expression produces "false", perform the second action.

The robot evaluates the value of the Boolean expression "there is no obstacle" in our example. If there is an obstacle, the expression produces "false" and the robot stops. Otherwise, the robot moves to point B.

When writing the conditional statement, you can combine several Boolean expressions using logical operators. Here is an example. Suppose that the robot tries to pick up a box at point A, but there is no box. Then there is no reason for him to move to point B. You can check this situation in the conditional statement. Add the new Boolean expression there using [**logical AND**](https://en.wikipedia.org/wiki/Logical_conjunction) (conjunction). Then the robot's algorithm becomes like this:

1. Move to point A.

2. Pick up the box at point A.

3. If there is a box AND no obstacle, move to point B. Otherwise, stop.

4. Put the box at point B.

Logical operators produce Boolean values when evaluated. The result of a logical AND equals "true" when both operands are "true". In our example, it happens when the robot has a box and there is no obstacle on its way. Otherwise, the result of logical AND equals "false". It forces the robot to stop.

You have used two more logical operators when learning the `find` utility. These operators are [**OR**](https://en.wikipedia.org/wiki/Logical_disjunction) (disjunction) and [**NOT**](https://en.wikipedia.org/wiki/Negation) (negation).

Actually, you have already applied logical NOT in the robot's algorithm. It stays implicitly in the expression "there is no obstacle". It equals the following negation: "there is NOT an obstacle". You can specify the logical NOT in the algorithm explicitly this way:

1. Move to point A.

2. Pick up the box at point A.

3. If there is a box AND there is NOT an obstacle, move to point B. Otherwise, stop.

4. Put the box at point B.

You can always replace logical AND by OR with some extra changes. Let's do it for our example but keep the robot's behavior the same. You should add the negation to the first Boolean expression and remove it from the second one. Also, you have to change the order of actions in the conditional statement. If the condition produces "true", the robot stops. If it produces "false", the robot moves to point B. The new algorithm looks this way:

1. Move to point A.

2. Pick up the box at point A.

3. If there is NOT a box OR there is an obstacle, stop. Otherwise, move to point B.

4. Put the box at point B.

Read the new conditional statement carefully. The robot follows the same decisions as before. It stops if it has no box or if there is an obstacle on its way. However, you have exchanged the logical AND to OR. This trick helps you to keep your conditional statements clear. Choose between logical AND and OR depending on your Boolean expressions. Pick one that fits your case better.

You wrote the Boolean expressions as sentences in English in our example. Such a sentence sounds unnatural. You have to read it several times to understand it. This happens because the natural humans' language is not suitable for writing Boolean expressions. This language is not accurate enough. Boolean algebra uses mathematical notation for that reason.

We have considered logical AND, OR and NOT. You will deal with three more operators in programming often:

* Equivalence
* Non-equivalence
* Exclusive OR

Table 2-5 explains them.

{caption: "Table 2-5. Logical operators", width: "100%"}
| Operator | Evaluation Rule |
| --- | --- |
| AND | It produces "true" when both operands are "true". |
|  | |
| OR | It produces "true" when any of the operands is "true". It produces "false" when all operands are "false". |
|  | |
| NOT | It produces "true" when the operand is "false" and vice versa. |
|  | |
| Exclusive OR (XOR) | It produces "true" when the operands have different values (true-false or false-true). It produces "false" when the operands are the same (true-true, false-false). |
|  | |
| Equivalence | It produces "true" when the operands have the same values. |
|  | |
| Non-equivalence | It produces "true" when the values of the operands differ. |

Try to memorize this table. It is simple to reach when you use logical operators often.

#### grep

The GNU utilities have one more searching tool besides `find`. It is called `grep`. This utility checks file contents when searching.

How to choose the proper utility for searching? Use `find` for searching a file or directory by its name, path or [**metadata**](https://en.wikipedia.org/wiki/Metadata). Metadata is extra information about an object. Examples of the file metadata are size, time of creation and last modification, permissions. Use the `grep` utility to find a file when you know nothing about it except its contents.

Here is an example. It shows you how to choose the right utility for searching. Suppose that you are looking for a documentation file. You know that it contains the phrase "free software". If you apply the `find` utility, the searching algorithm looks like this:

1. Call `find` to list all the files with the `README` name.

2. Open each file in a text editor and check if it has the phrase "free software".

Using a text editor for checking dozens of files takes too much effort and time. You should perform several operations with each file manually: open it, activate the editor's searching mode, type the "free software" phrase. The `grep` utility automates this task. For example, the following command finds all lines with the "free software" phrase in the specified `README` file:
{line-numbers: false, format: Bash}
```
grep "free software" /usr/share/doc/bash/README
```

The first parameter of the utility is a string for searching. Always enclose it in double quotes. This way, you prevent Bash expansions and guarantee that the utility receives the string unchanged. Without the quotes, Bash splits the phrase into two separate parameters. This mechanism of splitting strings into words is called [**word splitting**](http://mywiki.wooledge.org/WordSplitting).

The second parameter of `grep` is a relative or absolute path to the file. If you specify a list of files separated by spaces, the utility processes them all. In the example, we passed the `README` file path only.

Figure 2-18 shows the result of the `grep` call.

{caption: "Figure 2-18. The output of the `grep` utility", width: "100%"}
![grep output](images/BashShell/grep-command.png)

You see all lines of the file where the utility found the specified phrase. The `-n` option adds the line numbers to the `grep` output. It can help you to check big text files. Add the option before the first parameter when calling the utility. Figure 2-18 shows the output in this case.

We have learned how to use `grep` to find a string in the specified files. Now let's apply the utility to solve our task. You are looking for the documentation files with the phrase "free software". There are two ways to find them with the `grep` utility:

* Use Bash glob patterns.

* Use the file search mechanism of the `grep` utility.

The first method works well when you have all files for checking in the same directory. Suppose that you found two `README` files: one for Bash and one for the `xz` utility. You have copied them to the home directory with the names `bash.txt` and `xz.txt`. The following two commands find the file that contains the phrase "free software":
{line-numbers: true, format: Bash}
```
cd ~
grep "free software" *
```

The first command changes the current directory to the user's home. The second command calls the `grep` utility.

When calling `grep`, we have specified the asterisk for the target file path. This wildcard means any string. Bash expands all wildcards in the command before launching it. In our example, Bash replaces the asterisk with all files of the home directory. The resulting `grep` call looks like this:
{line-numbers: false, format: Bash}
```
grep "free software" bash.txt xz.txt
```

Launch both versions of the `grep` call: with the `*` pattern and with a list of two files. The utility prints the same result for both cases.

You can search for the phrase in a single command. Just exclude the `cd` call. Then add the home directory to the search pattern. You will get the following `grep` call:
{line-numbers: false, format: Bash}
```
grep "free software" ~/*
```

This command does not handle subdirectories. It means that the `grep` call does not check the files in the `~/tmp` directory, for example.

There is an option to check how the Bash expands a glob pattern. Use the `echo` command for that. Here are `echo` calls for checking our patterns:
{line-numbers: true, format: Bash}
```
echo *
echo ~/*
```

Run these commands. The first one lists files and subdirectories of the current directory. The second command does the same for the home directory.

Do not enclose search patterns in double quotes. Here is an example of the wrong command:
{line-numbers: false, format: Bash}
```
grep "free software" "*"
```

Quotes prevent the Bash expansion. Therefore, Bash does not insert the filenames to the command but passes the asterisk to the `grep` utility. The utility cannot handle the glob pattern properly as `find` does. Thus, you will get an error like Figure 2-19 shows.

{caption: "Figure 2-19. The result of processing a search pattern by `grep`", width: "100%"}
![grep error](images/BashShell/grep-error.png)

When expanding the `*` pattern, Bash ignores hidden files and directories. Therefore, the `grep` utility ignores them too in our example. Add the dot before the asterisk to get the glob pattern for hidden objects. It looks like `.*`. If you want to check all files at once, specify two patterns separated by the space. Here is an example `grep` call:
{line-numbers: false, format: Bash}
```
grep "free software" * .*
```

The second approach to search files with `grep` is using its built-in mechanism. It traverses the directories recursively and checks all files there. The `-r` option enables this mechanism. When using this option, specify the search directory in the second utility's parameter.

Here is an example of using the `-r` option:
{line-numbers: false, format: Bash}
```
grep -r "free software" .
```

This command finds the "free software" phrase in the files of the current directory. It processes the hidden objects too. If you work on Linux or macOS, prefer the `-R` option instead of `-r`. It forces `grep` to follow [**symbol links**](https://en.wikipedia.org/wiki/Symbolic_link) when searching. Here is an example:
{line-numbers: false, format: Bash}
```
grep -R "free software" .
```

I> A symbolic link is a file of a special type. Instead of data, it contains a pointer to another file or directory.

You can specify the starting directory for searching by a relative or absolute path. Here are the examples for both cases:
{line-numbers: true, format: Bash}
```
grep -R "free software" ilya.shpigor/tmp
grep -R "free software" /home/ilya.shpigor/tmp
```

Suppose that you are interested in a list of files that contain a phrase. You do not need all occurrences of the phrase in each file. The `-l` option switches the `grep` utility in the mode you need. Here is an example of using it:
{line-numbers: false, format: Bash}
```
grep -Rl "free software" .
```

Figure 2-20 shows the result of this command.

{caption: "Figure 2-20. The `grep` outputs filenames only"}
![grep output](images/BashShell/grep-files.png)

You see a list of files where the phrase "free software" occurs at least once. Suppose that you need the opposite result: a list of files without the phrase. Use the `-L` option for finding them. Here is an example:
{line-numbers: false, format: Bash}
```
grep -RL "free software" .
```

The `grep` utility processes the text files only. Therefore, it deals well with the source code files. You can use the utility as an add-on to your code editor or IDE.

You may have liked the `grep` utility. You want to process [PDF](https://en.wikipedia.org/wiki/PDF) and MS Office documents with it. Unfortunately, this approach does not work. The contents of these files are not text. It is encoded. You need another utility to process such files. Table 2-6 shows `grep` alternatives for non-text files.

{caption: "Table 2-6. Utilities for text searching in PDF and MS Office files", width: "70%", column-widths: "20% *"}
| Utility | Features |
| --- | --- |
| [pdftotext](http://www.xpdfreader.com) | It converts a PDF file into text format. |
|  | |
| [pdfgrep](https://pdfgrep.org) | It searches PDF files by their contents. |
|  | |
| [antiword](http://www.winfield.demon.nl) | It converts an MS Office document into text format. |
|  | |
| [catdoc](https://www.wagner.pp.ru/~vitus/software/catdoc) | It converts an MS Office document into text format. |
|  | |
| [xdoc2txt](https://documentation.help/xdoc2txt/xdoc2txt_en.html) | It converts PDF and MS Office files into text format. |

Some of these utilities are available in the MSYS2 environment. Use the `pacman` package manager for installing them. The last chapter of the book describes how to use it.

{caption: "Exercise 2-4. Searching for files with the `grep` utility", line-numbers: false}
```
Write a grep call to find system utilities with a free license.
Here are widespread licenses for open-source software:

1. GNU General Public License
2. MIT license
3. Apache license
4. BSD license
```
