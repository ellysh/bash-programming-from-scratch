## Conditional Statements

We have met the conditional statements when learning the `find` utility. Then we found out that Bash has its own logical operators AND (&&) and OR (||). The Bash language has other options to make branches.

We will consider the `if` and `case` operators in this section of the book.  The scripts use them often. Both operators provide similar behavior. However, each of them fits better for some specific tasks.

### If Statement

Imagine you are writing a one-line command. Such a command is called **one-liner**. You are trying to make it as compact as possible because a short command is faster to type. Also, there is less chance to make a mistake when typing.

Now imagine that you are writing a script. Your hard drive stores it. You call the script regularly and change it rarely. The code compactness is not important here. You follow another goal to make the script easy to read and modify.

The && and || operators fit well one-liners. But Bash has better options for scripts. Actually, it depends on the particular case. Sometimes you can use these operators in the script and keep its code clean. But they lead to hard-to-read code in most cases. Therefore, it is better to replace them with the `if` and `case` statements.

Here is an example. Have a look at Listing 3-9 again. There is a backup script there. It calls the `bsdtar` utility this way:
{line-numbers: true, format: Bash}
```
bsdtar -cjf "$1".tar.bz2 "$@" &&
  echo "bsdtar - OK" > results.txt ||
  { echo "bsdtar - FAILS" > results.txt ; exit 1 ; }
```

We have tried to make this script better to read. We split calls of the `bsdtar` and `mv` utilities. However, it is not enough. The `bsdtar` call is still too long and complicated for reading. Therefore, it is easy to make a mistake when modifying it. Such error-prone code is called **fragile**. A poor technical solution introduces it in most cases.

Let's improve the `bsdtar` call. First, we should write its algorithm step by step. It looks like this:

1. Read a list of files and directories from the `$@` variable. Archive and compress them.

2. If the archiving and compression were successful, write the line "bsdtar - OK" into the log file.

3. If an error occurred, write the line "bsdtar - FAILS" into the log file. Then terminate the script.

