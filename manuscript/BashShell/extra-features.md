## Extra Bash Features

We have learned the built-in Bash commands and GNU utilities for operating on the file system. Now you can run a program and copy a file in the command line. The graphical interface provides the same features. If you are solving such simple tasks, the interface does not matter.

The Bash interpreter provides several features that the GUI does not have. Thanks to them, some tasks are faster to perform in the command-line interface. If you have such a task, knowing Bash saves you time thanks to automation.

We will take a look at the following Bash features:

1. I/O redirection.
2. Pipelines.
3. Logical operators.

### Unix Philosophy

[Douglas McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy) is one of the Unix developers. He summarized the philosophy of this OS in three points:

1. Write programs that do one thing and do it well.
2. Write programs to work together.
3. Write programs to handle text streams, because that is a universal interface.

The plain text format is the cornerstone of the Unix philosophy. It is the foundation for the first two points.

The text format allows programs to share data easily. Suppose that two developers independently of each other wrote two utilities. Both utilities accept text data on input. They print results in text format too. You have a task. If you combine two utilities, you solve it. Because of the text interface, it is quite simple to do. You have to pass the output of the first utility to the input of the second one.

When it is easy for programs to interact, there is no need to overload them with extra features. For example, you write a program to copy files. It does the job well. But eventually, you realize that it lacks a search function. With this feature, it would be faster to find and copy the files at once. Then you decide that it is convenient to create directories and copy files by one program. This example shows that the requirements for a self-contained application grow rapidly.

When applications work together, each solves a single task only. If you need an extra feature, you call the corresponding special utility. You don't have to add this feature to your application. The feature is already available and well tested. Just call an external utility that does what you need.

### I/O Redirection

GNU utilities follow the Unix philosophy. They use a text format for input and output. Therefore, they are just as easy to combine as Unix utilities.

When combining GNU utilities, there is a task to pass text data between them. The task has several solutions.

Suppose the output of a utility fits one line. You need to pass it to another utility. Using the clipboard is the simplest solution here. Here are the steps to take it:

1. Select the utility output with the mouse.
2. Type the command to call another utility.
3. Paste the contents from the clipboard at the end.
4. Launch the command.

This simple method does not work for copying multiple lines. When you paste them, Bash handles line breaks as commands delimiter. It executes the command right after receiving the delimiter. Because of this, the shell loses some copied lines.

Another solution is to use the file system. Create a temporary file to save the utility output. Then pass the file name to another utility. It will read its contents and retrieve the data. This approach is more convenient than the clipboard for two reasons:

1. There is no limit on the number of lines to transfer.
2. There are no manual operations with the clipboard.

Bash has a mechanism that redirects the command output to the file. The same mechanism redirects data from the file to the command input. It means that your application does need a feature for interacting with the file system. Instead, it should support the text data format on input and output. Bash does all the other work of redirecting that data.

Let's look at an example. Suppose that you are looking for the files on the disk. The search result has to be saved into a file. To solve this task, use the `find` utility and the redirect operator `1>`. Then the utility call looks like this:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 1> readme_list.txt
```

The command creates the `readme_list.txt` file in the current directory. It contains the output of the `find` utility. The output looks the same in the file as it is printed on the screen. If the current directory has the `readme_list.txt` file already, the command overwrites it.

What does the `1>` operator mean? It is [redirection](https://en.wikipedia.org/wiki/Redirection_(computing)) of standard output stream. There are three [standard streams](https://en.wikipedia.org/wiki/Standard_streams) in the Unix environment. Table 2-12 explains them.

{caption: "Table 2-12. POSIX standard streams", width: "100%"}
| Number | Name | Purpose |
| --- | --- | --- |
| 0 | Standard input stream (stdin). | A program receives input data from this stream. By default, it comes from an input device like a keyboard. |
|  | | |
| 1 | Standard output stream (stdout). | A program outputs data there. The terminal window prints it by default. |
|  | | |
| 2 | Standard error stream (stderr). | A program outputs the error messages there. The terminal window prints it by default. |

A program operates in the software environment that the OS provides. A thread is a communication channel between the program and the environment. 

Early Unix systems have used physical channels for input and output data. The input was tied to the keyboard. The same way the output was tied to the monitor. Streams were introduced as [abstraction](https://en.wikipedia.org/wiki/Abstraction_layer) over these channels. The abstraction makes it possible to work with different objects using the same algorithm. It allows replacing input from a real device with input from a file. Similarly, printing to the screen can be replaced by output to a file. At the same time, the same OS code handles these I/O operations.

The purpose of the input and output streams is clear. But the error stream causes questions. Why do we need it? Imagine that you run the `find` utility to search for files. You do not have access to some directories. When the `find` utility reads their contents, it is unavailable. The utility prints an error message in this case.

Now imagine that the utility found many files. It is easy to miss error messages in a huge file list. Separating the output and error streams helps in this case. If you redirect the output stream to the file, the utility prints error messages only on the screen.

Use the `2>` operator to redirect the standard error stream. Here is an example of the `find` utility call with this operator:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 2> errors.txt
```

