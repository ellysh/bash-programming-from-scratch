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
