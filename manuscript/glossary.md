# Glossary

## A

[**Abstraction**](https://en.wikipedia.org/wiki/Abstraction_(computer_science)) is a software module, application, or library that replicates the basic properties of a real object. Abstractions help manage the complexity of software systems. They hide irrelevant details. Abstractions allow the same algorithm to handle different objects.

[**Algorithm**](https://en.wikipedia.org/wiki/Algorithm) is a finite sequence of instructions understandable to the executor. The goal of an algorithm is to calculate something or solve a task.

[**Argument**](http://linuxcommand.org/lc3_wss0120.php) is a word or string that the program receives via the command-line interface. Here is an example of arguments for the `grep` utility:
{line-numbers: false, format: Bash}
```
grep "GNU" README.txt
```

[**Asynchrony**](https://en.wikipedia.org/wiki/Asynchrony_(computer_programming)) means events that occur independently of the main program flow. Asynchrony also refers to methods for processing such events.

[**Array**](https://en.wikipedia.org/wiki/Array_data_structure) is a data structure consisting of a set of elements. The sequence number or index determines the position of each element. The array elements are placed one by one in computer memory.

## B

[**Boolean expression**](https://en.wikipedia.org/wiki/Boolean_expression) is a programming language construct. When calculated, It results in either the "true" or "false" value.

[**Builtin commands**](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html) are the commands that the interpreter executes by itself. It does not call utilities or programs for that. An example is the `pwd` built-in command.

## C

[**Child process**](https://en.wikipedia.org/wiki/Child_process) a process spawned by another process called the parent.

**Command** is the text entered after the command prompt. This text matches the action that the interpreter performs on its own or with another application's help.

[**Compiler**](https://en.wikipedia.org/wiki/Compiler) is a program for translating source code from a programming language to the machine code.

[**Computer program**](https://en.wikipedia.org/wiki/Computer_program) is a set of instructions that a computer can execute. Each program solves an applied task.

## D

## E

## F

## G

## H

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

[**Process**](https://en.wikipedia.org/wiki/Process_(computing)) is an instance of a computer program that is being executed by the CPU.

[**Programming paradigm**](https://en.wikipedia.org/wiki/Programming_paradigm) a set of ideas, methods and principles that define how to write programs.

## R

[**Redirections**](https://www.gnu.org/software/bash/manual/html_node/Redirections.html#Redirections) are the special Bash and Bourne shell language constructs that redirect I/O streams of built-in commands, utilities and applications. You should specify file descriptors as the source and target of the redirection. The descriptors point to files or standard streams. Here is an example of redirecting the `find` utility output to the `result.txt` file:
{line-numbers: false, format: Bash}
```
find / -path */doc/* -name README 1> result.txt
```

**Reserved variables** are the same as shell variables.

## S

[**Scope**](https://en.wikipedia.org/wiki/Scope_(computer_science)) is a part of a program or system where the variable's name remains associated with its value. In other words, the variable name is correctly converted to the memory address where its value is stored. Outside the scope, the same name can point to another memory location.

[**Shell options**](https://www.tldp.org/LDP/abs/html/options.html) change the behavior of the interpreter when it works in both shell and script modes. The built-in `set` command sets the options. For example, here is the command to enable the debug output of the interpreter:
{line-numbers: false, format: Bash}
```
set -x
```

## T

## U

## V

## W
