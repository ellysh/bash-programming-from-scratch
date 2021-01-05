## Actions on Files and Directories

We have learned how to find a file or directory on the disk. Now let's talk about what to do with them. If you have an experience with Windows GUI, you know the following actions with files and directories:

* Create
* Delete
* Copy
* Move or rename

There is a special GNU utility to perform each of these actions. Table 2-7 describes them.

{caption: "Table 2-7. Utilities for operating on files and directories", width: "100%"}
| Utility | Feature | Examples |
| --- | --- | --- |
| `mkdir` | Create the directory with the specified name and path. | `mkdir /tmp/docs` |
| | | `mkdir -p tmp/docs/report` |
|  | | |
| `rm` | Delete the file or directory by | `rm readme.txt` |
| | its absolute or relative path. | `rm -rf ~/tmp` |
|  | | |
| `cp` | Copy a file or directory. The first parameter | `cp readme.txt tmp/readme.txt` |
| | is the current path. The second parameter is the target path. | `cp -r /tmp ~/tmp` |
|  | | |
| `mv` | Move or rename the file or directory | `mv readme.txt documentation.txt.` |
| | that is specified by the first parameter. | `mv ~/tmp ~/backup` |

Each of these utilities has the `--help` option. It displays a brief help. Use it if you need a utility mode that this book misses. If the brief help is not enough, refer to the `info` or `man` system.

Let's consider how to use the utilities in Table 2-7. 

### mkdir

The `mkdir` utility creates a new directory at the specified absolute or relative path. It receives the target path in the first parameter. For example, the following command creates a directory called `docs` in the user's home directory:
{line-numbers: false, format: Bash}
```
mkdir ~/docs
```

We specified the absolute path to the `docs` directory. Instead, we can pass the relative path. There are two steps to take it:

1. Navigate to the user's home directory.
2. Call the `mkdir` utility.

These are the corresponding commands:
{line-numbers: true, format: Bash}
```
cd ~
mkdir docs
```

The utility has an option `-p` for creating the nested directories. There is an example. We should move the documents with 2019 reports in the path `∼/docs/reports/2019`. Assume that the `docs` and `reports` directories do not exist yet. We should create them before creating the `2019` directory. Another option is to call `mkdir` with the `-p` option:
{line-numbers: false, format: Bash}
```
mkdir -p ~/docs/reports/2019
```

If the `docs` and `reports` directories already exist, the command still executes successfully. In this case, it creates the missing part of the path, i.e., the `2019` directory.

### rm

The `rm` utility deletes files and directories. You can specify them by an absolute or relative path.

For example, there are two commands:
{line-numbers: true, format: Bash}
```
rm report.txt
rm ~/docs/reports/2019/report.txt
```

The first command deletes the `report.txt` file in the current directory. The second one deletes it in the `~/docs/reports/2019` path.

The `rm` utility can remove multiple files at once. To do that, specify a list of filenames separated by spaces. Here is an example:
{line-numbers: false, format: Bash}
```
rm report.txt ~/docs/reports/2019/report.txt
```

If you want to delete dozens of files, listing them all in a utility call is inconvenient. In this case, use a Bash search pattern. For example, let's delete all text files whose names begin with the word "report". These are documents with reports. The `rm` call for them looks like this:
{line-numbers: false, format: Bash}
```
rm ~/docs/reports/2019/report*.txt
```

When you remove a write-protected file, the `rm` utility prints a warning. Figure 2-26 shows an example of it.

{caption: "Figure 2-26. The warning when deleting a write-protected file", width: "100%"}
![rm warning](images/BashShell/rm-warning.png)

If you see such a message, press the Y (short for yes) and Enter keys. Call the utility with the `-f` or `--force` option to suppress warnings. The `rm` removes files without confirmation in this case. Here is an example call:
{line-numbers: false, format: Bash}
```
rm -f ~/docs/reports/2019/report*.txt
```

