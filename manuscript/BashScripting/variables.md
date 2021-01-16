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