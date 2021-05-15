## Extra Bash Features

We have learned the basic Bash built-ins and GNU utilities for operating the file system. Now you know how to run a program or copy a file using the shell. You can do the same things in GUI. When solving such simple tasks, both types of interfaces are effective.

Bash provides several features that a GUI does not have. They give you a significant performance gain when solving some specific tasks. Use these features to automate your work and save time.

These are the Bash features that we are talking about:

1. I/O redirection.
2. Pipelines.
3. Logical operators.

### Unix Philosophy

[Douglas McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy) is one of the Unix developers. He wrote several famous command-line utilities: `spell`, `diff`, `sort`, `join`, `graph`, `speak`, and `tr`. McIlroy summarized the best practices of software development for Unix in the following points:

1. Write programs that do one thing and do it well.
2. Write programs to work together.
3. Write programs to handle text streams, because that is a universal interface.

These principles became a part of the [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy).

The cornerstone of the Unix philosophy is the plain text format. McIlroy emphasized its significant role and called it a universal interface. Using text format allows you both to develop highly specialized programs and combine them together.

The primary feature of the text format is the simplicity of data exchange between programs. Here is an example. Suppose that two developers wrote two utilities independently of each other. The utilities use the text format for input and output data. This decision allows you to combine these utilities. This way, you apply their feature to solve your task. All you need is to pass the output of the first utility to the input of the second one.

When programs interact easily, there is no need to overload them with extra features. For example, you write a program that copies files. It does the job well. At some moment, you realize that the program needs a search function. This feature will speed up your work because you can find and copy the files at once. You add the searching mechanism and it works well. Then you decide to add the feature of creating new directories. It makes the program more convenient for use and so on. This example shows that the requirements for a self-contained application grow rapidly.

Having a universal interface, you can get a special program for each task. You do not need to add a search function to your program. Just call the `find` utility and use its results. This utility works better than your code. The reason is many people use it for a long time. Therefore, they find most of its bugs and fixed them.

Always prefer existed utilities when developing software for Unix and Linux.

### I/O Redirection

GNU utilities were done by 1987. The idea behind them is to provide open-source software for Unix developers. Most of the original Unix programs were proprietary. It means that you should buy a Unix system and launch them there.

GNU utilities copy all features of their originals. Therefore, they follow the Unix philosophy too. Using them, you get all benefits of the universal text format.

You have several options to transfer text data between the utilities. The simplest way is using the clipboard. Suppose that the data fits one line. Follow these steps to move them from one utility to another one:

1. Select the utility's output with the mouse. Now you got it in the clipboard.
2. Type the command to call another utility.
3. Paste the clipboard data with the middle mouse button.
4. Launch the command.

This approach does not work for copying multiple lines. When you paste them, Bash handles each line break as a command delimiter. It treats the text before the delimiter as a separate command. Thus, the shell loses some copied lines.

Another solution for data transfer is using the file system. Create a temporary file to save the utility's output. Then pass the filename to another utility. It will read the data there. This approach is more convenient than the clipboard for two reasons:

1. There is no limit on the number of text lines to transfer.
2. There are no manual operations with the clipboard.

Bash provides you a mechanism that redirects the command's output to the file. It can also redirect the file contents to the command input. It means that your application does not need a feature for interacting with the file system. Instead, it should support the text data format. Then Bash takes care of redirecting data.

Here is an example of redirecting text data. Suppose that you are looking for the files on the disk. You want to save the searching result into a file. Use the `find` utility and the redirection operator `1>`. Then the utility call looks like this:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 1> readme_list.txt
```

The command creates the `readme_list.txt` file in the current directory. It writes the `find` utility's output there. The file contents look the same as it is printed on the screen without the redirection operator. If the current directory has the `readme_list.txt` file already, the command overwrites it.

What does the `1>` operator mean? It is a [redirection](https://en.wikipedia.org/wiki/Redirection_(computing)) of the standard output stream. There are three [standard streams](https://en.wikipedia.org/wiki/Standard_streams) in Unix. Table 2-12 explains them.

{caption: "Table 2-12. POSIX standard streams", width: "100%"}
| Number | Name | Purpose |
| --- | --- | --- |
| 0 | Standard input stream (stdin). | A program receives input data from this stream. By default, it comes from an input device like a keyboard. |
|  | | |
| 1 | Standard output stream (stdout). | A program outputs data there. The terminal window prints this stream by default. |
|  | | |
| 2 | Standard error stream (stderr). | A program outputs the error messages there. The terminal window prints this stream by default. |

Any program operates in the software environment that the OS provides. You can imagine each standard stream as a communication channel between the program and the OS environment.

Early Unix systems have used only physical channels for data input and output. The input channel comes from the keyboard. The same way the output channel goes to the monitor. Then developers introduced the streams as an [abstraction](https://en.wikipedia.org/wiki/Abstraction_layer) for these channels. The abstraction makes it possible to work with different objects using the same algorithm. It allows replacing a real device input with the file data. Similarly, it replaces printing data to the screen with writing them to the file. The same OS code handles these I/O operations.

The purpose of the input and output streams is clear. However, the error stream causes questions. Why does a program need it? Imagine that you run the `find` utility to search for files. You do not have access to some directories. When the `find` utility reads their contents, it is unavailable. The utility reports about these issues in the error messages.

Suppose that the `find` utility found many files. You can miss error messages in a huge file list. Separating the output and error streams helps you in this case. For example, you can redirect the output stream to the file. Then the utility prints only error messages on the screen.

The `2>` operator redirects the standard error stream. Use it in the same way as the `1>` operator. Here is an example with the `find` utility:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 2> errors.txt
```

