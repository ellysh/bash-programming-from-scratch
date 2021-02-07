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

## Ones' Complement

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

Represent the following two-bytes integers in two's complement and add them:

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
| `УСЛОВИЕ ? ДЕЙСТВИЕ1 : ДЕЙСТВИЕ2` | [Ternary operator](https://en.wikipedia.org/wiki/%3F:) | `a=$(( b < c ? b : c ))` |
|  | | |
| `ДЕЙСТВИЕ1, ДЕЙСТВИЕ2` | The list of expressions | `((a = 4 + 5, b = 16 - 7))` |
|  | | |
| `( ДЕЙСТВИЕ1 )` | Grouping of expressions (subexpression) | `a=$(( (4 + 5) * 2 ))`|

Bash performs all operations in order of their priorities. The operations with a higher priority come first.

Table 3-18 shows the priority of operations.

{caption: "Table 3-18. Priority of operations in arithmetic expressions", width: "100%"}
| Priority | Operation | Description |
| --- | --- | --- |
| 1 | `( ДЕЙСТВИЕ1 )` | Grouping of expressions |
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
| 17 | `УСЛОВИЕ ? ДЕЙСТВИЕ1 : ДЕЙСТВИЕ2` | Ternary operator |
|  | | |
| 18 | `=, *=, /=, %=, +=, -=, <<=, >>=, &=, ^=, |=` | Assignments |
|  | | |
| 19 | `ДЕЙСТВИЕ1, ДЕЙСТВИЕ2` | The list of expressions |

You can change the order of execution using parentheses "( )". Their contents are called **subexpression**. Bash calculates subexpressions first. If there is more than one subexpression, Bash calculates them in the left-to-right order.

Suppose your code uses a numeric constant. You can specify its value in any numeral system. Use a prefix to select a numeral system. Table 3-19 shows the list of allowable prefixes.

{caption: "Table 3-19. The prefixes for numeral systems", width: "100%"}
| Prefix | Numeral System | Example] |
| --- | --- | --- |
| `0` | Octal | `echo "$((071)) = 57"` |
| `0x` | Hexadecimal | `echo "$((0xFF)) = 255"` |
| `0X` | Hexadecimal | `echo "$((0XFF)) = 255"` |
| `<основание>#` | The numeral system with a base from 2 to 64 | `echo "$((16#FF)) = 255"` |
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