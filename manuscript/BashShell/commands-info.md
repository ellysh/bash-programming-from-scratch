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