The number before the angle bracket in the operator means the number of the redirected stream. For example, the `2>` operator redirects stream number two.

Use the `0<` operator to redirect the standard input stream. Here is an example for searching the "Bash" pattern in the `README.txt` file:
{line-numbers: false, format: Bash}
```
grep "Bash" 0< README.txt
```

This example is not entirely correct. The command uses the `grep` utility interface that handles the standard input stream. But `grep` can read the contents of a specified file. It is always better to pass the filename to the utility. Here is an example:
{line-numbers: false, format: Bash}
```
grep "Bash" README.txt
```

Let's take a more complicated example. Some Bash manuals recommend the `echo` command to print the contents of the file. For example, the command for printing the`README.txt` file looks like this:
{line-numbers: false, format: Bash}
```
echo $( 0< README.txt )
```

Here `echo` receives the output of the following command: 
{line-numbers: false, format: Bash}
```
0< README.txt
```

**Command substitution** is substituting the command result where it was called. When the interpreter encounters the `$(` and `)` characters, it executes the command enclosed between them and substitutes its output.

Because of the command substitution, Bash executes our `echo` call in two steps:

1. Pass the contents of the `README.txt` file to the standard input stream.

2. Print data from the standard input stream with the `echo` command.

Please take into account the execution order of the substituted commands. The interpreter executes commands and inserts their results in the order they follow. Only when all substitutions are done, Bash executes the resulting command in its entirety.

The next `find` call leads to the error due to a commands order mistake:
{line-numbers: false, format: Bash}
```
$ find / -path */doc/* -name README -exec echo $(0< {}) \;
```

It prints the following error message:
{line-numbers: false, format: Bash}
```
bash: {}: No such file or directory
```

This command should print the contents of all the files that the `find` utility found. But we get an error from Bash instead.

The problem happens because the "0< {}" command is executed before the `find` utility call. Because of it, Bash tries to redirect the contents of the file named `{}` to the standard input stream. But there is no file with such a name. We expect the `find` utility substitutes the brackets `{}` by its results. It does not happen because the utility is called after executing the "0< {}" command.

If you replace the `echo` command by the `cat` utility, it solves the problem. The `find` call would look like this:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README -exec cat {} \;
```

This command prints the contents of all found files.

The redirection operators of standard input and output streams are used frequently. Therefore, developers have added short forms for them:

* The `<` operator redirects the input stream.
* The `>` operator redirects the output stream.

The `find` call with the short form of stream redirection looks like this:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README > readme_list.txt
```

Here is an example of the `echo` call with the short redirection form:
{line-numbers: false, format: Bash}
```
echo $( < README.txt )
```

Suppose that you redirect the standard output stream to a file. This file already exists and its contents should stay. In that case, append the command output to the end of the file. The `>>` operator does it.

For example, your computer has installed applications in the `/usr` and `/opt` system paths. Then the following two calls find their README files:
{line-numbers: true, format: Bash}
```
find /usr -path */doc/* -name README > readme_list.txt
find /opt -name README >> readme_list.txt
```

The first `find` call creates the `readme_list.txt` file and writes the result there. If the file already exists, the command overwrites its contents. The second `find` call appends its result to the end of `readme_list.txt`. If the file does not exist, the `>>` operator creates it.

The full form of the `>>` operator looks like `1>>`. If you want to redirect the error stream without overwriting the file, use the `2>>` operator.

Sometimes you need to redirect both the output and the error streams to the same file. The `&>` and `&>>` operators do it. The first operator overwrites an existing file. The second one appends data to its end. Here is an example:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README &> result_and_errors.txt
```

This command works in Bash properly. But it can fail in other shells. If you want to use the POSIX standard features only, use the `2>&1` operator. Here is an example:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README > result_and_errors.txt 2>&1
```

This redirection is called **stream duplicating**. Use it for redirecting both output and error streams to the same target.

Be careful when using streams duplicating. It's easy to make a mistake and mix up the operator order in a command. If you work in Bash, always prefer the `&>` and `&>>` operators.

Here is an example of the error with duplicating streams:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 2>&1 > result_and_errors.txt
```

The command outputs the error stream data on the screen. However, we expect that these data appear in the `result_and_errors.txt` file. The problem happens because the `2>&1` operator has the wrong position in the command.

The POSIX standard has the concept of [**file descriptor**](https://en.wikipedia.org/wiki/File_descriptor). The descriptor is a pointer to a file or communication channel. The descriptor works as an abstraction that simplifies handling of the streams.

When you start a program, descriptors of output and error streams point to the terminal window. You can change it and associate them with the file. The streams descriptors point to that file in this case. The [BashGuide article](http://mywiki.wooledge.org/BashFAQ/055) describes this mechanism in detail.

Let's go back to our `find` utility call. Bash applies redirection operators one by one from left to right. Table 2-13 shows this order for our example.

{caption: "Table 2-13. The order for applying redirection operators", width: "100%"}
| Number | Operation | Result |
| --- | --- | --- |
| 1 | `2>&1` | Now the error stream points to the same target as the output stream. In our case, the target is the terminal window. |
|  | | |
| 2 | `> result_and_errors.txt` | Now the output stream points to the file `result_and_errors.txt`. But the error stream is still associated with the terminal window. |

Let's fix the mistake in the `find` call. Changing the order of the redirection operators does it. The redirection of the output stream should come first. Then the duplicating streams should take place. Here is the resulting command:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README > result_and_errors.txt 2>&1
```