Each redirection operator has a number before the angle bracket. The number specifies the stream's number from Table 2-12. For example, the `2>` operator redirects the second stream.

If you need to redirect the standard input stream, the operator looks like `0<`. You cannot handle this stream with the `0>` operator. Here is an example. The following call searches the "Bash" pattern in the `README.txt` file:
{line-numbers: false, format: Bash}
```
grep "Bash" 0< README.txt
```

This command is for demonstration only. It uses the `grep` utility's interface that handles the standard input stream. However, the utility can read the contents of a specified file on its own. Use this mechanism and always pass the filename to the utility. Here is an example:
{line-numbers: false, format: Bash}
```
grep "Bash" README.txt
```

Let's take a more complicated example. Some Bash manuals recommend the `echo` command to print a file's contents. Using this approach, you can print the`README.txt` file this way:
{line-numbers: false, format: Bash}
```
echo $( 0< README.txt )
```

Here `echo` receives the output of the following command:
{line-numbers: false, format: Bash}
```
0< README.txt
```

We have used the **command substitution** Bash mechanism to embed one command into another one. When the shell encounters the `$(` and `)` characters, it executes everything enclosed between them. Then Bash inserts the output of the executed command instead of the `$(...)` block.

Bash executes our `echo` call in two steps because of the command substitution. These are the steps:

1. Pass the `README.txt` file's contents to the standard input stream.

2. Print data from the input stream on the screen.

Please take into account the execution order when invoking the command substitution. Bash executes sub-commands and inserts their results in the order they follow. Only when all substitutions are done, Bash executes the resulting command.

The following `find` call demonstrates a typical mistake when using the command substitution:
{line-numbers: false, format: Bash}
```
$ find / -path */doc/* -name README -exec echo $(0< {}) \;
```

This command should print the contents of all found files. However, it leads to the following Bash error:
{line-numbers: false, format: Bash}
```
bash: {}: No such file or directory
```

The problem happens because Bash executes the "0< {}" command before calling the `find` utility. When executing this command, the shell redirects the file called `{}` to the input stream. However, there is no file with such a name. We expect the `find` utility substitutes the brackets `{}` by its results. It does not happen because these results are not ready yet.

Replace the `echo` command with the `cat` utility. It solves the problem. Then you get the following `find` call:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README -exec cat {} \;
```

This command prints the contents of all found files.

Bash users apply the redirection operators frequently. Therefore, the shell developers have added short forms for some of them. Here are these forms:

* The `<` operator redirects the input stream.
* The `>` operator redirects the output stream.

Here is an example of using the `>` operator:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README > readme_list.txt
```

This command writes a list of all found README files to the `readme_list.txt` file.

Here is an example of using the `<` operator:
{line-numbers: false, format: Bash}
```
echo $( < README.txt )
```

Suppose that you redirect the output stream to a file. Then you found that this file already exists. You decide to keep its content and add new data at the end. Use the `>>` operator in this case.

Here is an example. You are searching the README files in the `/usr` and `/opt` system directories. You want to store the searching results in the `readme_list.txt` file. Then you should call the `find` utility twice. The first call uses the `>` operator. The second call should use the `>>` operator. These calls look like this:
{line-numbers: true, format: Bash}
```
find /usr -path */doc/* -name README > readme_list.txt
find /opt -name README >> readme_list.txt
```

The first `find` call creates the `readme_list.txt` file and writes its result there. If the file already exists, the utility overwrites its contents. The second `find` call appends its output to the end of `readme_list.txt`. If the file does not exist, the `>>` operator creates it.

The full form of the `>>` operator looks like `1>>`. You can use this form for both output and error streams. The operator for redirecting the error stream looks like `2>>`.

Suppose that you need to redirect both the output and the error streams to the same file. Use the `&>` and `&>>` operators in this case. The first operator overwrites an existing file. The second one appends data at the end of the file. Here is an example:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README &> result_and_errors.txt
```

This command works in Bash properly. However, the `&>` operator may absent in other shells. If you should use the features of the POSIX standard only, apply the `2>&1` operator. Here is an example:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README > result_and_errors.txt 2>&1
```

The `2>&1` operator is called **stream duplication**. It redirects both output and error streams to the same target.

Be careful when using stream duplication. It is easy to make a mistake and mix up the operators' order in a command. If you work in Bash, always prefer the `&>` and `&>>` operators.

