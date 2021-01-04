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