The output stream points to a file in this command. The error stream points to the same file.

You can specify redirection operators one after another if the output and error streams should point to different files. Here is an example:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README > result.txt 2> errors.txt
```

### Pipelines

It is inconvenient to create temporary files for sharing data between programs. Managing these files takes extra effort. You should remember their paths and removing them after usage. 

Unix environment provides an alternative solution. It is called [**pipeline**](https://en.wikipedia.org/wiki/Pipeline_(Unix)). This mechanism is more convenient than temporary files. It shares data between programs by passing messages without using the file system.

Let us consider an example. Suppose that you need information about the Bash [license](https://en.wikipedia.org/wiki/Software_license). You can find this information in the Bash documentation. The following `grep` utility call does it:
{line-numbers: false, format: Bash}
```
grep -R "GNU" /usr/share/doc/bash
```

Another solution is to search license information on the `info` help page. The pipeline allows you to connect the output of one program with the input of another one. If we apply the pipeline, we can call the `grep` utility to process the `info` page. The following command does it:
{line-numbers: false, format: Bash}
```
info bash | grep -n "GNU"
```

The `info` utility sends its result to the output stream. Then there is the vertical bar `|` symbol. It means the pipeline. The pipeline transfers the command's output on the left side to the command's input on the right side. This way, the `grep` utility receives the Bash `info` page. The utility searches the lines with the word "GNU" there. The nonempty command output means that Bash has the [GNU GPL](https://en.wikipedia.org/wiki/GNU_General_Public_License) license.

There is the `-n` option in the `grep` call. The option adds the line numbers in the `grep` output. It helps to find a particular place in the file.

#### du

Let's take a more complex example with pipelines. The `du` utility evaluates disk space usage. Run it without parameters in the current directory. The utility **recursively** passes through all subdirectories and prints the occupied space by each of them.

Recursive traversal means repeating visiting of subdirectories. The traversal algorithm looks like this:

1. Check the contents of the current directory.

2. If there is an unvisited subdirectory, go to it and start from the 1st step of the algorithm.

3. If all subdirectories are visited, go to the parent directory and start from the 1st step of the algorithm.

4. If it is impossible to go to the parent directory, finish the algorithm.

Following this algorithm, we bypass all subdirectories from the selected file system point. It is a universal traversal algorithm. You can add any action to it for processing each subdirectory. The action of the `du` utility is calculating disk space usage.

The algorithm of the `du` utility looks like this:

1. Check the contents of the current directory.

2. If there is an unvisited subdirectory, go to it and start from the 1st step of the algorithm.

3. If all subdirectories are visited:

    3.1 Calculate and display the disk space occupied by the current directory.

    3.2 Go to the parent directory.

    3.3 Start from the 1st step of the algorithm.

4. If it is impossible to go to the parent directory, finish the algorithm.

The `du` utility takes a path to the file or directory on input. In the case of the file, the utility prints its size. For the directory, the utility traverses its subdirectories.

Here is the `du` call for the system path `/usr/share`:
{line-numbers: false, format: Bash}
```
du /usr/share
```

Here is a clipped example of the command output:
{line-numbers: true, format: Bash}
```
261     /usr/share/aclocal
58      /usr/share/awk
3623    /usr/share/bash-completion/completions
5       /usr/share/bash-completion/helpers
3700    /usr/share/bash-completion
2       /usr/share/cmake/bash-completion
2       /usr/share/cmake
8       /usr/share/cygwin
1692    /usr/share/doc/bash
85      /usr/share/doc/flex
...
```

We get a table that has two columns. The right column shows the subdirectory. The left column shows the number of occupied bites.

If you want to add information about files in the `du` output, use the `-a` option. Here is an example:
{line-numbers: false, format: Bash}
```
du /usr/share -a
```

The `-h` option makes the output of the `du` utility clearer. The option converts the number of bytes into kilobytes, megabytes, and gigabytes.

Suppose that we should evaluate all HTML files in the `/usr/share` path. The following command prints that statistics:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | grep "\.html"
```

Here the pipeline transfers the `du` output to the `grep` input. Then `grep` prints the lines that contain the "\.html" pattern.