The following command demonstrates a mistake with using stream duplication:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 2>&1 > result_and_errors.txt
```

This command outputs the error stream data on the screen. However, we expect that these data come to the `result_and_errors.txt` file. The problem happens because of the wrong order of `2>&1` and `>` operators.

Here are the details of the problem. The POSIX standard has the concept of the [**file descriptor**](https://en.wikipedia.org/wiki/File_descriptor). The descriptor is a pointer to a file or communication channel. It serves as an abstraction that makes it easier to handle streams.

When you start a program, both descriptors of output and error streams point to the terminal window. You can associate them with files instead. If you do so, the streams' descriptors point to that file. The [BashGuide article](http://mywiki.wooledge.org/BashFAQ/055) describes this mechanism in detail.

Let's go back to our `find` call. Bash processes redirection operators one by one from left to right. Table 2-13 shows how it happens in our example.

{caption: "Table 2-13. The order for applying redirection operators", width: "100%"}
| Number | Operation | Result |
| --- | --- | --- |
| 1 | `2>&1` | Now the error stream points to the same target as the output stream. The target is the terminal window. |
|  | | |
| 2 | `> result_and_errors.txt` | Now the output stream points to the file `result_and_errors.txt`. The error stream is still associated with the terminal window. |

We should change the order of the redirection operators to fix the mistake. The `>` operator comes first. Then stream duplication takes place. Here is the command:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README > result_and_errors.txt 2>&1
```

Both output and error streams point to the `result_and_errors.txt` file here.

Suppose that you want to redirect output and error streams into two different files. Specify redirection operators for each stream one after another in this case. Here is an example:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README > result.txt 2> errors.txt
```

The order of the operators is not important here.

### Pipelines

The redirection operators are useful when you save data for manual analysis or processing. When you want to process data with another program, storing them in temporary files is inconvenient. Managing these files takes extra effort. You should keep in mind their paths and remove them after usage.

Unix provides an alternative solution for transferring text data. It is called a [**pipeline**](https://en.wikipedia.org/wiki/Pipeline_(Unix)). This mechanism shares data between programs by passing messages. It does not use the file system.

An example will demonstrate how pipelines work. Suppose that you are looking for information about the Bash [license](https://en.wikipedia.org/wiki/Software_license). Bash documentation has it. Therefore, you call the `grep` utility to parse documentation files this way:
{line-numbers: false, format: Bash}
```
grep -R "GNU" /usr/share/doc/bash
```

Another source of the Bash license information is the `info` help page. You can take this information and transfer it to the `grep` utility. The pipeline does this job. It takes the output of one program and sends it to the input of another one. The following command does it for `info` and `grep` programs:
{line-numbers: false, format: Bash}
```
info bash | grep -n "GNU"
```

The `info` utility sends its result to the output stream. This stream is associated with the monitor by default. Therefore, you see the information in the terminal window. You do not get it in our case because of the pipeline.

The vertical bar `|` means the pipeline operator. When you add it after the `info` call, the utility's output comes to the pipeline. You should add another command after the `|` symbol. This command receives the data from the pipeline. This is the `grep` call in our example.

The general algorithm of our command looks like this:

1. Call the `info` program to receive the Bash help.
2. Send the `info` output to the pipeline.
3. Call the `grep` utility.
4. Pass the data from the pipeline to `grep`.

The `grep` utility searches the "GNU" word in the input data. If the utility finds the word, it prints the corresponding string of the input data. Check the `grep` output. If it is not empty, the Bash license is [GNU GPL](https://en.wikipedia.org/wiki/GNU_General_Public_License).

We use the `-n` option when calling `grep`. It adds the line numbers to the utility's output. The option helps you find the exact place of the "GNU" word on the help page.

#### du

Here is a more complex example with pipelines and the `du` utility. The utility evaluates disk space usage. Run it without parameters in the current directory. The utility passes through all subdirectories **recursively**. It prints the space occupied by each of them.

Traversing a directory recursively means visiting all its subdirectories. If any of them has subdirectories, we should visit them too, etc. The traversal algorithm looks like this:

1. Check the contents of the current directory.

2. If there is an unvisited subdirectory, go to it and start from the 1st step of the algorithm.

3. If all subdirectories are visited, go to the parent directory and start from the 1st step of the algorithm.

4. If it is impossible to go to the parent directory, finish the algorithm.

You should select a starting point for this algorithm. It is a specific file system path. Then the algorithm bypasses all subdirectories starting from this path. The traversing finishes when the algorithm should come to the parent directory of the starting point.

We have considered the universal traversal algorithm. You can add any action to it for processing each subdirectory. The action of the `du` utility is calculating disk space usage.

The algorithm of the `du` utility looks like this:

1. Check the contents of the current directory.

2. If there is an unvisited subdirectory, go to it and start from the 1st step of the algorithm.

3. If there are no subdirectories:

    3.1 Calculate and print the disk space occupied by the current directory.

    3.2 Go to the parent directory.

    3.3 Start from the 1st step of the algorithm.

4. If it is impossible to go to the parent directory, finish the algorithm.

When calling the `du` utility, you can specify a path to a file or directory. If you pass the file's path, the utility prints its size and finishes. In the case of the directory, it executes the traversing algorithm.

Here is an example of the `du` call for the `/usr/share` path:
{line-numbers: false, format: Bash}
```
du /usr/share
```

It gives the following output:
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

You see a table of two columns. The right column shows the subdirectories. The left column shows the number of bits they occupy.

You can add the statistics for the files to the `du` output. Use the `-a` option for that. Here is an example `du` call:
{line-numbers: false, format: Bash}
```
du /usr/share -a
```

The `-h` option improves the `du` output. The option converts bytes to kilobytes, megabytes, and gigabytes.

Suppose that you want to evaluate the size of all HTML files in the `/usr/share` path. The following command does it:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | grep "\.html"
```

