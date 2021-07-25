## Variables and Parameters

We already met Bash variables several times in this book. You have learned the list of system paths in the `PATH` variable. Then you have used positional parameters in the backup script. It is time to get a good grasp on the topic.

Let's start with the meaning of the "variable" term in programming. The variable is an area of memory where some value is stored. In most cases, this is short-term memory (RAM, CPU cache and registers).

The first generation of programming languages (for example, [**assembler**](https://en.wikipedia.org/wiki/Assembly_language)) has minimal support of variables. When using such a language, you should refer to a variable by its address. If you want to read or write its value, you have to specify its memory address.

When working with memory addresses, you might get into trouble. Suppose you work on a computer with 32-bit processors. Then any memory address has a length of 4 bytes. It is the number from 0 to 4294967295. This number is twice larger for 64-bit processors. It is inconvenient to remember and operate with such big numbers. That is why modern programming languages allow you to replace a variable address with its name. A compiler or interpreter translates this name into a memory address automatically. These programs "remember" large numbers instead of you this way.

When should you apply variables? Our experience with `PATH` and positional parameters has shown that variables store some data. It is needed for one of the following purposes:

1. Transfer information from one part of a program or system to another.

2. Store the intermediate result of a calculation for later use.

3. Save the current state of the program or system. This state may determine its future behavior.

4. Set a constant value to be used repeatedly later.

A typical programming language has a special type of variable for each of these purposes. The Bash language follows this rule too.

### Classification of variables

The Bash interpreter has two operation modes: interactive (shell) and non-interactive (scripting). Variables solve similar tasks in each mode. However, the contexts of these tasks are different. Therefore, there are more features to classify variables in Bash than in other languages.

Let's simplify the terminology for convenience. It is not entirely correct, but it helps to avoid confusion. When we talk about scripts, we use the "variable" term. When we talk about shell and command-line arguments, we use the "parameter" term. These terms are often used synonymously.

There are four attributes for classifying variables in Bash. Table 3-1 explains them.

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
|            | Indexed array | It stores a numbered list of lines. | `cities=("London" "New York" "Berlin") ; echo "${cities[1]}"` |
|  | | | `cities[0]="London" ; cities[1]="New York" ; cities[2]="Berlin" ; echo "${cities[1]}"` |
|  | | | |
|            | [**Associative array**](https://en.wikipedia.org/wiki/Associative_array) | It is a data structure with elements that are key-value pairs. Each key and value are strings. | `declare -A cities=( ["Alice"]="London" ["Bob"]="New York" ["Eve"]="Berlin" ) ; echo "${cities[Bob]}"` |
|  | | | |
| Changeability | Constants | The user cannot delete them. They store values that cannot be changed. | `readonly CONSTANT="ABC" ; echo "$CONSTANT"` |
|                     | | | `declare -r CONSTANT="ABC" ; echo "$CONSTANT"` |
|  | | | |
|                     | Variables | The user can delete them. They store values that can be changed. | `filename="README.txt"` |

We will consider each type of variable in this section.

### Declaration Mechanism

#### User-Defined Variables

The purpose of user-defined variables is obvious from their name. You declare them for your own purposes. Such variables usually store intermediate results of the script, its state and frequently used constants.

To declare the user-defined variable, specify its name, put an equal sign, and type its value.

Here is an example. Suppose that you want to declare a variable called `filename`. It stores the `README.txt` filename. The variable declaration looks like this:
{line-numbers: false, format: Bash}
```
filename="README.txt".
```

Spaces before and after the equal sign are not allowed. It works in other programming languages but not in Bash. For example, the following declaration causes an error:
{line-numbers: false, format: Bash}
```
filename = "README.txt"
```

Bash misinterprets this line. It assumes that you call the command with the `filename` name. Then you pass there two parameters: `=` and "README.txt".

When declaring a variable, you can apply Latin letters, numbers and the underscore in its name. The name must not start with a number. Letter case is important. It means that `filename` and `FILENAME` are two different variables.

Suppose you have declared a variable `filename`. Then Bash allocates the memory area for that. It writes the `README.txt` string there. You can read this value back using the variable name. When you do that, Bash should understand your intention. If you put a dollar sign before the variable name, it would be a hint for Bash. Then it treats the word `filename` as the variable name.

When you reference the variable in a command or script, it looks like this:
{line-numbers: false, format: Bash}
```
$filename
```

Bash handles words with a dollar sign in a special way. When it encounters such a word, it runs the **parameter expansion** mechanism. The mechanism replaces all occurrences of a variable name by its value. Here is the example command:
{line-numbers: false, format: Bash}
```
cp $filename ~
```

The command looks like this after the parameter expansion:
{line-numbers: false, format: Bash}
```
cp README.txt ~
```

Bash performs nine kinds of expansions before executing each command. They are done in a strict order. Please try to remember this order. If you miss it, you can get an error.

Here is an example of a mistake that happens because of expansions order. Suppose that you manipulate the "my file.txt" file in the script. For the sake of convenience, you put the filename into a variable. Its declaration looks like this:
{line-numbers: false, format: Bash}
```
filename="my file.txt"
```

Then you use the variable in the `cp` call. Here is the copying command:
{line-numbers: false, format: Bash}
```
cp $filename ~
```

Bash does word splitting after the parameter expansion. They are two different expansion mechanisms. When both of them are done, the `cp` call looks like this:
{line-numbers: false, format: Bash}
```
cp my file.txt ~
```

This command leads to the error. Bash passes two parameters to the `cp` utility: "my" and "file.txt". These files do not exist.

Another error happens if the variable's value contains a special character. For example, you declare and use the `filename` variable this way:
{line-numbers: true, format: Bash}
```
filename="*file.txt"
rm $filename
```

The `rm` utility deletes all files ending in `file.txt`. The globbing mechanism causes such behavior. It happens because Bash does globbing after the parameter expansion. Then it substitutes files of the current directory whose names match the "*file.txt" pattern. It leads to unexpected results. Here is an example of the `rm` call that you can get this way:
{line-numbers: false, format: Bash}
```
rm report_file.txt myfile.txt msg_file.txt
```

When referencing a variable, always apply the double-quotes. They prevent unwanted Bash expansions. The quotes solve problems of both our examples:
{line-numbers: true, format: Bash}
```
filename1="my file.txt"
cp "$filename1" ~

filename2="*file.txt"
rm "$filename2"
```

Thanks to the quotes, Bash inserts the variables' values as they are:
{line-numbers: true, format: Bash}
```
cp "my file.txt" ~
rm "*file.txt"
```

We already know several [Bash expansions](http://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Expansions). Table 3-2 gives the full picture. It shows the complete list of expansions and their order of execution.

{caption: "Table 3-2. Bash expansions", width: "100%"}
| Order of Execution | Expansion | Description | Example |
| --- | --- | --- | --- |
| 1 | [Brace Expansion](https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html) | It generates a set of strings by the specified pattern with braces. | `echo a{d,c,b}e` |
|  | | | |
| 2 | [Tilde Expansion](https://www.gnu.org/software/bash/manual/html_node/Tilde-Expansion.html) | Bash replaces the tilde by the value of the `HOME` variable. | `cd ~` |
|  | | | |
| 3 | [Parameter Expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html) | Bash replaces parameters and variables by their values. | `echo "$PATH"` |
|  | | | |
| 4 | [Arithmetic Expansion](https://www.gnu.org/software/bash/manual/html_node/Arithmetic-Expansion.html) | Bash replaces arithmetic expressions by their results. | `echo $((4+3))` |
|  | | | |
| 5 | [Command Substitution](https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html) | Bash replaces commands with their output. | `echo $(< README.txt)` |
|  | | | |
| 6 | [Process Substitution](https://www.gnu.org/software/bash/manual/html_node/Process-Substitution.html) | Bash replaces commands with their output. Unlike Command Substitution, it is done [asynchronously](https://en.wikipedia.org/wiki/Asynchrony_(computer_programming)). The command's input and output are bound to a temporary file. | `diff <(sort file1.txt) <(sort file2.txt)` |
|  | | | |
| 7 | [Word Splitting](https://www.gnu.org/software/bash/manual/html_node/Word-Splitting.html) | Bash splits command-line arguments into words and passes them as separate parameters. | `cp file1.txt file2.txt ~` |
|  | | | |
| 8 | [Filename Expansion](https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html) (globbing) | Bash replaces patterns with filenames. | `rm ~/delete/*` |
|  | | | |
| 9 | Quote Removal | Bash removes all unshielded characters `, ' "` that were not derived from one of the expansions. | `cp "my file.txt" ~` |

{caption: "Exercise 3-1. Testing the Bash expansions", format: text, line-numbers: false}
```
Run the example of each Bash expansion from Table 3-2 in the terminal.
Figure out how the final command turned out.
Come up with your own examples.
```

Let's come back to the parameter expansion. When you put the dollar sign before a variable name, you use the short form of the expansion. Its full form looks this way:
{line-numbers: false, format: Bash}
```
${filename}
```

Use this form to avoid ambiguity. Ambiguity can happen when the text follows the variable name. Here is an example of such a case:
{line-numbers: true, format: Bash}
```
prefix="my"
name="file.txt"
cp "$prefix_$name" ~
```

Here Bash tries to find and insert the variable called "prefix_". It happens because the interpreter appends the underscore to the variable name. You can solve this kind of problem if you apply the full form of the parameter expansion. Do it this way:
{line-numbers: false, format: Bash}
```
cp "${prefix}_${name}" ~
```

If you prefer to use the short form of the expansion, you have another option. Enclose each variable name in the double-quotes. Then Bash will not confuse them and nearby text. Here is an example:
{line-numbers: false, format: Bash}
```
cp "$prefix"_"$name" ~
```

The full form of the parameter expansion has several features. They help you to handle cases when a variable is undefined. For example, you can insert the specified value in this case. Here is an example:
{line-numbers: false, format: Bash}
```
cp file.txt "${directory:-~}"
```

Here Bash checks if the `directory` variable is defined and has a non-empty value. If it is, Bash performs a regular parameter expansion. Otherwise, it inserts the value that follows the minus character. It is the home directory path in our example.

Table 3-3 shows all variations of the parameter expansion.

{caption: "Table 3-3. The full form of the parameter expansion", width: "100%"}
| Variation | Description|
| --- | --- |
| `${parameter:-word}` | If the "parameter" variable is not declared or has an empty value, Bash inserts the specified "word" value instead. Otherwise, it inserts the variable's value. |
|  | |
| `${parameter:=word}` | If a variable is not declared or has an empty value, Bash assigns it the specified "word" value. Then it inserts this value. Otherwise, Bash inserts the variable's value. You cannot override positional and special parameters this way. |
|  | |
| `${parameter:?word}` | If the variable is not declared or has an empty value, Bash prints the specified "word" value in the error stream. Then, it terminates the script with a non-zero exit status. Otherwise, Bash inserts the variable's value. |
|  | |
| `${parameter:+word}` | If the variable is not declared or has an empty value, Bash skips the expansion. Otherwise, it inserts the specified "word" value. |

{caption: "Exercise 3-2. The full form of the parameter expansion", format: text, line-numbers: false}
```
Write a script that searches for files with the TXT extension in the current directory.
The script ignores subdirectories.
Copy or move all found files to the home directory.
When calling the script, you can choose whether to copy or move the files.
If you do not specify the action, the script copies the files.
```

#### Internal Variables

You can declare variables for your own purposes. Bash also can do that. These variables are called **internal** or **shell variables**. You can change values for some of them.

Internal variables solve two tasks:

1. They pass information from the shell to the applications it runs.

2. They store the current state of the interpreter.

There are two groups of internal variables:

1. Bourne Shell variables.

2. Bash variables.

The first group came from Bourne Shell. Bash needs it for compatibility with the POSIX standard. Table 3-4 shows the frequently used variables of this group.

{caption: "Table 3-4. Bourne Shell variables", width: "100%", column-widths: "20% *"}
| Name | Value |
| --- | --- |
| `HOME` | The home directory of the current user. Bash uses this variable for tilde expansion and processing the `cd` call without parameters. |
|  | |
| [`IFS`](http://mywiki.wooledge.org/IFS) | It contains a list of delimiter characters. The word splitting mechanism uses them to split the strings into words. The default delimiters are space, [tab](https://en.wikipedia.org/wiki/Tab_key#Tab_characters) and a line break. |
|  | |
| `PATH` | It contains the list of paths where Bash looks for utilities and programs. Colons separate the paths in the list. |
|  | |
| `PS1` | It is a command prompt. The prompt can include [control characters](https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html#Controlling-the-Prompt). Bash replaces them with specific values (for example, the current user's name). |
|  | |
| `SHELLOPTS` | The list of [shell options](https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#The-Shopt-Builtin). They change the operating mode of the interpreter. Colons separate the options in the list. |

The second group of internal variables is Bash specific. Table 3-5 shows them. This list is incomplete. There are some more variables, but they are rarely used.

{caption: "Table 3-5. Bash variables", width: "100%"}
| Name | Value |
| --- | --- |
| `BASH` | The full path to the Bash executable file. This file corresponds to the current Bash process. |
|  | |
| `BASHOPTS` | The list of Bash specific [shell options](https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#The-Shopt-Builtin). They change the operating mode of Bash. Colons separate the options in the list. |
|  | |
| `BASH_VERSION` | The version of the running Bash interpreter. |
|  | |
| `GROUPS` | The list of groups to which the current user belongs. |
|  | |
| `HISTCMD` | The index of the current command in history. It shows you how many items are there. |
|  | |
| `HISTFILE` | The path to the file that stores the command history. The default path is `~/.bash_history`. |
|  | |
| `HISTFILESIZE` | The maximum number of lines allowed in the command history. The default value is 500. |
|  | |
| `HISTSIZE` | The maximum number of entries allowed in the command history. The default value is 500. |
|  | |
| `HOSTNAME` | The computer name as a node of the network. Other hosts can reach your computer by this name. |
|  | |
| `HOSTTYPE` | The string describing the hardware platform where Bash is running. |
|  | |
| `LANG` | [Locale settings](https://en.wikipedia.org/wiki/Locale_(computer_software)) for the user interface. They define the user's language, region and special characters. Some settings are overridden by variables `LC_ALL`, `LC_COLLATE`, `LC_CTYPE`, `LC_MESSAGES`, `LC_NUMERIC`, `LC_TYPE`. |
|  | |
| `MACHTYPE` | The string describing the system where Bash is running. It includes information from the `HOSTTYPE` and `OSTYPE` variables. |
|  | |
| `OLDPWD` | The previous directory that the `cd` command has set. |
|  | |
| `OSTYPE` | The string describing of the OS where Bash is running. |
|  | |
| `POSIXLY_CORRECT` | If this variable is defined, Bash runs in the [POSIX compatible mode](https://www.gnu.org/software/bash/manual/html_node/Bash-POSIX-Mode.html#Bash-POSIX-Mode). |
|  | |
| `PWD` | The current directory that the `cd` command has set. |
|  | |
| `RANDOM` | Each time you read this variable, Bash returns a random number between 0 and 32767. When you write the variable there, Bash assigns a new initializing number ([seed](https://en.wikipedia.org/wiki/Random_seed)) to the [pseudorandom number generator](https://en.wikipedia.org/wiki/Pseudorandom_number_generator). |
|  | |
| `SECONDS` | The number of seconds elapsed since the current Bash process started. |
|  | |
| `SHELL` | The path to the shell executable for the current user. Each user can use his own shell program. |
|  | |
| `SHLVL` | The nesting level of the current Bash instance. This variable is incremented by one each time you start Bash from the shell or script. |
|  | |
| `UID` | The ID number of the current user. |

The internal variables are divided into three groups depending on the allowed actions with them. These are the groups:

1. Bash assigns a value to a variable at startup. It remains unchanged throughout the session. You can read it, but changing is prohibited. Examples: `BASHOPTS`, `GROUPS`, `SHELLOPTS`, `UID`.

2. Bash assigns a default value to a variable at startup. Your actions or other events change this value. You can re-assign some values explicitly, but this can disrupt the interpreter. Examples: `HISTCMD`, `OLDPWD`, `PWD`, `SECONDS`, `SHLVL`.

3. Bash assigns a default value to the variable at startup. You can change it. Examples: `HISTFILESIZE`, `HISTSIZE`.

#### Special Parameters

Bash declares special parameters and assigns values to them. It handles them the same way as shell variables.

Special parameters pass information from the shell to the launched application and vice versa. A positional parameter is an example of this kind of Bash variable.

Table 3-6 shows frequently used special parameters.

{caption: "Table 3-6. Bash Special Parameters", width: "100%"}
| Name | Value |
| --- | --- |
| `$*` | The string with all positional parameters passed to the script. Parameters start with the `$1` variable but not with `$0`. If you skip the double quotes (`$*`), Bash inserts each positional parameter as a separate word. With double quotes ("$*"), Bash handles it as one quoted string. The string contains all the parameters separated by the first character of the internal variable `IFS`. |
|  | |
| `$@` | The list of strings that contains all positional parameters passed to the script. Parameters start with the `$1` variable. If you skip double quotes (`$@`), Bash handles each array's element as an unquoted string. Word splitting happens in this case. With double quotes ("$@"), Bash handles each element as a quoted string without word splitting. |
|  | |
| `$#` | The number of positional parameters passed to the script. |
|  | |
| `$1`, `$2`... | They contain the value of the corresponding positional parameter. `$1` matches the first parameter. `$2` matches the second one, etc. These numbers are given in the decimal system. |
|  | |
| `$?` | The exit status of the last executed command in the foreground mode. If you have executed a pipeline, the parameter stores the exit status of the last command in this pipeline. |
|  | |
| `$-` | It contains options for the current interpreter instance. |
|  | |
| `$$` | The process ID of the current interpreter instance. If you read it in the subshell, Bash returns the PID of the parent process. |
|  | |
| `$!` | The process ID of the last command launched in the background mode. |
|  | |
| `$0` | The name of the shell or script that is currently running. |
|  | |

You cannot change special Bash parameters directly. For example, the following redeclaration of `$1` does not work:
{line-numbers: false, format: Bash}
```
1="new value"
```

If you want to change positional parameters, use the `set` command. It redeclares all parameters at once. There is no option to change a single positional parameter only. Here is the general form of the `set` call:
{line-numbers: false, format: Bash}
```
set -- NEW_VALUE_OF_$1 NEW_VALUE_OF_$2 NEW_VALUE_OF_$3...
```

What to do if you need to change a single positional parameter? Here is an example. Suppose you call the script with four parameters like this:
{line-numbers: false, format: Bash}
```
./my_script.sh arg1 arg2 arg3 arg4
```

You want to replace the third parameter `arg3` with the `new_arg3` value. The following `set` call does that:
{line-numbers: false, format: Bash}
```
set -- "${@:1:2}" "new_arg3" "${@:4}"
```

Let's consider this command in detail. Bash replaces the first argument "${@:1:2}" with the first two elements of the `$@` array. It leads that `$1` and `$2` parameters get their previous values. Then there is the new value for the parameter `$3`. Now it equals "new_arg3". The "${@:4}" value comes at the end. Here Bash inserts all elements of the `$@` array starting from `$4`. It means that all these parameters get their previous values.

All special parameters from Table 3-6 are available in the POSIX-compatible mode of Bash.

### Scope

#### Environment Variables

Any software system has **scopes** that group variables. A scope is a part of a program or system where the variable name remains associated with its value. There you can convert the variable name into its address. Outside the scope, the same name can point to another variable.

A scope is called **global** if it spreads to the whole system. Here is an example. Suppose that the variable called `filename` is in the global scope. Then you can access it by its name from any part of the system.

Bash keeps all its internal variables in the global scope. They are called **environment variables**. It means that all internal variables are environment variables. You can declare your variable in the global scope too. Then it becomes a new environment variable.

Why does Bash store variables in the global scope? It happens because Unix has a special set of settings. They affect the behavior of the applications that you run. An example is locale settings. They dictate how each application should adapt its interface. Applications receive Unix settings through environment variables.

Suppose one process spawns a child process. The child process inherits all environment variables of the parent. This way, all utilities and applications launched from the shell inherit its environment variables. This mechanism allows all programs to receive global Unix settings.

The child process can change its environment variables. When it spawns another process, it inherits the changed variables. However, when the child changes its environment variables, it does not affect the corresponding variables of the parent process.

The `export` built-in command declares an environment variable. Here is an example of doing that:
{line-numbers: false, format: Bash}
```
export BROWSER_PATH="/opt/firefox/bin"
```

You can declare the variable and then add it to the global scope. Call the `export` command this way:
{line-numbers: true, format: Bash}
```
BROWSER_PATH="/opt/firefox/bin"
export BROWSER_PATH
```

Sometimes you need to declare the environment variables for the specific application only. List the variables and their values before the application call in this case. Here is an example:
{line-numbers: false, format: Bash}
```
MOZ_WEBRENDER=1 LANG="en_US.UTF-8" /opt/firefox/bin/firefox
```

This command launches the Firefox browser and passes it the `MOZ_WEBRENDER` and `LANG` variables. They can differ from the global Unix settings.

The last example works well in Bash. If you use another shell, you need another approach. Suppose that you use Bourne Shell. Then you can pass variables to the application using the `env` utility. Here is an example of doing that:
{line-numbers: false, format: Bash}
```
env MOZ_WEBRENDER=1 LANG="en_US.UTF-8" /opt/firefox/bin/firefox
```

If you call the `env` utility without parameters, it prints all declared environment variables for the current interpreter process. Call it in your terminal this way:
{line-numbers: false, format: Bash}
```
env
```

The `export` Bash built-in and the `env` utility print the same thing when called without parameters. Use `export` instead of `env`. There are two reasons for that. First, the `export` sorts its output. Second, it adds double quotes to the values of all variables. They prevent you from making a mistake if some values have line breaks.

All names of environment variables contain uppercase letters only. Therefore, it is a good practice to name local variables in lower case. It prevents you from accidentally using one variable instead of another.

#### Local Variables

We have considered the user-defined variables. You can declare them in several ways. Depending on your choice, the new variable comes to the **local scope** or global scope (environment).

There are two ways to declare the global scope variable:

1. Add the `export` command to the variable declaration.

2. Pass the variable to the program when launching it. You can do it with the `env` utility when using a shell other than Bash.

If you do not apply any of these ways, your variable comes to the local scope. A variable of this kind is called a **local variable**. It is available in the current instance of the interpreter. A child process (except a subshell) does not inherit it.

Here is an example. Suppose that you declare the `filename` variable in the terminal window this way:
{line-numbers: false, format: Bash}
```
filename="README.txt"
```

Now you can print its value in the same terminal window. The following `echo` command does that:
{line-numbers: false, format: Bash}
```
echo "$filename"
```

The same `echo` command works well in a subshell. You can try it. Spawn the subshell by adding the parentheses around the Bash command. It looks like this:
{line-numbers: false, format: Bash}
```
(echo "$filename")
```

The child process does not get the local `filename` variable. Let's check it. Start a child process by calling the Bash interpreter explicitly. Do it this way:
{line-numbers: false, format: Bash}
```
bash -c 'echo "$filename"'
```

The `-c` parameter passes a command that the Bash child process executes. A similar Bash call occurs implicitly when you run a script from the shell.

We enclose the `echo` call in the single quotes when passing it to the `bash` command. The quotes disable all Bash expansions for the string inside. This behavior differs from the double quotes. They disable all expansions except the command substitution and parameter expansion. If we apply double quotes in our `bash` call, the parameter expansion happens. Then Bash inserts the variable's value in the call. This way, we will get the following command:
{line-numbers: false, format: Bash}
```
bash -c "echo README.txt"
```

We are not interested in this command. Instead, we want to check how the child process reads the local variable. Therefore, the parent process should not insert its value into the `bash` call.

If you change a local variable in the subshell, its value stays the same in the parent process. The following commands confirm this rule:
{line-numbers: true, format: Bash}
```
filename="README.txt"
(filename="CHANGELOG.txt")
echo "$filename"
```

If you execute them, you get the "README.txt" output. It means that changing the local variable in the subshell does not affect the parent process.

When you declare a local variable, it comes to the shell's variables list. The list includes all local and environment variables that are available in the current interpreter process. The `set` command prints this list when called without parameters. Here is an example of how to find the `filename` variable there:
{line-numbers: false, format: Bash}
```
set | grep filename=
```

The `grep` utility prints the following string with the `filename` value:
{line-numbers: false, format: Bash}
```
filename=README.txt
```

It means that the `filename` variable is in the list of shell variables.

### Variable Content Type

#### Variable Types

It is common practice to use the [**static type system**](https://en.wikipedia.org/wiki/Type_system#Static_type_checking) in compiled programming languages (such as C). When using this system, you decide how to store the variable in memory. You should specify the variable type when declaring it. Then the compiler allocates memory and picks one of the predefined formats to store this type of variable.

Here is an example of how the static type system works. Suppose you want to declare a variable called `number`. You should specify its type in the declaration. You choose the unsigned integer type, which has a size of two bytes. Then the compiler allocates exactly two bytes of memory for this variable.

When the application starts, you assign the 203 value to the variable. It is equal to 0xCB in hexadecimal. Then the variable looks this way in the memory:
{line-numbers: false, format: Bash}
```
00 CB
```

I> Modern computers use the binary form to store information in the memory. Here we use the hexadecimal format instead for clarity.

One byte is enough to store the 203 value. However, you forced the compiler to reserve two bytes for that. The unused byte stays zeroed. No one can use it in the scope of the `number` variable. If the variable has a global scope, the byte is reserved and unused while the application works.

Suppose that you have assigned the 14037 value to the variable. It is equal to 0x36D5 in hexadecimal. Then it looks like this in the memory:
{line-numbers: false, format: Bash}
```
36 D5
```

I> The CPU determines the byte order when storing data in the computer memory. This byte order is called [**endianness**](https://en.wikipedia.org/wiki/Endianness). It is **big-endian** in our example. The alternative order is **little-endian**.

Now you want to store the 107981 (0x1A5CD) value in the variable. This number does not fit into two bytes. The variable's size is defined in the declaration. The compiler cannot extend it automatically afterward. Therefore, it writes only part of the 107981 value into the variable. It looks like this in the memory:
{line-numbers: false, format: Bash}
```
A5 CD
```

The compiler discarded the first digit of the number. If you read the variable, you get 42445 (0xA5CD). It means that you lose the original 107981 value. You cannot recover it anymore. This problem is called [**integer overflow**](https://en.wikipedia.org/wiki/Integer_overflow).

Here is another example of the static type system. Suppose you want to store the username in a variable called `username`. You declare this variable and assign it the string type. When doing that, you should specify the maximum length of the string. It can be ten characters, for example.

After declaring the variable, you write the "Alice" name there. If you use the C compiler, the string looks this way in memory:
{line-numbers: false, format: Bash}
```
41 6C 69 63 65 00 00 00 00 00
```

I> The C compiler uses the ASCII encoding for characters by default. When using it, you can clarify the hexadecimal code of each letter in the [ASCII table](http://www.asciitable.com).

Six bytes are enough to store the string "Alice". The first five bytes store characters. The last sixth byte stores the null character (00). It marks the end of the string. However, the compiler has reserved ten bytes for the variable. It fills the unused memory with zeros or random values.

[**Dynamic type system**](https://en.wikipedia.org/wiki/Type_system#Dynamic_type_checking_and_runtime_type_information) is an alternative to the static system. It uses another approach to choose how to store a variable in memory. This choice happens whenever you assign the new value to the variable. Together with the value, the variable gets new [**metadata**](https://en.wikipedia.org/wiki/Metadata). The metadata defines the variable type. They can change during the application work. Thus, the variable's representation in memory changes too. Most interpreted programming languages use the dynamic type system (for example, Python).

I> Metadata is additional information about some object or data. The [library catalog](https://en.wikipedia.org/wiki/Library_catalog) is an example of metadata. It has a card for each book. The card contains the author, title of the work, publisher, year of publication, and the number of pages. Thus, the card contains metadata about the book.

Strictly speaking, Bash does not have the type system at all. It is not a language with a static or dynamic type system. Bash stores all [**scalar variables**](https://en.wikipedia.org/wiki/Variable_(computer_science)) in memory as strings.

The scalar variable stores data of a [**primitive type**](https://en.wikipedia.org/wiki/Primitive_data_type). These data are the minimal building blocks to construct more complex [**composite types**](https://en.wikipedia.org/wiki/Composite_data_type). The scalar variable is just a name for the memory address where its value is stored.

Here is an example of how Bash represents scalar variables in memory. Suppose you made the following variable declaration:
{line-numbers: false, format: Bash}
```
declare -i number=42
```

Bash stores the `number` variable in memory as the following string:
{line-numbers: false, format: Bash}
```
34 32 00
```

Any language with the type system needs one byte to store this integer. But Bash needs three bytes. The first two bytes store each character of the integer. The characters are 4 and 2. The third byte stores the null character.

The Bourne Shell language has the scalar variables only. Bash introduces two new composite types: [**indexed array**](https://en.wikipedia.org/wiki/Array_data_structure) and [**associative array**](https://en.wikipedia.org/wiki/Associative_array).

The indexed array is a numbered set of strings. There each string corresponds to the sequence number. Bash stores such an array as a [**linked list**](https://en.wikipedia.org/wiki/Linked_list) in memory. A linked list is a data structure that consists of nodes. Each node contains data and the memory address of the next node. Node data are strings in this case.

The associative array is a more complicated thing. It is a set of elements. Each element consists of two strings. The first one is called "key". The second is called "value". When you want to access the array's element, you should specify its key. It works the same as for the indexed array, where you specify the element's index. The keys are unique. It means that the array cannot have two elements with the same keys. Bash stores associative array as a [**hash-table**](https://en.wikipedia.org/wiki/Hash_table) in memory.

Why are Bash "arrays" called arrays? Actually, they are linked lists and hash tables. A real array is the data structure whose elements are stored in memory one after another. Each element has a sequential number called an **index** or identifier. Bash "arrays" do not store their elements sequentially in memory. Thus, they are not arrays according to the definition.

Here is an example of how a real array stores its elements in memory. Suppose you have an array with numbers from five to nine. Each element takes one byte. Then the size of the array is five bytes. It looks this way in memory:
{line-numbers: false, format: Bash}
```
05 06 07 08 09
```

The indexing of arrays' elements starts with zero. It means that the index of the first element equals 0. The second index equals 1 and so on. In our example, the first element with the 0 index equals integer 5. The second element equals 6. Elements follow each other in memory. Their indexes match the memory offset from the beginning of the array. Thus, the element with the third index has three bytes offset. Its value equals integer 8.

Let's come back to the question about naming the Bash "arrays". Only the authors of the language can answer it. However, we can guess. The name "array" gives you a hint of how to work with such a variable. When you have experience with another language, you know how to operate with a regular array. This way, you can start using Bash "arrays" immediately. You do not need to know how Bash stores these "arrays" internally.

#### Attributes

The Bash language does not have a type system. It stores all scalar variables in memory as strings. At the same time, Bash has arrays. They are composite types because an array is a combination of strings.

When you declare a variable in Bash, you should choose if it is scalar or composite. You make this choice by specifying metadata for the variable. Such metadata is called **attributes**. The attributes also define the constancy and scope of a variable.

The `declare` Bash built-in specifies the variable attributes. When you call it without parameters, `declare` prints all local and environment variables. The `set` command prints the same output.

The `declare` command has the `-p` option. The option adds variables attributes to the output data.

If you need information on a particular variable, pass its name to the `declare` command. Here is an example of the `PATH` variable:
{line-numbers: false, format: Bash}
```
declare -p PATH
```

The `declare` command also prints information about declared [**subroutines**](https://en.wikipedia.org/wiki/Subroutine). They are called **functions** in Bash. A function is a program fragment or an independent block of code that performs a certain task.

Suppose you are interested in function declarations but not in variables. Then apply the `-f` option of the `declare` command. It filters out variables from the output. Here is the `declare` call in this case:
{line-numbers: false, format: Bash}
```
declare -f
```

You can specify the function name right after the `-f` option. Then the `declare` command prints information about it. Here is an example of the function `quote`:
{line-numbers: false, format: Bash}
```
declare -f quote
```

This command displays the declaration of the `quote` function. The function takes a string on the input and encloses it in single quotes. If the string already contains the single quotes, the function escapes them. You can call `quote` in the same way as any Bash built-in. Here is an example:
{line-numbers: false, format: Bash}
```
quote "this is a 'test' string"
```

The `declare` call without the `-p` option does not print a function declaration. It means that the following command outputs nothing:
{line-numbers: false, format: Bash}
```
declare quote
```

We have learned how to get information about already declared variables and functions using `declare`. Now let's find out how this command sets attributes for new variables.

Table 3-7 shows the frequently used options of the `declare` command.

{caption: "Table 3-7. The `declare` command options and the corresponding variable attributes", width: "100%"}
| Option | Definition |
| --- | --- |
| `-a` | The declared variable is an indexed array. |
|  | |
| `-A` | The declared variable is an associative array. |
|  | |
| `-g` | It declares a variable in the global scope of the script. The variable does not come to the environment. |
|  | |
| `-i` | It declares an integer variable. When you assign it a value, Bash treats it as an arithmetic expression. |
|  | |
| `-r` | It declares a constant. The constant cannot change its value after declaration. |
|  | |
| `-x` | It declares an environment variable. |

Here are several examples of how to declare variables with attributes. First, let's compare integer and string variables. Execute the following two commands in the terminal window:
{line-numbers: true, format: Bash}
```
declare -i sum=11+2
text=11+2
```

We declared two variables named `sum` and `text`. The `sum` variable has the integer attribute. Therefore, its value equals 13 that is the sum of 11 and 2. The `text` variable is equal to the "11+2" string.

Bash stores both variables as strings in memory. The `-i` option does not specify the variable's type. Instead, it limits the allowed values of the variable.

Try to assign a string to the `sum` variable. You can do it in one of the following ways:
{line-numbers: true, format: Bash}
```
declare -i sum="test"
sum="test"
```

Each of these commands sets the `sum` value to zero. It happens because the variable has the integer attribute. Therefore, it cannot be equal to some string.

Suppose you have declared an integer variable. Then you do not need any Bash expansion for arithmetic operations on it. The following commands do correct calculations:
{line-numbers: true, format: Bash}
```
sum=sum+1       # 13 + 1 = 14
sum+=1          # 14 + 1 = 15
sum+=sum+1      # 15 + 15 + 1 = 31
```

Here the calculation results come after the hash symbol. Bash ignores everything after this symbol. Such lines are called [**comments**](https://en.wikipedia.org/wiki/Comment_(computer_programming)).

I> The usefulness of comments is the subject of endless debates in the programming community. They are needed to explain the code. However, some people consider that comments are a sign of incomprehensible, poorly written code. If you just started learning to program, comment your code without doubts. Explain the complex constructions in your scripts. Otherwise, you can forget what do they mean afterward.

Now execute the same commands with the string variable. You will get the following results:
{line-numbers: true, format: Bash}
```
text=text+1     # "text+1"
text+=1         # "text+1" + "1" = "text+11"
text+=text+1    # "text+11" + "text" + "1" = "text+11text+1"
```

Here Bash concatenates strings instead of doing arithmetic calculations. If you want to operate on integers instead, you should use the arithmetic expansion. Here is an example of this expansion:
{line-numbers: true, format: Bash}
```
text=11
text=$(($text + 2)) # 11 + 2 = 13
```

When you apply the `-r` option of the `declare` built-in, you get a constant. Such a call looks this way:
{line-numbers: false, format: Bash}
```
declare -r filename="README.txt"
```

Whenever you change or delete the value of the `filename` constant, Bash prints an error message. Therefore, both following commands fail:
{line-numbers: true, format: Bash}
```
filename="123.txt"
unset filename
```

I> Use the `unset` command for removing variables. This command cannot remove constants.

The `-x` option of the `declare` command declares an environment variable. It provides the same result as if you apply the `export` built-in in the variable declaration. Thus, the following two commands are equivalent:
{line-numbers: true, format: Bash}
```
export BROWSER_PATH="/opt/firefox/bin"
declare -x BROWSER_PATH="/opt/firefox/bin"
```

A good practice is to use the `export` command instead of `declare` with the `-x` option. This improves the code readability. You do not need to remember what the `-x` option means. For the same reason, you should prefer the `readonly` command instead of `declare` with the `-r` option. Both built-ins declare a constant, but `readonly` is easier to remember.

The `readonly` command declares a variable in the global scope of a script. The `declare` built-in with the `-r` option has another result. If you call it in a function body, you declare a local variable. It is not available outside the function. Use the `-g` option to get the same behavior as `readonly`. Here is an example:
{line-numbers: false, format: Bash}
```
declare -gr filename="README.txt"
```

#### Indexed Arrays

Bourne Shell has scalar variables only. The interpreter stores them as strings in memory. Working with such variables is inconvenient in some cases. Therefore, developers have added arrays to the Bash language. When do you need an array?

Strings have a serious limitation. When you write a value to the scalar variable, it is a single unit. For example, you save a list of filenames in the variable called `files`. You separate them by spaces. As a result, the `files` variable stores a single string from the Bash point of view. It can lead to errors.

The root cause of the problem came from the POSIX standard. It allows any characters in filenames except the null character (NULL). NULL means the end of a filename. The same character means the end of a string in Bash. Therefore, a string variable can contain NULL at the end only. It turns out that you have no reliable way to separate filenames in a string. You cannot use NULL, but any other delimiter character can occur in the names.

You cannot process results of the `ls` utility reliable because of the delimiter problem. The utility cannot use NULL as a separator for names of files and directories in its output. It leads to a recommendation to avoid parsing of the `ls` output. Another advice is to not use `ls` in variable declarations this way:
{line-numbers: false, format: Bash}
```
files=$(ls Documents/*.txt)
```

This declaration writes all TXT files of the `Documents` directory to the `files` variable. If there are spaces or line breaks in the filenames, you cannot separate them properly anymore.

Bash arrays solve the delimiter problem. An array stores a list of separate units. You can always read them in their original form. Therefore, use an array to store filenames instead of a string. Here is a better declaration of the `files` variable:
{line-numbers: false, format: Bash}
```
declare -a files=(Documents/*.txt)
```

This command declares and **initializes** the array named `files`. Initializing means assigning values to the array's elements. You can do that in the declaration or after it.

When you declare a variable, Bash can deduce if it is an array. This mechanism works when you skip the `declare` built-in. Bash adds the appropriate attribute automatically. Here is an example:
{line-numbers: false, format: Bash}
```
files=(Documents/*.txt)
```

This command declares the indexed array `files`.

Suppose that you know all array elements in advance. In this case, you can assign them explicitly in the declaration. It looks like this:
{line-numbers: false, format: Bash}
```
files=("/usr/share/doc/bash/README" "/usr/share/doc/flex/README.md" "/usr/share/doc/xz/README")
```

When assigning array elements, you can read them from other variables. Here is an example:
{line-numbers: true, format: Bash}
```
bash_doc="/usr/share/doc/bash/README"
flex_doc="/usr/share/doc/flex/README.md"
xz_doc="/usr/share/doc/xz/README"
files=("$bash_doc" "$flex_doc" "$xz_doc")
```

This command writes values of variables `bash_doc`, `flex_doc` and `xz_doc` to the `files` array. If you change these variables after this declaration, it does not affect the array.

When declaring an array, you can specify an index for each element explicitly. Do it this way:
{line-numbers: true, format: Bash}
```
bash_doc="/usr/share/doc/bash/README"
flex_doc="/usr/share/doc/flex/README.md"
xz_doc="/usr/share/doc/xz/README"
files=([0]="$bash_doc" [1]="$flex_doc" [5]="/usr/share/doc/xz/README")
```

Here there are no spaces before and after each equal sign. Remember this rule: when you declare any variable in Bash, you do not put spaces near the equal sign.

Instead of initializing the entire array at once, you can assign its elements separately. Here is an example:
{line-numbers: true, format: Bash}
```
files[0]="$bash_doc"
files[1]="$flex_doc"
files[5]="/usr/share/doc/xz/README
```

There are gaps in the array indexes in the last two examples. It is not a mistake. Bash allows arrays with such gaps. They are called **sparse arrays**.

Suppose that you have declared an array. Now there is a question of how to read its elements. The following parameter expansion prints all of them:
{line-numbers: false, format: Bash}
```
$ echo "${files[@]}"
/usr/share/doc/bash/README /usr/share/doc/flex/README.md /usr/share/doc/xz/README
```

You see the `echo` command at the first line. Its output comes on the next line.

It can be useful to print indexes of elements instead of their values. For doing that, add an exclamation mark in front of the array name in the parameter expansion. Here is an example:
{line-numbers: true, format: Bash}
```
$ echo "${!files[@]}"
0 1 5
```

You can calculate an element index using some formula. Specify the formula in square brackets when accessing the array. The following commands read and write the fifth element:
{line-numbers: true, format: Bash}
```
echo "${files[4+1]}"
files[4+1]="/usr/share/doc/xz/README
```

You can use variables in the formula. Bash accepts both integer and string variables there. Here is another way to access the fifth element of the array:
{line-numbers: true, format: Bash}
```
i=4
echo "${files[i+1]}"
files[i+1]="/usr/share/doc/xz/README
```

You can insert the sequential array elements at once. Specify the starting index, colon and the number of elements in the parameter expansion. Here is an example:
{line-numbers: true, format: Bash}
```
$ echo "${files[@]:1:2}"
/usr/share/doc/flex/README.md /usr/share/doc/xz/README
```

This `echo` call prints two elements, starting from the first. The elements' indexes are not important in this case. You get the filenames with indexes 1 and 5.

Starting with version 4, Bash provides the `readarray` built-in. It is also known as `mapfile`. The command reads the contents of a text file into an indexed array. Let's see how to use it.

Suppose you have the file named `names.txt`. It contains names of several persons:
{line-numbers: true, format: Bash}
```
Alice
Bob
Eve
Mallory
```

You want to create an array with strings of this file. The following command does that:
{line-numbers: false, format: Bash}
```
readarray -t names_array < names.txt
```

The command writes all lines of the `names.txt` file to the `names_array` array.

{caption: "Exercise 3-3. Declaration of arrays", format: text, line-numbers: false}
```
Try all the following variants of the array declarations:

1. Using the declare command.

2. Without the declare command.

3. The globbing mechanism provides values for array elements.

4. Specify all array elements in the declaration.

5. Specify the elements separately after the array declaration.

6. Assign the values of the existing variables to array elements.

7. Read the array elements from a text file.

Print the array contents using the echo command for each case.
```

We have learned how to declare and initialize indexed arrays. Here are some more examples of using them. Suppose the `files` array contains a list of filenames. You want to copy the first file in the list. The following `cp` call does that:
{line-numbers: false, format: Bash}
```
cp "${files[0]}" ~/Documents
```

W> Most programming languages number the elements of arrays and characters of strings from zero, but not from one. Bash follows this rule too.

When reading an array element, you always apply the full form of the parameter expansion with curly brackets. Put the index of the element in square brackets after the variable name.

When you put the @ symbol instead of the element's index, Bash inserts all array elements. Here is an example:
{line-numbers: false, format: Bash}
```
cp "${files[@]}" ~/Documents
```

You need to get an array size in some cases. Put the # character in front of its name. Then specify the @ symbol as the element index. For example, the following parameter expansion gives you the size of the `files` array:
{line-numbers: false, format: Bash}
```
echo "${#files[@]}"
```

When reading array elements, always apply double quotes. They prevent errors caused by word splitting.

Call the `unset` Bash built-in if you need to remove an array element. Here is an example of removing the fourth element:
{line-numbers: false, format: Bash}
```
unset 'files[3]'
```

You can suppose that this command has the wrong element index. The command is correct. Remember about numbering array elements from zero. Also, single quotes are mandatory here. They turn off all Bash expansions.

The `unset` command can clear the whole array if you call it this way:
{line-numbers: false, format: Bash}
```
unset files
```

#### Associative Arrays

We have considered indexed arrays. Their elements are strings. Each element has an index that is a positive integer. The indexed array gives you a string by its index.

The developers introduced associative arrays in the 4th version of Bash. These arrays use strings as element indexes instead of integers. This kind of string-index is called **key**. The associative array gives you a string-value by its string-index. When do you need this feature?

Here is an example. Suppose you need a script that stores the list of contacts. The script adds a person's name, email or phone number to the list. Let's omit the person's last name for simplicity. When you need these data back, the script prints them on the screen.

You can solve the task using the indexed array. This solution would be inefficient for searching for the required contact. The script should traverse over all array elements. It compares each element with the person's name that you are looking for. When the script finds the right person, it prints his contacts on the screen.

An associative array makes searching for contacts faster. The script should not pass through all array elements in this case. Instead, it gives the key to the array and gets the corresponding value back.

Here is an example of declaring and initializing the associative array with contacts:
{line-numbers: false, format: Bash}
```
declare -A contacts=(["Alice"]="alice@gmail.com" ["Bob"]="(697) 955-5984" ["Eve"]="(245) 317-0117" ["Mallory"]="mallory@hotmail.com")
```

There is only one way to declare an associative array. For doing that, you should use the `declare` command with the `-A` option. Bash cannot deduce the array type without it, even if you specify string-indexes. Therefore, the following command declares the indexed array:
{line-numbers: false, format: Bash}
```
contacts=(["Alice"]="alice@gmail.com" ["Bob"]="(697) 955-5984" ["Eve"]="(245) 317-0117" ["Mallory"]="mallory@hotmail.com")
```

Let's check of how this indexed array looks like. The following `declare` call prints it:
{line-numbers: true, format: Bash}
```
$ declare -p contacts
declare -a contacts='([0]="mallory@hotmail.com")'
```

You see the indexed array with one element. This result happened because Bash converts all string-indexes to zero value. Then every next contact in the initialization list overwrites the previous one. This way, the zero-index element contains contacts of the last person in the initialization list.

You can specify elements of an associative array separately. Here is an example:
{line-numbers: true, format: Bash}
```
declare -A contacts
contacts["Alice"]="alice@gmail.com"
contacts["Bob"]="(697) 955-5984"
contacts["Eve"]="(245) 317-0117"
contact["Mallory"]="mallory@hotmail.com"
```

Suppose that you have declared an associative array. Now you can access its elements by their keys. The key is the name of a person in our example. The following command reads the contacts by the person's name:
{line-numbers: true, format: Bash}
```
$ echo "${contacts["Bob"]}"
(697) 955-5984
```

If you put the @ symbol as the key, you get all elements of the array:
{line-numbers: true, format: Bash}
```
$ echo "${contacts[@]}"
(697) 955-5984 mallory@hotmail.com alice@gmail.com (245) 317-0117
```

If you add the exclamation mark before the array name, you get the list of all keys. It is the list of persons in our example:
{line-numbers: true, format: Bash}
```
$ echo "${!contacts[@]}"
Bob Mallory Alice Eve
```

Add the # character before the array name to get its size:
{line-numbers: true, format: Bash}
```
$ echo "${#contacts[@]}"
4
```

Let's apply the associative array to the contacts script. The script receives a person's name via the command-line parameter. Then it prints an email or phone number of that person.

Listing 3-10 shows the script for managing the contacts.

{caption: "Listing 3-10. The script for managing the contacts", line-numbers: true, format: Bash}
![`contacts.sh`](code/BashScripting/contacts.sh)

If you need to edit some person's data, you should open the script in a code editor and change the array initialization.

The `unset` Bash built-in deletes an associative array or its element. It works this way:
{line-numbers: true, format: Bash}
```
unset contacts
unset 'contacts[Bob]'
```

Bash can insert several elements of an associative array in the same way as it does for an indexed array. Here is an example:
{line-numbers: true, format: Bash}
```
$ echo "${contacts[@]:Bob:2}"
(697) 955-5984 mallory@hotmail.com
```

Here you get two elements printed:

* The one that corresponds to the `Bob` key.
* The next one in memory.

There is one problem with inserting several elements of an associative array. Their order in memory does not match their initialization order. The [**hash function**](https://en.wikipedia.org/wiki/Hash_function) calculates a numerical index in the memory of each element. The function takes a string-key on input and returns a unique integer on output. Because of this feature, inserting several elements of the associative array is a bad practice.