The backslash \ escapes the dot in the "\.html" pattern. The dot means a single occurrence of any character. If you specify the ".html" pattern, the `grep` utility finds extra files (like `pod2html.1perl.gz`) and subdirectories (like `/usr/share/doc/pcre/html`). When you escape the dot, the `grep` utility treats it as a dot character.

The pipeline combines two commands in our example with `du` and `grep`. But the number of combined commands is not limited. For example, you can sort the found HTML files in descending order.  The `sort` utility does this job. Here is the example command:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | grep "\.html" | sort -h -r
```

By default, the `sort` utility sorts the strings in ascending [**lexicographic order**](https://en.wikipedia.org/wiki/Lexicographic_order). For example, there is a file that contains the following strings:
{line-numbers: true, format: text}
```
abc
aaaa
aaa
dca
bcd
dec
```

If you call the `sort` utility without options, it places the file's lines in the following order:
{line-numbers: true, format: text}
```
aaa
aaaa
abc
bcd
dca
dec
```

The `-r` option reverts the order. If you apply this option, the utility prints the following:
{line-numbers: true, format: text}
```
dec
dca
bcd
abc
aaaa
aaa
```

The `du` utility prints file sizes in the first column. The `sort` utility operates this column. The file sizes are numbers. Therefore, we cannot place them in order properly with lexicographic sorting. An example will help us to understand the issue.

Suppose there is a file with the following numbers:
{line-numbers: true, format: text}
```
3
100
2
```

Lexicographical sort of the file produces the following result:
{line-numbers: true, format: text}
```
100
2
3
```

The algorithm put the number 100 before 2 and 3. It assumes that 100 is less than other numbers. It happens because the ASCII code of character 1 is smaller than the codes of characters 2 and 3. Use the `-n` option for sorting integers by their values.

We have an example command with two pipelines. The `du` utility has the `-h` option there. The option converts bytes into larger memory units. The `sort` utility can process them only if you call it with the same `-h` option.

You can combine pipelines with stream redirection. Let's save the filtered and sorted output of the `du` utility to the file. The following command does it:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | grep "\.html" | sort -h -r > result.txt
```

The command writes its result into the `result.txt` file.

Suppose you are combining pipelines and stream redirection. You want to write the output stream into the file and pass it to another utility simultaneously. How can you do that? Bash does not have a built-in mechanism for this task. But the special `tee` utility does it. Here is an example:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | tee result.txt
```

The command prints the `du` utility result on the screen. It writes the same result into the `result.txt` file. It means that the `tee` utility duplicates its input stream to the specified file and the output stream. The utility overwrites the contents of `result.txt`. Use the `-a` option if you need to append data to the file instead of overwriting it.

Sometimes you want to check the data flow between commands in a pipeline. The `tee` utility helps you in this case. Just call the utility between the commands in the pipeline. Here is an example:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | tee du.txt | grep "\.html" | tee grep.txt | sort -h -r > result.txt
```

It stores the output of each command in the pipeline to the corresponding file. These intermediate results are useful for debugging. The `result.txt` file still contains the final result of the whole command.

#### xargs

The `find` utility has the `-exec` parameter. It calls a command for each found object. This behavior resembles a pipeline: `find` passes its result to another program. These mechanisms look similar but their internals differs. Choose an appropriate mechanism depending on your task.

Let's look at how the `find` utility performs the `-exec` action. Some program performs this action. The built-in `find` interpreter runs it. The interpreter passes to the program whatever the `find` utility has found. Note that the Bash interpreter is not involved in the `-exec` call. Therefore, you cannot use the following Bash features in the call:

* built-in Bash commands
* functions
* pipelines
* stream redirection
* conditional statements
* loops

Try to run the following command:
{line-numbers: false, format: Bash}
```
find ~ -type f -exec echo {} \;
```

The `find` utility calls the `echo` Bash built-in here. It works correctly. Why? Actually, `find` calls another utility with the same name `echo` as the Bash command. Unix environment provides several utilities that duplicate Bash built-ins. You can find them in the `/bin` system path. For example, there is the `/bin/echo` file there.

Some tasks require the Bash features in the `-exec` action. There is a trick to access them in this case. Run the interpreter explicitly and pass a command to it. Here is an example:
{line-numbers: false, format: Bash}
```
find ~ -type f -exec bash -c 'echo {}' \;
```

This command does the same as the previous one that calls the `echo` utility. It prints the results of the `find` search.

You can apply the pipeline and redirect the `find` output to another command. In this case, you pass the text through the pipeline rather than filenames and directories. Here is an example of such passing:
{line-numbers: false, format: Bash}
```
find ~ -type f | grep "bash"
```

The command prints the output like this:
{line-numbers: true, format: Bash}
```
/home/ilya.shpigor/.bashrc
/home/ilya.shpigor/.bash_history
/home/ilya.shpigor/.bash_logout
/home/ilya.shpigor/.bash_profile
```

The pipeline passes the `find` output to the `grep` utility input. Then `grep` prints only the filenames where the pattern "bash" occurs.