Here the pipeline redirects the `du` output to the `grep` input. The `grep` utility filters it and prints the lines that match the "\.html" pattern.

The backslash \ escapes the dot in the "\.html" pattern. The dot means a single occurrence of any character. If you specify the ".html" pattern, the `grep` output includes non-HTML files (like `pod2html.1perl.gz`) and subdirectories (like `/usr/share/doc/pcre/html`). When you escape the dot, the `grep` utility treats it as a dot character.

The pipeline combines calls of `du` and `grep` utilities in our example. However, you can combine more than two commands. Suppose that you need to sort the found HTML files. Call the `sort` utility for doing this job. Then you get the following pipeline :
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | grep "\.html" | sort -h -r
```

The `sort` utility sorts the strings in ascending [**lexicographic order**](https://en.wikipedia.org/wiki/Lexicographic_order) when called without options. The following example explains the lexicographic order. Suppose that you have a file. It has this contents:
{line-numbers: true, format: text}
```
abc
aaaa
aaa
dca
bcd
dec
```

You call the `sort` utility for this file. It gives you the following output:
{line-numbers: true, format: text}
```
aaa
aaaa
abc
bcd
dca
dec
```

The `-r` option of the utility reverts the sorting order. You get this output when applying the option:
{line-numbers: true, format: text}
```
dec
dca
bcd
abc
aaaa
aaa
```

The `du` utility prints it results in the table. The first column contains sizes of files and directories. The `sort` utility process its input data line by line from left to right. Suppose that you transfer the `du` output to the `sort` input. Then the `sort` utility deals with numbers which are sizes of objects. The lexicographic sorting does not work well in this case. An example will explain the issue to you.

There is a file with three integers:
{line-numbers: true, format: text}
```
3
100
2
```

If you call the `sort` utility for this file, it gives you this result:
{line-numbers: true, format: text}
```
100
2
3
```

The utility deduces that 100 is less than 2 and 3. It happens because `sort` compares strings but not digits. It converts each character of two lines to the corresponding ASCII code. Then the utility compares these codes one by one from left to right. When the first difference happens, the utility chooses the smaller string and puts it first. This string has the character with the smaller code.

The `-n` option forces `sort` to compare digits instead of strings. If you add this option, the utility converts all string into the numbers and compare them. Using this option, you get the correct sorting order like this:
{line-numbers: true, format: text}
```
2
3
100
```

Let's come back to our command:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | grep "\.html" | sort -h -r
```


It works well because of the `-h` option of the `sort` utility. This option forces the utility to convert the object sizes to integers. For example, it converts "2K" to "2048" integer. If `sort` meets the "2048" string, the utility treats it as an integer. This way, `sort` can process the `du` output.

You can combine pipelines with stream redirection. Suppose that you want to save the filtered and sorted `du` output to the file. The following command does it:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | grep "\.html" | sort -h -r > result.txt
```

The `result.txt` file gets the `sort` output here.

There is an option to split data streams when you combine pipelines and the redirection operator. For example, you want to write the output stream into the file and pass it to another utility at once. Bash does not have a mechanism for this task. However, you can call the `tee` utility for doing that. Here is an example:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | tee result.txt
```

The command prints the `du` output on the screen. It writes this output into the `result.txt` file at the same time. The `tee` utility duplicates its input stream to the specified file and the output stream. The utility overwrites the contents of `result.txt` if it exists. Use the `-a` option if you want to append data to the existing file.

Sometimes you need to check the data flow between commands in a pipeline. The `tee` utility helps you in this case. Just call the utility between the commands in the pipeline. Here is an example:
{line-numbers: false, format: Bash}
```
du /usr/share -a -h | tee du.txt | grep "\.html" | tee grep.txt | sort -h -r > result.txt
```

Each `tee` call stores the output of the previous pipeline command to the corresponding file. This intermediate output helps you to debug possible mistakes. The `result.txt` file contains the final result of the whole pipeline.

#### xargs

The `find` utility has the `-exec` parameter. It calls the specified command for each found object. This behavior resembles a pipeline: `find` passes its result to another program. These two mechanisms look similar, but their internals differs. Choose an appropriate one depending on your task.

Let's look at how the `find` utility performs the `-exec` action. The utility has a built-in interpreter. When it receives the `-exec` action on input, it calls the specified program there. The interpreter passes to the program whatever the `find` utility has found. Note that Bash is not involved in the `-exec` call. Therefore, you cannot use the following Bash features there:

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

The `find` utility calls the `echo` Bash built-in here. It works correctly. Why? Actually, `find` calls the `echo` utility. It has the same name as the Bash command. Unix environment provides several utilities that duplicate the Bash built-ins. You can find them in the `/bin` system directory. For example, there is the `/bin/echo` executable there.

