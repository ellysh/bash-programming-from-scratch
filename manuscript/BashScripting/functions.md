## Functions

Bash is [**procedural programming language**](https://en.wikipedia.org/wiki/Procedural_programming). Procedural languages allow you to divide a program into logical parts called [**subroutine**](https://en.wikipedia.org/wiki/Subroutine). A subroutine is an independent block of code that solves a specific task. A program calls subroutines when it is necessary.

Subroutines are called **functions** in modern programming languages. We have already met functions when considering the `declare` command. Now let's study the structure and purposes of functions.

### Programming Paradigms

We should start with the terminology. It will help us to understand why functions have appeared and which tasks they solve.

What is procedural programming? It is one of [**paradigms**](https://en.wikipedia.org/wiki/Programming_paradigm) of software development. A paradigm is a set of ideas, methods and principles that define how to write programs.

There are two dominant paradigms today. Most modern programming languages follow one of them. The paradigms are the following:

1. [**Imperative programming**](https://en.wikipedia.org/wiki/Imperative_programming). The developer explicitly specifies to the computer how to change its state. In other words, he writes a complete algorithm for calculating the result.

2. [**Declarative programming**](https://en.wikipedia.org/wiki/Declarative_programming). The developer specifies the properties of the desired result but not the algorithm to calculate it.

Bash follows the first paradigm. It is an imperative language.

The imperative and declarative paradigms define general principles for writing a program. There are different methodologies (i.e. approaches) within the same paradigm. Each methodology offers specific programming techniques.

The imperative paradigm has two dominant methodologies:

1. Procedural programming.

2. [**Object-oriented programming**](https://en.wikipedia.org/wiki/Object-oriented_programming).

These methodologies suggest structuring the source code of a program in different ways. Bash follows the first methodology.

Let's take a closer look at procedural programming. This methodology suggests features for combining the program's instruction sets into independent blocks of code. These blocks are called subroutines or functions.

You can call a function from any place of a program. The function can receive input parameters. This mechanism works similarly to passing command-line parameters to a script. This is a reason why a function is called "a program inside a program" sometimes.

The main task of the functions is to manage the complexity of a program. The larger the size of the source code, the harder it is to maintain. Repeating code fragments make this situation worse. They are scattered throughout the program and may contain errors. After fixing a mistake in one fragment, you have to find and fix all the rest. If you put the fragment into a function, it is enough to fix the error only there.

Here is an example of a repeating code fragment. Suppose that you are writing a large program. The program prints text messages to the error stream when handling errors. Then there will be many places in the source code where you call the `echo` command. These calls can look like this:
{line-numbers: false, format: Bash}
```
>&2 echo "The N error has happened"
```

At some point, you decide that it is better to write all errors in a log file. Then it will be easier to analyze them. Users of your program may redirect the error stream to the log file themselves. But let's assume that some of them do not know how to use redirection. Thus, the program must write messages into the log file by itself.

Let's change the program. You have to go through all places where it handles the errors. Then you should replace the `echo` calls there with the following one:
{line-numbers: false, format: Bash}
```
echo "The N error has happened" >> debug.log
```

If you miss one `echo` call accidentally, its output does not come into the log file. But this specific output can be critical. Without it, you would not understand why the program fails for the user.

We have considered one of the difficulties of maintaining programs. It often occurs when you change the existing code. The root cause of the problem is a violation of the [**don't repeat yourself**](https://en.wikipedia.org/wiki/Don't_repeat_yourself) or DRY development principle. The same error handling code was copied over and over again in different places of the program. You should not do that.

Functions solve the problem of code duplication. This solution somewhat resembles loops. The difference is that a loop executes a set of commands in one place of the program cyclically. In contrast to a loop, a function executes the same set of commands at different program places.

Using functions improves the readability of the program's code. It combines a set of commands into a single block. If you give the block a speaking name, the task it solves becomes obvious. You can call the function by its name. It makes the program easier to read. Instead of a dozen lines of the function's body, there will be just its name. It explains to the reader what is going on in the function.

### Using Functions in Shell

The functions are available in both Bash modes: the command interpreter and script execution. First, let's consider how they work in the command interpreter.

Here is the function's declaration in general:
{line-numbers: true, format: Bash}
```
FUNCTION_NAME()
{
  ACTION
}
```

You can also declare the function in one line this way:
{line-numbers: false, format: Bash}
```
FUNCTION_NAME() { ACTION ; }
```

The semicolon before the closing curly bracket is mandatory here.

The ACTION is a single command or a block of commands. It is called the **function body**.

Function names follow the same restrictions as variable names in Bash. They allow Latin characters, numbers and the underscore character. The name must not begin with a number.

Let's look at how to declare and use functions in the shell. Suppose you need statistics about memory usage. This statistics are available via the special file system [**proc**](https://en.wikipedia.org/wiki/Procfs) or procfs. This file system provides the following information:

* The list of running processes.
* The state of the OS.
* The state of the computer's hardware.

There are files in the `/proc` system path. You can read the required information from these files.

RAM usage statistics are available in the `/proc/meminfo` file. We can read it with the `cat` utility this way:
{line-numbers: false, format: Bash}
```
cat /proc/meminfo
```

The output of this command depends on your OS. The `/proc/meminfo` file contains less information for the MSYS2 environment and more for the Linux system.

Here is an example of the `meminfo` file contents for the MSYS2 environment:
{line-numbers: true, format: Bash}
```
MemTotal:        6811124 kB
MemFree:         3550692 kB
HighTotal:             0 kB
HighFree:              0 kB
LowTotal:        6811124 kB
LowFree:         3550692 kB
SwapTotal:       1769472 kB
SwapFree:        1636168 kB
```

Table 3-22 explains the meaning of each field of this file.

{caption: "Table 3-22. Fields of the `meminfo` file", width: "100%"}
| Field | Description |
| --- | --- |
| MemTotal | The total amount of usable RAM in the system |
|  | |
| MemFree | The amount of unused RAM at the moment. It is equal to sum of fields LowFree + HighFree. |
|  | |
| HighTotal | The total amount of usable RAM in the high region (above 860 MB). |
|  | |
| HighFree | The amount of unused RAM in the high region (above 860 MB). |
|  | |
| LowTotal | The total amount of usable RAM in the non-high region. |
|  | |
| LowFree | The amount of unused RAM in the non-high region. |
|  | |
| SwapTotal | The total amount of physical [**swap**](https://en.wikipedia.org/wiki/Memory_paging#Unix_and_Unix-like_systems) memory. |
|  | |
| SwapFree | The amount of unused swap memory |

This [article](https://www.thegeekdiary.com/understanding-proc-meminfo-file-analyzing-memory-utilization-in-linux/) provides more details about fields of the `meminfo` file.

Typing the `cat` command for printing the `meminfo` file content takes time. We can declare the function with a short name for that. Here is an example of this function:
{line-numbers: false, format: Bash}
```
mem() { cat /proc/meminfo; }
```

This is a one-line declaration of the `mem` function. Now you can call it the same way as any regular Bash command. Do it like this:
{line-numbers: false, format: Bash}
```
mem
```

The function prints statistics on memory usage.

The `unset` command removes the previously declared function. For example, the following call removes our `mem` function:
{line-numbers: false, format: Bash}
```
unset mem
```

Suppose a variable and a function are declared with the same name. Use the `-f` option to remove the function. Here is an example:
{line-numbers: false, format: Bash}
```
unset -f mem
```

You can add the function declaration to the `~/.bashrc` file. Then the function will be available every time you start the shell.

We declared the `mem` function in single-line format when using command-line. It is a convenient and fast way to type. But clarity is more important when declaring the function in the file `~/.bashrc`. Therefore, it is better to declare the `mem` function in a standard format there. Do it like this:
{line-numbers: true, format: Bash}
```
mem()
{
  cat /proc/meminfo
}
```

#### Difference Between Functions and Aliases

We have declared the `mem` function. It prints statistics on memory usage. The following alias does the same thing:
{line-numbers: false, format: Bash}
```
alias mem="cat /proc/meminfo"
```

It looks like functions and aliases work the same way. What should you choose then?

Functions and aliases have one similar aspect only. They are built-in Bash mechanisms. From the user's point of view, they reduce the input of long commands. But these mechanisms work in completely different ways.

An alias replaces one text with another in a typed command. In other words, Bash finds text in the command that matches the alias name. Then it replaces that text with the alias value. Finally, Bash executes the resulting command.

Here is an example of an alias. Suppose you have declared an alias for the `cat` utility. It adds the `-n` option to the utility call. The option adds line numbers to the `cat` output. The alias declaration looks like this:
{line-numbers: false, format: Bash}
```
alias cat="cat -n"
```

Whenever you type a command that starts with the word "cat", Bash replaces it with the "cat -n". For example, you type this command:
{line-numbers: false, format: Bash}
```
cat ~/.bashrc
```

When Bash inserts an alias value, the command becomes like this:
{line-numbers: false, format: Bash}
```
cat -n ~/.bashrc
```

Bash has replaced the word "cat" with "cat -n". It did not change the parameter, i.e. the path to the file.

I> You can force Bash to insert an alias before executing the command. Type the command and press the Ctrl+Alt+E keystroke for doing that.

Now let's look at how functions work. Suppose that Bash meets the function name in the typed command. Unlike an alias, the shell does not replace the function's name with its body. Instead, Bash executes the function's body.

Here is an example to explain the difference. We want to write the function that behaves the same way as the `cat` alias. If Bash functions work as aliases, the following declaration solves our task:
{line-numbers: false, format: Bash}
```
cat() { cat -n; }
```

We expect that Bash will add the `-n` option to the following command:
{line-numbers: false, format: Bash}
```
cat ~/.bashrc
```

However, it would not work. Bash does not insert the body of the function in the command. The shell executes the body and inserts the result into the command.

In our example, Bash calls the `cat` utility with the `-n` option but without the `~/.bashrc` parameter. We do not want such behavior.

We can solve the problem by passing the filename to the function as a parameter. This works just like passing a parameter to a command or script. You can call the function and specify its parameters, separated by spaces.

Calling a function and passing parameters to it looks like this in general:
{line-numbers: false, format: Bash}
```
FUNCTION_NAME PARAMETER_1 PARAMETER_2 PARAMETER_3`
```

You can read parameters in the function's body via names `$1`, `$2`, `$3`, etc. The `$@` array stores all received parameters.

Let's correct the declaration of the `cat` function. We will pass all parameters of the function to the `cat` utility input. Then the declaration becomes like this:
{line-numbers: false, format: Bash}
```
cat() { cat -n $@; }
```

This function would not work either. The problem happens because of unintentional **recursion**. When the function calls itself, it is called recursion.

Bash checks the list of declared functions before executing the command "cat -n $@". There is the `cat` function in the list. Bash executes its body at the moment, but it does not change anything. Thus, the shell calls the `cat` function again instead of calling the `cat` utility. The call repeats over and over again. It leads to the infinite recursion, which is similar to an infinite loop.

Recursion is not a mistake of Bash's behavior. It is a powerful mechanism that simplifies complex algorithms. The example of such algorithms is the traversing a [**graph**](https://en.wikipedia.org/wiki/Graph_(abstract_data_type)) or [**tree**](https://en.wikipedia.org/wiki/Tree_(data_structure)).

The mistake occurred in our declaration of the `cat` function. The recursive call happened by accident and led to a loop. There are two ways to solve this problem:

1. Use the `command` built-in.

2. Rename the function so that its name differs from the utility name.

Let's look at the first solution. The `command` built-in receives a command as parameters. If there are aliases and function names there, Bash ignores them. It does not insert the alias value instead of its name. It does not call a function. Instead, Bash executes the command as it is.

If we apply the `command` built-in in the `cat` function, we get the following result:
{line-numbers: false, format: Bash}
```
cat() { command cat -n "$@"; }
```

Now Bash calls the `cat` utility instead of the `cat` function.

The second solution is renaming the function. For example, this version works well:
{line-numbers: false, format: Bash}
```
cat_func() { cat -n "$@"; }
```

Always be aware of the problem of unintentional recursion. Keep the names of the functions unique. They should not match the names of built-in Bash commands and GNU utilities.

Here is a summary of our comparison of functions and aliases. If you want to shorten a long command, use an alias.

You need a function in the following cases only:

1. You need a conditional statement, loop, or code block to perform a command.

2. The parameters are not at the end of the command.

The second case needs an example. Let's shorten the `find` utility call. It should search for files in the specified directory. When you search in the home directory, the call looks like this:
{line-numbers: false, format: Bash}
```
find ~ -type f
```

We cannot write an alias that takes the target path as a parameter. The following solution does not work:
{line-numbers: false, format: Bash}
```
alias="find -type f"
```

The target path should come before the `-type` option. This is a problem for the alias.

However, we can use the function in this case. We can choose the position to insert the parameter in the `find` call. The function declaration looks like this:
{line-numbers: false, format: Bash}
```
find_func() { find $1 -type f; }
```

Now we can call it for searching files in the home directory this way:
{line-numbers: false, format: Bash}
```
find_func ~
```

### Using Functions in Scripts

The declaration of functions in scripts is the same as in a shell. There are two options: the  standard and one-line declarations.

For example, let's come back to the task of error handling in a large program. We can declare the following function for printing error messages:
{line-numbers: true, format: Bash}
```
print_error()
{
  >&2 echo "The error has happened: $@"
}
```

This function receives parameters. They should explain the root cause of the error. Suppose our program reads a file on the disk. The file becomes unavailable for some reason. Then the following `print_error` function call reports the problem:
{line-numbers: false, format: Bash}
```
print_error "the readme.txt file was not found"
```

Suppose that the requirements for the program have changed. Now the program should print error messages to a log file. It is enough to change only the declaration of the `print_error` function to meet the new requirement. The function's body looks like this after the change:
{line-numbers: true, format: Bash}
```
print_error()
{
  echo "The error has happened: $@" >> debug.log
}
```

This function prints all error messages to the `debug.log` file. There is no need to change places of the program where the function is called.

Sometimes you want to call one function from another. This is called **nested function call**. Bash allows it. In general, you can call a function from any point of the program.

Here is an example of nested function calls. Suppose you want to translate the program interface to another language. This task is called [**localization**](https://en.wikipedia.org/wiki/Internationalization_and_localization). It is better to print error messages in a language the user understands. This requires duplicating all messages in all languages supported by the program. How to do this?

The simplest solution is to assign a unique code to each error. Using error codes is a common practice in system programming. Let's apply this approach to our program. Then the `print_error` function will receive error codes via the parameters.

We can write error codes to the log file as it is. But then the user will need information about the meaning of that codes. Therefore, it is more convenient to print the message text as we did it before. To do this, we should convert error codes to the text in a specific language. We need a separate function for doing this conversion. Here is an example of such a function:
{line-numbers: true, format: Bash}
```
code_to_error()
{
  case $1 in
    1)
      echo "File not found:"
      ;;
    2)
      echo "Permission to read the file denied:"
      ;;
  esac
}
```

Let's apply the `code_to_error` function when printing an error in `print_error`. We get the following result:
{line-numbers: true, format: Bash}
```
print_error()
{
  echo "$(code_to_error $1) $2" >> debug.log
}
```

Here is an example of the `print_error` function call from the program's code:
{line-numbers: false, format: Bash}
```
print_error 1 "readme.txt"
```

It prints the following line into the log file:
{line-numbers: false, format: text}
```
File not found: readme.txt
```

The first parameter of the `print_error` function is the error code. The second parameter is the name of the file that caused the error.

Using functions made the error handling in our program easier to maintain. Changing the requirements can demonstrate it. Suppose that our customer asked us to support German language. We can do it by declaring two following functions:

* `code_to_error_en` for messages in English.

* `code_to_error_de` for messages in German.

How can you choose the right function to convert error codes? The `LANGUAGE` Bash variable helps you in this case. It stores the current language of the user's system. Check this variable in the `print_error` function and convert error codes accordingly.

I> If the `LANGUAGE` variable is not available on your system, use the `LANG` variable instead.

Our solution with the error codes conversion is just an example for demonstration. Never does it in the real project. Bash has a special mechanism to localize scripts. It uses PO files with texts in different languages. Read more about this mechanism in the [BashFAQ article](https://mywiki.wooledge.org/BashFAQ/098).

{caption: "Exercise 3-13. Functions", format: text, line-numbers: false}
```
Write the following functions to display error messages in English and German:

* print_error
* code_to_error_ru
* code_to_error_en

Write two versions of the "code_to_error" function:

* Using the "case" statement.
* Using an associative array.
```