The `-exec` action behaves in another way. When `find` passes its results to the `-exec` command, it constructs a utility call. The utility receives the names of found files and directories. You can get the same behavior when using the pipeline. Just apply the `xargs` utility for that.

Let's change our command with `find` and `grep`. Now we pass the text to the input stream of the `grep` utility. Then it filters found filenames. Instead of that, we want to filter the contents of the files. In this case, the `grep` utility should receive filenames via command line parameters. The `xargs` utility does this job:
{line-numbers: false, format: Bash}
```
find ~ -type f | xargs grep "bash"
```

I> This command cannot handle files whose names contain spaces and line breaks. The next section considers how to solve this problem.

Here is the output of the command:
{line-numbers: true, format: Bash}
```
/home/ilya.shpigor/.bashrc:# ~/.bashrc: executed by bash(1) for interactive shells.
/home/ilya.shpigor/.bashrc:# The copy in your home directory (~/.bashrc) is yours, please
/home/ilya.shpigor/.bashrc:# User dependent .bashrc file
/home/ilya.shpigor/.bashrc:# See man bash for more options...
/home/ilya.shpigor/.bashrc:# Make bash append rather than overwrite the history on disk
/home/ilya.shpigor/.bashrc:# When changing directory small typos can be ignored by bash
...
```

The `xargs` utility constructs a command from parameters that it receives on the input stream. The utility takes two things on the input: parameters and text from the stream. The parameters come in the first place in the constructing command. Then all data from the input stream follows.

Let's come back to our example. Suppose the first file that the `find` gets is `~/.bashrc`. Here is the `xargs` call that receives the file via the pipeline:
{line-numbers: false, format: Bash}
```
xargs grep "bash"
```

The utility receives two command-line parameters in this call: `grep` and "bash". Therefore, the constructed command starts with these two words:
{line-numbers: false, format: Bash}
```
grep "bash"
```

Then `xargs` appends the text from the input stream to the command. There is the filename `~/.bashrc` in the stream. Therefore, the constructed command looks like this:
{line-numbers: false, format: bash}
```
grep "bash" ~/.bashrc
```

The `xargs` utility does not call Bash for executing the constructed command. It means that the command has the same restrictions as the `-exec` action of the `find` utility. No Bash features are allowed there.

The `xargs` utility puts all data from the input stream at the end of the constructed command. In some cases, you want to change the position of these data. For example, you want to put them at the beginning of the command. The `-I` parameter of `xargs` does that.

Here is an example. Suppose that you want to copy the found files to the user's home directory. The `cp` utility does copying. But you should construct its call properly by the `xargs` utility. The following command does it:
{line-numbers: false, format: Bash}
```
find /usr/share/doc/bash -type f -name "*.html" | xargs -I % cp % ~
```

The `-I` parameter changes the place where the `xargs` utility puts the filenames. In our case, the parameter points to the position of the percent sign % for that.

The `xargs` utility calls `cp` for each line that it receives via the pipeline. Thus, it constructs the following two commands:
{line-numbers: true, format: Bash}
```
cp /usr/share/doc/bash/bash.html /home/ilya.shpigor
cp /usr/share/doc/bash/bashref.html /home/ilya.shpigor
```

The `-t` option of the `xargs` utility displays the constructed commands before executing them. It can help you with debugging. Here is an example of using the option:
{line-numbers: false, format: Bash}
```
find /usr/share/doc/bash -type f -name "*.html" | xargs -t -I % cp % ~
```

We have considered how to combine the `find` utility and pipelines. These examples are for educational purposes only. Do not apply them in your Bash scripts. Use the `-exec` action of the `find` utility instead of pipelines. This way, you avoid issues with processing filenames with spaces and line breaks.

There are few cases when a combination of `find` and pipeline makes sense. One of these cases is the parallel processing of found files.

Here is an example. When you call the `cp` utility in the `-exec` action, it copies files one by one. It is inefficient if your hard disk has a high access speed. You can speed up the operation by running it in several parallel processes. The `-P` parameter of the `xargs` utility does that. Specify the number of parallel processes in this parameter. They will execute the constructed command.

Suppose your computer processor has four cores. Then you can copy files in four parallel processes. Here is the command to do that:
{line-numbers: false, format: Bash}
```
find /usr/share/doc/bash -type f -name "*.html" | xargs -P 4 -I % cp % ~
```

The command copies four files at once. As soon as one of the parallel processes finishes, it handles the next file. This approach can speed up the execution of the command considerably. The gain depends on the configuration of your CPU and hard drive.

There are several GNU utilities for processing text data on the input stream. They work well in pipelines. Table 2-14 shows the most commonly used of these utilities.