Sometimes you need a Bash feature in the `-exec` action. There is a trick to get it. Run the shell explicitly and pass a command to it. Here is an example:
{line-numbers: false, format: Bash}
```
find ~ -type f -exec bash -c 'echo {}' \;
```

The previous command calls the `echo` utility. This command calls the `echo` Bash built-in. They do the same and print the `find` results on the screen.

Another option to process the `find` results is applying pipeline. Here is an example:
{line-numbers: false, format: Bash}
```
find ~ -type f | grep "bash"
```

The command's output looks like this:
{line-numbers: true, format: Bash}
```
/home/ilya.shpigor/.bashrc
/home/ilya.shpigor/.bash_history
/home/ilya.shpigor/.bash_logout
/home/ilya.shpigor/.bash_profile
```

The pipeline receives text data from the `find` utility. Then it transfers these data to the `grep` utility.  Finally, `grep` prints the filenames where the pattern "bash" occurs.

The `-exec` action behaves in another way. No text data is transferred in this case. The `find` interpreter constructs a program call using the `find` results. It passes the paths of found files and directories to the program. These paths are not plain text.

You can get the `-exec` action behavior when using the pipeline. Call the `xargs` utility for that.

Here is an example. Suppose that you want to find the pattern in the contents of the found files. The `grep` utility should receive file paths but not the plain text in this case. You can apply pipeline and `xarg` to solve this task. The solution looks like this:
{line-numbers: false, format: Bash}
```
find ~ -type f | xargs grep "bash"
```

I> This command cannot handle files whose names contain spaces and line breaks. The next section considers how to solve this problem.

Here is the command's output:
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

The `xargs` utility constructs a command. The utility takes two things on the input: parameters and text data from the input stream. The parameters come in the first place in the constructed command. Then all data from the input stream follows.

Let's come back to our example. Suppose that the `find` utility found the `~/.bashrc` file. The pipeline passes the file path to the following `xargs` call:
{line-numbers: false, format: Bash}
```
xargs grep "bash"
```

The `xargs` utility receives two parameters in this call: "grep" and "bash". Therefore, it constructs the command that starts with these two words. Here is the result:
{line-numbers: false, format: Bash}
```
grep "bash"
```

Then `xargs` do the second step. It takes text data from the input stream and converts them to the parameters for the constructed command. The pipeline passes the `~/.bashrc` path to `xargs`. The utility uses it for making this command:
{line-numbers: false, format: bash}
```
grep "bash" ~/.bashrc
```

The `xargs` utility does not invoke Bash for executing the constructed command. It means that the command has the same restrictions as the `-exec` action of the `find` utility. No Bash built-ins and features are allowed there.

The `xargs` utility places the parameters made from the input stream at the end of the constructed command. In some cases, you want to change their position. For example, you want to place the parameters in the middle of the command. The `-I` option of `xargs` does that.

Here is an example. Suppose that you want to copy the found HTML files to the home directory. The `cp` utility does it. The only task is placing its parameters in the proper order when constructing the `cp` call. Use the `-I` option of `xargs` this way to get it:
{line-numbers: false, format: Bash}
```
find /usr/share/doc/bash -type f -name "*.html" | xargs -I % cp % ~
```

When you apply the `-I` option, you specify the place to insert parameters by the percent sign %. You can replace the percent sign with any string. Here is an example:
{line-numbers: false, format: Bash}
```
find /usr/share/doc/bash -type f -name "*.html" | xargs -I FILE cp FILE ~
```

The `xargs` utility receives several lines via the pipeline. It constructs the `cp` call per each received line. The utility creates the following two commands in our example:
{line-numbers: true, format: Bash}
```
cp /usr/share/doc/bash/bash.html /home/ilya.shpigor
cp /usr/share/doc/bash/bashref.html /home/ilya.shpigor
```

The `-t` option of `xargs` displays the constructed commands before executing them. Use it for checking the utility's results and debugging. Here is an example of applying the option:
{line-numbers: false, format: Bash}
```
find /usr/share/doc/bash -type f -name "*.html" | xargs -t -I % cp % ~
```

We have considered several cases of using `find` with a pipeline. These examples are for educational purposes only. Do not apply them in practice! Use the `-exec` action of the `find` utility instead of pipelines. This way, you avoid issues when processing filenames with spaces and line breaks.

There are very few cases when combining `find` and a pipeline makes sense. One of these cases is the parallel processing of found files.

Here is an example. When you call the `cp` utility in the `-exec` action, it copies files one by one. It is inefficient if your CPU has several cores and the hard disk has a high access speed. You can speed up the operation by running it in several parallel processes. The `-P` parameter of the `xargs` utility does that. Specify the number of the processes in this parameter. They will execute the constructed command in parallel.

Suppose your computer's processor has four cores. Then you can copy files in four parallel processes. The following command does it:
{line-numbers: false, format: Bash}
```
find /usr/share/doc/bash -type f -name "*.html" | xargs -P 4 -I % cp % ~
```

