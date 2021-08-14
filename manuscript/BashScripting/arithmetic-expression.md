## Arithmetic Expressions

Bash allows you to do calculations on integers. You can apply the following operations there: addition, subtraction, multiplication and division. Besides that, Bash provides bitwise and logical operators. You will use them often when programming.

Bash does not support floating-point arithmetic. If you need this arithmetic in your scripts, please use the [bc](https://en.wikipedia.org/wiki/Bc_(programming_language)) or [dc](https://en.wikipedia.org/wiki/Dc_(computer_program)) calculator.

### Integer Representation

The first question we should consider is integers' representation in the computer's memory. This knowledge helps you to get mathematical operations in Bash.

You already know [integers](https://en.wikipedia.org/wiki/Integer) from mathematic. They do not have a fractional component and can be positive or negative. Programming languages with the static type system provide an [**integer**](https://en.wikipedia.org/wiki/Integer_(computer_science)) type of variables. You should use this type whenever you need to operate integers.

You can be very precise in programming and specify if the integer variable is positive only. The integer of this kind is called **unsigned**. If it can become positive and negative, the variable is called **signed**.

There are three common ways of representing integers in computer memory:

* [**Sign-magnitude representation**](https://en.wikipedia.org/wiki/Signed_number_representations#Sign-and-magnitude_method) (SMR)

* [**Ones' complement**](https://en.wikipedia.org/wiki/Signed_number_representations#Ones'_complement)

* [**Two's complement**](https://en.wikipedia.org/wiki/Signed_number_representations#Two's_complement)

#### Sign-Magnitude Representation

All numbers in the computer's memory are represented in binary form. It means that the computer stores them as a sequence of zeros and ones. A number representation defines how to interpret this sequence.

First, we consider the simplest numbers representation that is the sign-magnitude representation or SMR. There are two options to use it:

1. To store positive integers (unsigned).

2. To store both positive and negative integers (signed).

The computer allocates a fixed block of memory for any number. When you choose the first option of SMR, all allocated memory bits are used in the same way. They store the value of the number. Table 3-13 shows several examples of how it looks like.

{caption: "Table 3-13. Sign-magnitude representation of the unsigned integers", width: "70%"}
| Decimal | Hexadecimal | SMR |
| --- | --- | --- |
| 0 | 0 | 0000 0000 |
| 5 | 5 | 0000 0101 |
| 60 | 3C | 0011 1100 |
| 110 | 6E | 0110 1110 |
| 255 | FF | 1111 1111 |

Suppose that the computer allocates one byte of memory for a number. Then you can store unsigned integers from 0 to 255 there using SMR.

The second option of SMR allows you to store signed integers. In this case, the highest bit keeps the integer's sign. Therefore, there are fewer bits left for the value of the number.

Here is an example. Suppose that a computer allocates one byte to store the signed integer. One bit is reserved to indicate the positive or negative sign. Then you have seven bits only to store the number itself.

Table 3-14 shows the sign-magnitude representation of several  signed integers.

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

The highest (leftmost) bit of all negative numbers equals one. It equals zero for positive numbers. Because of the sign, it is impossible to store numbers greater than 127 in one byte. The minimum allowed negative number is -127 for the same reason.

There are two reasons why SMR is not widespread nowadays:

1. Arithmetic operations on negative numbers complicate the processor architecture. A processor module for adding positive numbers is not suitable for negative numbers.

2. There are two representations of zero: positive (0000 0000) and negative (1000 0000). It complicates the comparison operation because these values are not equal in memory.

Take your time and try to get well how the SMR works. Without getting it, you won't understand the other two ways of representing integers.

#### Ones' Complement

SMR has two disadvantages. They led to technical issues when computer engineers had used this representation in practice. Therefore, the engineers started looking for an alternative approach to store numbers in memory. This way, they came to ones' complement representation.

The first problem of SMR is related to operations on negative numbers. The ones' complement solves it. Let's consider this problem in detail.

The example will explain to you what exactly happens when you operate negative numbers in SMR. Suppose that you want to add integers 10 and -5. First, you should write them in SMR. Assume that each integer occupies one byte in computer memory. Then you represent them this way:
{line-numbers: false}
```
10 = 0000 1010
-5 = 1000 0101
```

Now the question arises. How does the processor add these two numbers? Any modern processor has a standard module called [**adder**](https://en.wikipedia.org/wiki/Adder_(electronics)). It adds two numbers in a bitwise manner. If you apply it for our task, you get the following result:
{line-numbers: false}
```
10 + (-5) = 0000 1010 + 1000 0101 = 1000 1111 = -15
```

This result is wrong. It means that the adder cannot add numbers in SMR. The calculation mistake happens because the adder handles the highest bit of the number wrongly. This bit stores the integer's sign.

There are two ways for solving the problem:

1. Add a special module to the processor. It should process operations on negative integers.

2. Change the integer representation in memory. The representation should fit the adder logic when it operates negative integers.

The development of computer technology followed the second way. It is cheaper than complicating the processor architecture.

The ones' complement reminds SMR. The sign of the integer occupies the highest bit. The remaining bits store the number. The difference with SMR is all bits of a negative number are inverted. It means zeros become ones, and ones become zeros. Bits of positive numbers are not inverted.

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

The memory capacity is the same when you switch from SMR to the ones' complement. One byte can store numbers from -127 to 127 in both cases.

How did inverting the bits of negative numbers solve the adder problem? Let's come back to our example with adding 10 and -5. First, you should represent them in the ones' complement this way:
{line-numbers: false}
```
10 = 0000 1010
-5 = 1111 1010
```

When you apply the standard adder, you get the following result:
{line-numbers: false}
```
10 + (-5) = 0000 1010 + 1111 1010 = 1 0000 0100
```

The addition led to the overflow because the highest one does not fit into one byte. It is discarded in this case. Then the result becomes like this:
{line-numbers: false}
```
0000 0100
```

The discarded highest one affects the final result. You need a second calculation step to take it into account. There you add the discarded value to the result this way:
{line-numbers: false}
```
0000 0100 + 0000 0001 = 0000 0101 = 5
```

You got the correct result of adding numbers 10 and -5.

If the addition results in a negative number, the second calculation step is unnecessary. Here is an example of adding numbers -7 and 2. First, write them in the ones' complement representation:
{line-numbers: false}
```
-7 = 1111 1000
2 = 0000 0010
```

Then add the numbers:
{line-numbers: false}
```
-7 + 2 = 1111 1000 + 0000 0010 = 1111 1010
```

The highest bit equals one. It means that you got a negative number. Therefore, you should skip the second calculation step.

Let's check if the result is correct. You can convert it from ones' complement to SMR for convenience. Invert bits of the number for doing that. The highest bit should stay unchanged. Here is the result:
{line-numbers: false}
```
1111 1010 -> 1000 0101 = -5
```

This is the correct result of adding -7 and 2 and.

The ones' complement solves the first of two SMR's problems. Now the CPU adder can operate any signed integers. This solution has one disadvantage. Addition requires two steps when you get a positive number in the result. This drawback slows down computations.

SMR has another problem with zeros. It represents zero in two ways. The ones' complement does not solve it.

#### Two's Complement

The two's complement solves both problems of SMR. First, it allows the CPU adder to operate negative numbers in one step. You need two steps for that when using the ones' complement. Second, the two's complement has only one way to represent zero.

Positive integers in the two's complement and SMR look the same. The highest bit equals zero there. The remaining bits store the number.

Negative integers in the two's complement have the highest bit equal to one. The rest bits are inverted the same way as in the ones' complement. The only difference is you need to add one to the negative number after inverting its bits.

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

The memory capacity stays the same when you switch from SMR to the two's complement. One byte can store the numbers from -127 to 127.

Here is an example of adding numbers 14 and -8. First, you should write them in the two's complement this way:
{line-numbers: false}
```
14 = 0000 1110
-8 = 1111 1000
```

Now you can add the numbers:
{line-numbers: false}
```
14 + (-8) = 0000 1110 + 1111 1000 = 1 0000 0110
```

The addition leads to the overflow. The highest one does not fit into a single byte. The rest bits make a positive number. It means that you should discard the highest one. This way, you get the following result:
{line-numbers: false}
```
0000 0110 = 6
```

When addition gives a negative result, you should not discard the highest bit. Here is an example. You want to add numbers -25 and 10. They look this way in the two's complement:
{line-numbers: false}
```
-25 = 1110 0111
10 = 0000 1010
```

This is the result of the addition:
{line-numbers: false}
```
-25 + 10 = 1110 0111 0000 1010 = 1111 0001
```

Now you should convert the result to decimal. First, covert it from two's complement to the ones' complement. Second, convert the result to SMR. You get the following sequence of conversions:
{line-numbers: false}
```
1111 0001 - 1 = 1111 0000 -> 1000 1111 = -15
```

When converting from the ones' complement to SMR, you invert all bits except the highest one. This way, you get the correct result of adding -25 and 10.

The two's complement allows the CPU adder to operate negative numbers. Moreover, such calculations require a single step only. Therefore, there is no performance loss, unlike the ones' complement case.

The two's complement solves the problem of zero representation. It has only one way to represent it. Zero is the number with all bits zeroed. Therefore, you do not have issues with comparing numbers anymore.

All modern computers use the two's complement representation to store numbers in memory.

{caption: "Exercise 3-7. Arithmetic operations with numbers in the two's complement representation", format: text, line-numbers: false}
```
Represent the following integers in the two's complement and add them:

* 79 + (-46)
* -97 + 96

Represent the following two-byte integers in the two's complement and add them:

* 12868 + (-1219)
```

#### Converting Numbers

You have learned how a computer represents numbers in memory. Would you need this knowledge in practice?

Modern programming languages take care of converting numbers to the correct format. For example, you declare a signed integer variable in decimal notation. You do not need to worry about how the computer stores it in memory. If the variable becomes negative, the computer applies the two's complement representation automatically.

There are cases when you want to treat a variable as a set of bits. You declare it as a positive integer in this case. You should operate it in hexadecimal. Please do not convert this variable to decimal. This way, you avoid the problems of converting numbers.

The issue arises when you want to read data from some device. Such a task often occurs in the [**system software development**](https://en.wikipedia.org/wiki/System_software). Specialists of this domain deal with device drivers, OS kernels and their modules, system libraries and network protocol stack.

An example will demonstrate you a problem. Suppose that you are writing a driver for a peripheral device. It measures air temperature cyclically and sends the results to the CPU. Your task is to interpret these data correctly. Unfortunately, the computer cannot do it for you. It happens because the computer and device represent the numbers differently. Therefore, you should write a code that does the conversion. You need to know numbers representation for doing that.

There is another task that requires you to know the two's complement. I am talking about debugging your program. Suppose that the program gives you an unexpectedly large number in the result. If you know the two's complement, you can guess that an integer overflow happens. This helps you find the root cause of the problem.

### Operator ((

Bash performs integer arithmetic in **math context**.

I> The syntax of math context resembles the C language. The idea behind it is to make Bash easier for learning for programmers who have experience with the C language. Most users of the first Unix versions knew C.

Suppose that you want to store a result of adding two numbers in a variable. You need to declare it using the `-i` attribute and assign a value in the declaration. Here is an example:
{line-numbers: false, format: Bash}
```
declare -i var=12+7
```

When processing this declaration, the variable gets value 19 instead of the "12+7" string. It happens because the `-i` attribute forces Bash to apply the mathematical context when handling the variable.

There is an option to apply the mathematical context besides the variable declaration. Call the `let `built-in for doing that.

Suppose that you declared the variable without the `-i` attribute. Then the `let` built-in allows you to calculate an arithmetic expression and assign its result to the variable. Here is an example:
{line-numbers: false, format: Bash}
```
let text=5*7
```

The `text` variable gets integer 35 after executing this command.

When declaring a variable using the `-i` attribute, you do not need the `let` command. You can calculate the arithmetic expression without it this way:
{line-numbers: false, format: Bash}
```
declare -i var
var=5*7
```

Now the `var` variable equals 35.

Declaring a variable using the `-i` attribute creates the mathematical context implicitly. The `let` built-in does it explicitly. Avoid implicit mathematical contexts whenever it is possible. They can lead to errors. The `-i` attribute does not affect the way of how Bash stores the variable in memory. Instead, it forces Bash to convert strings into numbers every time you operate the variable.

The `let` command allows you to treat a string variable as an integer variable. This way, you can do the following assignments:
{line-numbers: true, format: Bash}
```
let var=12+7
let var="12 + 7"
let "var = 12 + 7"
let 'var = 12 + 7'
```

All four commands give you the same result. They assign number 19 to the `var` variable.

The `let` built-in takes parameters on input. Each of them should be a valid arithmetic expression. If there are spaces, Bash splits the expression into parts because of word splitting. In this case, `let` computes each part separately. It can lead to errors.

The following command demonstrates the issue:
{line-numbers: false, format: Bash}
```
let var=12 + 7
```

Here Bash applies word splitting. It produces three expressions that the `let` built-in receives on input. These are the expressions:

* var=12
* +
* 7

When calculating the second expression, `let` reports the error. The plus sign means the arithmetic addition. The addition requires two operands. There are no operands at all in our case.

If you pass several correct expressions to the `let` built-in, it evaluates them one by one. Here are the examples:
{line-numbers: true, format: Bash}
```
let a=1+1 b=5+1
let "a = 1 + 1" "b = 5 + 1"
let 'a = 1 + 1' 'b = 5 + 1'
```

The results of all three commands are the same. The `a` variable gets number 2. The `b` variable gets number 6.

If you need to prevent word splitting of the `let` parameters, apply single or double quotes.

The `let` built-in has a synonym that is the (( operator. Bash skips word splitting when handling everything inside the parentheses. Therefore, you do not need quotes there. Always use the (( operator instead of the `let` built-in. This way, you will avoid mistakes.

I> The relationship of the (( operator and the `let` command resembles that of `test` and the [[ operator. You should use operators rather than commands in both cases.

The (( operator has two forms. The first one is called the [**arithmetic evaluation**](https://wiki.bash-hackers.org/syntax/ccmd/arithmetic_eval). It is a synonym for the `let` built-in. The arithmetic evaluation looks like this:
{line-numbers: false, format: Bash}
```
((var = 12 + 7))
```

Here the double opening parentheses replace the `let` keyword. When using the arithmetic evaluation, you need double closing parentheses at the end. When the evaluation succeeds, it returns zero exit status. It returns exit status equals one when it fails. After calculating the arithmetic evaluation, Bash replaces it with its exit status.

The second form of the (( operator is called the [**arithmetic expansion**](https://wiki.bash-hackers.org/syntax/expansion/arith). It looks like this:
{line-numbers: false, format: Bash}
```
var=$((12 + 7))
```

Here you put a dollar sign before the (( operator. In this case, Bash calculates the arithmetic expression and replaces it by its value.

I> The second form of the (( operator is a part of the POSIX standard. Use it for writing portable code. The first form of the operator is available in Bash, ksh and zsh interpreters only.

You can skip the dollar sign before variable names inside the (( operator. Bash evaluates them correctly in this case. For example, the following two expressions are equivalent:
{line-numbers: true, format: Bash}
```
a=5 b=10
result=$(($a + $b))
result=$((a + b))
```

Both expressions assign number 15 to the `result` variable.

Do not use the dollar sign inside the (( operator. It makes your code clearer.

I> Bash has an obsolete form of the arithmetic expansion that is the "$[ ]" operator. Never use it. Besides that, there is the GNU utility called `expr`. It calculates arithmetic expressions too. Bash uses it when launching old Bourne Shell scripts. You should never use `expr`.

Table 3-17 shows the operations that you can perform in the arithmetic expression.

{caption: "Table 3-17. The operations of the arithmetic expression", width: "100%"}
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
| `<<=` | Do bitwise left shift and assign the result | `echo "$((num <<= 1)) = 10` |
|  | | |
| `>>=` | Do bitwise right shift and assign the result | `echo "$((num >>= 2)) = 2"` |
|  | | |
| `&=` | Do bitwise AND and assign the result | `echo "$((num &= 3)) = 2"` |
|  | | |
| `^=` | Do bitwise XOR and assign the result | `echo "$((num^=7)) = 5"` |
|  | | |
| `|=` | Do bitwise OR and assign the result | `echo "$((num |= 7)) = 7"` |
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

Bash performs all operations of the arithmetic expression in order of their priorities. The operations with a higher priority come first.

Table 3-18 shows the priority of operations.

{caption: "Table 3-18. Priority of operations of the arithmetic expression", width: "100%"}
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

You can change the order of operations execution using parentheses "( )". Their contents are called **subexpression**. It has the highest priority for Bash. If there are several subexpressions, Bash calculates them in the left-to-right order.

Suppose your code uses a numeric constant. You can specify its value in any numeral system. Use a prefix for choosing the system. Table 3-19 shows the list of allowable prefixes.

{caption: "Table 3-19. The prefixes for numeral systems", width: "100%"}
| Prefix | Numeral System | Example] |
| --- | --- | --- |
| `0` | Octal | `echo "$((071)) = 57"` |
| `0x` | Hexadecimal | `echo "$((0xFF)) = 255"` |
| `0X` | Hexadecimal | `echo "$((0XFF)) = 255"` |
| `<base>#` | The numeral system with a base from 2 to 64 | `echo "$((16#FF)) = 255"` |
| | | `echo "$((2#101)) = 5"` |

When printing a number, Bash always converts it to decimal. The `printf` built-in changes the format of the number on output. You can use it this way:
{line-numbers: false, format: Bash}
```
printf "%x\n" 250
```

This command prints number 250 in hexadecimal.

The `printf` built-in handles variables in the same way:
{line-numbers: false, format: Bash}
```
printf "%x\n" $var
```

### Arithmetic Operations

Let's start with the arithmetic operations because they are the simplest. Programming languages use regular symbols to denote them:

* `+` addition
* `-` subtraction
* `/` division
* `*` multiplication

There are two more operations that are often used in programming. These are exponentiation and [division with remainder](https://en.wikipedia.org/wiki/Euclidean_division).

Suppose that you want to raise the `a` number to the power of `b`. You can write it on paper this way: a^b^. Here `a` is the base and `b` is the exponent. If you want to raise two to the power of seven, you write 2^7^. The same operation in Bash looks like this:
{line-numbers: false}
```
2**7
```

Calculating the remainder of a division is a complex but essential operation in programming. Therefore, we should consider it in detail.

Suppose that you have divided one integer by another. You get a fractional number in the result. The division operation produced a [**remainder**](https://en.wikipedia.org/wiki/Remainder) in this case.

Here is an example. Suppose that you want to divide the number 10 (the dividend) by 3 (the divisor). If you round the result, you will get 3.33333 (the quotient). The remainder of the division equals 1 in this case. To find it, you should multiply the divisor 3 by the integer part of the quotient 3 (the incomplete quotient). Then subtract the result from the dividend 10. It gives you the remainder, which equals 1.

Let's write our calculations in formulas. We can introduce the following notation for that:

* `a` is a dividend
* `b` is a divisor
* `q` is an incomplete quotient
* `r` is a remainder

Using the notation, you get this formula for calculating the dividend:
{line-numbers: false}
```
a = b * q + r
```

Move the "b * q" multiplication to the left side of the equal sign. Then you get the following formula for finding the remainder:
{line-numbers: false}
```
r = a - b * q
```

The right choice of an incomplete quotient `q` raises questions. Sometimes several numbers fit this role. There is a restriction that helps you to choose the right one. The `q` quotient should have the value that makes the `r` remainder's absolute value less than the `b` divisor. In other words, it should fulfill the following inequality:
{line-numbers: false}
```
|r| < |b|
```

The percent sign denotes the operation of finding the remainder in Bash. Some languages use the same symbol for the [**modulo operation**](https://en.wikipedia.org/wiki/Modulo_operation). These two operations [are not the same](https://rob.conery.io/2018/08/21/mod-and-remainder-are-not-the-same). They give the same results only when the signs of the dividend and the divisor match.

Here is an example of calculating the division remainder and modulo when dividing 19 by 12 and -19 by -12. You will get these results:
{line-numbers: false}
```
19 % 12 = 19 - 12 * 1 = 7
19 modulo 12 = 19 - 12 * 1 = 7

-19 % -12 = -19 - (-12) * 1 = -7
-19 modulo -12 = -19 - (-12) * 1 = -7
```

Let's change the signs of the dividend and divisor. Then you get the following pairs of numbers: 19, -12 and -19, 12. If you calculate the division remainder and modulo for them, you get these results:
{line-numbers: false}
```
19 % -12 = 19 - (-12) * (-1) = 7
19 modulo -12 = 19 - (-12) * (-2) = -5

-19 % 12 = -19 - 12 * (-1) = -7
-19 modulo 12 = -19 - 12 * (-2) = 5
```

You see that the remainder and the modulo differ for the same pairs of numbers. It looks strange because you use the same formula for calculating them. The trick happens when you choose the `q` incomplete quotient. You calculate it this way when finding the division remainder:
{line-numbers: false}
```
q = a / b
```

You should round the result to the lowest [absolute number](https://en.wikipedia.org/wiki/Absolute_value). It means discarding all decimal places.

Calculating the incomplete quotient for finding the modulo depends on the signs of `a` and `b`. If the signs are the same, the formula for the quotient stays the same:
{line-numbers: false}
```
q = a / b
```

If the signs differ, you should use another formula:
{line-numbers: false}
```
q = (a / b) - 1
```

You should round the result to the lowest absolute number in both cases.

When somebody talks about the division remainder `r`, he usually assumes that both the dividend `a` and divisor `b` are positive. That is why programming books often mention the following condition for `r`:
{line-numbers: false}
```
0 ≤ r < |b|
```

However, you can get a negative remainder when dividing numbers with different signs. Remember a simple rule: the `r` remainder always has the same sign as the `a` dividend. If the signs of `r` and `a` differ, you have found the modulo but not the division remainder.

Always keep in mind the difference between the division remainder and modulo. Some programming languages provide the % operator that calculates the remainder. Other languages have the same operator, but it calculates the modulo. It leads to confusion.

If you are unsure of your calculations, check them. The % operator of Bash always computes the division remainder. For example, you want to find the remainder of dividing 32 by -7. This command does it:
{line-numbers: false, format: Bash}
```
echo $((32 % -7))
```

This command prints the division remainder that equals four.

Now let's find the modulo for the same pair of numbers. You can use the [online calculator](https://planetcalc.com/8326) for that. First, enter the dividend 32 in the "Expression" field. Then enter the divisor 7 in the "Modulus" field. Finally, click the "CALCULATE" button. You will get two results:

* The "Result" field shows 4.
* The "Symmetric representation" field shows -3.

The first number 4 is the division remainder. The second number -3 is the modulo that you are looking for.

When do you need the division remainder in programming? It is often used for checking an integer for parity. For example, there is a widespread approach that controls the integrity of transmitted data in computer networks. It is called the [**parity bit**](https://en.wikipedia.org/wiki/Parity_bit) check. You need to calculate the division remainder there.

I> To check a number for parity, you should calculate the remainder of its division by 2. If the remainder is zero, then the number is even. Otherwise, it is odd.

Another task that requires calculating the division remainder is converting the time units. For example, you want to convert 128 seconds into minutes.

First, you count the number of minutes in 128 seconds. Divide 128 by 60 to do that. The result equals 2, which is the incomplete quotient. It means that 128 seconds contains 2 minutes.

The second step is calculating the remainder of dividing 128 by 60. This way, you will find the remaining seconds to add. Here is the result:
{line-numbers: false}
```
r = 128 - 60 * 2 = 8
```

The remainder equals 8. It means that 128 seconds equals two minutes and eight seconds.

Calculating the remainder is useful when working with loops. Suppose that you want to act on every 10th iteration of the loop. Then you need to check the remainder of dividing the loop counter by 10. If the remainder is zero, then the current iteration is a multiple of 10. Thus, you should act on this iteration.

The modulo operation is widely used in [**cryptography**](https://en.wikipedia.org/wiki/Modulo_operation#Properties_(identities)).

{caption: "Exercise 3-8. Modulo and the division remainder", format: text, line-numbers: false}
```
Calculate the division remainder and modulo for the following pairs of numbers:

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

[**Bitwise operations**](https://en.wikipedia.org/wiki/Bitwise_operation) handle each bit of a number individually. You will use them often when programming. Let's consider how they work in detail.

#### Bitwise negation

First, we will consider the simplest bitwise operation that is the negation. It is also called bitwise NOT. The tilde symbol indicates this operation in Bash.

When doing bitwise negation, you swap the value of each bit of an integer. It means that you replace each 1 to 0 and vice versa.

Here is an example of doing bitwise NOT for number 5:
{line-numbers: false}
```
5 = 101
~5 = 010
```

The bitwise NOT is a simple operation when we are talking about mathematics. However, there are pitfalls when using it in programming. You should keep in mind two things:

* How many bytes does the number occupy?
* What is the number's representation in memory?

Suppose that the two-byte variable stores the number 5. Then it looks like this in memory:
{line-numbers: false}
```
00000000 00000101
```

When you apply the bitwise NOT for this variable, you get the following result:
{line-numbers: false}
```
11111111 11111010
```

What do these bits mean? If you store them to the variable of the unsigned integer type, you get the number 65530. If the variable is a signed integer, it equals -6. You can check it by converting the two's complement representation to decimal.

Various Bash built-ins and operators represent integers in different ways. For example, `echo` always outputs numbers as signed integers. The `printf` command allows you to choose between a signed and unsigned integers.

There are no types in the Bash language. Bash stores all scalar variables as strings. It converts strings to integers right before inserting them into arithmetic expressions. The number interpretation (signed or unsigned) depends on the context.

Bash allocates 64 bits of memory space for each integer, regardless of its sign. Table 3-20 shows maximum and minimum allowed integers in Bash.

{caption: "Table 3-20. Maximum and minimum allowed integers in Bash", width: "100%"}
| Integer | Hexadecimal | Decimal |
| --- | --- | --- |
| Maximum positive signed | 7FFFFFFFFFFFFFFF | 9223372036854775807 |
| Minimum negative signed | 8000000000000000 | -9223372036854775808 |
| Maximum unsigned | FFFFFFFFFFFFFFFF | 18446744073709551615 |

The following examples show you how Bash interprets integers in the (( operator, `echo` and `printf` built-ins:
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

The last example of comparing the numbers 18446744073709551615 and -1 confirms that Bash stores signed and unsigned integers the same way in memory. However, it interprets them depending on the context.

Let's come back to the bitwise negation of the number 5. Bash gives you the result 0xFFFFFFFFFFFFFFFFFA in hexadecimal. You can print it as a positive or negative integer this way:
{line-numbers: true, format: Bash}
```
$ echo $((~5))
-6

$ printf "%llu\n" $((~5))
18446744073709551610
```

The numbers 18446744073709551610 and -6 are equal for Bash. It happens because all their bits in memory are the same.

{caption: "Exercise 3-9. Bitwise NOT", format: text, line-numbers: false}
```
Apply bitwise NOT for the following unsigned two-byte integers:

* 56
* 1018
* 58362

Repeat the calculations for the case when these are the signed integers.
```

#### Bitwise AND, OR and XOR

The bitwise AND operation resembles the logical AND. The result of the logical AND is "true" when both operands are "true". Any other operands lead to the "false" result.

The bitwise AND operate the numbers instead of Boolean expressions. These are steps to perform the bitwise AND manually:

1. Represent the numbers in the two's complement.

2. If one number has fewer bits than another, add zeros to its left side.

3. Take the bits of the numbers in the same position and apply the logical AND for them.

Here is an example. You want to calculate the bitwise AND for numbers 5 and 3. First, you should represent them in the two's complement like this:
{line-numbers: false}
```
5 = 101
3 = 11
```

The number 3 has fewer bits than 5. Therefore, you have to add an extra zero on its left side. This way, you get the following representation of the number 3:
{line-numbers: false}
```
3 = 011
```

Now you should apply the logical AND for each pair of bits of the numbers. You can write the numbers in columns for convenience:
{line-numbers: false}
```
101
011
---
001
```

The result equals 001. You can translate it in decimal this way:
{line-numbers: false}
```
001 = 1
```

It means that the bitwise AND for numbers 5 and 3 produces 1.

The ampersand sign denotes the bitwise AND operation in Bash. For example, the following command performs our calculations and prints the result:
{line-numbers: false, format: Bash}
```
echo $((5 & 3))
```

The bitwise OR operation works similarly as bitwise AND. The only difference is it applies logical OR instead of AND for each pair of bits.

Here is an example. Suppose that you need to calculate the bitwise OR for the numbers 10 and 6. First, you should write them in the two's complement representation this way:
{line-numbers: false}
```
10 = 1010
6 = 110
```

The number 6 is one bit shorter than 10. Then you should extend it by zero like this:
{line-numbers: false}
```
6 = 0110
```

Now you perform the logical OR on each pair of bits of the numbers:
{line-numbers: false}
```
1010
0110
----
1110
```

The last step is converting the result to decimal:
{line-numbers: false}
```
1110 = 14
```

The number 14 is the result of the bitwise OR.

The vertical bar denotes the bitwise OR in Bash. Here is the command to check our calculations:
{line-numbers: false, format: Bash}
```
echo $((10 | 6))
```

The bitwise exclusive OR (XOR) operation is similar to the bitwise OR. You should replace the logical OR with the **exclusive OR** when handling the bits of the numbers there. The exclusive OR returns "false" only when both operands have the same values. Otherwise, it returns "true".

Let's calculate the exclusive OR for the numbers 12 and 5. First, represent them in the two's complement:
{line-numbers: false}
```
12 = 1100
5 = 101
```

Then supplement the number 5 to four bits:
{line-numbers: false}
```
5 = 0101
```

Perform the exclusive OR for each pair of bits:
{line-numbers: false}
```
1100
0101
----
1001
```

Finally, convert the result to decimal:
{line-numbers: false}
```
1001 = 9
```

The caret symbol denotes the exclusive OR in Bash. For example, the following command checks our calculations:
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

A bit shift changes the positions of the bits in a number.

There are three types of bit shifts:

1. Logical
2. Arithmetic
3. Circular

The simplest shift type is the logical one. Let's consider it first.

Any bit shift operation takes two operands. The first one is some integer, which bits you want to shift. The second operand is the number of bits to move.

Here is an algorithm for doing the logical bit shift:

1. Represent the integer in the two's complement.

2. Discard the required amount of bits on the RHS for the right shift and the LHS for the left shift.

3. Append zeroes on the opposite side of the number. This is LHS for the right shift and RHS for the left shift. The amount of zeroes matches the number of shifted bits.

Here is an example. You need to do a logical right shift of the unsigned integer 58 by three bits. The integer occupies one byte of memory.

First, you represent the number in the two's complement:
{line-numbers: false}
```
58 = 0011 1010
```

The second step is discarding three bits on the right side of the number this way:
{line-numbers: false}
```
0011 1010 >> 3 = 0011 1
```

Finally, you add zeros to the left side of the result:
{line-numbers: false}
```
0011 1 = 0000 0111 = 7
```

The number 7 is the result of the shift.

Now let's do the left bit shift of the number 58 by three bits. You will get the following result:
{line-numbers: false}
```
0011 1010 << 3 = 1 1010 = 1101 0000 = 208
```

Here you follow the same algorithm as for the right shift. First, discard three leftmost bits. Then add zeros to the right side of the result.

Now let's consider the second type of bit shift that is the arithmetic shift. When you do it to the left side, you follow the logical shift algorithm. The steps are entirely the same.

The arithmetic shift to the right side differs from the logical shift. The first two steps are the same. You should convert the source integer in the two's complement and discard the bits on its right side. Then you append the same amount of bits on the left side. Their value matches the leftmost bit of the integer. If it equals one, you add ones. Otherwise, add zeros. This way, you keep the sign of the integer unchanged after the shifting.

Here is an example. Suppose that you need to do an arithmetic shift of the signed integer -105 to the right by two bits. The integer occupies one byte of memory.

First, you represent the number in the two's complement like this:
{line-numbers: false}
```
-105 = 1001 0111
```

Then you shift it to the right by two bits this way:
{line-numbers: false}
```
1001 0111 >> 2 -> 1001 01 -> 1110 0101
```

The leftmost bit of the integer equals one in this case. Therefore, you complement the result with ones on the left side.

This way, you get a negative number in the two's complement representation. You can convert it to decimal this way:
{line-numbers: false}
```
1110 0101 = 1001 1011 = -27
```

The number -27 is the result of the bit shift operation.

Bash has operators << and >>. They do arithmetic bit shifts. The following commands check your calculations:
{line-numbers: true, format: Bash}
```
$ echo $((58 >> 3))
7

$ echo $((58 << 3))
464

$ echo $((-105 >> 2))
-27
```

Bash provides another result for shifting 58 to the left by three bits. It equals 208. It happens because Bash always operates eight-byte integers.

The third type of bit shift is a circular shift. It is used in programming rarely. Therefore, most programming languages do not have built-in operators for circular shifts.

When doing the cyclic bit shift, you should append the discarded bits from one side of the number to another side.

Here is an example of the circular bit shift of the number 58 to the right by three bits:
{line-numbers: false}
```
0011 1010 >> 3 = 010 0011 1 = 0100 0111 = 71
```

You should discard bits 010 on the right side of the number. Then add them on the left side.

{caption: "Exercise 3-11. Bit shifts", format: text, line-numbers: false}
```
Perform arithmetic bit shifts for the following signed two-byte integers:

* 25649 >> 3
* 25649 << 2
* -9154 >> 4
* -9154 << 3
```

#### Using Bitwise Operations

Bitwise operations are widely used in system programming. The specialists of this domain deal with computer networks, device drivers and OS kernels. Translating data from one format to another often happens there.

Here is an example. Suppose you are writing a driver for some peripheral device. The byte order on the device is big-endian. Your computer uses another order, which is little-endian.

The device sends an unsigned integer to the computer. It equals 0xAABB in hexadecimal. Because of the different byte orders, your computer cannot handle the integer as it is. You should convert it to 0xBBAA. Then the computer reads it correctly.

Here are the steps for converting the 0xAABB integer to the computer's byte order:

1. Read the lowest (rightmost) byte of the integer and shift it to the left by eight bits, i.e. one byte. The following Bash command does that:
{line-numbers: false, format: Bash}
```
little=$(((0xAABB & 0x00FF) << 8))
```

2. Read the highest (leftmost) byte of the number and shift it to the right by eight bits. Here is the corresponding command:
{line-numbers: false, format: Bash}
```
big=$(((0xAABB & 0xFF00) >> 8))
```

3. Combine the highest and lowest bytes with the bitwise OR this way:
{line-numbers: false, format: Bash}
```
result=$((little | big))
```

Bash wrote the conversion result to the `result` variable. It is equal to 0xBBAA.

You can replace all three steps by the single Bash command:
{line-numbers: false, format: Bash}
```
value=0xAABB
result=$(( ((value & 0x00FF) << 8) | ((value & 0xFF00) >> 8) ))
```

Here is another example of using bitwise operations. You need them for computing bitmasks. You already know file permission masks in the Unix environment. Suppose that a file has the permissions "-rw-r--r--". It looks like this in binary:
{line-numbers: false}
```
0000 0110 0100 0100
```

Suppose that you want to check if the file owner can execute it. You can do that by calculating the bitwise AND for the permission mask and the 0000 0001 0000 0000 0000 number. Here is the calculation:
{line-numbers: false}
```
0000 0110 0100 0100 & 0000 0001 0000 0000 = 0000 0000 0000 0000 = 0
```

The result equals zero. It means that the owner cannot execute the file.

Using the bitwise OR, you can set bits of the bitmask. For example, you can allow the owner to execute the file this way:
{line-numbers: false}
```
0000 0110 0100 0100 | 0000 0001 0000 0000 = 0000 0111 0100 0100 = -rwxr--r--
```

I> The bits numbering is from right to left. It starts from zero.

We performed the bitwise OR for the permission mask and the 0000 0001 0000 0000 number. The eighth bit of the number equals one. It changes the eighth bit of the permission mask. The corresponding bit in the mask can have any value. It does not matter because the bitwise OR sets it to one regardless of its current value. If you do not want to change some bits in the permission mask, set the corresponding bits of the number to zero.

The bitwise AND clears bits of the bitmask. For example, let's remove the file owner's permission to write. Here is the calculation:
{line-numbers: false}
```
0000 0111 0100 0100 & 1111 1101 1111 1111 = 0000 0101 0100 0100 = -r-xr--r--
```

We set the ninth bit of the permission mask to zero. To do that, you should calculate the bitwise AND for the permission mask and the 1111 1101 1111 1111 number. The ninth bit of the number equals zero and all other bits are ones. Therefore, the bitwise AND changes the ninth bit of the permission mask only.

The OS operates masks whenever you access a file. This way, it checks your access rights.

Here is the last example of using bitwise operations. Until recently, software developers used bit shifts as an alternative to multiplication and division by a power of two. For example, the bit shift to the left by two bits corresponds to multiplication by 2^2^ (i.e. four). You can check it with the following Bash command:
{line-numbers: true, format: Bash}
```
$ echo $((3 << 2))
12
```

The bit shift gives the same result as multiplication because "3 * 4" equals 12.

This trick reduces the number of processor clock cycles to perform multiplication and division. These optimizations are now unnecessary due to the development of compilers and processors. Compilers automatically select the fastest assembly instructions when generating code. Processors execute these instructions in parallel with [several threads](https://en.wikipedia.org/wiki/Hyper-threading). Today, software developers tend to write code that is easier to read and understand. They do not care about optimizations as they do it before. Multiplication and division operations are better for reading the code than bit shifts.

Cryptography and computer graphics algorithms use bit operations a lot.

### Logical Operations

The [[ operator is inconvenient for comparing integers in the `if` statement. This operator uses two-letter abbreviations for expressing the relations between numbers. For example, the `-gt` abbreviation means greater. When you apply the (( operator instead, you can use the usual comparison symbols there. These symbols are: >, < and =.

Here is an example. Suppose that you want to compare some variable with the number 5. The following `if` construction does that:
{line-numbers: true, format: Bash}
```
if ((var < 5))
then
  echo "The variable is less than 5"
fi
```

The construction uses the (( operator in the arithmetic evaluation form. You can replace it with the `let` built-in. Then it provides the same result:
{line-numbers: true, format: Bash}
```
if let "var < 5"
then
  echo "The variable is less than 5"
fi
```

However, you should always prefer to use the (( operator.

There is an important difference between arithmetic evaluation and expansion. According to the POSIX standard, any program or command returns the zero exit status when it succeeds. It returns the status between 1 and 255 when it fails. The shell interprets the exit status like this: zero means "true" and nonzero means "false". If you apply this rule, the logical result of the arithmetic expansion is inverted. There is no such inversion for the arithmetic evaluation result.

Arithmetic evaluation is synonymous with the `let` built-in. Therefore, it follows the POSIX standard just like any other command. The shell executes the arithmetic expansion in the context of another command. Thus, its result depends on the interpreter's implementation.

Suppose that you use the (( operator in the arithmetic expansion form. Then Bash interprets its result this way: if the condition in the (( operator equals "true", it returns one. Otherwise, the operator returns zero. The C language deduces Boolean expressions in the same way.

An example will demonstrate the difference between the arithmetic expansion and evaluation. The following Bash command compares the `var` variable with the number 5:
{line-numbers: false, format: Bash}
```
((var < 5)) && echo "The variable is less than 5"
```

This command contains the arithmetic evaluation. Therefore, if the `var` variable is less than 5, the (( operator succeeds. It returns the zero exit status according to the POSIX standard. Then `echo` prints the message.

When you use the operator (( in the form of the arithmetic expansion, it gives you another result. The following command makes the same comparison:
{line-numbers: false, format: Bash}
```
echo "$((var < 5))"
```

When this condition is true, the `echo` command prints the number one. If you are familiar with the C language, you expect the same result.

You can use logical operations in the arithmetic evaluation form of the (( operator. They work in the same way as the Bash logical operators.

Here is an example of how to apply a logical operation. The following `if` condition compares the `var` variable with the numbers 1 and 5:
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

The condition is true if at least one of two expressions is true.

It rarely happens when you apply the logical NOT to some number. Instead, you use it to negate the value of some variable or expression. If you apply the logical NOT to a number, its output corresponds to the POSIX standard. In other words, zero means "true" and nonzero means "false". Here is an example:
{line-numbers: true, format: Bash}
```
if ((! var))
then
  echo "The variable equals true or zero"
fi
```

This condition is true if the `var` variable equals zero.

### Increment and Decrement

The increment and decrement operations first appeared in the [programming language B](https://en.wikipedia.org/wiki/B_(programming_language)). Ken Thompson and Dennis Ritchie developed it in 1969 while working at Bell Labs. Dennis Ritchie moved these operations later to his new language called C. Bash copied them from C.

First, let's consider the assignment operations. It helps you to get how increment and decrement work. A regular assignment in arithmetic evaluation looks like this:
{line-numbers: false, format: Bash}
```
((var = 5))
```

This command assigns the number 5 to the `var` variable.

Bash allows you to combine an assignment with arithmetic or bitwise operation. The following command does addition and assignment at the same time:
{line-numbers: false, format: Bash}
```
((var += 5))
```

The command performs two actions:

1. It adds the number 5 to the current value of the `var` variable.

2. It writes the result back to the `var` variable.

All other assignment operations work the same way. First, they do a mathematical or bitwise operation. Second, they assign the result to the variable. Using assignments makes your code shorter and clearer.

Now we will consider the increment and decrement operations. They have two forms: postfix and prefix. You should write them in different ways. The ++ and -- signs come after the variable name in the postfix form. They come before the variable name in the prefix form.

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

The increment operation increases the variable's value by one. Decrement decreases it by one.

Why does it make sense to introduce special operations for adding and subtracting one? The Bash language has assignments += and -= that you can use instead.

The most probable reason for introducing the increment and decrement is managing a [loop counter](https://en.wikipedia.org/wiki/For_loop#Loop_counters). This counter keeps the number of loop iterations. When you want to interrupt the loop, you check its counter in a condition. The result defines if you should interrupt the loop or not.

Increment and decrement make it easier to serve the loop counter. Besides that, modern processors perform these operations on the hardware level. Therefore, they work faster than addition and subtraction combined with the assignment.

What is the difference between prefix and postfix forms of increment? If the expression consists only of an increment operation, you get the same result for both forms.

For example, the following two commands increase the variable's value by one:
{line-numbers: true, format: Bash}
```
((++var))
((var++))
```

The difference between the increment forms appears when you assign the result to some variable. Here is an example:
{line-numbers: true, format: Bash}
```
var=1
((result = ++var))
```

After executing these two commands, both variables `result` and `var` store the number 2. It happens because the prefix increment first adds one and then returns the result.

If you break the prefix increment into steps, you get the following commands:
{line-numbers: true, format: Bash}
```
var=1
((var = var + 1))
((result = var))
```

The postfix increment behaves differently. Let's change the increment's form in our example:
{line-numbers: true, format: Bash}
```
var=1
((result = var++))
```

These commands write the number 1 to the `result` variable and the number 2 to the `var` variable. It happens because the postfix increment returns the current value of the variable first. Then it adds one to this value and writes the result back to the variable.

If you break the postfix increment into steps, you get the following commands:
{line-numbers: true, format: Bash}
```
var=1
((tmp = var))
((var = var + 1))
((result = tmp))
```

Note the order of steps in the postfix increment. First, it increments the `var` variable by one. Then it returns the previous value of `var`. Therefore, the increment needs the temporary variable `tmp` to store this previous value.

The postfix and prefix forms of decrement work similarly to increment. They decrease the variable by one.

Always use the prefix increment and decrement instead of the postfix form. First, the CPU performs them faster. The reason is it does not need to save the previous value of the variable in the registers. Second, it is easier to make an error using the postfix form. It happens because of the non-obvious order of assignments.

### Ternary Operator

The ternary operator is also known as the conditional operator and **ternary if**. The first time, it appeared in the programming language [ALGOL](https://en.wikipedia.org/wiki/ALGOL). The operator turned out to be convenient and many programmers liked it. The languages of the next generation ([BCPL](https://en.wikipedia.org/wiki/BCPL) and C) inherited the ternary if. This way, it comes to almost all modern languages: C++, C#, Java, Python, PHP, etc.

The ternary operator is a compact form of the `if` statement.

Here is an example. Suppose that your script has the following `if` statement:
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

You can get the same behavior using the ternary operator. It looks like this:
{line-numbers: false, format: Bash}
```
((result = var < 10 ? 0 : var))
```

The ternary operator replaced six lines of the `if` statement with one line. This way, you got simpler and clearer code.

The ternary operator consists of a conditional expression and two actions. Its general form looks like this:
{line-numbers: false}
```
(( CONDITION ? ACTION_1 : ACTION_2 ))
```

If the CONDITION is true, Bash executes the ACTION_1. Otherwise, it executes the ACTION_2. This behavior matches the following `if` statement:
{line-numbers: true}
```
if CONDITION
then
  ACTION_1
else
  ACTION_2
fi
```

Unfortunately, Bash allows the ternary operator in arithmetic evaluation and expansion only. It means that the operator accepts arithmetic expressions as actions. You cannot call commands and utilities there, as you do it in the code blocks of the `if` statement. There is no such restriction in other programming languages.

Use the ternary operator as often as possible. It is considered a good practice. The operator makes your code compact and easy to read. The less code has less room for potential errors.