The last step is the most confusing. When `bsdtar` completes successfully, the script does one action only. When an error happens, there are two actions. These actions are combined into the single [**command block**](https://en.wikipedia.org/wiki/Block_(programming)) by [curly brackets](https://www.gnu.org/software/bash/manual/html_node/Command-Grouping.html). This code block looks confusing.

The `if` statement is a solution for executing command blocks on specific conditions. We can write the statement in the general form like this:
{line-numbers: true}
```
if CONDITION
then
  ACTION
fi
```

You can write this statement in one line too. For doing that, add a semicolon before the `then` and `fi` words like this:
{line-numbers: false}
```
if CONDITION; then ACTION; fi
```

Both the CONDITION and ACTION here are a single command or a block of commands. If the CONDITION completes successfully with the zeroed exit status, Bash executes the ACTION.

Here is an example of the `if` statement:
{line-numbers: true, format: Bash}
```
if cmp file1.txt file2.txt &> /dev/null
then
  echo "Files file1.txt and file2.txt are identical"
fi
```

The CONDITION here is the `cmp` utility call. The utility compares the contents of two files. If they differ, `cmp` prints the position of the first character that is different. The exit status is non-zero in this case. If the files are the same, the utility returns the zero status.

When we call a utility in the `if` condition, its exit status matters only. Therefore, we redirect the `cmp` output to the [`/dev/null`](https://en.wikipedia.org/wiki/Null_device) file. It is a special system file. Writing there always succeeds. OS deletes all data that you write there.

If the contents of the `file1.txt` and `file2.txt` files match, the `cmp` utility returns the zero status. Then the `if` condition equals "true". In this case, the `echo` command prints the message.

We have considered a simple case. When the condition is met, the script does an action. But there are cases where a condition selects one of two possible actions. The `if-else` statement works in this way. Here is the statement in the general form:
{line-numbers: true}
```
if CONDITION
then
  ACTION_1
else
  ACTION_2
fi
```

The same `if-else` written in one line looks like this:
{line-numbers: false}
```
if CONDITION; then ACTION_1; else ACTION_2; fi
```

Bash executes ACTION_2 if CONDITION returns the non-zero exit status. The condition is "false" in this case. Otherwise, Bash executes the ACTION_1.

You can extend the `if-else` statement by the `elif` blocks. Such a block adds an extra condition and the corresponding action. Bash executes the action if the condition equals "true".

Here is an example. Suppose you choose one of three actions depending on the value of a variable. The following `if` statement provides this behavior:
{line-numbers: true}
```
If CONDITION_1
then
  ACTION_1
elif CONDITION_2
then
  ACTION_2
else
  ACTION_3
fi
```

There is no limitation for the number of `elif` blocks in the statement. You can add as many of them as you need.

Let's extend our example of file comparison. We want to print the message in both cases: when the files match and when they do not. The `if-else` statement does the job. It looks like this:
{line-numbers: true, format: Bash}
```
if cmp file1.txt file2.txt &> /dev/null
then
  echo "Files file1.txt and file2.txt are the same."
else
  echo "Files file1.txt and file2.txt differ."
fi
```

It is time to come back to our backup script. The script has a block of commands. The result of the `bsdtar` utility decides if Bash should execute this block. When we meet the code block and condition, it is a hint to apply the `if` statement here.

We apply the `if-else` statement to the `bsdtar` call and handling its result. Then we get the following code:
```
if bsdtar -cjf "$1".tar.bz2 "$@"
then
  echo "bsdtar - OK" > results.txt
else
  echo "bsdtar - FAILS" > results.txt
  exit 1
fi
```

Do you agree that it is easier to read the code now? We can simplify it even more. The [**early return**](https://medium.com/swlh/return-early-pattern-3d18a41bba8) pattern does that. Replace the `if-else` statement with `if` like this:
{line-numbers: true, format: Bash}
```
if ! bsdtar -cjf "$1".tar.bz2 "$@"
then
  echo "bsdtar - FAILS" > results.txt
  exit 1
fi

echo "bsdtar - OK" > results.txt
```

The code behaves the same as with the `if-else` statement. The logical negation inverts the `bsdtar` utility result. Now, if it fails, the condition of the `if` statement becomes "true". Then the script prints the "bsdtar - FAILS" message to the log file and terminates. Otherwise, the script skips the command block of the `if` statement. The further `echo` call prints the "bsdtar - OK" message to the log file.

The early return pattern is a useful technique that makes your code cleaner and easier to read. The idea behind it is to terminate the program as early as possible when an error appears. This solution allows you to avoid the nested `if` statements.

Here is an example. Imagine the algorithm that does five actions. Each action depends on the result of the previous one. If the previous action fails, the algorithm stops. We can implement this algorithm with the following nested `if` statements:
{line-numbers: true}
```
if ACTION_1
then
  if ACTION_2
  then
    if ACTION_3
    then
      if ACTION_4
      then
        ACTION_5
      fi
    fi
  fi
fi
```

These nested statements look confusing. If you add the `else` blocks for handling errors, this code becomes even harder to read.

The nested `if` statements make the code hard to read. It is a serious problem. The early return pattern solves it. Let's apply the pattern to our algorithm. Then we get the following code:
{line-numbers: true}
```
if ! ACTION_1
then
  # error handling
fi

if ! ACTION_2
then
  # error handling
fi

if ! ACTION_3
then
  # error handling
fi

if ! ACTION_4
then
  # error handling
fi

ACTION_5
```

We got the same algorithm. Its behavior did not change. There are still five actions. If any of them fails, the algorithm stops. But the early return pattern made the code simpler and clearer.

We use [**comments**](https://en.wikipedia.org/wiki/Comment_(computer_programming)) in the last example. They look like this: "# error handling". A comment is a string or part of a string that the interpreter ignores. In Bash, a comment is anything that comes after the hash symbol.

I> The usefulness of comments is the subject of endless debates in the programming community. They are needed to explain the code. However, some people consider that comments are a sign of incomprehensible, poorly written code. If you just started learning to program, comment your code without doubts. Explain the complex constructions in your scripts. You can forget what do they mean afterward. Thus, you save your time in the future when you come back to the old code.

Assume that each action of the algorithm corresponds to one short command. The exit command handles all errors. There is no output to the log file. In this case, the || operator can replace the `if` statement. Then the code remains simple and clear. It will look like this:
{line-numbers: true}
```
ACTION_1 || exit 1
ACTION_2 || exit 1
ACTION_3 || exit 1
ACTION_4 || exit 1
ACTION_5
```

There is only one case when the && and || operators are more expressive than the `if` statement. The case is short commands do actions and error handling.

Let's rewrite the backup script using the `if` statement. Listing 3-11 shows the result.

{caption: "Listing 3-11. The backup script with the early return pattern", line-numbers: true, format: Bash}
![`make-backup-if.sh`](code/BashScripting/make-backup-if.sh)

We replaced the && and || operators in the `bsdtar` call with the if statement. The behavior of the script has not changed.

Logical operators and the `if` statement are not equivalent in general. Here is an example. Suppose there is an expression of three commands A, B and C:
{line-numbers: false}
```
A && B || C
```

It might seem that the following `if-else` statement gives the same behavior:
{line-numbers: false}
```
if A
then
  B
else
  C
fi
```

If A is "true", then Bash executes B. Otherwise, it executes C. But there is another behavior in the expression with logical operators. Here, if A is "true", then Bash executes B. Then C execution depends on the result of B. If B is "true", Bash skips C. If B is "false", it executes C. Thus, execution of C depends on both A and B. There is no such dependence in the `if-else` statement.

{caption: "Exercise 3-4. The `if` statement", format: text, line-numbers: false}
```
Here is the Bash command:
( grep -RlZ "123" target | xargs -0 cp -t . && echo "cp - OK" || ! echo "cp - FAILS" ) && ( grep -RLZ "123" target | xargs -0 rm && echo "rm - OK" || echo "rm - FAILS" )

It looks for the string "123" in the files of the directory named "target".
If the file contains the string, it is copied to the current directory.
If there is no string in the file, it is removed from the target directory.

Make the script from this command.
Replace the && and || operators with the if statements.
```

### Operator [[

We got acquainted with the `if` statement. It calls a built-in Bash command or utility in the condition.

For example, let's solve a task. We should check if the text file contains a phrase. When the phrase present, our script prints the message in the log file.

We can solve the task by combining the `if` statement and the `grep` utility. Put the `grep` call in the `if` condition. Then if the utility succeeds, it returns zero exit status. In this case, the `if` condition equals "true" and the script prints the message.

The `grep` utility prints its results on the output stream. We do not need this output when calling the utility in the `if` condition. The `-q` option disables the `grep` output. Finally, we get the following `if` statement:
{line-numbers: true, format: Bash}
```
if grep -q -R "General Public License" /usr/share/doc/bash
then
  echo "Bash has the GPL license"
fi
```

Now suppose that the `if` condition compares two strings or numbers. Bash has a special operator [[ for this purpose. The double square brackets are [**reserved word**](https://en.wikipedia.org/wiki/Reserved_word) of the interpreter. Bash handles the brackets on its own without calling a utility.

W> The Bourne shell does not have the [[ operator. The POSIX standard does not have it too. Therefore, if you should follow the standard, use the obsolete [`test`](http://mywiki.wooledge.org/BashFAQ/031) operator or its synonym [. Never use `test` in Bash. It has limited capabilities comparing with the operator [[. Also, it has error-prone syntax.

Let's start with a simple example of using the [[. We need to compare two strings. In this case, the `if` condition looks like this:
{line-numbers: true, format: Bash}
```
if [[ "abc" = "abc" ]]
then
  echo "The strings are equal"
fi
```

Run this code. You see the message that the strings are equal. A check of this kind is not really useful. Usually, you want to compare some variable with a string. The [[ operator compares them this way:
{line-numbers: true, format: Bash}
```
if [[ "$var" = "abc" ]]
then
  echo "The variable equals the \"abc\" string"
fi
```

Double-quotes are optional in this condition. Bash skips globbing and word splitting when it substitutes a variable in the [[ operator. The interpreter uses a variable as it is in this operator. The quotes prevent problems if the string on the right side has spaces. Here is an example of such a string:
{line-numbers: true, format: Bash}
```
if [[ "$var" = abc def ]]
then
  echo "The variable equals the \"abc def\" string"
fi
```

Bash cannot execute the condition of this `if` statement because of word splitting. Always use quotes when working with strings. This way, you avoid such problems. Here is the fixed `if` condition:
{line-numbers: true, format: Bash}
```
if [[ "$var" = "abc def" ]]
then
  echo "The variable equals the \"abc def\" string"
fi
```

The [[ operator can compare two variables with each other. It looks like this:
{line-numbers: true, format: Bash}
```
if [[ "$var" = "$filename" ]]
then
  echo "The variables are equal"
fi
```

Table 3-8 shows all string comparisons that the [[ operator allows.

{caption: "Table 3-8. String comparisons in the [[ operator", width: "100%"}
| Operation | Description | Example |
| --- | --- | --- |
| > | The string on the left side is larger than the string on the right side in the [**lexicographic order**](https://en.wikipedia.org/wiki/Lexicographic_order). | [[ "bb" > "aa" ]] && echo "The \"bb\" string is larger than \"aa\"" |
|  | | |
| < | The string on the left side is smaller than the string on the right side in the lexicographic order. | [[ "ab" < "ac" ]] && echo "The \"ab\" string is smaller than \"ac\"" |
|  | | |
| = or == | The strings are equal. | [[ "abc" = "abc" ]] && echo "The strings are equal" |
|  | | |
| != | The strings are not equal. | [[ "abc" != "ab" ]] && echo "The strings are not equal" |
|  | | |
| -z | The string is empty. | [[ -z "$var" ]] && echo "The string is empty" |
|  | | |
| -n | The string is not empty. | [[ -n "$var" ]] && echo "The string is not empty" |
|  | | |
| = or == | Search the pattern on the right side in the string on the left side. Put the pattern without quotes here. | [[ "$filename" = READ* ]] && echo "The filename starts with \"READ\"" |
|  | | |
| != | Check that the pattern on the right side does not occur in the string on the left side. Put the pattern without quotes here. | [[ "$filename" != READ* ]] && echo "The filename does not start with \"READ\"" |
|  | | |
| =~ | Search the [**regular expression**](https://mywiki.wooledge.org/RegularExpression) on the right side in the string on the left side. | [[ "$filename" =~ ^READ.* ]] && echo "The filename starts with \"READ\"" |

You can use the logical operations AND, OR and NOT in the [[ operator. They combine several expressions into a single condition. Table 3-9 gives examples of such conditions.

{caption: "Table 3-9. Logical operations in the [[ operator", width: "100%"}
| Operation | Description | Example |
| --- | --- | --- |
| && | Logical AND. | [[ -n "$var" && "$var" < "abc" ]] && echo "The string is not empty and it is smaller than \"abc\"" |
|  | | |
| \|\| | Logical OR. | [[ "abc" < "$var" \|\| -z "$var" ]] && echo "The string is larger than \"abc\" or it is empty" |
|  | | |
| ! | Logical NOT. | [[ ! "abc" < "$var" ]] && echo "The string is not larger than \"abc\"" |

You can group expressions using parentheses in the [[ operator. Here is an example:
{line-numbers: false, format: Bash}
```
[[ (-n "$var" && "$var" < "abc") || -z "$var" ]] && echo "The string is not empty and less than \"abc\" or the string is empty"
```

Comparing the strings is one feature of the [[ operator. Also, it can check files and directories for various conditions. Table 3-10 shows operations for doing that.

{caption: "Table 3-10. Operations for checking files and directories in the [[ operator", width: "100%"}
| Operation | Description | Example |
| --- | --- | --- |
| -e | The file exists. | [[ -e "$filename" ]] && echo "The $filename file exists" |
|  | | |
| -f | The specified object is a regular file. It is not a directory or [**device file**](https://en.wikipedia.org/wiki/Device_file). | [[ -f "~/README.txt" ]] && echo "The README.txt is a regular file" |
|  | | |
| -d | The specified object is a directory. | [[ -f "/usr/bin" ]] && echo "The /usr/bin is a directory" |
|  | | |
| -s | The file is not empty. | [[ -s "$filename" ]] && echo "The $filename file is not empty" |
|  | | |
| -r | The specified file exists. The user who runs the script can read the file. | [[ -r "$filename" ]] && echo "The $filename file exists. You can read it" |
|  | | |
| -w | The specified file exists. The user who runs the script can write into the file. | [[ -w "$filename" ]] && echo "The $filename file exists. You can write into it" |
|  | | |
| -x | The specified file exists. The user who runs the script can execute the file. | [[ -x "$filename" ]] && echo "The $filename file exists. You can execute it" |
|  | | |
| -N | The file exists. It was modified since you read it last time. | [[ -N "$filename" ]] && echo "The $filename file exists. It was modified" |
|  | | |
| -nt | The file on the left side is newer than the file on the right side. Either the file on the left side exists and the file on the right side does not. | [[ "$file1" -nt "$file2" ]] && echo "The $file1 file is newer than $file2" |
|  | | |
| -ot | The file on the left side is older than the file on the right side. Either the file on the right side exists and the file on the left side does not. | [[ "$file1" -ot "$file2" ]] && echo "The $file1 file is older than $file2" |
|  | | |
| -ef | There are paths to the same file on the left and right sides. If your file system supports **hard links**, it can be the links to the same file on the left and right sides. | [[ "$file1" -ef "$file2" ]] && echo "The $file1 and $file2 files match" |

The [[ operator can compare integers. Table 3-11 shows operations for doing that.

{caption: "Table 3-11. Integer comparisons in the [[ operator", width: "100%"}
| Operation | Description | Example |
| --- | --- | --- |
| -eq | The number on the left side equals the number on the right side. | [[ "$var" -eq 5 ]] && echo "The variable equals 5" |
|  | | |
| -ne | The numbers are not equal. | [[ "$var" -ne 5 ]] && echo "The variable is not equal to 5" |
|  | | |
| -gt | Greater (>). | [[ "$var" -gt 5 ]] && echo "The variable is greater than 5" |
|  | | |
| -ge | Greater or equal. | [[ "$var" -ge 5 ]] && echo "The variable is greater than or equal to 5" |
|  | | |
| -lt | Less (<). | [[ "$var" -lt 5 ]] && echo "The variable is less than 5" |
|  | | |
| -le | Less or equal. | [[ "$var" -le 5 ]] && echo "The variable is less than or equal to 5" |

Table 3-11 raises questions. The operations there are harder to remember than the usual number comparisons: <, >, and =. Why aren't comparison signs used in the [[ operator? To answer this question, let's look at the operator's history.

The [[ operator came into Bash to replace its obsolete `test` analog. The utility has implemented the `test` command in the first version of the Bourne shell in 1979. This command becomes the built-in starting with the System III shell version in 1981. But this change did not affect the `test` syntax. The reason for that is backward compatibility. Software developers have written a lot of shell code by 1981. This code has used the old syntax. Therefore, the new System III shell version had to support it.

Let's take a look at the syntax of the `test` operator. When it was a utility, the format of its input parameters had to follow Bourne shell rules. For example, here is a typical `test` call to compare the `var` variable with the number five:
{line-numbers: false, format: Bash}
```
test "$var" -eq 5
```

This command does not raise any questions. Here we pass three parameters to the `test` utility:

1. The value of the `var` variable.
2. The `-eq` option.
3. The number 5.

We can use this call in the `if` condition this way:
{line-numbers: true, format: Bash}
```
if test "$var" -eq 5
then
  echo "The variable equals 5"
fi
```

The Bourne shell introduces the [ synonym for the `test` operator. The only difference between them is the presence of the closing parenthesis ]. The `test` operator does not need it but the synonym does.

Using the [ synonym, we rewrite the `if` condition this way:
{line-numbers: true, format: Bash}
```
if [ "$var" -eq 5 ]
then
  echo "The variable equals 5"
fi
```

The synonym [ improves readability of the code. That was an idea behind it. Thanks to the synonym, the `if` statement in Bourne shell looks the same as in other programming languages (e.g., C). The problem is that the [ and `test` operators are equivalent. It is easy to lose sight of this fact. Mostly it happens when you have experience in other languages. This mismatch between expected and real behavior leads to errors.

For example, programmers often forget the space between the bracket [ and the following character. This way, they get a condition like this:
{line-numbers: true, format: Bash}
```
if ["$var" -eq 5]
then
  echo "The variable equals 5"
fi
```

Replace the bracket [ with the `test` call in the condition. Then the error becomes obvious:
{line-numbers: true, format: Bash}
```
if test"$var" -eq 5
then
  echo "The variable equals 5"
fi
```

There must be a space between the command name and its parameters.

Let's come back to the question about comparison signs for numbers. Imagine the following `test` call:
{line-numbers: false, format: Bash}
```
test "$var" > 5
```

As you remember, the > symbol is a short form of the redirect operator `1>`. Thus, our `test` call does the following steps:

1. Calls the built-in `test` command and pass the `var` variable  to it.

2. Redirects the `test` output to a file named `5` in the current directory.

We expect another behavior. Such an error is easy to make and hard to detect. To prevent it, shell developers introduced the two-letter comparison operations. The Bash operator [[ inherited these operations. It was done for backward compatibility.

Imagine that the [[ operator replaces two-letter operations with comparison signs. Then you have the legacy code written on Bourne shell. You want to port it on Bash. There is the following `if` statement in the legacy code:
{line-numbers: true, format: Bash}
```
if [ "$var1" -gt 5 -o 4 -lt "$var2" ]
then
  echo "The var1 variable is greater than 5 or var2 is less than 4"
fi
```

Here you should replace the `-gt` operation to > and `-lt` to <. It is easy to make a mistake while doing that. Putting an extra parenthesis at the beginning and end of an expression is much simpler. This idea answers our question.

You can use comparison signs for string only when working with the [[ operator. Why there is no backward compatibility issue there? The first version of the `test` utility did not support the lexicographic comparison of strings. Therefore, the utility did not have comparison signs < and >. They appeared in the extension of POSIX standard later. The standard allows comparison signs for strings only. It was too late to add them for numbers because of the legacy code amount. According to the standard, you should escape comparison signs like this: `/<` and `/>`. The operator [[ took them and dropped the escaping.

{caption: "Exercise 3-5. The [[ operator", format: text, line-numbers: false}
```
Write a script to compare two directories named "dir1" and "dir2".
The script should print all files from one directory that absent
in another one.
```

### Case Statement

Programs often choose their actions depending on some values. If the variable has one value, the program does one thing. When the value differs, it does another thing. The condition statements provide such a behavior.

We have considered the `if` statement. There is an alternative `case` statement in Bash. It is more convenient than `if` in some cases.

Let's look at an example. Suppose you are writing a script for archiving documents. The script has three operating modes:

1. Archiving with compression.
2. Archiving without compression.
3. Unarchiving.

You can choose the mode by the command-line option. Table 3-12 shows an example of possible options.

{caption: "Table 3-12. Options of the archiving script", width: "50%"}
| Option | Operating mode  |
| --- | --- |
| `-a` | Archiving with compression |
| `-c` | Archiving without compression |
| `-x` | Unarchiving |

I> Always follow the [POSIX agreement](https://www.gnu.org/software/libc/manual/html_node/Argument-Syntax.html) and its [GNU extension](https://www.gnu.org/prep/standards/html_node/Command_002dLine-Interfaces.html) when choosing scripts' options and parameters format.

You can check the script option in the `if` statement. Listing 3-12 shows an example of doing that.

{caption: "Listing 3-12. The script for archiving documents", line-numbers: true, format: Bash}
![`archiving.sh`](code/BashScripting/archiving.sh)

The `$1` position parameter keeps the script option. We write it to the `operation` variable for convenience. Then depending on this variable, we choose parameters for the `bsdtar` call. The `if` statement with two `elif` blocks checks the `operation` value.

Now we replace the `if` statement with the `case` one. Listing 3-13 shows the result.

{caption: "Listing 3-13. The script for archiving documents", line-numbers: true, format: Bash}
![`archiving-case.sh`](code/BashScripting/archiving-case.sh)

Let's call our script `archiving-case.sh`. Then we can launch it in one of the following ways:
{line-numbers: true, format: Bash}
```
./archiving-case.sh -a
./archiving-case.sh -b
./archiving-case.sh -x
```

If you pass any other parameters to the script, it prints the error message and terminates.

W> Always call the `exit` command when handling errors in a script. It should return the non-zero exit status in this case.

The `case` statement compares a string with a list of patterns. Each pattern has a corresponding code block. When the string matches the pattern, Bash executes the corresponding code block.

Each `case` block consists of the following elements:

1. A pattern or a list of patterns separated by vertical bars.

2. Right parenthesis.

3. A code block.

4. Two semicolons. They mark the end of the code block.

Bash checks patterns of the `case` blocks one by one. If the string matches the first pattern, Bash executes its code block. Then it skips other patterns. Instead, Bash executes the command that follows the `case` statement.

The `*` pattern without quotes matches any string. It is usually placed at the end of the list. The corresponding code block handles cases when none of the patterns match the string. It usually means an error.

At first sight, it may seem that the `if` and `case` statements are equivalent. They are not. They allow you to achieve the same behavior.

Let's compare the statements from Listings 3-12 and 3-13. First, we write them in a general form. Here is the result for the `if` statement:
{line-numbers: true}
```
if CONDITION_1
then
  ACTION_1
elif CONDITION_2
then
  ACTION_2
elif CONDITION_3
then
  ACTION_3
else
  ACTION_4
fi
```

The `case` statement looks like this:
{line-numbers: true}
```
case STRING in
  PATTERN_1)
    ACTION_1
     ;;

  PATTERN_2)
    ACTION_2
    ;;

  PATTERN_3)
    ACTION_3
    ;;

  PATTERN_4)
    ACTION_4
    ;;
esac
```

The difference between the constructs is evident now. First, `if` checks the results of Boolean expressions. The `case` statement compares the string with the patterns. Therefore, it makes no sense to pass a Boolean expression to the `case` condition. Doing that, you handle two cases only: when the expression is "true" and "false". The `if` statement is more convenient for such checking.

The second difference between `if` and `case` is the number of conditions. Each branch of the `if` statement checks a separate Boolean expression. In general, these expressions are independent of each other.  In our example, they check the same variable, but that is a particular case. The `case` statement checks one string that you pass to it.

The `if` and `case` statements are fundamentally different. They are not interchangeable. In each case, use the statement depending on the nature of the check. The following questions will help you to make the right choice:

* How many conditions should you check? Use `if` for checking several conditions.

* Would it be enough to check one string only? Use `case` when the answer is yes.

* Do you need compound Boolean expressions? Use `if` when the answer is yes.

There are two possible delimiters between case blocks:

1. Two semicolons `;;`.
2. Semicolons and ampersand `;&`.

The ampersand delimiter is allowed in Bash, but it is not part of the POSIX standard. When Bash meets this delimiter, it executes the next block's code without checking its pattern. It can be useful when you want to start executing an algorithm from a specific step. Also, you can avoid code duplication in some cases with the ampersand delimiter.

Here is an example of a code duplication problem. We write a script that archives PDF documents and copies the resulting file. The script receives an option to choose the action to do. For example, the `-a` option means archiving and `-c` means copying. Suppose that the script always has to do the copying after archiving. In this case, we get code duplication.

Listing 3-14 shows the `case` statement where the `cp` call is duplicated.

{caption: "Listing 3-14. The script for archiving and copying PDF documents", line-numbers: true, format: Bash}
![`copy-archiving-duplication.sh`](code/BashScripting/copy-archiving-duplication.sh)

We can avoid code duplication by adding the `;&` separator between the `-a` and `-c` blocks. Listing 3-15 shows the changed script.

{caption: "Listing 3-15. The script for archiving and copying PDF documents", line-numbers: true, format: Bash}
![`copy-archiving.sh`](code/BashScripting/copy-archiving.sh)

The `;&` delimiter is useful in some cases. However, use it carefully. You can easily confuse the delimiters when reading. This way, you misread `;;` instead of `;&` and misunderstand the code.

### Alternative to the Case Statement

The case statement and the associative array solve similar tasks. The array makes the relationship between data (key-value). The case statement does the same between data and commands (value-action).

Usually, it is more convenient to work with data than with code. It is easier to modify data and check them for correctness. Therefore, it is worth replacing the `case` statement with an associative array in some cases. Converting data into code is easy in Bash comparing with other programming languages.

Here is an example. We want to write a wrapper script for the archiving utilities. It receives command-line options. They define if the script calls the `bsdtar` or `tar` utility.

Listing 3-16 shows the script. It handles the command-line options in the `case` statement.

{caption: "Listing 3-16. The wrapper script for the archiving utilities", line-numbers: true, format: Bash}
![`tar-wrapper.sh`](code/BashScripting/tar-wrapper.sh)

Here we use the pattern list for the first two `case` blocks. The script executes the first block's commands when the `utility` variable matches the string `-b` or `--bsdtar`. Likewise, the script executes the second block when the variable matches `-t` or `--tar`.

For example, you can launch the script this way:
{line-numbers: false, format: Bash}
```
./tar-wrapper.sh --tar -cvf documents.tar.bz2 Documents
```

The script calls the `tar` utility to archive the `Documents` directory. If you want to use the `bsdtar` utility instead, replace the `--tar` option with `-b` or `--bsdtar`. Do that like this:
{line-numbers: false, format: Bash}
```
./tar-wrapper.sh -b -cvf documents.tar.bz2 Documents
```

The script handles the first positional parameter on its own. It passes all the following parameters to the archiving utility. We use the `$@` parameter for doing that. It is not an array. But it supports the array-like syntax for accessing several elements. The archiving utility receives all elements of the `$@` parameter starting from the second one.

Let's rewrite our wrapper script using an associative array.

First, let's consider the Bash mechanisms for converting data into commands. For doing that, you should store the command and its parameters into the variable. Bash must insert the variable's value somewhere in the script for executing the command. You should check that Bash executes the resulting command correctly.

Here is an example of how to convert data into a command. For the first time, we will do it in the shell but not in the script. The first step is declaring the variable like this:
{line-numbers: false, format: Bash}
```
ls_command="ls"
```

Now the `ls_command` variable stores the command to call the `ls` utility. After such a declaration, we can use the variable name for calling the utility. It looks the following way:
{line-numbers: false, format: Bash}
```
$ls_command
```

This command calls the `ls` utility without parameters. How does it happen? Bash inserts the value of the `ls_command` variable. Then the command becomes like this:
{line-numbers: false, format: Bash}
```
ls
```

After parameter expansion, Bash executes the resulting command.

Why don't we use double-quotes when inserting the `ls_command` variable? One small change would help to answer this question. Let's add an option to the `ls` utility call. Here is an example of such `ls_command` variable:
{line-numbers: false, format: Bash}
```
ls_command="ls -l"
```

In this case, parameter expansion with double-quotes leads to the error:
{line-numbers: true, format: Bash}
```
$ "$ls_command"
ls -l: command not found
```

Double-quotes cause the problem because they prevent word splitting. Therefore, the command looks like this after parameter expansion:
{line-numbers: false, format: Bash}
```
"ls -l"
```

This command means that Bash must call a built-in or utility named "ls -l". As you remember, the POSIX standard allows spaces in filenames. Therefore, "ls -l" is the correct executable filename. Removing the quotes solves the problem. We meet one of the rare cases when you do not need double-quotes for parameter expansion.

It can happen that you still need double-quotes when reading the command from the variable. This task has the solution. Use the `eval` built-in in this case. It constructs a command from its input parameters. Then Bash does word splitting for this command regardless of double-quotes.

Here is an example of the `eval` call for processing the `ls_command` variable:
{line-numbers: false, format: Bash}
```
eval "$ls_command"
```

W> Many Bash manuals claim that it is bad practice to use `eval` and store commands in variables. It can lead to serious errors and vulnerabilities. In general, this idea is true. Be careful and never pass user-entered data to eval.

Now we can rewrite our wrapper script using an associative array. Listing 3-17 shows the result.

{caption: "Listing 3-17. The wrapper script for the archiving utilities", line-numbers: true, format: Bash}
![`tar-wrapper-array.sh`](code/BashScripting/tar-wrapper-array.sh)

Here the `utils` array stores matching between the script's options and utility names. Using the array, we construct the utility calls easily.

The utility call looks like this in the script:
{line-numbers: false, format: Bash}
```
${utils["$option"]} "${@:2}"
```

Bash reads the utility name from the `utils` array. The `option` variable provides the element's key. If you pass the wrong option to the script, the corresponding key does not present in `utils`.  Then Bash inserts an empty string after parameter expansion. It leads to an error. The `if` statement checks the `option` variable and prevents this error.

The `if` statement checks two Boolean expressions:

1. The `option` variable, which matches the `$1` parameter, is not empty.

2. The `utils` array has a key that equals the `option` variable.

The second expression uses the `-v` option of the [[ operator. It checks if the variable has been declared. If you have declared it and assigned an empty string, the check passes too.

Our example has shown that replacing the `case` statement with an associative array makes your code cleaner in some cases. Always consider if this option fits your case when writing scripts.

{caption: "Exercise 3-6. The `case` statement", format: text, line-numbers: false}
```
There are two configuration files in the user's home directory:
".bashrc-home" and ".bashrc-work".
Write a script to switch between them.
You can do that by copying one of the files to the path "~/.bashrc" or creating a symbolic link.
Solve the task with the "case" statement first.
Then replace the "case" statement with an associative array.
```