This command copies four files at once. As soon as one of the parallel processes finishes, it handles the next file. This approach speeds up the processing of time-consuming tasks considerably. The performance gain depends on the configuration of your hardware.

Many GNU utilities can handle text data from the input stream. They work well in pipelines. Table 2-14 shows the most commonly used of these utilities.

{caption: "Table 2-14. Utilities for processing the input stream", width: "100%"}
| Utility | Description | Examples |
| --- | --- | --- |
| `xargs` | It constructs a command from parameters and the input stream data. | `find . -type f -print0 | xargs -0 cp -t ~` |
|  | | |
| `grep` | It searches for text that matches | `grep -A 3 -B 3 "GNU" file.txt` |
| | the specified pattern. | `du /usr/share -a | grep "\.html"` |
|  | | |
| `tee` | It redirects the input stream to the output stream and file at the same time. | `grep "GNU" file.txt | tee result.txt` |
|  | | |
| `sort` | It sorts strings from the input stream | `sort file.txt` |
| | in forward or reverse order (`-r`). | `du /usr/share | sort -n -r` |
|  | | |
| `wc` | It counts the number of lines (`-l`), words (`-w`), | `wc -l file.txt` |
| | letters (`-m`) and bytes (`-c`) in the specified file or input stream. | `info find | wc -m` |
|  | | |
| `head` | It outputs the first bytes (`-c`) or lines (`-n`) | `head -n 10 file.txt` |
| | of a file or text from the input stream. | `du /usr/share | sort -n -r | head -10` |
|  | | |
| `tail` | It outputs the last bytes (`-c`) or lines (`-n`) | `tail -n 10 file.txt` |
| | of a file or text from the input stream. | `du /usr/share | sort -n -r | tail -10` |
|  | | |
| `less` | It is the utility for navigating | `less /usr/share/doc/bash/README` |
|  | text from the input stream. Press the Q key to exit. | `du | less` |

### Pipeline Pitfalls

The pipeline is a convenient Bash feature. You will apply it often when working with the shell. Unfortunately, you can easily make a mistake using the pipeline. Let's consider its pitfalls by examples.

You can expect that the same result from the following two commands:
{line-numbers: true, format: Bash}
```
find /usr/share/doc/bash -name "*.html"
ls /usr/share/doc/bash | grep "\.html"
```

These commands provide different results in some cases. The problem happens when you pass the filenames through the pipeline.

