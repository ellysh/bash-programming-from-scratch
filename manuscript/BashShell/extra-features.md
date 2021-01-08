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