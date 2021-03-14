## Command Information

We got acquainted with the file system navigation commands. For each of them, we have considered commonly used options and parameters only. What if you need a feature that was left out of the scope of this book?

All modern OSes and applications have documentation. But you need the documentation rarely, thanks to the graphical interface. The purposes of icons and buttons are usually obvious. Therefore, most PC users do not use the documentation that is built into applications.

When working with the command-line interface, the available features and modes of the application are not obvious. Before running it, you should know its options. The negligence can lead to loss or corruption of your data.

The first versions of Unix have paper documentation. It was inconvenient. The documentation volume grew rapidly. Soon it exceeded the size of a single book. The Unix developers introduced the system called `man`. It made accessing the documentation more convenient. The system allows a user to get information about any installed program.

The `man` system is a centralized place to get documentation. Besides it, every program in Unix provides information about itself. For example, the Bash interpreter has its own documentation system. It is called `help`.

You want to list all built-in Bash commands. For getting it, launch the `help` command without parameters. Figure 2-21 shows its output.

{caption: "Figure 2-21. The output of the `help` command", height: "50%"}
![help output](images/BashShell/bash-help.png)

Here is a list of all commands that Bash executes on its own. If a command absents in this list, a GNU utility or third-party program executes it.

For example, the command `cd` presents in the `help` list. It means that Bash executes it without calling any other program. Now suppose you type the "find" command. There is no `find` command in the `help` list. Therefore, Bash looks for a utility with the `find` name on the hard drive. If this utility presents, Bash launches it.

Where does Bash look for utilities for executing commands? It has a list of paths for searching. Bash stores the list in the **environment variable** that is called `PATH`. The [**variable**](https://en.wikipedia.org/wiki/Variable_(computer_science)) is a named area of memory. If you want to access the memory area, you should specify its address. Variables provide a mechanism for simplifying this access. You can use the variable name instead of the address. It is much simpler to memorize names than addresses.

Some data affect the behavior of Bash. The interpreter stores these data in the environment variables. We will consider all types of Bash variables in the next chapter.

I> Call the `env` utility without parameters to print all defined environment variables.

You can imagine the variable as a value that has a name. For example, you can say: "the time is 12 hours". In this case, the variable name is "time". Its value is "12 hours". The computer's memory stores this value. If you request a value of the variable with the name "time", the computer returns you "12 hours".

The `echo` command prints strings. It can also output the value of a variable. If you want to print the value of the `PATH` variable, call the following command:
{line-numbers: false, format: Bash}
```
echo "$PATH"
```

Why do we need the dollar sign $ before a variable name? The `echo` command prints the string that it receives as an input parameter. For example, the following command prints the text "123":
{line-numbers: false, format: Bash}
```
echo 123
```

The dollar sign $ before a word tells Bash that it is a variable name. It is handled differently than a normal string. When Bash encounters a variable name in a command, it looks for this name in the variable list. If the list has it, Bash substitutes the variable name by its value in the command. Otherwise, an empty string is placed.

I> Putting variable names in double-quotes " is [good practice](https://www.tldp.org/LDP/abs/html/quotingvar.html). This way, you avoid potential errors. There is an example. Bash substitutes the variable name by its value. The value contains [**control characters**](https://en.wikipedia.org/wiki/Control_character). The interpreter handles these characters. As a result, the substituted value of the variable differs from one that is stored in memory. This effect leads to incorrect behavior of the program.

Let's go back to the `echo` command that outputs the `PATH` variable. It prints the string as Figure 2-22 shows.

{caption: "Figure 2-22. The value of the `PATH` variable", height: "30%", width: "100%"}
![PATH value](images/BashShell/echo-path.png)

What does this output mean? There is a list of paths that are separated by colons. We can write each path on a new line and get the following list:
{line-numbers: false}
```
/usr/local/bin
/usr/bin
/bin
/opt/bin
/c/Windows/System32
/c/Windows
/c/Windows/System32/Wbem
/c/Windows/System32/WindowsPowerShell/v1.0/
```

The format of the `PATH` variable raises questions. Why does Bash not store the list with [line breaks](https://en.wikipedia.org/wiki/Newline) delimiters instead of colons? This approach makes it easy to read the variable value. The short answer is colons are easy to handle in programs. Bash and some GNU utilities handle the line break character differently. It leads to unobvious errors.

If you want to locate a utility or program on the disk, the `PATH` variable gives you a hint of where to look. Also, the `find` utility can assist you in this task. There is an example. The following command searches the executable of the `find` utility on the disk:
{line-numbers: false, format: Bash}
```
find / -name find
```

The command shows you two locations of the `find` file:

* `/bin`
* `/usr/bin`

There is a much faster way to locate an executable on the disk. Bash has a built-in command called `type`. Launch it and pass the name of any program as an input parameter. The command prints the absolute path to the program's executable. Figure 2-23 shows an example of the output.

{caption: "Figure 2-23. The output of the `type` command", height: "30%"}
![type output](images/BashShell/type-command.png)

The output shows us that the executables of `find` and `ls` utilities are located in the `/usr/bin` directory. Moreover, the path to the `ls` utility is **hashed**. Bash remembers it. When a user calls `ls`, Bash does not search the binary on the disk. It uses the hashed path and calls the utility immediately. If you move the utility with a hashed path, Bash cannot find it anymore.

You can call `type` and pass a built-in shell command there. In this case, you get a message that Bash executes it. Figure 2-23 shows an example of such output for the `pwd` command.

Imagine that we have found the executable of the required utility. How do we know what input parameters it accepts? Call the utility with the `--help` option to print a brief help. Figure 2-24 shows an example of output for the `cat` utility.

{caption: "Figure 2-24. The brief help for the `cat` utility", height: "50%"}
![help for cat](images/BashShell/cat-help.png)

If the brief help is not enough, refer to the documentation system called `info`. Suppose you need some examples of how to use the `cat` utility. The following command shows them:
{line-numbers: false, format: Bash}
```
info cat
```

Figure 2-25 shows the result of the command.

{caption: "Figure 2-25. The `info` page for the `cat` utility", height: "50%"}
![info page for cat](images/BashShell/cat-info.png)

You see a program for reading text documents. The arrow keys or PageUp and PageDown scroll the text. The Q key ends the program.

Developers of GNU utilities have created the `info` system. Before that, all Unix distributions used the `man` system. The capabilities of both programs are similar. The MSYS2 environment uses the modern `info` system.

Your Linux distribution may use `man` instead of `info`. You can use it in the same way as `info`. For example, the following command outputs help for the `cat` utility:
{line-numbers: false, format: Bash}
```
man cat
```

When you know the utility's name to solve your task, it is simple to get help. But what to do if you don't know how to solve the task? The best approach is to look for the answer on the Internet. The command-line tips are more concise than the manuals for GUI programs. You don't need screenshots and videos for explaining each action. Instead, all you need is one single line with a command that does everything you want.

{caption: "Exercise 2-5. The documentation system", format: text, line-numbers: false}
```
Find documentation for each of the built-in commands and utilities in Table 2-1.
Examine the parameters of the ls and find utilities that we did not consider.
```
