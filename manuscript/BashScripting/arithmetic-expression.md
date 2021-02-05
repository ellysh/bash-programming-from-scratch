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
