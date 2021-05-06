## Command Information

We got acquainted with commands for navigating the file system. Each command has several options and parameters. We have covered the most common ones only. What if you need a rare feature that is missing in this book? You would need official documentation in this case.

All modern OSes and applications have documentation. However, you rarely need it when using the graphical interface. It happens because graphic elements are self-explanatory in most cases. Therefore, most PC users do not care about documentation.

When working with the CLI, the only way to know about available features of the software is by reading documentation. Besides that, you do not have anything that gives you a quick hint. When using CLI utility, it is crucial to know its basics. The negligence can lead to loss or corruption of your data.

The first versions of Unix had paper documentation. Using it was inconvenient and time-consuming. Soon it became even worse because the documentation volume grew rapidly. It exceeded the size of a single book. The Unix developers introduced the system called [man page](https://en.wikipedia.org/wiki/Man_page) to solve the issue with documentation. Using this software, you can quickly find the required topic. It contains information about OS features and all installed applications.

The man page system is a centralized place to access documentation. Besides it, every program in Unix provides brief information about itself. For example, the Bash interpreter has its own documentation system. It is called `help`.

Suppose that you want to get a list of all Bash built-ins. Launch the `help` command without parameters. Figure 2-21 shows its output.

{caption: "Figure 2-21. The output of the `help` command", height: "50%"}
![help output](images/BashShell/bash-help.png)

You see a list of all commands that Bash executes on its own. If some command is missing in this list, Bash calls a GNU utility or another program to execute it.

Here is an example. The `cd` command presents in the `help` list. It means that Bash executes it without calling another program. Now suppose you type the `find` command. It is missing in the `help` list. Therefore, Bash looks for an executable file with the `find` name on the disk drive. If it succeeds, Bash launches this file.

Where does Bash look for files that execute your commands? Bash has a list of paths where it searches utilities and programs. The **environment variable** called `PATH` stores this list. The [**variable**](https://en.wikipedia.org/wiki/Variable_(computer_science)) is a named area of memory. If you write a program in machine code and want to access the memory area, you should specify its address. A variable is a mechanism of a programming language. It allows you to use the variable name instead of the memory address. Therefore, you do not need to remember addresses, which are long numbers.

Bash stores about a hundred environment variables. They hold data that affect the interpreter's behavior. Most of these data are system settings. We will consider Bash variables in the next chapter.

I> Call the `env` utility without parameters. It shows you all the environment variables that Bash uses at the moment.

You can imagine the variable as a value that has a name. For example, you can say: "The time now is 12 hours". "Time now" is the variable name. Its value equals "12 hours". The computer stores it in memory at some address. You do not know the address. However, you can ask a computer the value of the "time now" variable. It returns you "12 hours". This is how the variables work.

The `echo` command prints strings. It can also show you the value of a variable. For example, the following `echo` call prints the `PATH` variable:
{line-numbers: false, format: Bash}
```
echo "$PATH"
```

Why do we need the dollar sign $ before the variable name? The `echo` command receives the string on input and outputs it. For example, this `echo` call prints the text "123":
{line-numbers: false, format: Bash}
```
echo 123
```

The dollar sign before a word tells Bash that it is a variable name. The interpreter handles it differently than a regular word. When Bash encounters a variable name in a command, it checks its variable list. If the name presents there, Bash inserts the variable value into the command. Otherwise, the interpreter places an empty string there.

I> Enclosing variable names in double-quotes is a [good practice](https://www.tldp.org/LDP/abs/html/quotingvar.html). This way, you avoid potential errors. There is an example. Bash replaces the variable name by its value. The value contains [**control characters**](https://en.wikipedia.org/wiki/Control_character). The interpreter handles these characters. As a result, the inserted variable's value differs from one that is stored in memory. This effect leads to incorrect behavior of the program. Double-quotes prevent Bash from processing strings.

Let's come back to the `echo` command that prints the `PATH` variable. Figure 2-22 shows this output.

{caption: "Figure 2-22. The value of the `PATH` variable", height: "30%", width: "100%"}
![PATH value](images/BashShell/echo-path.png)

What does this line mean? It is a list of paths separated by colons. If you write each path on a new line, you get the following list:
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

The format of the `PATH` variable raises questions. Why does Bash use colons as delimiters instead of [line breaks](https://en.wikipedia.org/wiki/Newline)? Line breaks make it easy to read the list. The reason is the specific behavior of Bash and some utilities when handling line breaks. Colons allow developers to avoid potential problems.

Suppose that you want to locate an executable file of some program on the disk. The `PATH` variable gives you a hint of where to look. Then you can apply the `find` utility and locate the file. For example, the following command searches the executable of the `find` utility:
{line-numbers: false, format: Bash}
```
find / -name find
```

The command shows you two locations of the `find` file:

* `/bin`
* `/usr/bin`

Both locations present in the `PATH` variable.

There is a much faster way to locate an executable on the disk. The `type` Bash built-in does it. Call the command and give it a program name. You will get the absolute path to the program's executable. Figure 2-23 shows how it works.

{caption: "Figure 2-23. The output of the `type` command", height: "30%"}
![type output](images/BashShell/type-command.png)

You see that the `/usr/bin` directory stores the executables of `find` and `ls` utilities. The `ls` utility is marked as **hashed**. It means that Bash has remembered its path. When you call `ls`, the interpreter does not search the executable on the disk. Bash uses the stored path and calls the utility directly. If you move the hashed executable, Bash cannot find it anymore.

You can call the `type` command and pass a Bash built-in there. Then `type` tells you that Bash executes this command. Figure 2-23 shows an example of such output for the `pwd` command.

Suppose that you found the executable of the required utility. How do you know the parameters it accepts? Call the utility with the `--help` option. The option prints a brief help. Figure 2-24 shows this help for the `cat` utility.

{caption: "Figure 2-24. The brief help for the `cat` utility", height: "50%"}
![help for cat](images/BashShell/cat-help.png)

If the brief help is not enough, refer to the documentation system called `info`. Suppose you need examples of how to use the `cat` utility. The following command shows them:
{line-numbers: false, format: Bash}
```
info cat
```

Figure 2-25 shows the result of the command.

{caption: "Figure 2-25. The `info` page for the `cat` utility", height: "50%"}
![info page for cat](images/BashShell/cat-info.png)

You see a program for reading text documents. Use the arrow keys, PageUp and PageDown to scroll the text. Press the Q key to end the program.

Developers of GNU utilities have created the `info` system. Before that, all Unix distributions used the `man` system. The capabilities of `info` and `man` are similar. The MSYS2 environment uses the `info` system, which is more modern.

Your Linux distribution may use `man` instead of `info`. Use it in the same way as `info`. For example, the following `man` call shows you help for the `cat` utility:
{line-numbers: false, format: Bash}
```
man cat
```

When you know which utility solves your task, it is easy to get help. What would you do if you don't know how to solve the task? The best approach is to look for the answer on the Internet. You will find tips there. They are more concise than the manuals for GUI programs. You don't need screenshots and videos that explain each action. Instead, you will find a couple of lines with command calls that do everything you need.

{caption: "Exercise 2-5. The documentation system", format: text, line-numbers: false}
```
Find documentation for each of the built-in commands and utilities in Table 2-1.
Check the parameters of the ls and find utilities that we did not consider.
```
