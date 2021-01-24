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

If the contents of the `file1.txt` and `file2.txt` files match, the `cmp` utility returns the zero status. Then the `if` condition equals true. In this case, the `echo` command prints the message.

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

Bash executes ACTION_2 if CONDITION returns the non-zero exit status. The condition is false in this case. Otherwise, Bash executes the ACTION_1.
