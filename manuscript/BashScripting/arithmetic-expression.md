## Arithmetic Expressions

Bash can calculate integers. It does simple arithmetic operations: addition, subtraction, multiplication and division. Also, Bash does bitwise and logical operations. They are often used in programming. We consider them in detail now.

Bash does not support floating-point arithmetic. For doing that, use the [bc](https://en.wikipedia.org/wiki/Bc_(programming_language)) or [dc](https://en.wikipedia.org/wiki/Dc_(computer_program)) calculator.

### Integer Representation

Let's have a look at how a computer represents integers in its memory. Knowing it, you understand how mathematical operations work in Bash.

Mathematical [integers](https://en.wikipedia.org/wiki/Integer) can be positive or negative. They match the data type with the same name [**integer**](https://en.wikipedia.org/wiki/Integer_(computer_science)).

If an integer type variable accepts positive values only, it is called **unsigned**. If it allows both positive and negative values, the variable is called **signed**.

There are three most common ways of representing integers in computer memory:

* [**Sign-Magnitude representation**](https://en.wikipedia.org/wiki/Signed_number_representations#Sign-and-magnitude_method) (SMR)

* [**Ones' complement**](https://en.wikipedia.org/wiki/Signed_number_representations#Ones'_complement)

* [**Two's complement**](https://en.wikipedia.org/wiki/Signed_number_representations#Two's_complement)

#### Sign-Magnitude Representation

All numbers in computer memory are represented in binary form. It means that the computer stores any number as a sequence of zeros and ones. Number representation defines what those zeros and ones mean.

First, we consider the simplest numbers representation that is the sign-magnitude representation or SMR. There are two options to use it:

1. To store only positive integers (unsigned).

2. To store both positive and negative integers (signed).

The computer allocates a fixed block of memory for any number. When you choose the first option of SMR, all bits of the allocated memory are used in the same way. They store the value of the number. Table 3-13 shows how it looks like.

{caption: "Table 3-13. Sign-magnitude representation of the unsigned integers", width: "70%"}
| Decimal | Hexadecimal | SMR |
| --- | --- | --- |
| 0 | 0 | 0000 0000 |
| 5 | 5 | 0000 0101 |
| 60 | 3C | 0011 1100 |
| 110 | 6E | 0110 1110 |
| 255 | FF | 1111 1111 |

Suppose that the computer allocates one byte of memory for a number. Then you can store unsigned integers from 0 to 255 there using SMR.

The second option of SMR allows you to store signed integers. In this case, the highest bit of the number stores its sign. Therefore, there are fewer bits left for the value of the number. Suppose that there is one byte to keep the number. The number's sign takes one bit. Then only seven bits can store the value of the number.

Table 3-14 shows the sign-magnitude representation of the signed integers.

{caption: "Table 3-14. The sign-magnitude representation of the signed integers", width: "70%"}
| Decimal | Hexadecimal | SMR |
| --- | --- | --- |
| -127 | FF | 1111 1111 |
| -110 | EE | 1110 1110 |
| -60 | BC | 1011 1100 |
| -5 | 85 | 1000 0101 |
| -0 | 80 | 1000 0000 |
| 0 | 0 | 0000 0000 |
| 5 | 5 | 0000 0101 |
| 60 | 3C | 0011 1100 |
| 110 | 6E | 0110 1110 |
| 127 | 7F | 0111 1111 |

The highest (leftmost) bit of all negative numbers equals one. It equals zero for positive numbers. Because of the sign, it is impossible to store numbers greater than 127 in one byte. For the same reason, the minimum allowed negative number is -127.

There are two reasons why SMR is not widespread nowadays:

1. Arithmetic operations on negative numbers complicate the processor architecture. A processor module for adding positive numbers is not suitable for negative numbers.

2. There are two representations of zero: positive (0000 0000) and negative (1000 0000). It complicates the comparison operation because these values are not equal in memory.

Take your time and try to understand SMR. Without getting it, you won't understand the other two ways of representing integers.

#### Ones' Complement

SMR has two disadvantages. They have led to technical issues when using the representation in practice. Therefore, the engineers have looked for an alternative approach to store numbers in memory. This way, they came to ones' complement representation.

The first problem of SMR is related to operations on negative numbers. The ones' complement solves it. Let's consider the root cause of this problem.

Here is an example. We want to add the numbers 10 and -5. First, we should write them in SMR. Assume that each number occupies one byte in computer memory. Then we get the following result:
{line-numbers: false}
```
10 = 0000 1010
-5 = 1000 0101
```

Now the question arises. How does the processor add these numbers? Any modern processor has a standard module called [**adder**](https://en.wikipedia.org/wiki/Adder_(electronics)). It adds two numbers in a bitwise manner. If we apply it in our task, we get the following result:
{line-numbers: false}
```
10 + (-5) = 0000 1010 + 1000 0101 = 1000 1111 = -15
```

The result is wrong. It means that the adder cannot add numbers in SMR. The calculation mistake happens because the adder does not consider the highest bit of the number. This bit stores the sign.

There are two ways for solving the problem:

1. Add a special module to the processor. It should process operations on negative integers.

2. Change the integer representation in memory. The representation should fit the adder logic when it adds negative integers.

The development of computer technology followed the second way. It is cheaper than complicating the processor architecture.

The ones' complement reminds SMR. The sign of the number occupies the highest bit. The remaining bits store the value. The difference is all bits of the value are inverted for negative numbers. It means zeros become ones and ones become zeros. Bits of positive numbers are not inverted.

Table 3-15 shows the ones' complement representation of some numbers.

{caption: "Table 3-15. The ones' complement of the signed integers", width: "70%"}
| Decimal | Hexadecimal | Ones' Complement |
| --- | --- | --- |
| -127 | 80 | 1000 0000 |
| -110 | 91 | 1001 0001 |
| -60 | C3 | 1100 0011 |
| -5 | FA | 1111 1010 |
| -0 | FF | 1111 1111 |
| 0 | 0 | 0000 0000 |
| 5 | 5 | 0000 0101 |
| 60 | 3C | 0011 1100 |
| 110 | 6E | 0110 1110 |
| 127 | 7F | 0111 1111 |

The memory capacity when using SMR and the ones' complement is the same. One byte can store numbers from -127 to 127 in both cases.

What is the effect of inverting the value bits for negative numbers? Let's have a look at how the addition of negative numbers works now. First, we will write 10 and -5 in the ones' complement. Then add them using the adder CPU module.

Here is how the numbers look like in memory:
{line-numbers: false}
```
10 = 0000 1010
-5 = 1111 1010
```

Their addition gives the following result:
{line-numbers: false}
```
10 + (-5) = 0000 1010 + 1111 1010 = 1 0000 0100
```

The addition caused an overflow. The highest one does not fit into one byte. In this case, it is discarded. Then the result of the addition becomes like this:
{line-numbers: false}
```
0000 0100
```

The discarded one affects the final result. We need a second calculation step to take it into account. In this step, we add the discarded one as a number to the result. It looks like this:
{line-numbers: false}
```
0000 0100 + 0000 0001 = 0000 0101 = 5
```

We got the correct result of adding the numbers 10 and -5.

If the addition results in a negative number, the second calculation step is unnecessary. As an example, add the numbers -7 and 2. First, write them in the ones' complement:
{line-numbers: false}
```
-7 = 1111 1000
2 = 0000 0010
```

Then do the first step of addition:
{line-numbers: false}
```
-7 + 2 = 1111 1000 + 0000 0010 = 1111 1010
```

The high bit equals one. It means that we got a negative number. Therefore, we should skip the second step of addition.

Let's check if the result is correct. For convenience, convert the number from ones' complement to SMR. Invert all bits of the number value for doing that. The sign bit should stay unchanged. Here is the result:
{line-numbers: false}
```
1111 1010 -> 1000 0101 = -5
```

We got the right result again.

The ones' complement solved one problem. Now the adder CPU module can add any signed integers. There is one disadvantage of this solution. Addition requires two steps in some cases. It slows down computations.

SMR has the second problem. It represents zero in two ways. Ones' complement did not solve it.

#### Two's Complement

The two's complement solves both problems of SMR. First, it allows the standard adder to add negative numbers. In the ones' complement, this operation requires two steps. In two's complement, one step is sufficient. Second, there is only one way to represent zero.

Positive integers in the two's complement look the same as in SMR. The highest bit equals zero there. The remaining bits store the value of the number. Negative integers have the highest bit equal to one. The value bits are inverted the same way as in the ones' complement. The result is increased by one.

Table 3-16 shows the two's complement representation of some numbers.

{caption: "Table 3-16. The two's complement of the signed integers", width: "70%"}
| Decimal | Hexadecimal | Two's Complement |
| --- | --- | --- |
| -127 | 81 | 1000 0001 |
| -110 | 92 | 1001 0010 |
| -60 | C4 | 1100 0100 |
| -5 | FB | 1111 1011 |
| 0 | 0 | 0000 0000 |
| 5 | 5 | 0000 0101 |
| 60 | 3C | 0011 1100 |
| 110 | 6E | 0110 1110 |
| 127 | 7F | 0111 1111 |

The memory capacity stays the same when using the two's complement. One byte can store the numbers from -127 to 127.

Let's consider adding negative numbers in the two's complement. For example, we add 14 and -8. First, write them in the two's complement. Here is the result:
{line-numbers: false}
```
14 = 0000 1110
-8 = 1111 1000
```

Now add these number like this:
{line-numbers: false}
```
14 + (-8) = 0000 1110 + 1111 1000 = 1 0000 0110
```

The addition leads to the overflow. The highest one did not fit into one byte. We should discard it. Then the final result looks like this:
{line-numbers: false}
```
0000 0110 = 6
```

When addition gives a negative result, you should not discard the highest bit. For example, we want to add the numbers -25 and 10. When we write them in two's complement, they look like this:
{line-numbers: false}
```
-25 = 1110 0111
10 = 0000 1010
```

The addition of these numbers gives the following result:
{line-numbers: false}
```
-25 + 10 = 1110 0111 0000 1010 = 1111 0001
```

Let's convert the result from two's complement to ones' complement. Then do one more step and get it in SMR. Here are the conversions:
{line-numbers: false}
```
1111 0001 - 1 = 1111 0000 -> 1000 1111 = -15
```

When converting from ones' complement to SMR, we invert all bits except the highest one. This way, we got the correct result of adding -25 and 10.

Two's complement allowed the standard adder of the CPU to add negative numbers. Moreover, the adder does this calculation in a single step. Therefore, there is no performance loss, unlike the ones' complement case.

Two's complement solved the problem of zero representation. There is only one way to represent it. It is the number with all bits zeroed. Therefore, there are no issues with comparing numbers.

All modern computers represent integers in two's complement.

{caption: "Exercise 3-7. Arithmetic operations with numbers in the two's complement representation", format: text, line-numbers: false}
```
Represent the following integers in two's complement and add them:

* 79 + (-46)
* -97 + 96

Represent the following two-byte integers in two's complement and add them:

* 12868 + (-1219)
```

#### Converting Numbers

We learned how a computer represents numbers in memory. When would you need it in practice?

Modern programming languages take care of converting numbers into the correct format. For example, you declare a signed integer variable in decimal notation. You do not need to worry about how the computer stores it in memory. If the variable's value becomes negative, the computer makes two's complement representation without your involvement.

In some cases, you want to treat a variable as a set of bits. Then declare it as a positive integer. Do all operations on it in hexadecimal. Do not convert the variable's value to decimal. This way, you avoid the problems of converting numbers.

The issue arises when you want to read data from some device. Such a task often occurs in [**system software development**](https://en.wikipedia.org/wiki/System_software). This domain includes the development of device drivers, OS kernels and modules, system libraries and network protocol stacks.

Here is an example. Suppose that you write a driver for a peripheral device. The device periodically sends data to the CPU. For example, it is the results of some measurements. Interpret them correctly is your task. The computer cannot do it for you in most cases. It happens because the computer and the device represent the numbers differently. You know this difference. Thus, you should apply your knowledge about numbers representation and convert them properly.

There is another task that every programmer faces. It is [**debugging**](https://en.wikipedia.org/wiki/Debugging). Debugging a program is searching and eliminating its errors. For example, there is an integer overflow in the arithmetic expression. Knowing numbers representation helps you find and solve the problem.

### Operator ((

Bash performs integer arithmetic in **math context**. Its syntax resembles the C language.

Suppose that you want to store the result of adding two numbers in a variable. Declare it with the `-i` integer attribute. Then assign its value in the declaration. Here is an example:
{line-numbers: false, format: Bash}
```
declare -i var=12+7
```

Bash assigned the number 19 to the variable but not the "12+7" string. When you add the `-i` attribute to the declaration, Bash calculates the assigned value in the mathematical context. It happened in our example.

You can declare the mathematical context explicitly. The `let `built-in command does that.

Suppose you declare the variable without the `-i` attribute. Then the `let` command allows you to assign an arithmetic expression result to the variable. Here is an example:
{line-numbers: false, format: Bash}
```
let text=5*7
```

The `text` variable equals 35 in the result.

When declaring the variable with the `-i` attribute, you do not need the `let` command. It looks like this:
{line-numbers: false, format: Bash}
```
declare -i var
var=5*7
```

Now the `var` variable equals 35 too.

Declaring a variable with the `-i` attribute creates the mathematical context implicitly. It can lead to errors. Therefore, try to avoid using the `-i` attribute. It does not affect the way how the Bash stores the variable in memory. Instead, converting a string to a number and back takes place every time you assign the variable.

The `let` command allows you to treat a string variable as an integer variable. This way, you can do the following assignments:
{line-numbers: true, format: Bash}
```
let var=12+7
let var="12 + 7"
let "var = 12 + 7"
let 'var = 12 + 7'
```

All four commands give the same result. They set the variable's value to 19.

The `let` command takes parameters on input. Each of them must be a valid arithmetic expression. If there are spaces in the expression, Bash splits it into parts because of word splitting. In this case, `let` computes each part of the expression separately. It can lead to an error.

The following command demonstrates the issue:
{line-numbers: false, format: Bash}
```
let var=12 + 7
```

Here the `let` command receives three expressions after word splitting. These are the expressions:

* var=12
* +
* 7

When calculating the second one, `let` reports about an error. The plus means an arithmetic addition. It requires two operands. But in our case, there are no operands at all.

Suppose that you pass correct expressions to the `let` command. Then the command evaluates them one by one. Here are the examples:
{line-numbers: true, format: Bash}
```
let a=1+1 b=5+1
let "a = 1 + 1" "b = 5 + 1"
let 'a = 1 + 1' 'b = 5 + 1'
```

All three commands give the same result. The variable `a` gets the value of 2. The variable `b` gets the value of 6.

You can prevent word splitting of the `let` parameters. Use single or double-quotes for that.

The `let` command has a synonym that is the (( operator. Bash skips word splitting inside the operator. Therefore, you can skip quotes there. Always use the (( operator instead of the `let` command. This way, you will avoid mistakes.

I> The relationship of the (( operator and the `let` command resembles that of `test` and the [[ operator. In both cases, use operators rather than commands.

The (( operator has two forms. The first one is called [**arithmetic evaluation**](https://wiki.bash-hackers.org/syntax/ccmd/arithmetic_eval). It is a synonym for the `let` command. The arithmetic evaluation looks like this:
{line-numbers: false, format: Bash}
```
((var = 12 + 7))
```

Here we use opening double-parentheses instead of the `let` command. There are closing double-parentheses at the end. This form of the (( operator returns exit status zero if it succeeds. It returns exit status one if it fails. After calculating the expression, Bash replaces it with its exit status.

The second form of the (( operator is called [**arithmetic expansion**](https://wiki.bash-hackers.org/syntax/expansion/arith). It looks like this:
{line-numbers: false, format: Bash}
```
var=$((12 + 7))
```

Here we put a dollar sign before the (( operator. In this case, Bash calculates the value of the expression. Then Bash inserts this value in place of the expression. This behavior differs from the first form of the (( operator. Bash inserts the exit status there.

I> The second form of the (( operator is part of the POSIX standard. Use it for writing portable code. The first form of the operator is available in Bash, ksh and zsh interpreters only.

You can skip the dollar sign before variables names in the (( operator. Bash still inserts their values correctly in this case. For example, here are two equivalent expressions for calculating the `result` variable:
{line-numbers: true, format: Bash}
```
a=5 b=10
result=$(($a + $b))
result=$((a + b))
```

Both expressions assign the value of 15 to the `result` variable.

Do not use the dollar sign in the (( operator. It makes your code clearer.

I> Bash has an obsolete form of arithmetic expansion that is the "$[ ]" operator. Never use it. There is a GNU utility called `expr` for calculating arithmetic expressions. Bash needs it for launching old Bourne Shell scripts. Never use `expr` when developing new scripts.

Table 3-17 shows the operations that Bash allows in arithmetic expressions.

{caption: "Table 3-17. The operations in arithmetic expressions", width: "100%"}
| Operation | Description | Example |
| --- | --- | --- |
| | **Calculations** | |
|  | | |
| `*` | Multiplication | `echo "$((2 * 9)) = 18"` |
|  | | |
| `/` | Division | `echo "$((25 / 5)) = 5"` |
|  | | |
| `%` | The remainder of division  | `echo "$((8 % 3)) = 2"` |
|  | | |
| `+` | Addition | `echo "$((7 + 3)) = 10"` |
|  | | |
| `-` | Subtraction | `echo "$((8 - 5)) = 3"` |
|  | | |
| `**` | Exponentiation | `echo "$((4**3)) = 64"` |
|  | | |
|  | | |
| | **Bitwise operations** | |
|  | | |
| `~` | Bitwise NOT | `echo "$((~5)) = -6"` |
|  | | |
| `<<` | Bitwise left shift | `echo "$((5 << 1)) = 10"` |
|  | | |
| `>>` | Bitwise right shift | `echo "$((5 >> 1)) = 2"` |
|  | | |
| `&` | Bitwise AND | `echo "$((5 & 4)) = 4"` |
|  | | |
| `|` | Bitwise OR | `echo "$((5 | 2)) = 7"` |
|  | | |
| `^` | [Bitwise XOR](https://en.wikipedia.org/wiki/Exclusive_or) | `echo "$((5 ^ 4)) = 1"` |
|  | | |
|  | | |
| | **Assignments** | |
|  | | |
| `=` | Ordinary assignment | `echo "$((num = 5)) = 5"` |
|  | | |
| `*=` | Multiply and assign the result | `echo "$((num *= 2)) = 10"` |
|  | | |
| `/=` | Divide and assign the result | `echo "$((num /= 2)) = 5"` |
|  | | |
| `%=` | Get the remainder of the division and assign it | `echo "$((num %= 2)) = 1"` |
|  | | |
| `+=` | Add and assign the result | `echo "$((num += 7)) = 8"` |
|  | | |
| `-=` | Subtract and assign the result | `echo "$((num -= 3)) = 5"` |
|  | | |
| `<<=` | Bitwise left shift and assign the result | `echo "$((num <<= 1)) = 10` |
|  | | |
| `>>=` | Bitwise right shift and assign the result | `echo "$((num >>= 2)) = 2"` |
|  | | |
| `&=` | Bitwise AND and assign the result | `echo "$((num &= 3)) = 2"` |
|  | | |
| `^=` | Bitwise XOR and assign the result | `echo "$((num^=7)) = 5"` |
|  | | |
| `|=` | Bitwise OR and assign the result | `echo "$((num |= 7)) = 7"` |
|  | | |
|  | | |
| | **Comparisons** | |
|  | | |
| `<` | Less than | `((num < 5)) && echo "The \"num\" variable is less than 5"` |
|  | | |
| `>` | Greater than | `((num > 5)) && echo "The \"num\" variable is greater than 3"` |
|  | | |
| `<=` | Less than or equal | `((num <= 20)) && echo "The \"num\" variable is less or equal 20"` |
|  | | |
| `>=` | Greater than or equal | `((num >= 15)) && echo "The \"num\" variable is greater or equal 15"` |
|  | | |
| `==` | Equal | `((num == 3)) && echo "The \"num\" variable is equal to 3"` |
|  | | |
| `!=` | Not equal | `((num != 3)) && echo "The \"num\" variable is not equal to 3"` |
|  | | |
|  | | |
| | **Logical operations** | |
|  | | |
| `!` | Logical NOT | `(( ! num )) && echo "The \"num\" variable is FALSE"` |
|  | | |
| `&&` | Logical AND | `(( 3 < num && num < 5 )) && echo "The \"num\" variable is greater than 3 but less than 5"` |
|  | | |
| `||` | Logical OR | `(( num < 3 || 5 < num )) && echo "The \"num\" variable is less than 3 or greater than 5"` |
|  | | |
|  | | |
| | **Other operations** | |
|  | | |
| `num++` | Postfix increment | `echo "$((num++))"` |
|  | | |
| `num--` | Postfix decrement | `echo "$((num--))"` |
|  | | |
| `++num` | Prefix increment | `echo "$((++num))"` |
|  | | |
| `--num` | Prefix decrement | `echo "$((--num))"` |
|  | | |
| `+num` | Unary plus or multiplication of a number by 1 | `a=$((+num))"` |
|  | | |
| `-num` | Unary minus or multiplication of a number by -1 | `a=$((-num))"`|
| `CONDITION ? ACTION_1 : ACTION_2` | [Ternary operator](https://en.wikipedia.org/wiki/%3F:) | `a=$(( b < c ? b : c ))` |
|  | | |
| `ACTION_1, ACTION_2` | The list of expressions | `((a = 4 + 5, b = 16 - 7))` |
|  | | |
| `( ACTION_1 )` | Grouping of expressions (subexpression) | `a=$(( (4 + 5) * 2 ))`|

Bash performs all operations in order of their priorities. The operations with a higher priority come first.

Table 3-18 shows the priority of operations.

{caption: "Table 3-18. Priority of operations in arithmetic expressions", width: "100%"}
| Priority | Operation | Description |
| --- | --- | --- |
| 1 | `( ACTION_1 )` | Grouping of expressions |
|  | | |
| 2 | `num++, num--` | Postfix increment and decrement |
|  | | |
| 3 | `++num, --num` | Prefix increment and decrement |
|  | | |
| 4 | `+num, -num` | Unary plus and minus |
|  | | |
| 5 | `~, !` | Bitwise and logical NOT |
|  | | |
| 6 | `**` | Exponentiation |
|  | | |
| 7 | `*, /, %` | Multiplication, division and the remainder of division |
|  | | |
| 8 | `+, -` | Addition and subtraction |
|  | | |
| 9 | `<<, >>` | Bitwise shifts |
|  | | |
| 10 | `<, <=, >, >=` | Comparisons |
|  | | |
| 11 | `==, !=` | Equal and not equal |
|  | | |
| 12 | `&` | Bitwise AND |
|  | | |
| 13 | `^` | Bitwise XOR |
|  | | |
| 14 | `|` | Bitwise OR |
|  | | |
| 15 | `&&` | Logical AND |
|  | | |
| 16 | `||` | Logical OR |
|  | | |
| 17 | `CONDITION ? ACTION_1 : ACTION_2` | Ternary operator |
|  | | |
| 18 | `=, *=, /=, %=, +=, -=, <<=, >>=, &=, ^=, |=` | Assignments |
|  | | |
| 19 | `ACTION_1, ACTION_2` | The list of expressions |

You can change the order of execution using parentheses "( )". Their contents are called **subexpression**. Bash calculates subexpressions first. If there is more than one subexpression, Bash calculates them in the left-to-right order.

Suppose your code uses a numeric constant. You can specify its value in any numeral system. Use a prefix to select a numeral system. Table 3-19 shows the list of allowable prefixes.

{caption: "Table 3-19. The prefixes for numeral systems", width: "100%"}
| Prefix | Numeral System | Example] |
| --- | --- | --- |
| `0` | Octal | `echo "$((071)) = 57"` |
| `0x` | Hexadecimal | `echo "$((0xFF)) = 255"` |
| `0X` | Hexadecimal | `echo "$((0XFF)) = 255"` |
| `<base>#` | The numeral system with a base from 2 to 64 | `echo "$((16#FF)) = 255"` |
| | | `echo "$((2#101)) = 5"` |

When printing a number to the screen or file, Bash always converts it in decimal. The `printf` command changes the format of the number output. You can use it this way:
{line-numbers: false, format: Bash}
```
printf "%x\n" 250
```

This command prints the number 250 in hexadecimal.

You can format the variable's value in the same way:
{line-numbers: false, format: Bash}
```
printf "%x\n" $var
```

### Arithmetic Operations

Let's start with the simplest mathematical operations that are arithmetic operations. Programming languages use usual symbols to denote them:

* `+` addition
* `-` subtraction
* `/` division
* `*` multiplication

Two more operations are often used in programming. These are exponentiation and [division with remainder](https://en.wikipedia.org/wiki/Euclidean_division).

Suppose that you want to raise the `a` number to the power of `b`. You can write it this way: a^b^. Here `a` is the base and `b` is the exponent. For example, raising two to the power of seven is written as 2^7^. You can write this operation with two asterisks in Bash:
{line-numbers: false}
```
2**7
```

Calculating the remainder of the division is a complex but essential operation in programming. Let's take a closer look at it. Suppose we have divided one integer number by another. A result is a fractional number. In this case, we say that the division produced a [**remainder**](https://en.wikipedia.org/wiki/Remainder).

For example, let's divide 10 (the dividend) by 3 (the divisor). If we round the result, we get 3.33333 (the quotient). In this case, the remainder of the division is 1. To find it, we should multiply the divisor 3 by the integer part of the quotient 3 (the incomplete quotient). Then subtract the result from the dividend 10. It gives us the remainder, which is equal to 1.

Let's write our calculations in formulas. We can introduce the following notation for that:

* `a` is a dividend
* `b` is a divisor
* `q` is an incomplete quotient
* `r` is a remainder

Using the notation, we can write the formula for calculating the dividend:
{line-numbers: false}
```
a = b * q + r
```

Then we derive the formula for finding the remainder:
{line-numbers: false}
```
r = a - b * q
```

The choice of an incomplete quotient `q` raises questions. Sometimes several numbers fit this role. The restriction helps to choose the right one. The `q` quotient must be such that the absolute value of the `r` remainder is less than the `b` divisor. In other words, you should fulfill the following inequality:
{line-numbers: false}
```
|r| < |b|
```

The percent sign denotes the operation of finding the remainder in Bash. Some languages use the same symbol for the [**modulo operation**](https://en.wikipedia.org/wiki/Modulo_operation). These two operations [are not the same](https://rob.conery.io/2018/08/21/mod-and-remainder-are-not-the-same). They give the same results only when the signs of the dividend and the divisor match.

For example, let's calculate the remainder and modulo when dividing 19 by 12 and -19 by -12. We get these results:
{line-numbers: false}
```
19 % 12 = 19 - 12 * 1 = 7
19 modulo 12 = 19 - 12 * 1 = 7

-19 % -12 = -19 - (-12) * 1 = -7
-19 modulo -12 = -19 - (-12) * 1 = -7
```

Now consider cases when the signs of the dividend and the divisor differ. Here are the results:
{line-numbers: false}
```
19 % -12 = 19 - (-12) * (-1) = 7
19 modulo -12 = 19 - (-12) * (-2) = -5

-19 % 12 = -19 - 12 * (-1) = -7
-19 modulo 12 = -19 - 12 * (-2) = 5
```

The reminder and the modulo are different for the same pairs of numbers.

The same formula calculates the remainder and modulo. But the choice of the `q` incomplete quotient differs. For calculating the reminder, you get `q` this way:
{line-numbers: false}
```
q = a / b
```

You should round the result to the lowest [absolute number](https://en.wikipedia.org/wiki/Absolute_value). It means discarding all decimal places.

Calculation of the incomplete quotient for finding the modulo depends on the signs of `a` and `b`. If the signs are the same, the formula for the quotient stays the same:
{line-numbers: false}
```
q = a / b
```

If the signs differ, here is another formula:
{line-numbers: false}
```
q = (a / b) + 1
```

In both cases, you should round the result to the lowest absolute number.

When one speaks of the remainder of division `r`, he usually assumes that both the divisor a and the divisor b are positive. That is why reference books often mention the following condition for `r`:
{line-numbers: false}
```
0 ≤ r < |b|
```

However, you can get a negative remainder when dividing numbers with different signs. Remember a simple rule: the `r` remainder always has the same sign as the `a` dividend. If the signs of `r` and `a` differ, you have found the modulo but not the reminder.

Always keep in mind the difference between the remainder and the modulo. Some programming languages calculate the remainder in the % operator, while others calculate it in the `modulo` operator. It leads to confusion.

If in doubt about your calculations, check them. The % Bash operator always computes the remainder of a division. Suppose you want to find the remainder of dividing 32 by -7. This command shows it to you:
{line-numbers: false, format: Bash}
```
echo $((32 % -7))
```

The remainder of the division is four.

Now find the modulo for the same pair of numbers. Use the [online calculator](https://planetcalc.com/8326) for that. Enter the dividend32 in the "Expression" field. Then enter the divisor 7 in the "Modulus" field. Click the "CALCULATE" button. You will get two results:

* The "Result" field shows 4.
* The "Symmetric representation" field shows -3.

The second answer -3 is the modulo. The first one is the reminder.

When do you need the remainder of a division in programming? The most common task is to check a number for parity. For example, it helps to control the integrity of transmitted data in computer networks. This approach is called [**the parity bit**](https://en.wikipedia.org/wiki/Parity_bit).

I> To check a number for parity, you should find the remainder of its division by 2. If the remainder is zero, then the number is even. Otherwise, it is odd.

There is another task where you need to calculate the remainder. It is the converting of time units. Suppose you want to convert 128 seconds into minutes. Then you should count the number of minutes in 128 seconds. The next step is to add the remainder to the result.

The first step is calculating the number of minutes. Divide 128 by 60 to do that. The result is an incomplete quotient of 2. It means that 128 seconds contains 2 minutes. Calculate the remainder of dividing 128 by 60 to find the remaining seconds. Here is the result:
{line-numbers: false}
```
r = 128 - 60 * 2 = 8
```

The remainder equals 8. It means that 128 seconds equals two minutes and eight seconds.

Calculating the remainder is useful when working with loops. Suppose that you want to act on every 10th iteration of the loop. Then you need to check the remainder of dividing the loop counter by 10. If the remainder is zero, then the current iteration is a multiple of 10. Thus, you should act on this iteration.

The modulo operation is widely used in [**cryptography**](https://en.wikipedia.org/wiki/Modulo_operation#Properties_(identities)).

{caption: "Exercise 3-8. Modulo and the remainder of a division", format: text, line-numbers: false}
```
Calculate the remainder of a division and modulo:

* 1697 % 13
* 1697 modulo 13

* 772 % -45
* 772 modulo -45

* -568 % 12
* -568 modulo 12

* -5437 % -17
* -5437 modulo -17
```

### Bitwise operations

[**Bitwise operations**](https://en.wikipedia.org/wiki/Bitwise_operation) are another type of mathematical operations. Software developers use them often. The operations get their name because they operate each bit of a number individually.

#### Bitwise negation

We start with the simplest bitwise operation that is the negation. It is also called bitwise NOT. The tilde symbol indicates this operation in Bash.

Swap the value of each bit of a number to perform bitwise negation. It means that you replace each one to zero and vice versa.

Here is an example of doing bitwise NOT of number 5:
{line-numbers: false}
```
5 = 101
~5 = 010
```

The bitwise NOT is a simple operation when we are talking about mathematics. However, using it in programming causes difficulties. First, you should know how many bytes the number occupies.

Suppose that the two-byte variable stores the number 5 in our example. Then it looks like this in memory:
{line-numbers: false}
```
00000000 00000101
```

Bitwise NOT for these bits gives us the following result:
{line-numbers: false}
```
11111111 11111010
```

What does this result mean? If the variable is an unsigned integer, the result equals the number 65530 in SMR. If the variable is a signed integer, it is the two's complement value. The result equals -6 in this case.

Bash commands and operators represent integers in different ways. For example, `echo` always outputs numbers as signed integers. The `printf` command allows you to specify the output format: signed or unsigned integer.

There are no types in the Bash language. Bash stores
all scalar variables as strings. Therefore, it interprets integers when it inserts them into arithmetic expressions. The interpretation (signed or unsigned) depends on the context.

Bash allocates 64 bits of memory space for each integer regardless of its sign. Table 3-20 shows maximum and minimum allowed integers in Bash.

{caption: "Table 3-20. Maximum and minimum allowed integers in Bash", width: "100%"}
| Integer | Hexadecimal | Decimal |
| --- | --- | --- |
| Maximum positive signed | 7FFFFFFFFFFFFFFF | 9223372036854775807 |
| Minimum negative signed | 8000000000000000 | -9223372036854775808 |
| Maximum unsigned | FFFFFFFFFFFFFFFF | 18446744073709551615 |

The following examples show how Bash interprets integers in `echo`, `printf`, and the (( operator:
{line-numbers: true, format: Bash}
```
$ echo $((16#FFFFFFFFFFFFFFFF))
-1

$ printf "%llu\n" $((16#FFFFFFFFFFFFFFFF))
18446744073709551615

$ if ((18446744073709551615 == 16#FFFFFFFFFFFFFFFF)); then echo "ok"; fi
ok

$ if ((-1 == 16#FFFFFFFFFFFFFFFF)); then echo "ok"; fi
ok

$ if ((18446744073709551615 == -1)); then echo "ok"; fi
ok
```

The last example of comparing the numbers 18446744073709551615 and -1 shows that Bash stores signed and unsigned integers in memory the same way. But their interpretation depends on the context.

Let's come back to the bitwise negation of the number 5. Bash gave us the result 0xFFFFFFFFFFFFFFFFFA in hexadecimal. You can print this 64-bit number as a positive or negative integer this way:
{line-numbers: true, format: Bash}
```
$ echo $((~5))
-6

$ printf "%llu\n" $((~5))
18446744073709551610
```

The numbers 18446744073709551610 and -6 are equal in terms of Bash. It happens because all their bits in memory are the same.

{caption: "Exercise 3-9. Bitwise NOT", format: text, line-numbers: false}
```
Apply bitwise NOT for the following unsigned two-byte integers:

* 56
* 1018
* 58362

Repeat the calculations for the case when these integers are signed.
```

#### Bitwise AND, OR and XOR

The bitwise AND operation resembles the logical AND. The result of the logical AND is "true" when both operands are "true". Any other values of operands lead to the "false" result.

Operands of the bitwise AND are two numbers. You can do this operation in three steps:

1. Represent numbers in the two's complement.

2. If one number has fewer bits than another, add zeros to its left side.

3. Apply the logical AND operation to each pair of numbers' bits. The pair means two bits from each number that have the same position.

Here is an example. We want to calculate the bitwise AND for numbers 5 and 3. First, we should represent them in the two's complement like this:
{line-numbers: false}
```
5 = 101
3 = 11
```

Number 3 has fewer bits than 5. Thus, we add an extra zero on its left side. This way, we get the following representation:
{line-numbers: false}
```
3 = 011
```

Now we apply the logical AND for bit pairs of the numbers. For convenience, let's write the numbers in columns like this:
{line-numbers: false}
```
101
011
---
001
```

The result is 001. We can translate it in decimal:
{line-numbers: false}
```
001 = 1
```

It means that the bitwise AND operation with numbers 5 and 3 gives 1.

The ampersand sign denotes the bitwise AND operation in Bash. Here is the command to repeat our calculations and print the result:
{line-numbers: false, format: Bash}
```
echo $((5 & 3))
```

The bitwise OR operation works similarly as bitwise AND. But instead of the logical AND, you should perform the logical OR on bit pairs of the numbers.

For example, we want to calculate the bitwise OR for the numbers 10 and 6. First, write them in the two's complement like this:
{line-numbers: false}
```
10 = 1010
6 = 110
```

One bit is missing in the number 6. Let's extend it by one zero to get four bits:
{line-numbers: false}
```
6 = 0110
```

Now perform the logical OR on bit pairs of the numbers:
{line-numbers: false}
```
1010
0110
----
1110
```

The last step is converting the result in decimal:
{line-numbers: false}
```
1110 = 14
```

We got the number 14.

The vertical bar denotes the bitwise OR in Bash. Here is the command to check our calculations:
{line-numbers: false, format: Bash}
```
echo $((10 | 6))
```

The bitwise exclusive OR (XOR) operation is similar to the bitwise OR. Here the logical OR is replaced by the **exclusive OR**. The exclusive OR returns "false" only if both operands are the same. In other cases, the result equals "true".

Let's calculate the exclusive OR for the numbers 12 and 5. Here is their representation in the two's complement:
{line-numbers: false}
```
12 = 1100
5 = 101
```

We should supplement the number 5 to four bits:
{line-numbers: false}
```
5 = 0101
```

Perform a bitwise exclusive OR for each pair of bits:
{line-numbers: false}
```
1100
0101
----
1001
```

Convert the result to the decimal:
{line-numbers: false}
```
1001 = 9
```

The caret symbol denotes the exclusive OR in Bash. The following command repeats our calculations:
{line-numbers: false, format: Bash}
```
echo $((12 ^ 5))
```

{caption: "Exercise 3-10. Bitwise AND, OR and XOR", format: text, line-numbers: false}
```
Perform bitwise AND, OR and XOR for the following unsigned two-byte integers:

* 1122 and 908
* 49608 and 33036
```

#### Bit Shifts

A bit shift is a changing of the bit positions in a number.

There are three types of bit shifts:

1. Logical
2. Arithmetic
3. Circular

The simplest shift is the logical one. Let's take a look at it first.

Any bit shift operation takes two operands. The first one is the integer. The operation shifts its bits. The second operand is the number of bits to shift.

You should represent the integer in the two's complement for doing the logical bit shift. Suppose that you do a shift in the right direction by two bits. Then you discard the two rightmost bits of the integer. Instead of them, add two zeros on the left side.

You can do the shift to the left in the same way. Discard two leftmost bits of the integer. Then add two zeroes on the right side.

Here is an example. Perform a logical shift of unsigned single-byte integer 58 to the right by three bits. First, represent the number in the two's complement:
{line-numbers: false}
```
58 = 0011 1010
```

Then discard the three bits on the right side like this:
{line-numbers: false}
```
0011 1010 >> 3 = 0011 1
```

Then add zeros to the left side of the result:

{line-numbers: false}
```
0011 1 = 0000 0111 = 7
```

The result of the shift is the number 7.

Now shift the number 58 to the left by three bits. We get the following result:
{line-numbers: false}
```
0011 1010 << 3 = 1 1010 = 1101 0000 = 208
```

Here we follow the same algorithm as for the right shift. First, discard the outermost bits on the left side. Then add zeros to the right side.

Now let's consider the second type of shift that is the arithmetic shift. If you do it to the left, you follow the logical shift algorithm. The steps are entirely the same.

The arithmetic shift to the right differs from the logical shift to the right. When performing it, you should discard the bits on the right side. Then complete the result with the bits on the left side. Their value should match the highest bit of the integer. If it equals one, add ones to the right. Otherwise, add zeros. This way, we keep the sign of the integer unchanged after the shifting.

For example, let's do an arithmetic shift of the signed one-byte integer -105 to the right by two bits.

First, we represent the number in the two's complement like this:
{line-numbers: false}
```
-105 = 1001 0111
```

Now do the arithmetic shift to the right by two bits. We get:
{line-numbers: false}
```
1001 0111 >> 2 -> 1001 01 -> 1110 0101
```

The highest bit of the integer equals one in our case. Thus, we complement the result with two ones on the left side.

This way, we got a negative number in the two's complement. Let's convert it to SMR and get the decimal like this:
{line-numbers: false}
```
1110 0101 = 1001 1011 = -27
```

The result of the shift is the number -27.

Bash has operators << and >>. They do arithmetic shifts. The following commands repeat our calculations:
{line-numbers: true, format: Bash}
```
$ echo $((58 >> 3))
7

$ echo $((58 << 3))
464

$ echo $((-105 >> 2))
-27
```

Bash gives another result for shifting 58 to the left by three bits. We got 208 in this case. It happens because Bash always operates with eight-byte integers.

The last type of bit shift is circular. You can rarely meet it when programming. Therefore, most programming languages do not have built-in operators for circular shifts.

In the cyclic shift, the discarded bits appear in the vacated place at the other side of the number.

Here is an example of the circular shift of the number 58 to the right by three bits:
{line-numbers: false}
```
0011 1010 >> 3 = 010 0011 1 = 0100 0111 = 71
```

We have discarded bits 010 on the right side. Then they appeared on the left side of the result.

{caption: "Exercise 3-11. Bit shifts", format: text, line-numbers: false}
```
Perform arithmetic bit shifts of the following signed two-byte integers:

* 25649 >> 3
* 25649 << 2
* -9154 >> 4
* -9154 << 3
```

#### Using Bitwise Operations

Bitwise operations are widely used in system programming. It happens because working with computer networks and peripheral devices requires translating data from one format to another.

Here is an example. Suppose you are working with a peripheral device. The byte order on the device is big-endian. Your computer uses another order, which is little-endian.

Now suppose that the device sends an unsigned integer to the computer. It equals 0xAABB in hexadecimal. Because of the different byte orders, your computer cannot receive the integer as it is. You should convert the integer to 0xBBAA. Then the computer reads it correctly.

Here are the steps for converting the 0xAABB integer into the computer's byte order:

1. Read the lowest (rightmost) byte of the integer and shift it to the left by eight bits, i.e. one byte. The following Bash command does that:
{line-numbers: false, format: Bash}
```
little=$(((0xAABB & 0x00FF) << 8))
```

2. Read the highest (leftmost) byte of the number and shift it to the right by eight bits. Here is the command:
{line-numbers: false, format: Bash}
```
big=$(((0xAABB & 0xFF00) >> 8))
```

3. Connect the highest and lowest bytes with the bitwise OR this way:
{line-numbers: false, format: Bash}
```
result=$((little | big))
```

Bash wrote the converting result to the `result` variable. It is equal to 0xBBAA.

The following command does all steps of our calculation at once:
{line-numbers: false, format: Bash}
```
value=0xAABB
result=$(( ((value & 0x00FF) << 8) | ((value & 0xFF00) >> 8) ))
```

Here is another example of using bitwise operations. They are essential for computing bitmasks. We are already familiar with file permission masks in the Unix environment. Suppose that a file has the permissions "-rw-r--r--". This mask looks like this in binary:
{line-numbers: false}
```
0000 0110 0100 0100
```

We want to check if the owner of the file has the right to execute it. We can do that by calculating the bitwise AND for the file's permissions and the mask 0000 0001 0000 0000 0000. Here is the calculation:
{line-numbers: false}
```
0000 0110 0100 0100 & 0000 0001 0000 0000 = 0000 0000 0000 0000 = 0
```

The result is zero. It means that the owner cannot execute the file.

The bitwise OR adds bits to the bitmask. We can add the execution permission to the file owner. The calculation looks like this:
{line-numbers: false}
```
0000 0110 0100 0100 | 0000 0001 0000 0000 = 0000 0111 0100 0100 = -rwxr--r--
```

I> The numbering of bits in an integer starts at zero. It usually goes from right to left.

We performed the bitwise OR for the file's permissions and the mask 0000 0001 0000 0000 0000. The only eighth bit of the mask equals one. We use it to change the eighth bit of the permissions. This bit can have any value. It does not matter in this calculation. The bitwise OR sets it to one regardless of its current value. If we do not change the permissions bit, the corresponding bit in the mask equals zero.

The bitwise AND removes bits from the bitmask. For example, let's remove the file owner's permission to write. Here is the calculation:
{line-numbers: false}
```
0000 0111 0100 0100 & 1111 1101 1111 1111 = 0000 0101 0100 0100 = -r-xr--r--
```

We set the ninth bit of the permissions to zero. To do that, we calculate the bitwise AND for the permissions and the mask 1111 1101 1111 1111 1111. The ninth bit of the mask equals zero and all other bits are ones. Therefore, the bitwise AND changes the ninth bit of the permissions only.

The OS performs mask operations every time you access a file. This way, it checks your access rights.

Here is the last example of using bitwise operations. Until recently, software developers used bit shifts as an alternative to multiplication and division by a power of two. For example, the bit shift to the left by two bits corresponds to multiplication by 2^2^ (i.e. four). Let's check it with the following Bash command:
{line-numbers: true, format: Bash}
```
$ echo $((3 << 2))
12
```

The bit shift gave a correct result. Multiplying 3 by 4 is equal to 12.

Such tricks reduce the number of processor clock cycles to perform multiplication and division. These optimizations are now unnecessary due to the development of compilers and processors. Compilers automatically select the fastest assembly instructions when generating code. Processors execute these instructions in parallel with [several threads](https://en.wikipedia.org/wiki/Hyper-threading). Therefore, today software developers tend to write code that is easier to read and understand. They do not care about optimizations as they do it before. Multiplication and division operations are better for reading the code than bit shifts.

Cryptography and computer graphics algorithms use bit operations a lot.

### Logical Operations

The [[ operator is inconvenient for comparing integers in the `if` statement. This operator uses two-letter abbreviations for expressing the relations between numbers. For example, the `-gt` abbreviation means greater. The (( operator fits the `if` condition better. You can use usual number comparison symbols (>, <, =) there.

Here is an example. Suppose that you want to compare the variable with 5. The following `if` construction does that:
{line-numbers: true, format: Bash}
```
if ((var < 5))
then
  echo "The variable is less than 5"
fi
```

Here we use the (( operator in the arithmetic evaluation form. You can replace it by the `let` command. It provides the same result:
{line-numbers: true, format: Bash}
```
if let "var < 5"
then
  echo "The variable is less than 5"
fi
```

However, you should always prefer to use the (( operator.

There is an important difference between arithmetic evaluation and expansion. According to the POSIX standard, any program or command returns the zero exit status when executed successfully. It returns the status between 1 and 255 in case of an error. The shell interprets the exit status like this: zero means "true" and nonzero means "false". If you apply this rule, the logical result of the arithmetic expansion is inverted. There is no inversion for the arithmetic evaluation result.

Arithmetic evaluation is synonymous with the `let` command. Therefore, it follows the POSIX standard just like any other command. The shell executes the arithmetic expansion in the context of another command. Thus, its result depends on the interpreter's implementation.

Suppose that you use the (( operator in the arithmetic expansion form. Then Bash interprets its result this way: if the condition in the (( operator equals "true", it returns one. Otherwise, the operator returns zero. The C language deduces Boolean expressions in the same way.

Here is an example for comparing the results of arithmetic expansion and evaluation. There is a Bash command that compares a variable with a number. It looks like this:
{line-numbers: false, format: Bash}
```
((var < 5)) && echo "The variable is less than 5"
```

There is an arithmetic evaluation in this command. Therefore, if the variable is less than 5, the (( operator succeeds. It returns the zero exit status according to the POSIX standard.

When you use the operator (( in the form of an arithmetic expansion, it gives another result. The following command makes the same comparison:
{line-numbers: false, format: Bash}
```
echo "$((var < 5))"
```

When the condition is true, the `echo` command prints the number one. If you are familiar with the C language, you expect the same result.

Logical operations are used in the arithmetic evaluation form of the (( operator in most cases. They work in the same way as the Bash logical operators.

Here is an example of applying the logical operation. The following `if` condition compares the variable with two numbers:
{line-numbers: true, format: Bash}
```
if ((1 < var && var < 5))
then
  echo "The variable is less than 5 but greater than 1"
fi
```

This condition is true when both expressions are true.

The logical OR works similarly:
{line-numbers: true, format: Bash}
```
if ((var < 1 || 5 < var))
then
  echo "The variable is less than 1 or greater than 5"
fi
```

The condition is true if at least one of the expressions is true.

The logical NOT is rarely applied to numbers themselves. It negates an expression in most cases. If you apply the logical NOT to a number, its output corresponds to the POSIX standard. In other words, zero means "true" and nonzero means "false". Here is an example:
{line-numbers: true, format: Bash}
```
if ((! var))
then
  echo "The vraiable equals true or zero"
fi
```

This condition is true if the variable is zero.

### Increment and Decrement

The increment and decrement operations first appeared in the [programming language B](https://en.wikipedia.org/wiki/B_(programming_language)). Ken Thompson and Dennis Ritchie developed it in 1969 while working at Bell Labs. Dennis Ritchie later transferred these operations to his new language called C. Bash copied them from C.

First, let's consider the assignment operations. It helps to get the meaning of increment and decrement. A regular assignment in arithmetic evaluation looks like this:
{line-numbers: false, format: Bash}
```
((var = 5))
```

This command assigns the integer 5 to the variable.

Bash allows you to combine an assignment with arithmetic or bitwise operation. Here is an example of simultaneous addition and assignment:
{line-numbers: false, format: Bash}
```
((var += 5))
```

The command performs two actions:

1. It adds the integer 5 to the current value of the `var` variable.

2. It writes the result to the variable `var`.

All other assignment operations work the same way. First, they do a mathematical or bitwise operation. Second, they assign the result to the variable. The assignments' syntax makes the code shorter and clearer.

Now we are ready to consider the increment and decrement operations. They have two forms: postfix and prefix. They are written in different ways. The ++ and -- signs come after the variable name in the postfix form. They come before the variable name in the prefix form.

Here is an example of the prefix increment:
{line-numbers: false, format: Bash}
```
((++var))
```

This command provides the same result as the following assignment operation:
{line-numbers: false, format: Bash}
```
((var+=1))
```

The increment operation increases the variable's value by one. The decrement operation decreases it by one.

Why does it make sense to introduce separate operations for adding and subtracting one? The Bash language has similar assignments like += and -=.

The most probable reason to add increment and decrement to the programming language is a [loop counter](https://en.wikipedia.org/wiki/For_loop#Loop_counters). This counter keeps the number of loop iterations. When you want to interrupt the loop, you check its counter in a condition. The result defines if you should interrupt the loop or not.

Increment and decrement make it easier to serve the loop counter. Besides that, modern processors perform these operations at the hardware level. Therefore, they work faster than addition and subtraction combined with the assignment.

What is the difference between prefix and postfix forms of increment? If the expression consists only of an increment operation, it gives the same result for both forms.

For example, the following two commands increase the variable's value by one:
{line-numbers: true, format: Bash}
```
((++var))
((var++))
```

The difference between the increment forms appears when assigning the result to a variable. Here is an example:
{line-numbers: true, format: Bash}
```
var=1
((result = ++var))
```

After these two commands, both variables `result` and `var` store the integer 2. It means that the prefix increment first adds one and then returns the result.

If you break the prefix increment into steps, you get the following commands:
{line-numbers: true, format: Bash}
```
var=1
((var = var + 1))
((result = var))
```

The postfix increment behaves differently. Here we change the increment's form in our example:
{line-numbers: true, format: Bash}
```
var=1
((result = var++))
```

These commands write the integer 1 to the `result` variable and the integer 2 to the `var` variable. Thus, postfix increment returns the value first. Then it adds one.

If you break the postfix increment into steps, you get the following commands:
{line-numbers: true, format: Bash}
```
var=1
((tmp = var))
((var = var + 1))
((result = tmp))
```

Note the order of steps in the postfix increment. First, it increments the `var` variable by one. Then it returns the past value of `var`. Therefore, the increment requires the temporary variable `tmp` to store the past value.

The postfix and prefix forms of decrement work similarly to increment.

Always use the prefix increment and decrement instead of the postfix form. First, the CPU performs them faster. The reason is it does not need to save the past value of the variable in the registers. Second, it is easier to make an error using the postfix form. It happens because of the non-obvious assignment order.

### Ternary Operator

The ternary operator is also known as the conditional operator and **ternary if**. It first appeared in the programming language [ALGOL](https://en.wikipedia.org/wiki/ALGOL). The operator turned out to be convenient and in demand by programmers. Therefore, the languages of the next generation ([BCPL](https://en.wikipedia.org/wiki/BCPL) and C) inherited ternary if. Then it comes to almost all modern languages: C++, C#, Java, Python, PHP, etc.

A ternary operator is a compact form of the `if` statement.

Here is an example. Suppose that there is the following `if` statement in the script:
{line-numbers: true, format: Bash}
```
if ((var < 10))
then
  ((result = 0))
else
  ((result = var))
fi
```

Here the `result` variable gets the zero value if `var` is less than 10. Otherwise, `result` gets the value of `var`.

The ternary operator can provide the same behavior as our `if` statement. The operator looks like this:
{line-numbers: false, format: Bash}
```
((result = var < 10 ? 0 : var))
```

Here we replaced six lines of the `if` statement with one line.

A ternary operator consists of a conditional expression and two actions. It looks like this in the general form:
{line-numbers: false}
```
(( CONDITION ? ACTION_1 : ACTION_2 ))
```

If the CONDITION is true, Bash executes the ACTION_1. Otherwise, it executes the ACTION_2. This behavior matches the `if` statement. Let's write it down in the general form too:
{line-numbers: true}
```
if CONDITION
then
  ACTION_1
else
  ACTION_2
fi
```

Compare the ternary operator and the `if` statement.

Unfortunately, Bash only allows the ternary operator in arithmetic evaluation and expansion. It means that the operator accepts only arithmetic expressions as actions. You cannot call commands and utilities as it happens in the code blocks of the `if` statement. There is no such restriction in other programming languages.

Use the ternary operator as often as possible. It is considered a good practice. The operator makes your code compact and easy to read. The less code has less room for potential errors.
