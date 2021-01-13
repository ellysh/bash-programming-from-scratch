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

### Poor Technical Solution

We have written the long and complicated backup command. If you run it regularly, you should store it somewhere. Otherwise, you have to type the command in the terminal window each time. Typing is a bad idea because you can make a mistake easily.

The Bash history file saves all commands that you execute in the terminal. Each user has this file in his home directory. Its path is `~ / .bash_history`. When you press Ctrl+R keys in the terminal window, Bash calls the quick search over the history file. You can quickly find the required command this way.

Can we use the history file for storing the backup command permanently? There you can find and execute the command every time you need it. This solution seems to be reliable and convenient. But don't jump to conclusions. Let's take a look at its possible problems.

First, the history file has a limited size. By default, the file saves only the 500 most recently executed commands. If this number is exceeded, each new command overwrites the oldest ones in the file. This way, you can accidentally lose the backup command.

It is possible to increase the maximum size of the history file. But what size would be enough? Whatever size we choose, there is a risk of exceeding it. There is an option to remove the size limitation at all. Then the history file saves all commands without overwriting the old ones.

It seems we find a way to store the backup command effectively. The Bash history file with unlimited size does it. Could this solution have any problems?

Suppose you use Bash for a couple of years. All commands you entered during this time come to the `.bash_history` file. If you execute the same command twice, it appears in the file twice too. Therefore, the file size will reach hundreds of megabytes in two years. You do not need most of these commands. Instead, only a small part of them are needed for regular usage. It leads to inefficient use of hard disk space.

You might argue that storing the extra two hundred megabytes is not a problem for modern computers. Yes, it is true. But there is an overhead that you miss. When you press Ctrl+R, Bash searches the command in the entire `.bash_history` file. The larger it is, the longer the search takes. Over time, you will wait several seconds even on a powerful computer.

When the history file grows, the search time increases. There are two reasons for that. First, Bash should process more lines to find your request. Second, the file has many commands that have the same first letters. It forces you to type more letters after pressing Ctrl+R to find the right command. At some point, the history file search becomes inconvenient. That is the second problem with our solution.

What else could go wrong? Suppose that you get new photo albums. Their path differs from `~/photo`. It is `~/Documents/official_photo` for example. Our backup command works with the `~/photo` path only. It cannot copy photos from another path. You should write a new command for doing that. Thus, the complexity of extending features is the third problem of our solution.

You may already have several backup commands. The first one copies photos. The second one copies documents. It would be hard to combine them. You have to write the third command that includes all actions of the existing ones.

We can conclude that a history file is a bad option for the long-term storage of commands. There is the same reason for all our problems. We misuse the history file mechanism. It was not intended as a permanent storage place. As a result, we came up with the poor technical solution.

Everybody can make a poor technical solution. Professionals with extensive experience often come to them too. It happens for various reasons. The lack of knowledge played a role in our case. We got how to work with Bash in shell mode. Then we applied this experience to the new task. But we did not take into account all the requirements.

Here is the complete list of the requirements for our task:

1. The backup command should have long-term storage.
2. The way to call the command quickly should be available.
3. It should be a possibility to extend the command by new features.
4. The command should be able to combine with other commands.

First, let's evaluate our knowledge of Bash. They are not enough to meet all these requirements. All the mechanisms we know don't fit here. Maybe a Bash script could help us? I propose to explore its features. Then we can check if it is suitable for our task.

### Bash Script

Let's create a Bash script with our backup command. Here are the steps for that:

1. Open the source code editor and create a new file. If you have integrated Notepad++ into Bash, run the following command:
{line-numbers: false, format: Bash}
```
notepad++ ~/photo-backup.sh
```

2. Copy the command to the file:
{line-numbers: false, format: Bash}
```
(bsdtar -cjf ~/photo.tar.bz2 ~/photo &&
  echo "bsdtar - OK" > results.txt ||
  ! echo "bsdtar - FAILS" > results.txt) &&
(cp -f ~/photo.tar.bz2 /d &&
  echo "cp - OK" >> results.txt ||
  ! echo "cp - FAILS" >> results.txt)
```

3. Save the file in the user's home directory. It should have the `photo-backup.sh` name.

4. Close the editor.

Now we have the Bash script file. Call the Bash interpreter and pass the script there as the first parameter. Here is an example of such a command:
{line-numbers: false, format: Bash}
```
bash photo-backup.sh
```

We have run our first script. The script itself is a sequence of Bash commands. The file on some drive stores them. When Bash runs a script, it reads the file line by line. The interpreter executes lines in this order. Conditional and loop statements can change the order of execution.

It is inconvenient to run a script with an explicit call of the Bash interpreter. You can run it by a relative or absolute path. To do that, change the permissions of the script. Here are the steps:

1. Run the following command in the terminal window:
{line-numbers: false, format: Bash}
```
chmod +x ~/photo-backup.sh
```

2. Open the script file in an editor.

3. Add the following line at the beginning of the script:
{line-numbers: false, format: Bash}
```
#!/bin/bash
```

4. Save the modified file.

5. Close the editor.

Now you can run the script by a relative or absolute path. Here are examples of these commands:
{line-numbers: true, format: Bash}
```
./photo-backup.sh
~/photo-backup.sh
```

Let's consider our steps for launching the script. The first thing that prevents it from running is permissions. When you create a new file, it gets the following permissions by default:
{line-numbers: false}
```
-rw-rw-r--
```

It means that the owner and his group can read and modify the file. Everyone else can only read it. No one can run the file.

The `chmod` utility changes the permissions of the specified file. We call it with the `+x` option. The option changes the file permissions to this:
{line-numbers: false}
```
-rwxrwxr-x
```

It means that everyone can execute the file now.

If you run the script by a relative or absolute path, your shell tries to interpret its lines. It works if your shell is Bash.

Suppose that your shell is not Bash. It is the [Csh](https://ru.wikipedia.org/wiki/Csh) for example. Then the script fails. It happens because the syntax of Bash and Csh differs. It means that they use different language constructions for the same things. You wrote the script in Bash language. Therefore, the Bash interpreter only can execute it.

There is an option to specify the interpreter that should execute the script. To do that, add the [**shebang**](https://en.wikipedia.org/wiki/Shebang_(Unix)) at the beginning of the script file. Shebang is a combination of the number sign and exclamation mark. It looks like this:
{line-numbers: false}
```
#!
```

The absolute path to the interpreter comes after the shebang. In our case, we get the following line:
{line-numbers: false, format: Bash}
```
#!/bin/bash
```

Now Bash always executes the script. It happens even when the user works in another shell.

The `file` utility prints the type of the specified file. If the script does not have the shebang, the utility defines it as a regular text file. Here is an example output:
{line-numbers: false, format: Bash}
```
~/photo-backup.sh: ASCII text
```

If you add the shebang, the utility defines the same file as a Bash script:
{line-numbers: false, format: Bash}
```
~/photo-backup.sh: Bourne-Again shell script, ASCII text executable
```

Most Linux systems have the same path to the Bash interpreter. It equals `/bin/bash`. However, this path differs on some Unix systems (for example, FreeBSD). It can be a reason why your script does not work there. You can solve this problem by the following shebang:
{line-numbers: false, format: Bash}
```
#!/usr/bin/env bash
```

Here we call the `env` utility. It searches the Bash executable in the paths of the `PATH` variable.