The root cause of the problem came from the POSIX standard. The standard allows all printable characters in the file and directory names. It means that spaces and line breaks are allowed. The only forbidden character is the [**null character**](https://en.wikipedia.org/wiki/Null_character) (NULL). This rule can lead to unexpected consequences.

Here is an example. Create a file in the home directory. The filename should contain the line break. This is a control character that matches the `\n` [**escape sequence**](https://en.wikipedia.org/wiki/Escape_sequence) in the ASCII encoding. Call the `touch` utility to create the empty file this way:
{line-numbers: false, format: Bash}
```
touch ~/$'test\nfile.txt'
```

The `touch` utility updates the modification time of the file. It is a primary task of the utility. If the file does not exist, `touch` creates it. Such secondary features of a program are called [**side effect**](https://en.wikipedia.org/wiki/Side_effect_(computer_science)).

You need to create two extra files for our test. Call them `test1.txt` and `file1.txt`. The following command does that:
{line-numbers: false, format: Bash}
```
touch ~/test1.txt ~/file1.txt
```

Now call the `ls` utility for the home directory. Pass its output to `grep` using the pipeline. Here are the example commands:
{line-numbers: true, format: Bash}
```
ls ~ | grep test
ls ~ | grep file
```

Figure 2-27 shows the output of these commands.

{caption: "Figure 2-27. The result of combining the `ls` and `grep` utilities", width: "100%"}
![ls and grep](images/BashShell/ls-grep.png)

Both commands truncate the `test\nfile.txt` filename.

Try to call `ls` without the pipeline. You will see that the utility prints the 'test'$'\n''file.txt' filename properly. When you pass it via the pipeline, the escaping sequence `\n` is replaced by the line break. It leads to splitting the filename into two parts. Then `grep` handles these parts separately.

There is another potential problem. Suppose you search and copy the file. Its name has a space (for example, "test file.txt"). Then the following command fails:
{line-numbers: false, format: Bash}
```
ls ~ | xargs cp -t ~/tmp
```

Here `xargs` constructs the following call of the `cp` utility:
{line-numbers: false, format: Bash}
```
cp -t ~/tmp test file.txt
```

The command copies the `test` and `file.txt` files to the `~/tmp` path. However, none of these files exists. The reason for the error is the word splitting mechanism. Bash splits lines in words by the spaces. You can disable the mechanism by double-quotes. Here is an example for our command:
{line-numbers: false, format: Bash}
```
ls ~ | xargs -I % cp -t ~/tmp "%"
```

It copies the "test file.txt" file properly.

Double quotes do not help if the filename has a line break. The only solution here is not to use `ls`. The `find` utility with the `-exec` action does this job right. Here is an example:
{line-numbers: false, format: Bash}
```
find . -name "*.txt" -exec cp -t tmp {} \;
```

It would be great not to use pipelines with file and directory names at all. However, you need it for solving some tasks. Combine the `find` and `xargs` utilities in this case. This approach works well if you call `find` with the `-print0` option. Here is an example:
{line-numbers: false, format: Bash}
```
find . -type f -print0 | xargs -0 -I % bsdtar -cf %.tar %
```

The `-print0` option changes the `find` output format. The default format is a list of the found objects. The separator between the objects is a line break. The `-print0` option changes the separator to the null character.

You have changed the `find` output format. Now you should change the `xargs` call accordingly. The `xarg` utility separates the input stream data by line breaks. The `-0` option changes the separator to the null character. This way, you reconcile the output and input formats of two utilities.

The `-Z` option changes the `grep` output format in the same manner. It replaces the line breaks with the null characters. Using the option, you can pass the `grep` output via the pipeline without errors. Here is an example:
{line-numbers: false, format: Bash}
```
grep -RlZ "GNU" . | xargs -0 -I % bsdtar -cf %.tar %
```

This command searches files that contain the "GNU" pattern. Then the pipeline passes the found filenames to the `xargs` utility. The utility constructs the `bsdtar` call for archiving these files.

Here are the general hints for using pipelines:

1. Be aware of spaces and line breaks when passing file and directory names via the pipeline.

2. Never process the `ls` output. Use the `find` utility with the `-exec` action instead.

3. Always use `-0` option when processing the object names by `xargs`. Pass only null character separated names to the utility.

{caption: "Exercise 2-7. Pipelines and I/O streams redirection", format: text, line-numbers: false}
```
Write a command to archive photos using the bsdtar utility.
If you are a Linux or macOS user, use the tar utility instead.
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

The pipeline allows you to combine several commands. These commands together make an algorithm with a [**linear sequence**](https://www.cs.utexas.edu/users/mitra/csSpring2017/cs303/lectures/algo.html). The computer executes actions of such an algorithm one by one without any conditions.

Suppose that you need a more complex algorithm. There the result of the first command determines the next step. If the command succeeds, the computer does one action. Otherwise, it does another action. Such a dependency is known as a [**conditional algorithm**](https://en.wikipedia.org/wiki/Conditional_(computer_programming)). The pipeline does not fit in this case.

Here is an example of the conditional algorithm. You want to write a command to copy the directory. If this operation succeeds, the command writes the "OK" line in the log file. Otherwise, it writes the "Error" line there.

You can write the following command using the pipeline:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup | echo "OK" > result.log
```

This command does not work properly. It writes the "OK" line to the `result.log` file regardless of the copying result. Even if the `docs` directory does not exist, you get the "OK" line. It means the succeeded operation, but it has failed in fact.

The `cp` utility result should define the `echo` output. You can get this behavior using the && operator. Then the command looks like this:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup && echo "OK" > result.log
```

Now `echo` prints the "OK" line when the `cp` utility succeeds. Otherwise, there is no output to the log file.

The && operator performs the logical conjunction (AND). Its operands are Bash commands, which are actions. It differs from a regular AND that operates the Boolean expressions. These expressions are conditions.

Let's have a look at how the logical conjunction deals with the Bash commands. The POSIX standard requires each program to return an [**exit code**](https://en.wikipedia.org/wiki/Exit_status) (or exit status) when it is done. The zero code means that the program finished successfully. Otherwise, the code takes a value from 1 to 255. Each Bash built-in returns the exit code too.

When you apply logical conjunction to the commands, the operator handles their exit codes. Bash executes the commands. Then the shell converts their exit codes into Boolean values. These values are the allowed operands of the logical operator.

Let's go back to our example command:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup && echo "OK" > result.log
```

Suppose the `cp` utility completes successfully. It returns the zero code in this case. The zero code matches the "true" Boolean value. Therefore, the left-hand side (LHS) operand of the && operator equals "true". This information is not enough to deduce the result of the whole expression. It can be "true" or "false" depending on the right-hand side (RHS) operand. Then the && operator has to execute the `echo` command. This command always succeeds and returns the zero code. Thus, the result of the && operator equals "true".

It is not clear how do we use the result of the && operator in our example. The answer is we do not use it at all. Logical operators are needed to calculate Boolean expressions. However, they are often used in Bash for their side effect. This side effect is a strict order of operands evaluation.

Let's consider the case when the `cp` utility fails in our example. It returns a non-zero exit code. This code is equivalent to the "false" value for Bash. In this case, the && operator can deduce the value of the whole Boolean expression. It does not need to calculate the RHS operand. If at least one operand of the logical AND is "false", the operator's result equals "false". Thus, the exit code of the `echo` command is not required. Then the && operator does not execute it. This way, the "OK" line does not come to the log file.

We have considered the behavior of logical operators that is called the [**short-circuit evaluation**](https://en.wikipedia.org/wiki/Short-circuit_evaluation). It means calculation only those operands that are sufficient to deduce the value of the whole Boolean expression.

I> Bash stores an exit code of the last executed command in the environment variable. The variable name is the question mark. You can print its value with the `echo` command this way:
{line-numbers: false, format: Bash}
```
echo $?
```

We have done only the first part of our task. Now the command prints the "OK" line in the log file when copying succeeds. We need to handle the case of a failure too. If copying fails, the log file should get the "Error" line. You can add this behavior with the || operator, which does logical OR.

When adding the OR operator, our command looks like this:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup && echo "OK" > result.log || echo "Error" > result.log
```

This command implements the conditional algorithm that we need. If the `cp` utility finishes successfully, the log file gets the "OK" line. Otherwise, it gets the "Error" line. Let's consider how it works in detail.

First, we would make our command simpler for reading. Let's denote all operands by Latin letters. The "A" letter matches the `cp` call. The "B" letter marks the first `echo` call with the "OK" line. The "C" letter is the second `echo` call. Then we can rewrite our command this way:
{line-numbers: false}
```
A && B || C
```

The && and || operators have the same priorities. Bash calculates Boolean expressions from the left to the right side. The operators are called [**left-associative**](https://en.wikipedia.org/wiki/Operator_associativity) in this case. Given this, we can rewrite our expression this way:
{line-numbers: false}
```
(A && B) || C
```

Adding parentheses does not change the calculation order. First, Bash evaluates the expression (A && B). Then, it calculates the "C" operand if it is necessary.

If "A" equals "true", the && operator calculates its RHS operand "B". This is the `echo` command that prints the "OK" line to the log file. Next, Bash processes the || operator. Its LHS operand (A && B) equals "true". When calculating the OR operator, it is enough to get the "true" value for at least one operand. Then you can conclude that the operator's result equals "true". Therefore, Bash skips the RHS operand "C" in our case. It leads that the "Error" line does not come to the log file.

If the "A" value is "false", the expression (A && B) equals "false" too. In this case, Bash skips the operand "B". It is enough to have one operand equals "false" to deduce the "false" result of the AND operator. Then the "OK" line does not come to the log file. Next, Bash handles the || operator. The shell already knows that its LHS operand equals "false". Thus, it should evaluate the RHS operand "C" for deducing the whole expression. It leads to executing the second `echo` command. Then the "Error" line comes to the log file.

The principle of short-circuits evaluation is not obvious. You would need some time to figure it out. Please do your best for that. Every modern programming language supports Boolean expressions. Therefore, understanding the rules of their evaluation is essential.

We already know how to combine Bash commands with pipelines and logical operators. There is a third way to do that. You can put a semicolon as a delimiter between the commands. In this case, Bash executes them one by one from left to right without any conditions. You get the linear sequence algorithm in this case.

Here is an example. Suppose that you want to copy two directories to different target paths. A single `cp` call cannot do it. But you can combine two calls into one command like this:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup ; cp -R ~/photo ~/photo-backup
```

This command calls the `cp` utility twice. The second call does not depend on the result of copying the `docs` directory. Even if it fails, Bash copies the `photo` directory anyway.

You can do the same with the pipeline this way:
{line-numbers: false, format: Bash}
```
cp -R ~/docs ~/docs-backup | cp -R ~/photo ~/photo-backup
```

Here Bash executes both `cp` calls one by one too. It means that the linear sequence algorithm is the same for commands with the semicolon and pipeline.

However, a semicolon and pipeline behave differently in general. When you use the semicolon, two commands do not depend on each other completely. When you use the pipeline, there is dependency. The output stream data of the first command comes to the input stream of the second command. In some cases, it changes the behavior of your algorithm.

Compare the following two commands:
{line-numbers: true, format: Bash}
```
ls /usr/share/doc/bash | grep "README" * -
ls /usr/share/doc/bash ; grep "README" * -
```

The `-` option of `grep` appends data from the input stream to the utility's parameters.

Figure 2-28 shows the results of both commands.

{caption: "Figure 2-28. Results of commands with pipeline and semicolon", width: "100%"}
![pipeline and semicolon](images/BashShell/pipe-vs-connector.png)

Even the behavior of the `ls` utility differs in these two commands. When using the pipeline, `ls` prints nothing on the screen. Instead, it redirects its output to the `grep` input.

Let's consider the output of the commands. The second parameter of `grep` is the "*" pattern. It forces the utility to process all files in the current directory first. `grep` founds the "README" word in the `xz.txt` file. Then it prints this line on the screen:
{line-numbers: false, format: Bash}
```
xz.txt: README This file
```

When file processing is done, `grep` handles the input stream data from the `ls` utility. This data also contains the "README" word. Then `grep` prints the following line:
{line-numbers: false, format: Bash}
```
(standard input):README
```

This way, the `grep` utility processes two things at once:

* Files of the current directory.
* Data from the input stream.

When using the semicolon, the `ls` utility prints its result on the screen. Then Bash calls the `grep` utility. It processes all files of the current directory. Next, `grep` checks its input stream. There is no data there. This way, `grep` finds the "README" word in the `xz.txt` file only.

{caption: "Exercise 2-8. Logical operators", format: text, line-numbers: false}
```
Write the command that implements the following algorithm:

1. Copy the README file with the Bash documentation to the home directory.

2. Archive the copied ~/README file.

3. Delete the copied ~/README file.

Each step takes place only if the previous one succeeds.
Write the result of each step to the log file result.txt.
```
