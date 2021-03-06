# Glossary

## A

[**Abstraction**](https://en.wikipedia.org/wiki/Abstraction_(computer_science)) is a software module, application, or library that replicates the basic properties of a real object. Abstractions help manage the complexity of software systems. They hide irrelevant details. Abstractions allow the same algorithm to handle different objects.

[**Algorithm**](https://en.wikipedia.org/wiki/Algorithm) is a finite sequence of instructions understandable to the executor. The goal of an algorithm is to calculate something or solve a task.

[**Alias**](https://www.gnu.org/software/bash/manual/html_node/Aliases.html#Aliases) is a built-in Bash command for shortening long strings. It is used when the interpreter works in shell mode.

[**Application programming interface**](https://en.wikipedia.org/wiki/Application_programming_interface) (API) is a set of agreements on interaction components of the information system. The agreements answer the following questions:

* What function the called component performs?
* What data does the function need on the input?
* What data does the function return on the output?

[**Argument**](http://linuxcommand.org/lc3_wss0120.php) is a word or string that the program receives via the command-line interface. Here is an example of arguments for the `grep` utility:
{line-numbers: false, format: Bash}
```
grep "GNU" README.txt
```

[**Arithmetic Expansion**](https://www.gnu.org/software/bash/manual/html_node/Arithmetic-Expansion.html#Arithmetic-Expansion) calculates an arithmetic expression and substitutes its result into the Bash command or statement. Here is an example of the expansion:
{line-numbers: false, format: Bash}
```
echo $((4+3))
```

[**Array**](https://en.wikipedia.org/wiki/Array_data_structure) is a data structure consisting of a set of elements. The sequence number or index determines the position of each element. The array elements are placed one by one in computer memory.

[**ASCII**](https://en.wikipedia.org/wiki/ASCII) is an eight-bit character encoding standard. It includes the following characters:

* decimal digits
* Latin alphabet
* national alphabet
* punctuation marks
* control characters

[**Asynchrony**](https://en.wikipedia.org/wiki/Asynchrony_(computer_programming)) means events that occur independently of the main program flow. Asynchrony also refers to methods for processing such events.


## B

[**Background**](https://www.gnu.org/software/bash/manual/html_node/Job-Control-Basics.html#Job-Control-Basics) is a process execution mode in Bash. When activated, the process identifier does not belong to the [identifier group](https://en.wikipedia.org/wiki/Process_group) of the terminal. Also, the executed process does not handle keyboard interrupts.

[**Bash**](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) (Bourne again shell) is a command-line interpreter developed by Brian Fox. Bash has replaced the Bourne shell in Linux distributions and some proprietary Unix systems. Bash is compatible with the POSIX standard. However, the standard does not include some of the interpreter's features.

[**Bash script**](https://www.gnu.org/software/bash/manual/html_node/Shell-Scripts.html#Shell-Scripts) is a text file containing interpreter commands. Bash executes scripts in non-interactive mode.

[**Best Practices**](http://mywiki.wooledge.org/BashGuide/Practices) are recommended approaches for using a programming language or technology. An example of best practice for Bash is enclosing strings in double quotes to avoid word splitting.

[**Bottleneck**](https://en.wikipedia.org/wiki/Bottleneck_(software)) is a component or resource of a computer system that limits its performance or throughput.

[**Boolean expression**](https://en.wikipedia.org/wiki/Boolean_expression) is a programming language construct. When calculated, It results in either the "true" or "false" value.

[**Bourne shell**](https://en.wikipedia.org/wiki/Bourne_shell) is a command-line interpreter developed by Stephen Bourne. It replaced the original [Ken Thompson's interpreter](https://en.wikipedia.org/wiki/Thompson_shell) in [Unix version 7](https://en.wikipedia.org/wiki/Version_7_Unix). The [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html) contains all features of the Bourne shell. But the shell misses some features from the standard.

[**Brace Expansion**](http://mywiki.wooledge.org/BraceExpansion) is a Bash mechanism for generating words from given parts. The POSIX standard misses this mechanism.
Here is an example of the brace expansion:
{line-numbers: false, format: Bash}
```
cp test.{txt,md,log} Documents
```
It generates the following command:
{line-numbers: false, format: Bash}
```
cp test.txt test.md test.log Documents
```

[**Builtin commands**](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html) are the commands that the interpreter executes by itself. It does not call utilities or programs for that. An example is the `pwd` built-in command.

## C

[**Child process**](https://en.wikipedia.org/wiki/Child_process) a process spawned by another process called the parent.

**Command** is the text entered after the command prompt. This text matches the action that the interpreter performs on its own or with another application's help.

[**Command-line parameter**](https://stackoverflow.com/a/36495940/6562278) is a type of the command's argument. It passes information to the program. The parameter can also be a part of some option. For example, it specifies the selected mode of the program's operation.
Here is the `find` utility call:
{line-numbers: false, format: Bash}
```
find ~/Documents -name README
```
The first parameter `~/Documents` specifies the path to start the search. The second parameter `README` refers to the option `-name`. It specifies the file or directory name for searching.

[**Command prompt**](https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html#Controlling-the-Prompt) is a sequence of characters. The shell prints a prompt when it is ready to process the user's command.

[**Compiler**](https://en.wikipedia.org/wiki/Compiler) is a program for translating source code from a programming language to the machine code.

[**Computer program**](https://en.wikipedia.org/wiki/Computer_program) is a set of instructions that a computer can execute. Each program solves an applied task.

[**Conditional statement**](https://en.wikipedia.org/wiki/Conditional_(computer_programming)) is a construct of a programming language. It executes a block of commands depending on the result of the Boolean expression.

[**Control character**](https://en.wikipedia.org/wiki/Control_character) is a separate character in the control sequence.

[**Control flow**](https://en.wikipedia.org/wiki/Control_flow) is the order in which the program executes its instructions and functions.

## D

## E

[**Environment variables**](http://mywiki.wooledge.org/Environment) is an unordered set of variables that the child process copies from the parent one. The `env` utility changes environment variables at the program startup. If you call the utility without parameters, it prints all variables declared in the current shell.

[**Escape sequence**](https://en.wikipedia.org/wiki/Escape_sequence) is a set of characters that have no meaning of their own. Instead, they control the output device. For example, the line break character `\n` commands the output device to start a new line.

## F

[**File descriptor**](https://en.wikipedia.org/wiki/File_descriptor) is an abstract pointer to a file or communication channel (stream, pipeline or network socket). Descriptors are part of the POSIX interface. They are non-negative integers.

[**Filename extension**](https://en.wikipedia.org/wiki/Filename_extension) is a suffix of the filename. The extension defines the type of file.

[**File system**](https://en.wikipedia.org/wiki/File_system) is a set of rules to store and read data from storage media.

**Function** is another name for a subroutine.

## G

[**General-purpose programming language**](https://en.wikipedia.org/wiki/General-purpose_programming_language) is a language that you can use to develop applications for various applied domains. It does not contain constructs that are useful in one domain and useless in others.

[**Glob pattern**](https://en.wikipedia.org/wiki/Glob_(programming)) is a search query. It includes regular and [wildcard characters](https://en.wikipedia.org/wiki/Wildcard_character) (* and ?). The wildcards correspond to any characters. For example, the "R*M?" pattern matches strings that begin with R and whose penultimate letter is M.

## H

[**Hash function**](https://en.wikipedia.org/wiki/Hash_function) generates a unique sequence of bytes from the input data.

[**Hash table**]([hash table](https://en.wikipedia.org/wiki/Hash_table) is a data structure. Each element is a key-value pair. A hash table maps keys to values. The role of keys resembles the indexes of elements in an array. A [hash function](https://en.wikipedia.org/wiki/Hash_function) calculates the keys for added elements.

## I

[**Idiom**](https://en.wikipedia.org/wiki/Programming_idiom) is a way to express a typical construct using a specific programming language. An idiom is a template for implementing an algorithm or data structure. Here is the Bash idiom for processing a list of files in the `for` loop:
{line-numbers: true, format: Bash}
```
for file in ./*.txt
do
  cp "$file" ~/Documents
done
```

[**Interpreter**](https://en.wikipedia.org/wiki/Interpreter_(computing) is a program that executes instructions. Instructions are written in a programming language. You do not need the compilation step for executing them.

[**Iteration**](https://en.wikipedia.org/wiki/Iteration#Computing) is a single execution of a commands block in the loop's body.

## K

## L

[**Library**](https://en.wikipedia.org/wiki/Library_(computing)) is a collection of subroutines and objects assembled into a standalone module or file. Applications use libraries as building blocks.

[**Linked list**](https://en.wikipedia.org/wiki/Linked_list) is a data structure consisting of elements or nodes. Their positions in the list do not match their placement in memory. Therefore, each node has a pointer to the next node. Such an organization of the list leads to efficient insertion and deletion operations.

[**Linux distribution**](https://en.wikipedia.org/wiki/Linux_distribution) is an operating system based on the Linux kernel and the [GNU packages](https://en.wikipedia.org/wiki/List_of_GNU_packages). The OS is combined from packages of ready-to-run programs and libraries. There is a package manager application for operating them.

[**Literal**](https://en.wikipedia.org/wiki/Literal_(computer_programming)) is a notation in the source code of the program. It represents a fixed value. There are different ways to write literals depending on the data type. Most programming languages support literals for integers, [floating point numbers](https://en.wikipedia.org/wiki/Floating-point_arithmetic) and strings. Here is an example of the string literal `~/Documents` in Bash:
{line-numbers: true, format: Bash}
```
var="~/Documents"
```

[**Logical operator**](https://en.wikipedia.org/wiki/Logical_connective) is an operation on one or more Boolean expressions. The operation can combine them into a single expression. Its calculation result depends on the values of the original expressions.

## M

[**Multiprogramming**](https://www.geeksforgeeks.org/difference-between-multitasking-multithreading-and-multiprocessing) is distributing the computer's workload among several programs. For example, the computer runs a program until it needs some resource. If the resource is busy, the program stops. The computer switches to another program. It returns to running the first program when the resource it needs becomes free.

[**Multitasking**](https://en.wikipedia.org/wiki/Computer_multitasking) is the parallel execution of several tasks (processes) in a certain period of time. The computer does it by [switching](https://en.wikipedia.org/wiki/Context_switch) between tasks and executing them in parts.

## N

[**Network protocol**](https://en.wikipedia.org/wiki/Communication_protocol) is an agreement on the format of messages between nodes of a computer network.

## O

[**Operand**](https://en.wikipedia.org/wiki/Operand) is an argument of a mathematical operation or command. It represents the data to be processed. Here is an example of operands 1 and 4 in the addition operation:
{line-numbers: false, format: Bash}
```
1 + 4
```

[**Option**](http://linuxcommand.org/lc3_wss0120.php) is an argument in a standardized form, which the program receives on input. The option begins with a dash `-` or a double dash `--`.  It switches the mode of the program's operation. You can combine successive options into one group. Here is an example of grouping the `-l`, `-a` and `-h` options of the `ls` utility:
{line-numbers: false, format: Bash}
```
ls -lah
```

## P

[**Parameter**](http://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Parameters) is an entity that stores some value. A parameter may have no name, unlike a variable.

[**Pipeline**](https://en.wikipedia.org/wiki/Pipeline_(Unix)) is a mechanism for process communication in Unix-like operating systems. The mechanism is based on passing messages. A pipeline is also two or more processes with connected input and output streams. The output stream of one process is sent directly to the other's input stream.

[**Positional parameters**](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameters.html#Shell-Parameters) contain all command-line arguments that the Bash script receives on calling. Parameter names match the order of arguments. Here is an example of using the first positional parameter in a script:
{line-numbers: false, format: Bash}
```
cp "$1" ~
```

[**Process**](https://en.wikipedia.org/wiki/Process_(computing)) is an instance of a computer program that is being executed by the CPU.

[**Programming paradigm**](https://en.wikipedia.org/wiki/Programming_paradigm) a set of ideas, methods and principles that define how to write programs.

## R

[**Recursion**](https://en.wikipedia.org/wiki/Recursion_(computer_science)) is a case when the function calls itself. This is the direct recursion. The indirect recursion happens when the function calls itself through other functions.

[**Redirections**](https://www.gnu.org/software/bash/manual/html_node/Redirections.html#Redirections) are the special Bash and Bourne shell language constructs that redirect I/O streams of built-in commands, utilities and applications. You should specify file descriptors as the source and target of the redirection. The descriptors point to files or standard streams. Here is an example of redirecting the `find` utility output to the `result.txt` file:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 1> result.txt
```

**Reserved variables** are the same as shell variables.

## S

[**Scope**](https://en.wikipedia.org/wiki/Scope_(computer_science)) is a part of a program or system where the variable's name remains associated with its value. In other words, the variable name is correctly converted to the memory address where its value is stored. Outside the scope, the same name can point to another memory location.

[**Shebang**](https://en.wikipedia.org/wiki/Shebang_(Unix)) is a sequence of a number sign and exclamation mark (#!) at the beginning of the script. The program loader treats the string after shebang as the interpreter's name. The loader launches the interpreter and passes the script to it for execution. Here is an example of shebang for the Bash script:
{line-numbers: true, format: Bash}
```
#!/bin/bash
```

[**Shell options**](https://www.tldp.org/LDP/abs/html/options.html) change the behavior of the interpreter when it works in both shell and script modes. The built-in `set` command sets the options. For example, here is the command to enable the debug output of the interpreter:
{line-numbers: false, format: Bash}
```
set -x
```

[**Shell parameter**](http://mywiki.wooledge.org/BashGuide/Parameters) is a named area of the shell's memory for storing data.

[**Shell variables**](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html) are variables that the shell sets (for example, `PATH`). They store temporary data, settings and states of the OS or Unix environment. The user can read the values of these variables. Only some of them are writable.  The `set` command prints values of the shell variables.

[**Special parameters**](http://mywiki.wooledge.org/BashGuide/Parameters) are set by the interpreter. They perform the following tasks:

1. Store the interpreter's state.
2. Pass parameters to the called program.
3. Store the exit status of the finished program.

Special parameters are read-only. An example of such a parameter is `$?`.

[**Standard streams**](https://en.wikipedia.org/wiki/Standard_streams) are the software channels of communication between the program and the environment where it operates. Streams are abstractions of physical channels of input from the keyboard and output to the screen. You can operate channels via their descriptors. OS assigns these descriptors.

[**Subroutine**](https://en.wikipedia.org/wiki/Subroutine) is a fragment of a program that performs a single task. The fragment is an independent code block. It can be called from any place in the program.

[**Symbolic link**](https://en.wikipedia.org/wiki/Symbolic_link) is a special type of file. Instead of data, it contains a pointer to another file or directory.

[**Synchronous**](https://en.wiktionary.org/wiki/synchronous) means events or actions that occur in the main program flow.

## T

[**Time-sharing**](https://en.wikipedia.org/wiki/Time-sharing) is the approach when several users utilize computer resources simultaneously. It is achieved by multitasking and multiprogramming.

## U

[**Utility software**](https://en.wikipedia.org/wiki/Utility_software) is a special program for managing the OS or hardware.

## V

[**Variable**](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameters.html#Shell-Parameters) is an area of memory that can be accessed by its name.
There is another meaning of this term for Bash. A variable is a parameter that is accessible by its name. The user or the interpreter defines variables.
Here is an example of the variable declaration:
{line-numbers: false, format: Bash}
```
filename="README.txt"
```

[**Vulnerability**](https://en.wikipedia.org/wiki/Vulnerability_(computing)) is a bug or flaw in the computing system. An attacker can perform unauthorized actions using the vulnerability.

## W
