## Variables and Parameters

Variables in Bash have already been mentioned several times in this book. We have learned the list of system paths in the `PATH` variable. We have used positional parameters in the backup script. It is time to get a good grasp on the topic.

First, let's find out what the term "variable" means in programming. The variable is an area of memory where some value is stored. In most cases, this is short-term memory (RAM, CPU cache and registers).

There was a generation of the first programming languages (for example [**assembler**](https://en.wikipedia.org/wiki/Assembly_language)). When using such a language, you should refer to a variable by its address. If you want to read or write its value, you have to specify its memory address.

Suppose you work on a computer with 32-bit processors. Then a memory address has a length of 4 bytes. It is the number from 0 to 4294967295. This number is twice larger for 64-bit processors. It is inconvenient to remember and operate with such big numbers. That is why modern programming languages allow you to replace a variable address with its name. This name is translated into memory address while compiling or interpreting the program. Thus, the compiler or interpreter takes care of "remembering" large numbers.

Why do we need variables? Our experience with `PATH` and position parameters has shown that variables store some data. It is needed for one of the following purposes:

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