{caption: "Table 2-14. Utilities for processing the input stream", width: "100%"}
| Utility | Description | Examples |
| --- | --- | --- |
| `xargs` | It constructs a command using command-line parameters and data from the input stream. | `find . -type f -print0 | xargs -0 cp -t ~` |
|  | | |
| `grep` | It searches for text that matches | `grep -A 3 -B 3 "GNU" file.txt` |
| | the specified pattern. | `du /usr/share -a | grep "\.html"` |
|  | | |
| `tee` | It redirects the input stream to the output stream and file at the same time. | `grep "GNU" file.txt | tee result.txt` |
|  | | |
| `sort` | It sorts strings from the input stream | `sort file.txt` |
| | in forward and reverse order (`-r`). | `du /usr/share | sort -n -r` |
|  | | |
| `wc` | It count the number of lines (`-l`), words (`-w`), | `wc -l file.txt` |
| | letters (`-m`) and bytes (`-c`) in a specified file or input stream. | `info find | wc -m` |
|  | | |
| `head` | It outputs the first bytes (`-c`) or lines (`-n`) | `head -n 10 file.txt` |
| | of a file or text from the input stream. | `du /usr/share | sort -n -r | head -10` |
|  | | |
| `tail` | It outputs the last bytes (`-c`) or lines (`-n`) | `tail -n 10 file.txt` |
| | of a file or text from the input stream. | `du /usr/share | sort -n -r | tail -10` |
|  | | |
| `less` | It is the utility for navigating | `less /usr/share/doc/bash/README` |
|  | through text from the standard input stream. Press the Q key to exit. | `du | less` |

### Pipelines Pitfalls

Pipelines are a popular feature of the Unix environment.  Users apply them frequently. Unfortunately, it is quite simple to make a mistake using pipelines. Let's consider the common mistakes by examples.

You can expect that the following two commands give the same result:
{line-numbers: true, format: Bash}
```
find /usr/share/doc/bash -name "*.html"
ls /usr/share/doc/bash | grep "\.html"
```

The commands' results differ in some cases. There is no problem in processing the search pattern differently by the `find` and `grep` utilities. The problem happens when you pass the filenames through the pipeline.

