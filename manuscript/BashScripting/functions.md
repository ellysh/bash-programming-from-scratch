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

Typing the `cat` command for printing the `meminfo` file contents takes time. We can declare the function with a short name for that. Here is an example of this function:
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
* code_to_error_en
* code_to_error_de

Write two versions of the "code_to_error" function:

* Using the case statement.
* Using an associative array.
```

#### Returning a Function's Result

Procedural languages have a reserved word for returning the function's result. It is called `return` in most cases. Bash also has a command with this name. But it has another purpose. The `return` command in Bash does not return a value. Instead, it passes a function's exit status, which is an integer between 0 and 255.

The complete algorithm for calling and executing the function looks like this:

1. Bash meets the function name in the command.

2. The interpreter goes to the body of the function and executes it from the first command.

3. If Bash meets the `return` command in the function body, it stops executing it. The interpreter jumps to the place where the function is called. The special parameter `$?` stores the exit status of the function.

4. If there is no `return` command in the function's body, Bash executes it until the last command. Then, the interpreter jumps to the place where the function is called.

In procedural languages, the `return` command returns the variable of any type from a function. It can be a number, a string or an array. You need other mechanisms for doing that in Bash. There are three options:

1. Command Substitution.

2. A global variable.

3. The caller specifies a global variable.

Let's look at examples of using these approaches.

We wrote the functions `code_to_error` and `print_error` to print error messages in the last section. They look like this:
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

Here we have used the first approach for returning the function's result. We put the `code_to_error` call into the command substitution statement. Thus, Bash inserts whatever the function prints to the console into the place of the call.

The `code_to_error` function prints the error message via the `echo` command in our example. Then Bash inserts this output into the body of the `print_error` function. There is only one `echo` call there. It consists of two parts:

1. Output of the `code_to_error` function. This is the error message.

2. The input parameter `$2` of the `print_error` function. This is the name of the file, which we tried to access but got an error.

The `echo` command of the `print_error` function accumulates all data and prints the final error message to the log file.

The second way to return a value from a function is to write it to a global variable. This kind of variable is available anywhere in the script. Thus, you can access it in the function's body and the place where it is called.

I> All variables declared in the script are global by default. There is one exception to this rule. We will discuss it later.

Let's apply the global variable approach to our case. We should rewrite the `code_to_error` and `print_error` functions. The first one will store its result in a global variable. Then `print_error` reads it. The resulting code looks like this:
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

The `code_to_error` function writes its result to the `error_text` global variable. Then the `print_error` function combines this variable with the `$2` parameter to make a final error message and print it to the log file.

Returning the function result via a global variable is the error-prone solution. It may cause a naming conflict. For example, assume that there is another variable called `error_text` in the script. It has nothing to do with the output to the log file. Then any `code_to_error` call will overwrite the value of that variable. This will cause errors in all places where `error_text` is used outside the `code_to_error` and `print_error` functions.

**Variable naming convention** can solve the problem of naming conflict. The convention is an agreement of how to name the variables in all parts of the project's code. This agreement is one of the clauses of [**code style**](https://en.wikipedia.org/wiki/Programming_style) guide. Any large program project must have such a guide.

Here is an example of a variable naming convention:

> All global variables, which functions use to return values, should have an underscore sign prefix in their names.

Let's follow this convention. Then we should rename the `error_text` variable to `_error_text`. We solved the problem in our specific case. But there are cases when the issue still can happen. Suppose one function calls another, i.e. there is a nested call. What happens if both functions use the variable called the same to return their values? We get the naming conflict again.

The third way to return a function's result solves the name conflict problem. The idea is to let the caller code a way to specify the global variable's name. Then the called function writes its result to that variable.

How to pass a variable name to the called function? We can do it via the function's input parameter. Next, the function calls the `eval` command. This command converts the specified text into a Bash command. It is required because we pass the variable's name as a text. Bash does not allow referring to the variable using text. So, `eval` resolves this obstacle.

Let's change the `code_to_error` function. We will pass two following parameters there:

1. The error code in the `$1` parameter.

2. The name of the global variable to store the result. We use the `$2` parameter for that.

This way, we get the following code:
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

At first glance, the code is almost the same as it was before. But it is not. Now it behaves more flexibly. The `print_error` function chooses the global variable's name to get the `code_to_error` result. The caller code explicitly specifies this name. Therefore, it is easier to find and resolve naming conflicts.

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
