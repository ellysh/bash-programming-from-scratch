## Variables and Parameters

Variables in Bash have already been mentioned several times in this book. We have learned the list of system paths in the `PATH` variable. We have used positional parameters in the backup script. It is time to get a good grasp on the topic.

First, let's find out what the term "variable" means in programming. The variable is an area of memory where some value is stored. In most cases, this is short-term memory (RAM, CPU cache and registers).

There was a generation of the first programming languages (for example [**assembler**](https://en.wikipedia.org/wiki/Assembly_language)). When using such a language, you should refer to a variable by its address. If you want to read or write its value, you have to specify its memory address.

Suppose you work on a computer with 32-bit processors. Then a memory address has a length of 4 bytes. It is the number from 0 to 4294967295. This number is twice larger for 64-bit processors. It is inconvenient to remember and operate with such big numbers. That is why modern programming languages allow you to replace a variable address with its name. This name is translated into memory address while compiling or interpreting the program. Thus, the compiler or interpreter takes care of "remembering" large numbers.

Why do we need variables? Our experience with `PATH` and positional parameters has shown that variables store some data. It is needed for one of the following purposes:

1. To transfer information from one part of a program or system to another.

2. To store the intermediate result of a calculation for later use.

3. Save the current state of the program or system. This state may determine future behavior.

4. Set a constant value to be used repeatedly later.

A programming language has a special type of variable for each of these purposes. The Bash language has it too.

### Classification of variables

The Bash interpreter has two modes of operation: interactive (shell) and non-interactive (scripting). In each mode, variables solve similar tasks. But the contexts of these tasks are different. Therefore, there are more features to classify variables in Bash than in other interpreted languages.

Let's simplify the terminology for convenience. It is not quite right, but it helps to avoid confusion. When we talk about scripts, we use the term "variable". When we talk about shell and command-line arguments, we use the term "parameter". These terms are often used synonymously.

There are four attributes for classifying variables in Bash. Table 3-1 shows them.

{caption: "Table 3-1. Variable Types in Bash", width: "100%"}
| Classification Attribute | Variable Types | Definition | Examples |
| --- | --- | --- | --- |
| Declaration mechanism | User-defined variables | The user sets them. | `filename="README.txt" ; echo "$filename"` |
|  | | | |
|                    | Internal variables | The interpreter sets them. It needs them to work correctly. | `echo "$PATH"` |
|  | | | |
|                    | Special parameters | The interpreter sets them for the user. The user can read them but not write. | `echo "$?"` |
|  | | | |
| [Scope](https://en.wikipedia.org/wiki/Scope_(computer_science)) | Environment or global variables | They are available in any instance of the interpreter. The `env` utility lists them. | `echo "$PATH"` |
|  | | | |
|                     | Local variables | They are available in a particular instance of the interpreter only. | `filename="README.txt" ; echo "$filename"` |
|  | | | |
| Content type | String | It stores a string. | `filename="README.txt"` |
|  | | | |
|            | Integer | It stores an integer. | `declare -i number=10/2 ; echo "$number"` |
|  | | | |
|            | Numerically indexed array | It stores a numbered list of lines. | `cities=("London" "New York" "Berlin") ; echo "${cities[1]}"` |
|  | | | `cities[0]="London" ; cities[1]="New York" ; cities[2]="Berlin" ; echo "${cities[1]}"` |
|  | | | |
|            | [**Associative array**](https://en.wikipedia.org/wiki/Associative_array) | It is a data structure with elements that are key-value pairs. Each key and value are strings. | `declare -A cities=( ["Alice"]="London" ["Bob"]="New York" ["Eve"]="Berlin" ) ; echo "${cities[Bob]}"` |
|  | | | |
| Changeability | Constants | The user cannot delete them. They store values that cannot be changed. | `readonly CONSTANT="ABC" ; echo "$CONSTANT"` |
|                     | | | `declare -r CONSTANT="ABC" ; echo "$CONSTANT"` |
|  | | | |
|                     | Variables | The user can delete them. They store values that can be changed. | `filename="README.txt"` |

Let's consider each type of variable.

### Declaration Mechanism

#### User-Defined Variables

The purpose of user variables is obvious from their name. The user declares them for his purposes. Such variables usually store intermediate results of the script, its state and frequently used constants.

To declare the user-defined variable, specify its name, put an equal sign, and type its value.

Here is an example. We declare a variable called `filename`. Its value equals the filename `README.txt`. The declaration of the variable looks like this:
{line-numbers: false, format: Bash}
```
filename="README.txt".
```

Spaces before and after the equal sign are not allowed. Other programming languages allow them, but Bash does not. It leads to an error when Bash handles the following declaration:
{line-numbers: false, format: Bash}
```
filename = "README.txt"
```

Bash misinterprets this line. It assumes that you call the command with the `filename` name. Then you pass there two parameters: `=` and `"README.txt"`.

Only Latin characters, numbers and the underscore are allowed in variable names. The name must not start with a number. Letter case is important. It means that `filename` and `FILENAME` are two different variables.

Suppose we have declared a variable `filename`. Then Bash allocates the memory area for that. It writes the `README.txt` string there. You can read this value back by specifying the variable name. But when you do that, Bash should understand your intention. If you put a dollar sign before the variable name, it would be a hint for Bash. Then it treats the word `filename` as the variable name.

When you reference the variable in a command or script, it should look like this:
{line-numbers: false, format: Bash}
```
$filename
```

Bash handles words with a dollar sign in a special way. When it encounters such a word, it runs the **parameter expansion** mechanism. The mechanism replaces all occurrences of a variable name by its value. Here is the command for example:
{line-numbers: false, format: Bash}
```
cp $filename ~
```

After parameter expansion, the command looks like this:
{line-numbers: false, format: Bash}
```
cp README.txt ~
```

There are nine kinds of expansions that Bash does. There is a strict order in which the interpreter performs them. The order is important. If you miss it, errors can occur. Let's consider an example of such an error.

Suppose we manipulate the "my file.txt" file in the script. For the sake of convenience, we put the filename into a variable. Its declaration looks like this:
{line-numbers: false, format: Bash}
```
filename="my file.txt"
```

Then we use the variable in the `cp` call. Here is the command:
{line-numbers: false, format: Bash}
```
cp $filename ~
```

Bash does word splitting after parameter expansion. They are two different expansion mechanisms. When both of them are done, the `cp` call looks the following:
{line-numbers: false, format: Bash}
```
cp my file.txt ~
```

This command leads to an error. Bash passes two parameters to the `cp` utility: "my" and "file.txt". There are no such files.

Another error happens if the variable's value contains a special character. Here is an example:
{line-numbers: true, format: Bash}
```
filename="*file.txt"
rm $filename
```

The `rm` utility deletes all files ending in `file.txt`. The globbing mechanism causes such behavior. It happens because Bash does globbing after parameter expansion too. Then it substitutes files of the current directory whose names match the "*file.txt" pattern. It leads to unexpected results. Here is an example of the possible command:
{line-numbers: false, format: Bash}
```
rm report_file.txt myfile.txt msg_file.txt
```

When referencing variables, always apply double-quotes. They prevent unwanted Bash expansions. Here are the examples:
{line-numbers: true, format: Bash}
```
filename1="my file.txt"
cp "$filename1" ~

filename2="*file.txt"
rm "$filename2"
```

Thanks to the quotes, Bash inserts the variables' values as it is:
{line-numbers: true, format: Bash}
```
cp "my file.txt" ~
rm "*file.txt"
```

We already know several [Bash expansions](http://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Expansions). Table 3-2 gives their complete list and order of execution. 

{caption: "Table 3-2. Bash expansions", width: "100%"}
| Order of Execution | Expansion | Description | Example |
| --- | --- | --- | --- |
| 1 | [Brace Expansion](https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html) | It generates a set of strings by the specified pattern with braces. | `echo a{d,c,b}e` |
|  | | | |
| 2 | [Tilde Expansion](https://www.gnu.org/software/bash/manual/html_node/Tilde-Expansion.html) | Bash replaces the tilde by the value of the `HOME` variable. | `cd ~` |
|  | | | |
| 3 | [Parameter Expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html) | Bash replaces parameters and variables by their values. | `echo "$PATH"` |
|  | | | |
| 4 | [Arithmetic Expansion](https://www.gnu.org/software/bash/manual/html_node/Arithmetic-Expansion.html) | Bash replaces arithmetic expressions by their results. | `echo $((4+3))` |
|  | | | |
| 5 | [Command Substitution](https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html) | Bash replaces the command with its output. | `echo $(< README.txt)` |
|  | | | |
| 6 | [Process Substitution](https://www.gnu.org/software/bash/manual/html_node/Process-Substitution.html) | Bash replaces the command with its output. Unlike Command Substitution, it is done [asynchronously](https://en.wikipedia.org/wiki/Asynchrony_(computer_programming)). The command's input and output are bound to a temporary file. | `diff <(sort file1.txt) <(sort file2.txt)` |
|  | | | |
| 7 | [Word Splitting](https://www.gnu.org/software/bash/manual/html_node/Word-Splitting.html) | Bash splits command-line arguments into words and passes them as separate parameters. | `cp file1.txt file2.txt ~` |
|  | | | |
| 8 | [Filename Expansion](https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html) (globbing) | Bash replaces patterns with filenames. | `rm ~/delete/*` |
|  | | | |
| 9 | Quote Removal | Bash removes all unshielded \, ' and " characters that were not derived from one of the expansions. | `cp "my file.txt" ~` |

{caption: "Exercise 3-1. Testing the Bash expansions", format: text, line-numbers: false}
```
Run the example of each Bash expansion from Table 3-2 in the terminal.
Figure out how the final command turned out.
Come up with your own examples.
```

The dollar sign before a variable name is a shortened form of parameter expansion. Its full form looks the following:
{line-numbers: false, format: Bash}
```
${filename}
```

Use the full form to avoid ambiguity. Here is an example when the text follows the variable name:
{line-numbers: true, format: Bash}
```
prefix="my"
name="file.txt"
cp "$prefix_$name" ~
```

In this case, Bash looks for a variable named "prefix_". It happens because the interpreter appends the underscore to the variable name. The full form of the parameter expansion solves this problem:
{line-numbers: false, format: Bash}
```
cp "${prefix}_${name}" ~
```

There is an alternative solution. Enclose each variable name in double-quotes. Here is an example:
{line-numbers: false, format: Bash}
```
cp "$prefix"_"$name" ~
```

The full form of parameter expansion helps when the variable has not been defined. In that case, you can insert the specified value instead. Do it like this:
{line-numbers: false, format: Bash}
```
cp file.txt "${directory:-~}"
```

Here Bash checks if the `directory` variable is defined and has a non-empty value. If it is, Bash performs a regular parameter expansion. Otherwise, it inserts the value that follows the minus character. It is the user's home directory in our example.

The full form of parameter expansion has several variations. Table 3-3 shows all of them.

{caption: "Table 3-3. The full form of parameter expansion", width: "100%"}
| Variation | Description|
| --- | --- |
| `${parameter:-word}` | If the "parameter" variable is not declared or has an empty value, Bash inserts the specified "word" value instead. Otherwise, it inserts the variable's value. |
|  | |
| `${parameter:=word}` | If a variable is not declared or has an empty value, Bash assigns it the specified value. Then it inserts this value. Otherwise, Bash inserts the variable's value. You cannot override positional and special parameters in this way. |
|  | |
| `${parameter:?word}` | If the variable is not declared or has an empty value, Bash prints the specified value on the error stream. Then, it terminates the script with a non-zero exit status. Otherwise, Bash inserts the variable's value. |
|  | |
| `${parameter:+word}` | If the variable is not declared or has an empty value, Bash skips the expansion. Otherwise, it inserts the specified value. |

{caption: "Exercise 3-2. The full form of parameter expansion", format: text, line-numbers: false}
```
Write a script that searches for files with TXT extension in the current directory.
The script ignores subdirectories.
Copy or move all found files to the user's home directory.
When calling the script, you can choose whether to copy or move the files.
If no action is specified, the script chooses to copy the files.
```

#### Internal variables

The user can declare variables. Bash also can do that. In this case, they are called **internal** or **shell variables**. The interpreter assigns the default values to them. The user can change some shell variables.

Internal variables have two functions:

1. Passing information from the shell to the application it runs.

2. Storing the current state of the interpreter itself.

The variables are divided into two groups:

1. Bourne Shell variables.

2. Bash variables.

The first group of variables comes from Bourne Shell. Bash needs it for POSIX compatibility. Table 3-4 shows the frequently used of these variables.

{caption: "Table 3-4. Bourne Shell variables", width: "100%"}
| Name | Value |
| --- | --- |
| `HOME` | The home directory of the current user. Bash uses this variable for doing tilde expansion and processing the `cd` call without parameters. |
|  | |
| [`IFS`](http://mywiki.wooledge.org/IFS) | It contains a list of delimiter characters. The word splitting mechanism uses these characters to split the strings into words. The default delimiters are space, [tab](https://en.wikipedia.org/wiki/Tab_key#Tab_characters) and a line break. |
|  | |
| `PATH` | It contains a list of paths. Bash uses the list to look for utilities and programs when the user runs them. Colons separate the paths in the list. |
|  | |
| `PS1` | It is a command prompt. The prompt can include [control characters](https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html#Controlling-the-Prompt). Bash replaces them with specific values (for example, the current user's name). |
|  | |
| `SHELLOPTS` | A list of [shell options](https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#The-Shopt-Builtin). They change the operating mode of interpreter. Colons separate the options in the list. |

In addition to the inherited Bourne Shell variables, Bash introduces new ones. Table 3-5 shows them. The list is incomplete. There are some extra variables, but they are rarely used.

{caption: "Table 3-5. Bash variables", width: "100%"}
| Name | Value |
| --- | --- |
| `BASH` | The full path to the Bash executable file. This file corresponds to the current Bash process. |
|  | |
| `BASHOPTS` | A list of Bash-specific [shell options](https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#The-Shopt-Builtin). They change the operating mode of Bash. Colons separate the options in the list. |
|  | |
| `BASH_VERSION` | The version of the running Bash interpreter. |
|  | |
| `GROUPS` | A list of groups to which the current user belongs. |
|  | |
| `HISTCMD` | The number of the current command in the command history. It shows you how many items are in history. |
|  | |
| `HISTFILE` | The path to the file that stores the command history. The default value is `~/.bash_history`. |
|  | |
| `HISTFILESIZE` | The maximum allowed number of lines in the command history. The default value is 500. |
|  | |
| `HISTSIZE` | The maximum allowed amount of items in the command history. The default value is 500. |
|  | |
| `HOSTNAME` | The name of the current computer as a node on the computer network. |
|  | |
| `HOSTTYPE` | A string describing the hardware platform on which Bash is running. |
|  | |
| `LANG` | [Locale settings](https://en.wikipedia.org/wiki/Locale_(computer_software)) for the user interface. They define the user's language, region and some special characters. Some settings are overridden by variables `LC_ALL`, `LC_COLLATE`, `LC_CTYPE`, `LC_MESSAGES`, `LC_NUMERIC`, `LC_TYPE`. |
|  | |
| `MACHTYPE` | A string describing the system on which Bash is running. It includes information from the `HOSTTYPE` and `OSTYPE` variables. |
|  | |
| `OLDPWD` | The previous working directory, which was set by the `cd` command. |
|  | |
| `OSTYPE` | A string describing the OS on which Bash is running. |
|  | |
| `POSIXLY_CORRECT` | If this variable is defined, Bash runs in the [POSIX compatible mode](https://www.gnu.org/software/bash/manual/html_node/Bash-POSIX-Mode.html#Bash-POSIX-Mode). |
|  | |
| `PWD` | The current directory that the `cd` command has set. |
|  | |
| `RANDOM` | Each time the user reads this variable, Bash returns a random number between 0 and 32767. When the user writes the variable, Bash assigns a new initializing number ([seed](https://en.wikipedia.org/wiki/Random_seed)) to the [pseudorandom number generator](https://en.wikipedia.org/wiki/Pseudorandom_number_generator). |
|  | |
| `SECONDS` | The number of seconds elapsed since the current Bash process started. |
|  | |
| `SHELL` | The path to the shell executable file for the current user. Each user can use his own shell program. |
|  | |
| `SHLVL` | The nesting level of the current Bash instance. This variable is incremented by one each time you start Bash from itself. |
|  | |
| `UID` | The ID number of the current user. |

The internal variables are divided into three groups depending on the allowed actions with them. These are the groups:

1. Bash assigns a value to a variable at startup. It remains unchanged throughout the session. The user can read it, but changing is prohibited. Examples: `BASHOPTS`, `GROUPS`, `SHELLOPTS`, `UID`.

2. Bash assigns a default value to a variable at startup. User actions or other events change this value. Some variables can be explicitly re-assigned, but this can disrupt the interpreter. Examples: `HISTCMD`, `OLDPWD`, `PWD`, `SECONDS`, `SHLVL`.

3. Bash assigns a default value to the variable at startup. The user can change it. Examples: `HISTFILESIZE`, `HISTSIZE`.

#### Special Parameters

Bash declare special parameters and assign values to them. It works in the same way as for shell variables.

Special parameters pass information from a shell to a launching application and vice versa. We have already considered positional parameters. All of them are special parameters.

Table 3-6 shows frequently used special parameters.

{caption: "Table 3-6. Bash Special Parameters", width: "100%"}
| Name | Value |
| --- | --- |
| `$*` | It contains all positional parameters passed to the script. Parameters start with the `$1` variable but not with `$0`. If you skip double-quotes (`$*`), Bash inserts each positional parameter as a separate word. With double-quotes ("$*"), Bash handles it as a single quoted string. The string contains all the parameters separated by the first character of the internal variable `IFS`. |
|  | |
| `$@` | The array that contains all positional parameters passed to the script. Parameters start with the `$1` variable. If you skip double-quotes (`$@`), Bash handles each array's element as an unquoted string. Word splitting happens in this case. With double-quotes ("$@"), Bash handles each element as a quoted string without word splitting. |
|  | |
| `$1`, `$2`... | It contains the value of the corresponding positional parameter. `$1` matches the first parameter. `$2` matches the second one, etc. The numbers are given in the decimal system. |
|  | |
| `$?` | The exit status of the last executed command in the foreground mode. If a pipeline was executed, the parameter stores the exit status of the last command in the pipeline. |
|  | |
| `$-` | It contains options for the current interpreter instance. |
|  | |
| `$$` | The process ID of the current interpreter instance. If you use it in the subshell, Bash inserts the PID of the parent process. |
|  | |
| `$!` | The process ID of the last command that was launched in the background mode. |
|  | |
| `$0` | The name of the shell or script that is currently running. |
|  | |

You cannot change special Bash parameters directly. For example, the following redeclaration of `$1` does not work:
{line-numbers: false, format: Bash}
```
1="new value"
```

If you want to redeclare positional parameters, use the `set` command. It redeclares all parameters at once. There is no option to change a single parameter only. Here is the form of the `set` call:
{line-numbers: false, format: Bash}
```
set -- NEW_VALUE_OF_$1 NEW_VALUE_OF_$2 NEW_VALUE_OF_$3...
```

What to do if you need to change a single positional parameter? Suppose you call the script with four parameters. For example, like this:
{line-numbers: false, format: Bash}
```
./my_script.sh arg1 arg2 arg3 arg4
```

You want to replace the third parameter `arg3` with the `new_arg3` value. Here is the `set` call for that:
{line-numbers: false, format: Bash}
```
set -- "${@:1:2}" "new_arg3" "${@:4}"
```

Let's consider this call in detail. Bash replaces the first argument "${@:1:2}" by the first two elements of the `$@` array. It leads that `$1` and `$2` parameters get their previous values. Then there is the new value for the parameter `$3`. Now it equals "new_arg3". Then there is the "${@:4}" value. Here Bash inserts all elements of the `$@` array starting from `$4`. It means that all these parameters get their previous values.

All special parameters from Table 3-6 are available in the POSIX-compatible mode.

### Scope

#### Environment Variables

Variables are divided into **scopes** (scope) in any software system. A scope is a part of a program or system where the variable name remains associated with its value. In other words, you can convert the variable name into its address in the scope of that variable only. Outside the scope, the same name can point to another variable.

A scope is called **global** if it spreads to the whole system. For example, the variable called `filename` is in the global scope. Then you can access it by its name from any part of the system.

Bash keeps all its internal variables in the global scope. They are called **environment variables**. It means that all internal variables are environment variables. The user can declare his variable in the global scope too. Then it becomes an environment variable.

Why does Bash store variables in the global scope? It happens because Unix has a special set of settings. They affect the behavior of the applications the user runs. An example is locale settings. According to them, each running application adapts its interface. Applications share such kinds of settings through environment variables.

Suppose one process spawns a child process. The child process inherits all environment variables of the parent. Thus, all utilities and applications launched from the shell inherit its environment variables. This way, global Unix settings are spread to all user programs.

The child process can change its environment variables. Then it spawns another process. This new process inherits the changed variables. However, when the child changes its environment variables, it does not affect the corresponding variables of the parent process.

The `export` built-in command declares an environment variable. Here is an example of doing that:
{line-numbers: false, format: Bash}
```
export BROWSER_PATH="/opt/firefox/bin"
```

You can declare the variable and then add it to the global scope. Call the `export` command in this way:
{line-numbers: true, format: Bash}
```
BROWSER_PATH="/opt/firefox/bin"
export BROWSER_PATH
```

Sometimes you want to declare the environment variables for the specific application only. Then list the variables and their values before the application call. Here is an example:
{line-numbers: false, format: Bash}
```
MOZ_WEBRENDER=1 LANG="en_US.UTF-8" /opt/firefox/bin/firefox
```

Here the Firefox browser receives the specified `MOZ_WEBRENDER` and `LANG` variables. They can differ from the system-wide settings.

Suppose that you use another interpreter as the shell. An example is Bourne Shell. Then you should apply the `env` utility. It declares environment variables for the launching application. Here is an example:
{line-numbers: false, format: Bash}
```
env MOZ_WEBRENDER=1 LANG="en_US.UTF-8" /opt/firefox/bin/firefox
```

If you call the `env` utility without parameters, it prints all declared environment variables for the current interpreter process. Try to get this output in your terminal:
{line-numbers: false, format: Bash}
```
env
```

The `export` command and the `env` utility print the same thing if called without parameters. Prefer to use `export` instead of `env`. There are two reasons for that. First, the `export` output is sorted. Second, all variable values are enclosed in double-quotes. They prevent you from making a mistake if there is a line break in some value.

Environment variable names have uppercase letters only. Therefore, it is considered good practice to name local variables in lower case. It prevents you from accidentally using one variable instead of another.

#### Local Variables

We know about the user-defined variables. The user can declare them in several ways. Depending on his choice, the new variable comes to the **local scope** or global scope (environment).

There are two ways to declare the global scope variable:

1. Add the `export` command to the variable declaration.

2. Pass the variable when launching the program. You can do it with the `env` utility when using a shell other than Bash.

If you do not apply any of these options, your variable comes to the local scope. It is called the **local variable**. It is available in the current instance of the interpreter.  Child processes (except subshell) does not inherit it.

Here is an example. Suppose that you declare a variable in the terminal window like this: 
{line-numbers: false, format: Bash}
```
filename="README.txt"
```

Now you can output its value in the same terminal window. Call the following `echo` command for that:
{line-numbers: false, format: Bash}
```
echo "$filename"
```

The same command works well in a subshell. Just add parentheses to spawn a subshell for the specific command. It looks like this:
{line-numbers: false, format: Bash}
```
(echo "$filename")
```

However, if you read the variable from a child process, you get an empty value. You can start a child process by calling the Bash explicitly in the terminal window. Here is an example:
{line-numbers: false, format: Bash}
```
bash -c 'echo "$filename"'
```

The `-c` parameter passes a command to be executed by the Bash child process. A similar Bash call occurs implicitly when running the script from a shell.

We enclose the `echo` call in the single-quotes when passing it to the `bash` command. The quotes disable all Bash expansions for the string inside. This behavior differs from the double-quotes. They disable all expansions except command substitution and parameter expansion. If we use double-quotes in our `bash` call, the parameter expansion happens. Then Bash inserts the variable's value in the call. The call would look like this:
{line-numbers: false, format: Bash}
```
bash -c "echo README.txt"
```

We are not interested in such a call. Instead, we want to check how the child process reads the local variable. The parent process should not put its value into the `bash` call.

If you change a local variable in the subshell, the parent process keeps its old value. For example, the following `echo` command prints the "README.txt" filename:
{line-numbers: true, format: Bash}
```
filename="README.txt"
(filename="CHANGELOG.txt")
echo "$filename"
```

This output confirms that changing the local variable in the subshell does not affect the parent process.

When you declare a local variable, it comes in the shell variables list. The list includes all local and environment variables that are available in the current interpreter process. The `set` command prints this list when called without parameters. Here is an example of how to find the `filename` variable there:
{line-numbers: false, format: Bash}
```
set | grep filename=
```

There is the following line in the command's output:
{line-numbers: false, format: Bash}
```
filename=README.txt
```

It means that the `filename` variable is in the list of shell variables.