The POSIX standard allows all printable characters in filenames. It means that spaces and line breaks are allowed too. The only forbidden character is [**null character**](https://en.wikipedia.org/wiki/Null_character) (NULL). This rule can lead to unexpected results.

Here is an example. Create a file in the user's home directory. The filename should contain the line break. This control character matches the `\n` [**escape sequence**](https://en.wikipedia.org/wiki/Escape_sequence) in ASCII encoding. You can add escape sequences in filenames with the `touch` utility. Call it this way:
{line-numbers: false, format: Bash}
```
touch ~/$'test\nfile.txt'
```

The `touch` utility updates the modification time of the file. It is a primary task of the utility. If the file does not exist, `touch` creates it. It is a [**side effect**](https://en.wikipedia.org/wiki/Side_effect_(computer_science)) feature of the utility.

Create extra two files for our example: `test1.txt` and `file1.txt`. The following command does that:
{line-numbers: false, format: Bash}
```
touch ~/test1.txt ~/file1.txt
```

Now call the `ls` utility in the user's home directory. Pass its output to `grep` via pipeline. Here are the examples:
{line-numbers: true, format: Bash}
```
ls ~ | grep test
ls ~ | grep file
```

Figure 2-27 shows the output of these commands.

{caption: "Figure 2-27. The result of combining the `ls` and `grep` utilities", width: "100%"}
![ls and grep](images/BashShell/ls-grep.png)

Both commands truncate the `test\nfile.txt` filename. Remove the grep calls in the commands. You see that the `ls` utility prints the filename properly in this way: 'test'$'\n''file.txt'. When you pass it via the pipeline, the escaping sequence `\n` is replaced by the line break. It leads to splitting the filename into two parts. Then `grep` handles the parts separately as two different filenames.

There is another potential problem. Suppose you search and copy the file. Its name has space (for example, "test file.txt"). Then the following command fails:
{line-numbers: false, format: Bash}
```
ls ~ | xargs cp -t ~/tmp
```

In this case, `xargs` constructs the following call of the `cp` utility:
{line-numbers: false, format: Bash}
```
cp -t ~/tmp test file.txt
```

The command copies the `test` and `file.txt` files to the `~/tmp` path. But none of these files exists. The reason for the error is the word splitting mechanism of Bash. It splits lines in words by spaces. You can disable the mechanism by double-quotes. Here is an example for our command:
{line-numbers: false, format: Bash}
```
ls ~ | xargs -I % cp -t ~/tmp "%"
```

It copies the "test file.txt" file properly.

Double-quotes do not help if the filename has a line break. The only solution here is not to use `ls`. The `find` utility with the `-exec` action does this job right. Here is an example:
{line-numbers: false, format: Bash}
```
find . -name "*.txt" -exec cp -t tmp {} \;
```

It would be great not to use pipelines with filenames at all. However, it is required for solving some tasks. In this case, you can combine the `find` and `xargs` utilities. This approach works fine if you call `find` with the `-print0` option. Here is an example:
{line-numbers: false, format: Bash}
```
find . -type f -print0 | xargs -0 -I % bsdtar -cf %.tar %
```

The `-print0` option changes the `find` output format. It separates the paths to found objects by the null character. Without the option, the separator is a line break.

We changed the `find` output format. Then we should notify the `xargs` utility about it. By default, the utility separates the strings on the input stream by line breaks. The `-0` option changes this behavior. With the option, `xargs` applies the null character as the separator.  In this way, we have reconciled the output and input formats of the utilities.

You can change the output format of the `grep`utility in the same manner. It allows you to pass its output through the pipeline. The `-Z` option does that. The option separates filenames with the null character. Here is an example:
{line-numbers: false, format: Bash}
```
grep -RlZ "GNU" . | xargs -0 -I % bsdtar -cf %.tar %
```

The command searches files that contain the "GNU" pattern. Then it passes their names to the `xargs` utility. The utility constructs the `bsdtar` call for archiving the files.

Here are the general advices for using pipelines:

1. Be aware of spaces and line breaks when passing filenames through the pipeline.

2. Never process the `ls` output. Use the `find` utility with the `-exec` action instead.

3. Always use `-0` option when process filenames by `xargs`. Pass null separated names to the utility.

{caption: "Exercise 2-7. Pipelines and I/O streams redirection", format: text, line-numbers: false}
```
Write a command to archive photos with the `bsdtar` utility.
If you are a Linux or macOS user, use the `tar` utility instead.
The photos are stored in the directory structure from exercises 2-6:

~/
  photo/
        2019/
             11/
             12/
        2020/
             01/

The photos of the same month should come into the same archive.
Your command should provide the following result:

~/
  photo/
        2019/
             11.tar
             12.tar
        2020/
             01.tar
```

### Logical Operators

Pipelines allow you to combine several commands. Together they make an algorithm with [**linear sequence**](https://www.cs.utexas.edu/users/mitra/csSpring2017/cs303/lectures/algo.html). The computer executes actions of such an algorithm one by one without any checks.

Suppose we implement a more complex algorithm. There the result of the first command determines the next step. If the command succeeds, the computer does one action. Otherwise, it does another action. Such a dependency is known as [**conditional algorithm**](https://en.wikipedia.org/wiki/Conditional_(computer_programming)). The pipeline does not work in this case. 

Here is an example of the conditional algorithm. We want to write a command to copy the directory. Then we should write the operation result to the log file. The "OK" line matches successful copying. The "Error" line means error.

We can write the following command using a pipeline:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup | echo "OK" > result.log
```

The command does not work properly. It writes the "OK" line to the `result.log` file regardless of the copying result. Even if the `docs` directory does not exist, the log file's message says that the operation succeeds.

The `cp` utility result should define the `echo` command output. The operator && can provide such behavior. Here is an example:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup && echo "OK" > result.log
```

Now the command prints the "OK" line when the `cp` utility succeeds. Otherwise, there is no output to the log file.

What is the && operator? It is a logical AND operation. Here its operands are Bash commands (actions) instead of Boolean expressions (conditions). Let's have a look at how the logical operation works in this case.

The POSIX standard requires each running program to provide [**exit status**](https://en.wikipedia.org/wiki/Exit_status) when it finishes. The zero code means that the program completed successfully. Otherwise, the code takes a value from 1 to 255.

When you apply a logical operator to a command, the operator handles its exit status. First, Bash executes the command. Then its exit status is used as the Boolean expression in the logical operator.

Let's go back to our example:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup && echo "OK" > result.log
```

Suppose the `cp` utility completes successfully. It returns the zero code in this case. The zero code matches the value "true" in Bash. Therefore, the left part of the && operator equals "true". This information is not enough to deduce the result of the whole expression. It can be "true" or "false" depending on the right operand. Then the && operator has to execute the `echo` command. It always succeeds and returns the zero code. Thus, the result of the && operator equals "true".

It is not clear how do we use the result of the && operator in our example. The answer is we do not. Logical operators are needed to calculate Boolean expressions. But they are often used for their side effect in Bash. This side effect is a strict order of operands evaluation.

Let's consider the case when the `cp` utility finishes with an error in our example. Then it returns a non-zero exit status. It is equivalent to the "false" value for Bash. In this case, the && operator can already calculate the value of the whole Boolean expression. It does not need to calculate the right operand. Because If at least one operand of the boolean AND is "false", the entire expression is "false". Thus, the exit status of the `echo` command is not required. Then the && operator does not execute it. In this case, there is no "OK" output in the log file.

Now you get the [**short-circuit evaluation**](https://en.wikipedia.org/wiki/Short-circuit_evaluation). It means calculation only those operands that are sufficient to deduce the value of the whole Boolean expression.

I> Bash stores the exit status of the last executed command in the environment variable. Its name is the question mark. The `echo` command displays its value like this:
{line-numbers: false, format: Bash}
```
echo $?
```

We have done only the first part of our task. Now the command prints the "OK" line in the log file when copying succeeds. But we should handle the false case. The "Error" line should appear in the log file in this case. We can do it with the logical OR operator. It is called || in Bash.

With the OR operator, our command looks like this:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup && echo "OK" > result.log || echo "Error" > result.log
```

This command implements the conditional algorithm that we need. If the `cp` utility finishes successfully, the command writes "OK" in the log file. Otherwise, it writes "Error". To understand how it works, let's consider the priority of the operation first.

First, we would make our command simpler for reading. Let's denote all operands by Latin letters. The "A" letter matches the `cp` call. The "B" letter marks the first `echo` call with the "OK" line. The "C" letter is the second `echo` call. Then we can rewrite our command this way:
{line-numbers: false}
```
A && B || C
```

The && and || operators have the same priorities in Bash. The Boolean expression is calculated from the left to the right side. The operators are called [**left-associative**](https://en.wikipedia.org/wiki/Operator_associativity) in this case. Given this, we can rewrite our expression this way:
{line-numbers: false}
```
(A && B) || C
```

Adding parentheses does not change anything. First, Bash evaluates the expression (A && B). Then, it calculates the "C" operand if it is necessary.

What happens if "A" equals "true"? The && operator calculates its right operand "B" in this case. It leads to printing the "OK" line to the log file. Next, Bash processes the || operator. The interpreter already knows the value of its left operand (A && B). It equals "true". The OR operator's value equals "true" when at least one of its operands is "true". Therefore, the right operand's value does not affect the expression result. Bash skips it. It leads that the "Error" line absents in the log file.

If the "A" value is "false", the expression (A && B) equals "false" too. In this case, Bash skips the operand "B". It leads to the missing "OK" output in the log file. Then Bash handles the next || operator. The interpreter already knows that its left operand equals "false". Thus, it should evaluate the right operand for deducing the whole expression. It leads to the execution of the second `echo` command. Then the "Error" line comes to the log file.

The principle of short-circuits evaluation is not obvious. You would need some time to figure it out. Please do your best for that. Every modern programming language supports Boolean expressions. Therefore, understanding the rules of their evaluation is essential.

We already know how to combine Bash commands with pipelines and logical operators. There is a third way to do that. You can use a semicolon. When two commands have the semicolon in between, Bash executes them one by one without any conditions. You get the linear sequence algorithm in this case.

Here is an example. Suppose that you want to copy two directories to different target paths. The single `cp` call cannot do it at once. But you can combine two calls into one command like this:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup ; cp -R ~/photo ~/photo-backup
```

The command calls the `cp` utility twice. The second call does not depend on the result of copying the `docs` directory. Even if it fails, Bash copies the `photo` directory.

Can we do the same with the pipeline? Yes. Bash executes both `cp` calls in this case too. It means that we get the same linear sequence algorithm in both cases. Here is the command with the pipeline:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup | cp -R ~/photo ~/photo-backup
```

However, semicolon and pipeline behave differently in general. When you use a semicolon, two commands do not depend on each other completely. When you use a pipeline, there is dependency. The output stream of the first command is connected to the input stream of the second command. In some cases, it changes the behavior of the entire algorithm.

Compare the following two commands:
{line-numbers: true, format: Bash}
```
ls /usr/share/doc/bash | grep "README" * -
ls /usr/share/doc/bash ; grep "README" * -
```

The `-` option of `grep` appends data from the input stream to the utility parameters.

Figure 2-28 shows the results of both commands.

{caption: "Figure 2-28. Results of commands with pipeline and semicolon", width: "100%"}
![pipeline and semicolon](images/BashShell/pipe-vs-connector.png)

Even the behavior of the `ls` utility differs in these two commands. With the pipeline, `ls` prints on the screen nothing. Instead, it redirects the output to the `grep` utility input.

Let's consider the output of the commands. The second parameter of `grep` is the "*" pattern. Because of it, the utility processes all files in the current directory. It founds the "README" word in the `xz.txt` file. Then it prints this line on the screen:
{line-numbers: false, format: Bash}
```
xz.txt: README This file
```

On the next step, `grep` processes the `ls` output that it receives on the input stream. This data also contains the "README" word. Then `grep` prints the following line:
{line-numbers: false, format: Bash}
```
(standard input):README
```

This way, the `grep` utility processed two things at once:

* Files of the current directory.
* Data on the input stream.

When you combine the commands with the semicolon, the `ls` utility prints its result on the screen. Then Bash calls the `grep` utility. It processes all files in the current directory. Next, `grep` checks its input stream. But there is no data there. This way, `grep` finds the "README" word in the `xz.txt` file only.

{caption: "Exercise 2-8. Logical operators", format: text, line-numbers: false}
```
Write a command that implements the following algorithm:

1. Copy the README file with the Bash documentation to the user's home directory.

2. Archive the copied ~/README file.

3. Delete the copied ~/README file.

Each step takes place only if the previous one succeeds.
Write the result of each step to the log file result.txt.
```