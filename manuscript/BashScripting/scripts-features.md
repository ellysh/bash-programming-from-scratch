## Why Do We Need Scripts?

We learned how to write complex Bash commands using pipelines and logical operators. The pipeline combines several commands into one. You get a linear sequence algorithm this way. Logical operators add conditions to the algorithm. You get a complete program in the result.

Why isn't the shell enough for Bash programming? Bash scripts are programs that the hard drive stores. Let's figure out why users need them.

### Backup Command

To understand Bash scripts better, we would write the command. It makes a backup of photos on the [external hard drive](https://en.wikipedia.org/wiki/Hard_disk_drive#EXTERNAL). The command consists of two actions: archiving and copying.

Suppose that the `~/photo` directory keeps all photos. The mount point of the external drive is `/d`. Then the backup command can be like this:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo && cp -f ~/photo.tar.bz2 /d
```

Because of the logical AND, copying happens when the archiving step succeeds. If the `bsdtar` utility returns an error, there is no `cp` call.

I> In our example, the backup operation happens in two steps: archiving and copying. This separation of actions is necessary for educational purposes. You can do the same by the single `bsdtar` call:
{line-numbers: false, format: Bash}
```
bsdtar -cjf /d/photo.tar.bz2 ~/photo
```

Suppose that our backup command runs automatically. For example, it launches every day by scheduling. In this case, you cannot read error messages of utilities if they fail. Then you need a log file to store the results of utilities. Here is the `bsdtar` call with the debug output:
{line-numbers: true, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo &&
echo "bsdtar - OK" > results.txt ||
echo "bsdtar - FAILS" > results.txt
```

You can split a Bash command into multiple lines. There are two ways for doing that:

1. Line break immediately after the logical operator (&& or ||).

2. Line break after backslash \.

We applied the first option in the last `bsdtar` call. The second option looks like this:
{line-numbers: true, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo \
&& echo "bsdtar - OK" > results.txt \
|| echo "bsdtar - FAILS" > results.txt
```

Here is the command to print the `cp` utility result in the log file:
```
cp -f ~/photo.tar.bz2 /d &&
echo "cp - OK" >> results.txt ||
echo "cp - FAILS" >> results.txt
```

The single command should perform the backup operation. Therefore, we can combine the `bsdtar` and `cp` calls with the logical AND. Here is the result:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo &&
  echo "bsdtar - OK" > results.txt ||
  echo "bsdtar - FAILS" > results.txt &&
cp -f ~/photo.tar.bz2 /d &&
  echo "cp - OK" >> results.txt ||
  echo "cp - FAILS" >> results.txt
```

Let's consider how this command works. For convenience, we will rewrite it in the form of a logical expression. The Latin letter replaces each command and utility call. Then we get the following result:
{line-numbers: false, format: Bash}
```
B && O1 || F1 && C && O2 || F2
```

The letters "B" and "C" represent the `bsdtar` and `cp` calls. "O1" and "F1" are the commands for printing the `bsdtar` result. The "O1" command prints the "bsdtar - OK" line into the log file. The "F1" command prints the "bsdtar - FAIL" line. Similarly, "O2" and "F2" are the commands for logging the `cp` result.

If the `bsdtar` call succeeds, the "B" operand equals "true". Then Bash performs the following steps sequence:

1. B
2. O1
3. C
4. O2 or F2

If the `bsdtar` fails, the "B" operand equals false. Then Bash does the following actions:

1. B
2. F1
3. C
4. O2 or F2

The copy operation does not make sense if the archiving step fails. The `bsdtar` utility makes things even more confusing. It creates an empty archive if you pass to it an unavailable file or directory. Then the `cp` utility copies the empty archive successfully. These operations lead to the following output to the log file:
{line-numbers: true}
```
bsdtar - FAILS
cp - OK
```

Such output confuses the user instead of clarifying the issue.

Let's come back to our expression:
{line-numbers: false, format: Bash}
```
B && O1 || F1 && C && O2 || F2
```

Why does Bash call the `cp` utility after an error in `bsdtar`? It happens because the `echo` command always succeeds. It returns zero code, which means "true". Thus, the "O1", "F1", "O2" and "F2" operands are always "true".

Now we focus on the `bsdtar` call and corresponding `echo` commands. They match the following part of the logical expression:
{line-numbers: false, format: Bash}
```
B && O1 || F1
```

We can put its left side into brackets without changing the result. Then it looks like this:
{line-numbers: false, format: Bash}
```
(B && O1) || F1
```

Here is a logical OR for the operands (B && O1) and "F1". The "F1" operand always equals "true". Therefore, the whole expression is always "true".

We can solve the problem by inverting the result of "F1". The logical NOT operator does that. This way, we get the following expression:
{line-numbers: false}
```
B && O1 || ! F1 && C && O2 || F2
```

Now, if the "B" operand fails, Bash evaluates "F1". It always equals false because of negation. Then Bash skips the "C" and "O2" command. It happens because there is a logical AND between them and "F1". The "F2" command is the next one that Bash performs. The shell needs its result because it has a logical OR in front of it.

The following parentheses would make the expression clearer:
{line-numbers: false}
```
(B && O1 || ! F1 && C && O2) || F2
```

It is evident that Bash executes the "F2" action when the parenthesized expression equals "false". Otherwise, it cannot evaluate the value of the entire expression.

This command writes the following output into the log file:
{line-numbers: true}
```
bsdtar - FAILS
cp - FAILS
```

This output is better than the previous one. Now the `cp` utility does not copy an empty archive.

However, our current result is not good enough. Imagine that the backup command contains 100 actions. If an error occurs at the 50th action, all the remaining operations print their failed results into the log file. Such output prevents you from finding the problem. The best solution here is to terminate the command after the first error. To do that, we can group calls of utilities and their output with parentheses. Here is the result:
{line-numbers: false}
```
(B && O1 || ! F1) && (C && O2 || F2)
```

Let's check what happens if the "B" operand is false. Then Bash executes the "F1" action. The negation inverts "F1" result. Therefore, the entire left side of the expression equals "false". Here is the left side:
{line-numbers: false}
```
(B && O1 || ! F1)
```

Then short-circuit evaluation happens. Because of it, Bash does not calculate the right operand of the logical AND. It means that the shell skips all actions on the right side of the expression. Here is the right side:
{line-numbers: false}
```
(C && O2 || F2)
```

It is the behavior we wanted.

We can add one more improvement. The "F2" operand should be inverted. Then the whole expression equals "false" if "C" is "false". It means that the backup command fails if the `cp` utility fails. It sounds reasonable. Also, you would need such behavior for integrating the backup command with other commands.

Here is the final version of our expression:
{line-numbers: false}
```
(B && O1 || ! F1) && (C && O2 || ! F2)
```

Let's come back to the real Bash code. The backup command looks like this now:
{line-numbers: true, format: Bash}
```
(bsdtar -cjf ~/photo.tar.bz2 ~/photo &&
  echo "bsdtar - OK" > results.txt ||
  ! echo "bsdtar - FAILS" > results.txt) &&
(cp -f ~/photo.tar.bz2 /d &&
  echo "cp - OK" >> results.txt ||
  ! echo "cp - FAILS" >> results.txt)
```

We wrote the command quickly. But it is hard for reading and understanding. It is often happening in programming. Because of it, you should pay more efforts to make your code clean and obvious. Code cleanliness is more important than a high speed of writing it.
