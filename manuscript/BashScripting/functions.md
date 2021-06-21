## Functions

Bash is the [**procedural programming language**](https://en.wikipedia.org/wiki/Procedural_programming). Procedural languages allow you to divide a program into logical parts called [**subroutines**](https://en.wikipedia.org/wiki/Subroutine). A subroutine is an independent block of code that solves a specific task. A program calls subroutines when it is necessary.

A subroutine is a deprecated term. It is called **function** in modern programming languages. We have already met functions when considering the `declare` Bash built-in. Now it is time to study them in detail.

### Programming Paradigms

We should start with the terminology. It will explain to you why functions were introduced and which tasks they solve.

What is procedural programming? It is one of the [**paradigms**](https://en.wikipedia.org/wiki/Programming_paradigm) of software development. A paradigm is a set of ideas, methods and principles that define how to write programs.

There are two dominant paradigms today. Most modern programming languages follow them. That paradigms are the following:

1. [**Imperative programming**](https://en.wikipedia.org/wiki/Imperative_programming). The developer explicitly specifies to the computer how to change the state of the program. In other words, he writes a complete algorithm for calculating the result.

2. [**Declarative programming**](https://en.wikipedia.org/wiki/Declarative_programming). The developer specifies the properties of the desired result, but not the algorithm to calculate it.

Bash follows the first paradigm. It is an imperative language.

The imperative and declarative paradigms define general principles for writing programs. There are different methodologies (i.e. approaches) within the same paradigm. Each methodology offers specific programming techniques.

The imperative paradigm has two dominant methodologies:

1. Procedural programming.

2. [**Object-oriented programming**](https://en.wikipedia.org/wiki/Object-oriented_programming).

Each of these methodologies suggests a specific way for structuring the source code of programs. Bash follows the first methodology.

Let's take a closer look at procedural programming. This methodology suggests features for combining the program instructions into independent code blocks. These blocks are called subroutines or functions.

You can call a function from any place of a program. The function can receive input parameters. This mechanism works similarly to passing command-line parameters to a script. This is a reason why a function is called "a program inside a program" sometimes.

The main task of the functions is to manage the complexity of the source code. The larger size it has, the harder it is to maintain. Repeating code fragments make things worse. They are scattered throughout the program and may contain errors. After fixing a mistake in one fragment, you have to find and fix all the rest. If you put the fragment into a function, it is enough to fix the error only there.

Here is an example of a repeating code fragment. Suppose that you are writing a large program. Whenever some error happens, the program prints the corresponding text message to the error stream. This approach leads to duplicating `echo` calls in the source code. The typical call looks this way:
{line-numbers: false, format: Bash}
```
>&2 echo "The N error has happened"
```

At some point, you decide that it is better to write all errors to the log file. It will help you to debug possible issues. Users of your program may redirect the error stream to the log file themselves. This is a good idea, but some users do not know how to use redirection. Thus, your program must write messages into the log file by itself.

You decided to change the way how the program prints error messages. It means that you need to check every place where it happens. You should change the `echo` calls there this way:
{line-numbers: false, format: Bash}
```
echo "The N error has happened" >> debug.log
```

If you miss one `echo` call accidentally, its output does not come to the log file. This specific output can be critical for debugging. Without it, you would not understand why the program fails on the user side.

We have considered one of several problems of maintaining programs. The maintenance forces you to change the existing source code. If you have violated the [**don't repeat yourself**](https://en.wikipedia.org/wiki/Don't_repeat_yourself) or DRY development principle, you get a lot of troubles. Remember a simple rule: do not copy the same code block of your program.

Functions solve the problem of code duplication. They resemble loops in some sense. The difference is, a loop executes a code block in one place of the program cyclically. In contrast to a loop, a function executes the code block at different program places.

Using functions improves the readability of the source code. A function combines a set of commands into a single block. If you give a speaking name to this block, its purpose becomes obvious. Then you can use this name to call the function. It makes your program easier to read. You replace a dozen lines of the function body with its name wherever you call it.

### Using Functions in Shell

The functions are available in both Bash modes: shell and script execution. First, let's consider how they work in the shell.

Here is the general form of the function declaration:
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

The ACTION is a single command or block of commands. It is called the **function body**.

Function names follow the same restrictions as variable names in Bash. You are allowed to use Latin letters, numbers and the underscore character there. The name must not begin with a number.

Let's have a look at how to declare and use functions in the shell. Suppose you need statistics about memory usage. These statistics are available via the special file system [**proc**](https://en.wikipedia.org/wiki/Procfs) or procfs. This file system provides the following information:

* The list of running processes.
* The state of the OS.
* The state of the computer hardware.

The default mount point of the procfs is the `/proc` path. You can find special files there. They provide you an interface to the kernel data.

You can read the RAM usage statistics in the `/proc/meminfo` file. The `cat` utility prints the file contents to the screen:
{line-numbers: false, format: Bash}
```
cat /proc/meminfo
```

The output of this command depends on your OS. The `/proc/meminfo` file provides less information for the MSYS2 environment and more for the Linux system.

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

Table 3-22 explains the meaning of these abbreviations.

{caption: "Table 3-22. Fields of the `meminfo` file", width: "100%"}
| Field | Description |
| --- | --- |
| MemTotal | The total amount of usable RAM in the system. |
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
| SwapFree | The amount of unused swap memory. |

This [article](https://www.thegeekdiary.com/understanding-proc-meminfo-file-analyzing-memory-utilization-in-linux/) provides more details about fields of the `meminfo` file.

You can always call the `cat` utility and get the `meminfo` file contents. However, typing this call takes time. You can shorten it by declaring the function this way:
{line-numbers: false, format: Bash}
```
mem() { cat /proc/meminfo; }
```

This is the one-line declaration of the `mem` function. Now you can call it the same way as any regular Bash built-in. Do it like this:
{line-numbers: false, format: Bash}
```
mem
```

This command calls the `mem` function that prints statistics on memory usage.

The `unset` Bash built-in removes the declared function. For example, the following call removes our `mem` function:
{line-numbers: false, format: Bash}
```
unset mem
```

Suppose that you have declared a variable and function with the same names. Call `unset` with the `-f` option to remove the function and keep the variable. Here is an example:
{line-numbers: false, format: Bash}
```
unset -f mem
```

You can add the function declaration to the `~/.bashrc` file. Then the function will be available whenever you start the shell.

We have declared the `mem` function in the single-line format. It is convenient when you type it in the shell. However, clarity is more important when you declare the function in the `~/.bashrc` file. Therefore, it is better to apply the following format there:
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

Functions and aliases have one similar aspect only. They are built-in Bash mechanisms. From the user's point of view, they shorten long commands. However, these mechanisms work in completely different ways.

An alias replaces one text with another in a typed command. In other words, Bash finds a part of the command that matches the alias name. Then the shell replaces it with the alias value. Finally, Bash executes the resulting command.

Here is an example of an alias. Suppose you have declared the alias for the `cat` utility. It adds the `-n` option to the utility call. This option adds line numbers to the `cat` output. The alias declaration looks this way:
{line-numbers: false, format: Bash}
```
alias cat="cat -n"
```

Whenever you type a command that starts with the word "cat", Bash replaces it with the "cat -n". For example, you type this command:
{line-numbers: false, format: Bash}
```
cat ~/.bashrc
```

Bash inserts the alias value here, and the command becomes like this:
{line-numbers: false, format: Bash}
```
cat -n ~/.bashrc
```

Bash has replaced the word "cat" with "cat -n". It did not change the parameter, i.e. the `~/.bashrc` path.

I> You can force Bash to insert an alias without executing the resulting command. Type the command and press the Ctrl+Alt+E keystroke for doing that.

Now let's have a look at how functions work. Suppose that Bash meets the function name in the typed command. The shell does not replace the function name with its body, as it does for the alias. Instead, Bash executes the function body.

An example will explain to you how it works. Suppose that you want to write the function that behaves the same way as the `cat` alias. If Bash functions work as aliases, the following declaration should solve your task:
{line-numbers: false, format: Bash}
```
cat() { cat -n; }
```

You expect that Bash will add the `-n` option to the following command:
{line-numbers: false, format: Bash}
```
cat ~/.bashrc
```

However, it does not happen. Bash does not insert the function body into the command. The shell executes the body and inserts the result into the command.

In our example, Bash calls the `cat` function. The function calls the `cat` utility with the `-n` option, but it ignores the `~/.bashrc` parameter. You do not want such behavior.

You can solve the problem of ignoring the `~/.bashrc` parameter. Pass this path to the function as a parameter. This mechanism works similarly to passing a parameter to some command or script. You can call the function and specify its parameters, separated by spaces.

Calling a function and passing parameters to it looks this way in the general form:
{line-numbers: false, format: Bash}
```
FUNCTION_NAME PARAMETER_1 PARAMETER_2 PARAMETER_3`
```

You can read parameters in the function body via their names `$1`, `$2`, `$3`, etc. The `$@` array stores all these parameters.

Let's correct the declaration of the `cat` function. You should pass all parameters of the function to the input of the `cat` utility. Then the declaration becomes like this:
{line-numbers: false, format: Bash}
```
cat() { cat -n $@; }
```

This function does not work either. The problem happens because of unintentional **recursion**. When some function calls itself, it is called recursion.

Why did we get the recursion? Bash checks the list of declared functions before executing the command "cat -n $@". There is the `cat` function in the list. Bash executes it at the moment, but it does not change anything. Thus, the shell calls the `cat` function again instead of calling the `cat` utility. This call repeats over and over again. It leads to the infinite recursion, which is similar to an infinite loop.

Recursion is not a mistake of Bash behavior. It is a powerful mechanism that simplifies complex algorithms. An example of such algorithms is the traversing of a [**graph**](https://en.wikipedia.org/wiki/Graph_(abstract_data_type)) or [**tree**](https://en.wikipedia.org/wiki/Tree_(data_structure)).

The mistake occurred in our declaration of the `cat` function. The recursive call happens by accident and leads to a loop. There are two ways to solve this problem:

1. Use the `command` Bash built-in.

2. Give another name to the function that does not conflict with the utility name.

Let's try the first solution. The `command` built-in receives some command on input. If there are aliases or function names there, Bash ignores them. It does not insert the alias value instead of its name. It does not call a function. Instead, Bash executes the command as it is.

If you add the `command` built-in to the `cat` function, you get the following result:
{line-numbers: false, format: Bash}
```
cat() { command cat -n "$@"; }
```

Now Bash calls the `cat` utility instead of the `cat` function here.

Another solution is renaming the function. For example, this declaration works well:
{line-numbers: false, format: Bash}
```
cat_func() { cat -n "$@"; }
```

Always be aware of the problem of unintentional recursion. Give unique names to your functions. They should not match the names of Bash built-ins and GNU utilities.

Here is a summary of our comparison of functions and aliases. If you want to shorten a long command, use an alias.

When using the shell, you need a function in two cases only:

1. You need a conditional statement, loop, or code block to perform your command.

2. The input parameters are not at the end of the command.

The second case needs an example. Let's shorten the `find` utility call. It should search for files in the specified directory. When you search them in the home directory, the `find` call looks this way:
{line-numbers: false, format: Bash}
```
find ~ -type f
```

You cannot declare an alias that takes the target path as a parameter. In other words, the following solution does not work:
{line-numbers: false, format: Bash}
```
alias="find -type f"
```

The target path should come before the `-type` option. This requirement is a serious problem for the alias.

However, you can declare the function in this case. The function allows you to specify the position to insert the parameter to the `find` call. The declaration looks like this:
{line-numbers: false, format: Bash}
```
find_func() { find $1 -type f; }
```

Now you can call the function that searches files in the home directory this way:
{line-numbers: false, format: Bash}
```
find_func ~
```

### Using Functions in Scripts

You can declare a function in a script the same way as you do it in the shell. Bash allows both full or one-line form there.

For example, let's come back to the task of handling errors in the large program. You can declare the following function for printing error messages:
{line-numbers: true, format: Bash}
```
print_error()
{
  >&2 echo "The error has happened: $@"
}
```

This function expects input parameters. They should explain to a user the root cause of the error. Suppose that your program reads a file on the disk. The file becomes unavailable for some reason. Then the following `print_error` call reports this problem:
{line-numbers: false, format: Bash}
```
print_error "the readme.txt file was not found"
```

Suppose that the requirements for the program have changed. Now the program should print error messages to a log file. It is enough to change only the declaration of the `print_error` function to meet the new requirement. The function body looks this way after the change:
{line-numbers: true, format: Bash}
```
print_error()
{
  echo "The error has happened: $@" >> debug.log
}
```

This function prints all error messages to the `debug.log` file. There is no need to change anything at the points where the function is called.

Sometimes you want to call one function from another. This technique is named a **nested function call**. Bash allows it. In general, you can call a function from any point of the program.

Here is an example of a nested function call. Suppose you want to translate the program interface to another language. This task is called [**localization**](https://en.wikipedia.org/wiki/Internationalization_and_localization). It is better to print error messages in a language the user understands, right? You need to duplicate all messages in all languages supported by your program to reach this requirement.

The straightforward solution for localization is to assign a unique code to each error. Using such codes is a common practice in system programming. Let's apply this approach to your program. Then the `print_error` function will receive an error code via the input parameter.

You can write error codes to the log file as it is. However, it will be inconvenient for a user to interpret these codes. He would need a table to map them into error messages. Therefore, the better solution is to print the text messages to the log file. It means that it is your responsibility to convert error codes to text in a specific language. You would need a separate function for doing this conversion. Here is an example of such a function:
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

Now you can apply the `code_to_error` function when printing an error in the `print_error` body. You will get the following result:
{line-numbers: true, format: Bash}
```
print_error()
{
  echo "$(code_to_error $1) $2" >> debug.log
}
```

Here is an example of the `print_error` function call from some point of your program:
{line-numbers: false, format: Bash}
```
print_error 1 "readme.txt"
```

It prints the following message to the log file:
{line-numbers: false, format: text}
```
File not found: readme.txt
```

The first parameter of the `print_error` function is the error code. The second parameter is the name of the file that caused the error.

Using functions made the error handling in your program easier to maintain. Changing the requirements demonstrates it. Suppose that your customer asked you to support the German language. You can introduce this feature by declaring two extra functions:

* `code_to_error_en` for messages in English.

* `code_to_error_de` for messages in German.

How can you choose the proper function to convert error codes? The `LANGUAGE` Bash variable helps you in this case. It stores the language that the user has chosen for his system. You should check this variable in the `print_error` function and convert all error codes accordingly.

I> If the `LANGUAGE` variable is not available on the target system, use the `LANG` variable instead.

Our functions for handling the error codes are just an example for demonstration. Never apply them in your real project. Bash has a special mechanism to localize scripts. It uses PO files with texts in different languages. Read more about this mechanism in the [BashFAQ article](https://mywiki.wooledge.org/BashFAQ/098).

{caption: "Exercise 3-13. Functions", format: text, line-numbers: false}
```
Write the following functions for printing error messages in English and German:

* print_error
* code_to_error_en
* code_to_error_de

Write two versions of the "code_to_error" function:

* Using the case statement.
* Using an associative array.
```

#### Returning a Function Result

Most procedural languages have a reserved word for returning the function result. It is called `return`. Bash also has a built-in with the same name. However, it has another purpose. The `return` command of Bash does not return a value. Instead, it provides a function exit status to the caller. This status is an integer between 0 and 255.

The complete algorithm of calling and executing the function looks this way:

1. Bash meets the function name in the command.

2. The interpreter goes to the function body and executes it starting from the first command.

3. If Bash meets the `return` command in the function body, it stops executing it. The interpreter jumps to the place where the function was called. The special parameter `$?` keeps an exit status of the function.

4. If there is no `return` command in the function body, Bash executes it until the last command. Then, the interpreter jumps to the place where the function was called.

In a typical procedural language, the `return` command returns a variable of any type from a function. It can be a number, string or array. You need other mechanisms for doing that in Bash. There are three options:

1. The command substitution.

2. A global variable.

3. The caller specifies a global variable.

Let's consider these approaches with examples.

We wrote the `code_to_error` and `print_error` functions to print error messages. Here are their declarations:
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

print_error()
{
  echo "$(code_to_error $1) $2" >> debug.log
}
```

Here we have used the first approach for returning the function result. We call the `code_to_error` function using the command substitution. Thus, Bash inserts whatever the function prints to the console instead of its call.

The `code_to_error` function prints the error message using the `echo` command. Then Bash inserts this output to the `print_error` function body. There is only one `echo` call there. It consists of two parts:

1. Output of the `code_to_error` function. It contains an error message.

2. The input parameter `$2` of the `print_error` function. This is the name of the file that caused the error.

The `echo` command of the `print_error` function accumulates all data and prints the final error message to the log file.

The second way to return a value from a function is to write it to some global variable. This kind of variable is available anywhere in the script. Thus, you can access it in the function body and the place where it is called.

I> All variables declared in the script are global by default. There is one exception to this rule. We will discuss it later.

Let's apply the global variable approach to our case. You should rewrite the `code_to_error` and `print_error` functions for doing that. The first function will write its result to a global variable. Then `print_error` reads it. The resulting code looks this way:
{line-numbers: true, format: Bash}
```
code_to_error()
{
  case $1 in
    1)
      error_text="File not found:"
      ;;
    2)
      error_text="Permission to read the file denied:"
      ;;
  esac
}

print_error()
{
  code_to_error $1
  echo "$error_text $2" >> debug.log
}
```

The `code_to_error` function writes its result to the `error_text` global variable. Then the `print_error` function combines this variable with the `$2` parameter to make the final error message and print it to the log file.

Returning a function result via a global variable is the error-prone solution. It may cause a naming conflict. Here is an example of such an error. Suppose that there is another variable called `error_text` in your script. It has nothing to do with the output to the log file. Then any `code_to_error` call will overwrite the value of that variable. This will cause errors in all places where `error_text` is used outside the `code_to_error` and `print_error` functions.

**Variable naming convention** can solve the problem of naming conflict. The convention is an agreement on how to name the variables in all parts of the project. This agreement is one of the clauses of the [**code style**](https://en.wikipedia.org/wiki/Programming_style) guide. Any large program project must have such a guide.

Here is an example of a variable naming convention:

> All global variables, which functions use to return their results, should have an underscore sign prefix in their names.

Let's follow this convention in our example. Then you should rename the `error_text` variable to `_error_text`. This way, you solve one specific problem. However, there are cases when a naming conflict can happen. Suppose one function calls another, i.e. there is a nested call. What happens if both functions use the same variable to return their results? You will get the naming conflict again.

The third way to return a function result solves the name conflict problem. The idea is to let the caller the possibility to specify the global variable name. Then the called function writes its result to that variable.

How to pass a variable name to the called function? You can do it using an input parameter. Then the function calls the `eval` built-in. This command converts the specified text into a Bash command. You need this conversion because you passed the variable name as text. Bash does not allow you to refer to the variable using text. So, `eval` resolves this obstacle.

Let's adapt the `code_to_error` function for receiving a global variable name. The function should accept two input parameters:

1. The error code in the `$1` parameter.

2. The name of the global variable to store the result. Use the `$2` parameter for that.

This way, you will get the following code:
{line-numbers: true, format: Bash}
```
code_to_error()
{
  local _result_variable=$2

  case $1 in
    1)
      eval $_result_variable="'File not found:'"
      ;;
    2)
      eval $_result_variable="'Permission to read the file denied:'"
      ;;
  esac
}

print_error()
{
  code_to_error $1 "error_text"
  echo "$error_text $2" >> debug.log
}
```

At first glance, the code looks almost the same as it was before. However, it behaves more flexibly now. The `print_error` function chooses the global variable to get the `code_to_error` result. The caller explicitly specifies the variable name. Therefore, it is easier to find and resolve naming conflicts.

#### Variable Scope

Naming conflicts is a serious problem. It occurs in Bash when functions declare variables in the global scope. As a result, the names of two variables can match. Then two functions will access them at different moments. This leads to confusion and data loss.

Procedural languages suggest the solution for the naming conflicts problem. They provide features to restrict the scope of declared variables. Bash has these features too.

If you declare a variable with the `local` keyword in a function, its body limits the variable's scope. In other words, the variable becomes available inside the function only.

Here is our latest version of the `code_to_error` function:
{line-numbers: true, format: Bash}
```
code_to_error()
{
  local _result_variable=$2

  case $1 in
    1)
      eval $_result_variable="'File not found:'"
      ;;
    2)
      eval $_result_variable="'Permission to read the file denied:'"
      ;;
  esac
}
```

We have declared the `_result_variable` variable using the `local` keyword. Therefore, it becomes a local variable. You can read and write its value in `code_to_error` and any other functions that it calls.

Bash limits a local variable's scope by the execution time of the function where it is declared. Such a scope is called [**dynamic**](https://en.wikipedia.org/wiki/Scope_(computer_science)#Lexical_scope_vs._dynamic_scope_2). Modern languages prefer to use **lexical** scope. There the variable is available in the function's body only. If you have nested calls, the variable is not available in the called functions.

Local variables do not come into the global scope. This ensures that no function will overwrite them by accident.

{caption: "Exercise 3-14. Variable scope", format: text, line-numbers: false}
```
What text will the script in Listing 3-37 print to the console when it executes?
```

{caption: "Listing 3-37. The script for testing the variable scope", line-numbers: true, format: Bash}
![`quiz-variable-scope.sh`](code/BashScripting/quiz-variable-scope.sh)

Careless handling of local variables leads to errors. They happen because a local variable hides a global variable with the same name. Let's look at an example.

Suppose you write a function to handle a file. For example, it calls the `grep` utility to look for a pattern in the file. The function looks like this:
{line-numbers: true, format: Bash}
```
check_license()
{
  local filename="$1"
  grep "General Public License" "$filename"
}
```

Now suppose that you have declared the global variable named `filename` at the beginning of the script. Its declaration looks like this:
{line-numbers: true, format: Bash}
```
#!/bin/bash

filename="$1"
```

Will the `check_license` function run correctly? Yes. It happens thanks to **hiding a global variable**. This mechanism works in the following way. When Bash meets the `filename` variable in the function's body, it accesses the local variable instead of the global one. It happens because the local variable is declared later than the global one. Because of the hiding mechanism in the function's body, you cannot access the global variable `filename` there.

Accidental hiding of global variables leads to errors. Try to avoid any possibility of getting such a situation. To do this, add a prefix or postfix for local variable names. For example, it can be an underscore at the end of the name.

A global variable becomes unavailable in a function's body only after declaring the local variable with the same name. Consider the following variant of the `check_license` function:
{line-numbers: true, format: Bash}
```
#!/bin/bash

filename="$1"

check_license()
{
  local filename="$filename"
  grep "General Public License" "$filename"
}
```

Here we initialize the local variable `filename` by the value of a global variable with the same name. This assignment operation works as expected.  It happens because Bash does parameter expansion before executing the assignment.

Suppose that you pass the `README` filename to the script. Then the assignment looks like this after parameter expansion:
{line-numbers: false, format: Bash}
```
  local filename="README"
```

Developers changed the default scopes of arrays in the 4.2 Bash version. If you declare an indexed or associative array in a function' body, it comes to the local scope. You should use the `-g` option of the `declare` command to make an array global.

Here is the declaration of the local array `files`:
{line-numbers: true, format: Bash}
```
check_license()
{
  declare files=(Documents/*.txt)
  grep "General Public License" "$files"
}
```

You should change the declaration this way to declare the global array:
{line-numbers: true, format: Bash}
```
check_license()
{
  declare -g files=(Documents/*.txt)
  grep "General Public License" "$files"
}
```

We have considered the functions in Bash. Here are general recommendations on how to use them:

1. Choose names for functions carefully. Each name should tell the reader of your code what the function does.

2. Declare only local variables inside functions. Use the naming convention for them. This solves potential conflicts of local and global variable names.

3. Do not use global variables in functions. Instead, pass the value of the global variable to the function via a parameter.

4. Do not use the `function` keyword when declaring functions. It is present in Bash but not in the POSIX standard.

Let's take a closer look at the last tip. Do not declare functions this way:
{line-numbers: true, format: Bash}
```
function check_license()
{
  declare files=(Documents/*.txt)
  grep "General Public License" "$files"
}
```

The `function` keyword is useful in only one case. It resolves the conflict between the function name and the alias.

For example, the following function declaration does not work without the `function` keyword:
{line-numbers: true, format: Bash}
```
alias check_license="grep 'General Public License'"

function check_license()
{
  declare files=(Documents/*.txt)
  grep "General Public License" "$files"
}
```

If you have such a declaration, you can call the function only by adding a slash before its name. Here is an example of this call:
{line-numbers: false, format: Bash}
```
\check_license
```

If you skip the slash, Bush inserts the alias value instead of calling the function. It means this command brings the alias:
{line-numbers: false, format: Bash}
```
check_license
```

There is a low probability that you get alias and function names conflict in the script. Each script runs in a separate Bash process. This process does not load aliases from the `.bashrc` file. Therefore, name conflicts can happen by mistake in the shell mode only.