I> The GNU utility options have a short form and a full form. The short form consists of one letter and begins with a dash `-`. The full form is a word preceded by a double dash `--`. This option format is recommended by the [POSIX standard](https://www.gnu.org/software/libc/manual/html_node/Argument-Syntax.html) and the [GNU extension](https://www.gnu.org/prep/standards/html_node/Command_002dLine-Interfaces.html) to it.

The rm utility cannot remove a directory unless you do not pass an extra option to it. If you remove the empty directory, specify the `-d` or `--dir` option. Here is an example:
{line-numbers: false, format: Bash}
```
rm -d ~/docs
```

If the directory contains files or subdirectories, call the utility with the `-r` or `--recursive` option. Such a call looks following:
{line-numbers: false, format: Bash}
```
rm -r ~/docs
```

This command also deletes the empty `docs` directory. To make it easier to remember, always specify the `-r` option when removing a directory.

### cp and mv

The copying and renaming utilities work in the same way. They take the target file or directory in the first parameter. The second parameter is the new path where the utility copies or moves the object

There is an example. We want to make a copy of the `report.txt` file. First, we go to the directory that contains it. Then we call the `cp` utility in this way:
{line-numbers: false, format: Bash}
```
cp report.txt report-2019.txt
```

This command creates a new file named `report-2019.txt`. It has the same content as `report.txt`.

Assume that the old file `report.txt` is not needed. After copying it, you can remove it with the `rm` utility. But you can combine copying and removing in a single command. Call the `mv` utility for doing that:
{line-numbers: false, format: Bash}
```
mv report.txt report-2019.txt
```

This command creates a new file named `report-2019.txt`. At the same time, it removes the old file `report.txt`.

The `cp` and `mv` utilities process both relative and absolute paths. For example, there is the task to copy a file from the user's home directory to `~/docs/reports/2019`. The following command does it:
{line-numbers: false, format: Bash}
```
cp ~/report.txt ~/docs/reports/2019
```

The command copies the `report.txt` file to the path `~/docs/reports/2019/report.txt`.

You can obtain the same result in another way. Go to the user's home directory and call the `cp` utility with relative paths. Here are the commands:
{line-numbers: true, format: Bash}
```
cd ~
cp report.txt docs/reports/2019
```

You can specify the name of the copy explicitly. It is useful when the names of the original file and the copy should differ. The following `cp` call makes them different:
{line-numbers: false, format: Bash}
```
cp ~/report.txt ~/docs/reports/2019/report-2019.txt
```

Moving files from one directory to another works the same way as copying. For example, the following command moves the file `report.txt`:
{line-numbers: false, format: Bash}
```
mv ~/report.txt ~/docs/reports/2019
```

The following command moves and renames the file at the same time:
{line-numbers: false, format: Bash}
```
mv ~/report.txt ~/docs/reports/2019/report-2019.txt
```

The `mv` utility can rename directories too. Here is an example:
{line-numbers: false, format: Bash}
```
mv ~/tmp ~/backup
```

This command renames the `tmp` directory to `backup`.

The `cp` utility cannot copy directories in a default mode. For example, you want to copy the directory with the temporary files `/tmp` to the user's home directory. The following command does not work:
{line-numbers: false, format: Bash}
```
cp /tmp ~
```

You must add the `-r` or `--recursive` option. Then the `cp` utility works properly. The resulting call looks like this:
{line-numbers: false, format: Bash}
```
cp -r /tmp ~
```

Suppose you copy or move a file. If the target path already has a file with the same name, the `cp` and `mv` utilities ask you to confirm the operation. If you approve the operation, it overwrites the existing file.

If you do not need the existing file, overwrite it without confirmation. To do that, add the `-f` or `--force` option. Here are examples:
{line-numbers: true, format: Bash}
```
cp -f ~/report.txt ~/tmp
mv -f ~/report.txt ~/tmp
```

Both commands overwrite the existing `report.txt` file in the `tmp` directory. There is no need to confirm the operations.

{caption: "Exercise 2-6. Operations with files and directories", format: text, line-numbers: false}
```
Organize your photos from the past three months using the GNU utilities.
Make a backup before you start.
Separate all photos by year and month.
You should get a similar directory structure:

~/
  photo/
        2019/
             11/
             12/
        2020/
             01/
```

#### File System Permissions

When the `rm` utility removes a file or directory, it checks the [**file system permissions**](https://en.wikipedia.org/wiki/File-system_permissions). For example, if a file is write-protected, the utility prints a warning. What are permissions and what are they for?

Permissions restrict what the user can do with the file system. The operating system controls them. With this feature, users can access only their files and directories. At the same time, access to the OS components is restricted.

The permissions allow several people to share one computer. This approach was widespread everywhere before inventing personal computers. Computing resources were expensive at that time. Thus, it was more effective to share one computer among users.

Let's look again at Figure 2-26. When you call the `ls` utility with the `-l` option, it prints the table. Its single row corresponds to one file or directory. The columns have the following meaning:

1. Permissions or access rights.
2. The number of hard links to the file or directory.
3. Owner.
4. Owner group.
5. The size of the object in bytes.
6. Date and time of the last change.
7. File or directory name.

Now we are interested in permissions. They equal the line "-r--r--r--" for the file `report.txt`. What does it mean?

In Unix, file or directory permissions are stored as [**bitmask**](https://en.wikipedia.org/wiki/Mask_(computing)). The bitmask is a positive integer. The memory stores it in binary form as a sequence of zeros and ones. Each bit of the mask keeps a value that is independent of the other bits. Therefore, it is possible to pack a set of values into a single bitmask.

What values can a bitmask store? For example, these can be the attributes of an object. The object either has or does not have each attribute. Each bit of the bitmask corresponds to one attribute. If the bit equals one, the object attribute presents. Otherwise, the bit equals zero.

Let's come back to the file access rights. We can represent these rights as the following three attributes:

1. Read permission.
2. Write permission.
3. Permission to execute.

We can pack these attributes in the mask of three bits. Suppose a user has full access to the file. He can read or change it. Also, the user can copy, remove or execute the file. It means that the file has read, write, and execute permissions. The writing permission allows changing the file and removing it. In this case, the file permissions mask looks like this:
{line-numbers: false}
```
111
```

All three bits equal ones in the mask.

Suppose the user cannot read or execute the file. The first bit of the mask corresponds to the read access. The third bit is execution permission. Both these bits equal zero. Then we get the following mask:
{line-numbers: false}
```
010
```

You should know the meaning of each bit in the mask if you want to operate it properly. The mask itself does not provide this information. 

We have considered the simplified example of permissions. Now let's see how they look like in Unix. The `ls` utility prints the following line with permissions for the `report.txt` file:
{line-numbers: false}
```
-r--r--r--
```

This string is the bitmask. Here dashes correspond to zeroes and Latin letters are ones. Then we can represent the string "-r--r--r--" as the mask 0100100100. If all bits of the mask equal ones, the `ls` utility prints the string "drwxrwxrwx".

The Unix permissions string has four parts. Table 2-8 explains the meaning of each.

{caption: "Table 2-8. Parts of the permissions string in Unix", width: "100%"}
| d | rwx | rwx | rwx |
| --- | --- | --- | --- |
| The directory attribute. | The object's owner permissions. The owner is a user who has created the object. | The permissions of the user group that is attached to the object. By default, it is the group to which the owner belongs. | The permissions of all other users except the owner and the group attached to the object. |

A separate bitmask represents each part of the Unix permissions. The bitmasks have the same four bits size. Therefore, the string "-r--r--r--" matches the following four bitmasks:
{line-numbers: false}
```
0000 0100 0100 0100
```

What do the Latin letters in the permissions string mean? They match bits that have value one in the bitmask. Each bit's position determines the allowed user's action on the object: read, write, and execute. The letters make the bitmask easier to read for humans. Just compare the string "-rw-r--r--" and the binary number 0000011001000100. What is simpler to read?

Table 2-9 explains the meaning of each letter in the permissions string.

{caption: "Table 2-9. Letters in the permissions string", width: "100%"}
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

Suppose that all users of the system have full access to the file. Then its permissions string looks like this:
{line-numbers: false}
```
-rwxrwxrwx
```

If the user has full access to a directory, the permissions string is almost the same. The only difference is the first character. It equals `d` instead of the dash. Here is an example of the string:
{line-numbers: false}
```
drwxrwxrwx
```

I> The `groups` utility prints the list of groups that the current user belongs.

Now you can read the permissions in Figure 2-26 easily. There are two files: `report.txt` and `report1.txt`. All users can read the first one. No one can modify or execute it. Everyone can read the second file. Only the owner can modify it. No one can execute it.

We have considered commands and utilities for operating on the file system. Each of them accesses the specified file or directory. It means that the target object should have certain permissions. Otherwise, the command fails.

Table 2-10 shows the required permissions for each utility and command.

{caption: "Table 2-10. File system permissions for running commands and utilities", width: "100%"}
| Command | Bitmask | Permissions | Comment |
| --- | --- | --- | --- |
| `ls` | `r--` | Reading | Applied for directories only. |
|  | | | |
| `cd` | `--x` | Executing | Applied for directories only. |
|  | | | |
| `mkdir` | `-wx` | Writing and executing | Applied for directories only. |
|  | | | |
| `rm` | `-w-` | Writing | Specify the `-r` option for the directories. |
|  | | | |
| `cp` | `r--` | Reading | The target directory should have writing and executing permissions.
 |
|  | | | |
| `mv` | `r--` | Reading | The target directory should have writing and executing permissions.
 |
|  | | | |
| Executing | `r-x` | Reading and executing. | Applied for files only. |
