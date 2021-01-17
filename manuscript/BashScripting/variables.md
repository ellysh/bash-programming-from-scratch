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