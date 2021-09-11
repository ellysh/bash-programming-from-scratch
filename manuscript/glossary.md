# Glossary

## A

[**Abstraction**](https://en.wikipedia.org/wiki/Abstraction_(computer_science)) is a software module, application, or library that replicates the basic properties of some object. Abstractions help to manage the complexity of software systems. They hide irrelevant details. Abstractions allow the same algorithm to handle different objects.

[**Algorithm**](https://en.wikipedia.org/wiki/Algorithm) is a finite sequence of instructions that are understandable for the executor. The goal of an algorithm is to calculate something or solve a specific task.

[**Alias**](https://www.gnu.org/software/bash/manual/html_node/Aliases.html#Aliases) is a built-in Bash command for shortening long strings in the user input. You can apply this command when Bash works in the shell mode.

[**Application programming interface**](https://en.wikipedia.org/wiki/Application_programming_interface) (API) is a set of agreements on interaction components of the information system. The agreements answer the following questions:

* What function does the called component performs?
* What data does the function need on the input?
* What data does the function return on the output?

[**Argument**](http://linuxcommand.org/lc3_wss0120.php) is a word or string that the program receives via the command-line interface. Here is an example of two arguments for the `grep` utility:
{line-numbers: false, format: Bash}
```
grep "GNU" README.txt
```

[**Arithmetic expansion**](https://www.gnu.org/software/bash/manual/html_node/Arithmetic-Expansion.html#Arithmetic-Expansion) calculates an arithmetic expression and substitutes its result into the Bash command or statement. Here is an example of the expansion:
{line-numbers: false, format: Bash}
```
echo $((4+3))
```

[**Array**](https://en.wikipedia.org/wiki/Array_data_structure) is a data structure that consists of a set of elements. Their positions are defined by the sequence numbers or indexes. The array elements are placed one after another in computer memory.

[**ASCII**](https://en.wikipedia.org/wiki/ASCII) is an eight-bit character encoding standard. It includes the following characters:

* Decimal digits
* Latin alphabet
* National alphabet
* Punctuation marks
* Control characters

[**Asynchrony**](https://en.wikipedia.org/wiki/Asynchrony_(computer_programming)) means events that occur independently of the main program flow. Asynchrony also means the methods for processing such events.

## B

[**Background**](https://www.gnu.org/software/bash/manual/html_node/Job-Control-Basics.html#Job-Control-Basics) is a mode of Bash for process execution. When you apply this mode, the process identifier does not belong to the [identifier group](https://en.wikipedia.org/wiki/Process_group) of the terminal. Also, the executed process does not handle keyboard interrupts in the terminal window.

[**Bash**](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) (Bourne again shell) is a command-line interpreter developed by Brian Fox. Bash has replaced the Bourne shell in Linux distributions and some proprietary Unix systems. Bash is compatible with the POSIX standard. However, the standard does not include some features of the interpreter.

[**Bash script**](https://www.gnu.org/software/bash/manual/html_node/Shell-Scripts.html#Shell-Scripts) is a text file that contains commands for the interpreter. Bash executes scripts in the non-interactive mode.

[**Best practices**](http://mywiki.wooledge.org/BashGuide/Practices) are recommended approaches for using a programming language or technology. An example of best practice for Bash is enclosing strings in double quotes to avoid word splitting.

[**Bottleneck**](https://en.wikipedia.org/wiki/Bottleneck_(software)) is a component or resource of a computer system that limits its performance.

[**Boolean expression**](https://en.wikipedia.org/wiki/Boolean_expression) is a programming language construct. When calculated, It results in either the "true" or "false" value.

[**Bourne shell**](https://en.wikipedia.org/wiki/Bourne_shell) is a command-line interpreter developed by Stephen Bourne. It replaced the original [Ken Thompson's interpreter](https://en.wikipedia.org/wiki/Thompson_shell) in [Unix version 7](https://en.wikipedia.org/wiki/Version_7_Unix). The [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html) contains all features of the Bourne shell. However, the shell misses some features from the standard.

[**Brace expansion**](http://mywiki.wooledge.org/BraceExpansion) is a Bash mechanism for generating words from given parts. The POSIX standard misses this mechanism.
Here is an example of the brace expansion:
{line-numbers: false, format: Bash}
```
cp test.{txt,md,log} Documents
```
Bash generates the following command from it:
{line-numbers: false, format: Bash}
```
cp test.txt test.md test.log Documents
```

[**Builtin commands**](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html) are the built-in commands that the interpreter executes by itself. It does not call utilities or programs for that. An example is `pwd`.

## C

[**Child process**](https://en.wikipedia.org/wiki/Child_process) is a process spawned by another process called the parent.

[**Code base**](https://en.wikipedia.org/wiki/Codebase) is a collection of source code used to build a software system or application. It does not contain generated code by tools.

[**Code style**](https://en.wikipedia.org/wiki/Programming_style) is a set of rules and conventions for writing the program source code. These rules help several programmers write, read, and manage their code base.

**Command** is the text entered after the command prompt. This text defines the action that the interpreter should perform. If the interpreter cannot do the specified action, it can call another application for that.

[**Command-line parameter**](https://stackoverflow.com/a/36495940/6562278) is a type of command argument that passes information to the program. The parameter can also be a part of some option. For example, it specifies the program working mode.
Here is the `find` utility call with two parameters:
{line-numbers: false, format: Bash}
```
find ~/Documents -name README
```
The first parameter `~/Documents` specifies the path where the search starts. The second parameter `README` refers to the option `-name`. It specifies the file or directory name for searching.

[**Command prompt**](https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html#Controlling-the-Prompt) is a sequence of characters. The shell prints a prompt when it is ready to process a user command.

[**Command substitution**](https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html#Command-Substitution) is the Bash mechanism that replaces a command call to its output. The subshell executes the command call.
Here is an example of the command substitution:
{line-numbers: false, format: Bash}
```
echo "$(date)"
```

[**Compiler**](https://en.wikipedia.org/wiki/Compiler) is a program for translating source code from some programming language to machine code.

[**Computer program**](https://en.wikipedia.org/wiki/Computer_program) is a set of instructions that a computer can execute. Each program solves a specific applied task.

[**Conditional statement**](https://en.wikipedia.org/wiki/Conditional_(computer_programming)) is a construct of a programming language. This statement chooses a block of commands to execute depending on the result of the Boolean expression.

[**Control character**](https://en.wikipedia.org/wiki/Control_character) is a separate character in the escape sequence.

[**Control flow**](https://en.wikipedia.org/wiki/Control_flow) is an order in which the program executes its instructions and functions.

## E

[**Endianness**](https://en.wikipedia.org/wiki/Endianness) is the byte order that the computer uses to store numbers in memory. The CPU defines the supported endianness. There are two commonly used byte orders: big-endian and little-endian. Some CPUs support both (bi-endian).
Here is an example of representing the four-byte number 0x0A0B0C0D in different byte orders:
{line-numbers: false, format: Bash}
```
0A 0B 0C 0D     big-endian
0D 0C 0B 0A     little-endian
```

[**Environment variables**](http://mywiki.wooledge.org/Environment) is an unordered set of variables that the child process copies from the parent one. The `env` utility can set environment variables when a program starts. If you call the utility without parameters, it prints all variables declared in the current shell.

[**Error-prone**](https://en.wiktionary.org/wiki/error-prone) (error-prone) means failed programming techniques and solutions. These solutions work correctly in particular cases. However, they cause errors with specific input data or conditions.
An example of an error-prone solution is handling the `ls` utility output in the pipeline like this:
{line-numbers: false, format: Bash}
```
ls | grep "test"
```

[**Escape sequence**](https://en.wikipedia.org/wiki/Escape_sequence) is a set of characters that have no meaning of their own. Instead, they control the output device. For example, the line break character `\n` commands the output device to start a new line.

[**Exit code**](https://www.gnu.org/software/bash/manual/html_node/Exit-Status.html#Exit-Status) (or exit status) is an integer value from 0 to 255 that the shell command returns when finishing. The zero status means successful execution of the command. All other codes indicate an error.

## F

[**File descriptor**](https://en.wikipedia.org/wiki/File_descriptor) is an abstract pointer to some file or communication channel (stream, pipeline or network socket). Descriptors are part of the POSIX interface. Non-negative integers represent them.

[**Filename expansion**](https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html#Filename-Expansion) is a Bash mechanism that replaces patterns with filenames. A pattern can contain the following wildcards: ?, *, [.
Here is an example of using the filename expansion:
{line-numbers: false, format: Bash}
```
rm -rf *
```

[**Filename extension**](https://en.wikipedia.org/wiki/Filename_extension) is a suffix of the filename. The extension defines a file type.

[**File system**](https://en.wikipedia.org/wiki/File_system) is a set of rules to store and read data from a storage device. Also, a file system means a component of OS to manage storage devices.

[**Foreground**](https://www.gnu.org/software/bash/manual/html_node/Job-Control-Basics.html#Job-Control-Basics) is a default process execution mode in Bash. When you apply it, the process identifier belongs to the [identifier group](https://en.wikipedia.org/wiki/Process_group) of the terminal. The executed process handles keyboard interrupts in the terminal window.

**Function** is a modern name for a subroutine.

## G

[**General-purpose programming language**](https://en.wikipedia.org/wiki/General-purpose_programming_language) is a language that you can use to develop applications for various applied domains. It does not contain constructs that are useful in one domain and useless in others.

[**Globbing**](https://mywiki.wooledge.org/glob?action=show&redirect=globbing) or glob is another name for the filename expansion mechanism of Bash.

[**Glob pattern**](https://en.wikipedia.org/wiki/Glob_(programming)) is a search query. It includes regular and [wildcard characters](https://en.wikipedia.org/wiki/Wildcard_character) (* and ?). The wildcards correspond to any characters.
For example, the "R*M?" pattern matches strings that begin with R and whose penultimate letter is M.

## H

[**Hash function**](https://en.wikipedia.org/wiki/Hash_function) generates a unique sequence of bytes from the input data.

[**Hash table**]([hash table](https://en.wikipedia.org/wiki/Hash_table) is a data structure. Its elements are key-value pairs. A hash table maps keys to values. The role of keys resembles the indexes of elements in an array. A [hash function](https://en.wikipedia.org/wiki/Hash_function) calculates the keys for added elements.

## I

[**Idiom**](https://en.wikipedia.org/wiki/Programming_idiom) is a way to express some statement using a specific programming language. An idiom can be a template for implementing an algorithm or data structure.
Here is the Bash idiom for using patterns when processing files in the `for` loop:
{line-numbers: true, format: Bash}
```
for file in ./*.txt
do
  cp "$file" ~/Documents
done
```

[**Input field separator**](https://mywiki.wooledge.org/IFS) (IFS) is a list of characters. Bash uses them as separators when processing input strings. For example, it uses them for word splitting. The default separators are space, tab and a line break.

[**Interpreter**](https://en.wikipedia.org/wiki/Interpreter_(computing)) is a program that executes instructions. They are written in a programming language. The interpreter allows you to execute them without compilation.

[**Iteration**](https://en.wikipedia.org/wiki/Iteration#Computing) is a single execution of a command block in the loop body.

## L

[**Library**](https://en.wikipedia.org/wiki/Library_(computing)) is a collection of subroutines and data structures assembled into a standalone module. Applications use libraries as building blocks.

[**Linked list**](https://en.wikipedia.org/wiki/Linked_list) is a data structure that consists of elements called nodes. Their positions in the list do not match their placement in memory. Therefore, each node has a pointer to the next one. Such list organization makes insertion and deletion operations effective.

[**Linux distribution**](https://en.wikipedia.org/wiki/Linux_distribution) is an operating system based on the Linux kernel and the [GNU packages](https://en.wikipedia.org/wiki/List_of_GNU_packages). Such an OS is assembled from open-source programs and libraries.

**Linux environment** is another name for a POSIX environment.

[**Literal**](https://en.wikipedia.org/wiki/Literal_(computer_programming)) is a notation for some fixed value in the source code of a program. There are different ways to write literals depending on their data types. Most programming languages support literals for integers, [floating point numbers](https://en.wikipedia.org/wiki/Floating-point_arithmetic) and strings.
Here is an example of the string literal `~/Documents` in Bash:
{line-numbers: true, format: Bash}
```
var="~/Documents"
```

[**Logical operator**](https://en.wikipedia.org/wiki/Logical_connective) is an operation on one or more Boolean expressions. The operation can combine them into a single expression.

## M

[**Multiprogramming**](https://www.geeksforgeeks.org/difference-between-multitasking-multithreading-and-multiprocessing) is a technique for distributing computer resources among several programs. 
For example, a program runs until it needs some busy resource. Then OS switches to another program. It comes back to the first program when the required resource becomes free.

[**Multitasking**](https://en.wikipedia.org/wiki/Computer_multitasking) is the execution of several tasks (processes) in parallel. The OS does it by [switching](https://en.wikipedia.org/wiki/Context_switch) between tasks frequently and executing them in parts.

## N

[**Network protocol**](https://en.wikipedia.org/wiki/Communication_protocol) agrees on the format of messages between nodes of a computer network.

## O

[**Operand**](https://en.wikipedia.org/wiki/Operand) is an argument of some operation or command. It represents the data to be processed.
Here is an example of operands 1 and 4 for the addition operation:
{line-numbers: false, format: Bash}
```
1 + 4
```

[**Option**](http://linuxcommand.org/lc3_wss0120.php) is an argument in a standardized form, which the program receives as input. Options of GNU utilities begin with a dash `-` or a double dash `--`.  Each option sets a specific mode of the program. You can combine successive options into one group.
Here is an example of grouping the `-l`, `-a` and `-h` options of the `ls` utility:
{line-numbers: false, format: Bash}
```
ls -lah
```

## P

[**Parameter**](http://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Parameters) is an entity that transfers some value from one part of the system to another. A parameter may have no name, unlike a variable.

[**Parameter expansion**](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html#Shell-Parameter-Expansion) is the Bash mechanism that replaces a variable name with its value.
Here are two examples of the parameter expansion:
{line-numbers: false, format: Bash}
```
echo "$PATH"
echo "${var:-empty}"
```

[**Pipeline**](https://en.wikipedia.org/wiki/Pipeline_(Unix)) is a process communication mechanism of Unix-like operating systems. The mechanism is based on passing messages. Also, the pipeline means two or more processes with connected input and output streams. OS sends the output stream of one process directly to the input stream of another.

[**Portable operating system interface**](https://en.wikipedia.org/wiki/POSIX) (POSIX) is a set of standards. They describe the API of a portable OS, its shell and the utility interfaces. POSIX guarantees compatibility of OSes from the Unix family. This compatibility allows you to move programs between systems with minimal efforts.

[**Positional parameters**](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameters.html#Shell-Parameters) contain all command-line arguments that the Bash script receives as input. Parameter names match the order of arguments.
Here is an example of using the first positional parameter in a script:
{line-numbers: false, format: Bash}
```
cp "$1" ~
```

**POSIX environment** is a software environment that is compatible with the POSIX standard. The full compatibility is available only when the OS kernel, shell and file system follow POSIX. Environments like [Cygwin](https://en.wikipedia.org/wiki/Cygwin) provide partial compatibility.

[**POSIX shell**](https://www.grymoire.com/Unix/Sh.html) is a standard for POSIX systems that describes a minimum set of shell features. If the shell provides these features, it is considered POSIX compatible. The standard does not restrict additional features and extensions. The standard is based on the ksh88 implementation of the [Korn shell](https://en.wikipedia.org/wiki/KornShell). This interpreter appeared later than the Bourne shell. Therefore, the Bourne shell misses some features of the POSIX standard.

[**Process**](https://en.wikipedia.org/wiki/Process_(computing)) is an instance of a computer program that the CPU executes.

[**Process substitution**](https://www.gnu.org/software/bash/manual/html_node/Process-Substitution.html#Process-Substitution) is the Bash mechanism that resembles command substitution. It executes the command and provides its output to the Bash process. The mechanism transfers data via temporary files.
Here is an example of using process substitution:
{line-numbers: false, format: Bash}
```
diff <(sort file1.txt) <(sort file2.txt)
```

[**Programming paradigm**](https://en.wikipedia.org/wiki/Programming_paradigm) is a set of ideas, methods and principles that dictate how to write programs.

## Q

[**Quote removal**](https://www.gnu.org/software/bash/manual/html_node/Quote-Removal.html#Quote-Removal) is the Bash mechanism that removes the following three unescaped characters from the strings: \ ' ".

## R

[**Recursion**](https://en.wikipedia.org/wiki/Recursion_(computer_science)) is a case when some function calls itself. This case is called the direct recursion. The indirect recursion happens when the function calls itself through other functions.

[**Redirections**](https://www.gnu.org/software/bash/manual/html_node/Redirections.html#Redirections) are the special shell constructs that redirect I/O streams of executed commands. You should specify file descriptors as the source and target for a redirection. A descriptor can point to a file or standard stream.
Here is an example of redirecting the `find` utility output to the `result.txt` file:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 1> result.txt
```

**Reserved variables** mean the same as shell variables.

## S

[**Scope**](https://en.wikipedia.org/wiki/Scope_(computer_science)) is a part of a program or system where the variable name and value remain associated with each other. In other words, the program can convert the variable name into the memory address inside the scope. This conversion does not work outside the scope.

[**Shebang**](https://en.wikipedia.org/wiki/Shebang_(Unix)) is a sequence of a number sign and exclamation mark (#!) at the beginning of the script. The program loader treats the string after shebang as the interpreter name. The loader launches the interpreter and passes the script to it for execution.
Here is an example of shebang for the Bash script:
{line-numbers: true, format: Bash}
```
#!/bin/bash
```

[**Shell options**](https://www.tldp.org/LDP/abs/html/options.html) change the interpreter behavior. They affect both shell and script modes. The built-in `set` command sets these options.
For example, here is the command to enable the debug output from the interpreter:
{line-numbers: false, format: Bash}
```
set -x
```

[**Shell parameter**](http://mywiki.wooledge.org/BashGuide/Parameters) is a named area of the shell memory for storing data.

[**Shell variables**](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html) are set by the shell (for example, `PATH`). They store temporary data, settings and states of the OS or Unix environment. A user can read these variables. Only some of them are writable.  The `set` command prints all shell variables.

[**Short-circuit evaluation**](https://en.wikipedia.org/wiki/Short-circuit_evaluation) (short-circuit) is the approach to limit calculations when deducing Boolean expression. The idea is to calculate only those operands that are sufficient to deduce the whole expression.

[**Special parameters**](http://mywiki.wooledge.org/BashGuide/Parameters) are set by the shell. They perform the following tasks:

1. Store the shell state.
2. Pass parameters to the called program.
3. Store the exit status of the finished program.

Special parameters are read-only. An example of such a parameter is `$?`.

[**Standard streams**](https://en.wikipedia.org/wiki/Standard_streams) are software channels of communication between a program and the environment where it operates. Streams are abstractions of physical channels of input from the keyboard and output to the screen. You can operate the channels via their descriptors. OS assigns these descriptors.

[**Subroutine**](https://en.wikipedia.org/wiki/Subroutine) is a fragment of a program that performs a single task. This fragment is an independent code block. It can be called from any place of the program.

[**Subshell**](http://mywiki.wooledge.org/SubShell) is a way of grouping shell commands. A child process executes the grouped commands. Variables defined in the child process are not available in the parent process.
Here is an example of executing commands in a subshell:
{line-numbers: false, format: Bash}
```
(ps aux | grep "bash")
```

[**Symbolic link**](https://en.wikipedia.org/wiki/Symbolic_link) is a special type of file. Instead of data, it contains a pointer to another file or directory.

[**Synchronous**](https://en.wiktionary.org/wiki/synchronous) means events or actions that occur in the main program flow.

## T

[**Tilde expansion**](https://www.gnu.org/software/bash/manual/html_node/Tilde-Expansion.html#Tilde-Expansion) (tilde expansion) is the Bash mechanism that replaces the ~ character with the user home directory. The shell takes the path to this directory from the `HOME` variable.

[**Time-sharing**](https://en.wikipedia.org/wiki/Time-sharing) is a computer mode when several users utilize its resources simultaneously. This mode is based on multitasking and multiprogramming.

## U

[**Unix environment**](https://ccrma.stanford.edu/guides/planetccrma/Unix.html) is another name for the POSIX environment.

[**Utility software**](https://en.wikipedia.org/wiki/Utility_software) is a special program for managing the OS or hardware.

## V

[**Variable**](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameters.html#Shell-Parameters) is an area of memory that can be accessed by its name.
There is another meaning of this term for Bash. A variable is a parameter that is accessible by its name. The user or the interpreter defines variables.
Here is an example of the variable declaration:
{line-numbers: false, format: Bash}
```
filename="README.txt"
```

[**Vulnerability**](https://en.wikipedia.org/wiki/Vulnerability_(computing)) is a bug or flaw of the computing system. An attacker can perform unauthorized actions using the vulnerability.

## W

[**Word splitting**](https://www.gnu.org/software/bash/manual/html_node/Word-Splitting.html#Word-Splitting) is the Bash mechanism that splits command-line arguments into words. Then Bash passes these words to the command as separate parameters. The mechanism uses the characters from the `IFS` variable as delimiters. It skips arguments that are enclosed in quotes.
Here is an example of a command where word splitting takes place:
{line-numbers: false, format: Bash}
```
cp file1.txt file2.txt "my file.txt" ~
```
