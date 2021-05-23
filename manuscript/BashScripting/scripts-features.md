## Why Do We Need Scripts?

We learned how to write complex Bash commands using pipelines and logical operators. The pipeline combines several commands into one. You get a linear sequence algorithm this way. If you add logical operators there, you get the conditional algorithm. These operators allow you to handle special cases and choose a proper reaction for them.

The shell command that implements the conditional algorithm can be as complicated as a real program. What is the difference between them? Why do we need scripts that are Bash programs? Let's figure out answers to these questions.

### Backup Command

We need an example to consider Bash scripts features. Let's write the command that creates a backup of your photos on the [external hard drive](https://en.wikipedia.org/wiki/Hard_disk_drive#EXTERNAL). The command consists of two actions: archiving and copying.

Suppose that you store all your photos in the `~/photo` directory. The mount point of the external drive is `/d`. Then the following command creates an archive of the photos on the external drive:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo && cp -f ~/photo.tar.bz2 /d
```

Here the logical AND connects the archiving and copying commands. Therefore, the `cp` call happens only when the `bsdtar` utility succeeds. This utility creates an archive called `photo.tar.bz2`. It contains all files of the `~/photo` directory.

I> In our example, creating the backup happens in two steps: archiving and copying. It is done for demonstration purposes. You can do the same thing by the single `bsdtar` call:
{line-numbers: false, format: Bash}
```
bsdtar -cjf /d/photo.tar.bz2 ~/photo
```

Suppose that you run the backup command automatically. For example, it launches every day by schedule. If some error happens, you do not have a chance to read its message. You need a log file to get this possibility. Here is an example of the `bsdtar` call that writes its status to the file:
{line-numbers: true, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo &&
echo "bsdtar - OK" > results.txt ||
echo "bsdtar - FAILS" > results.txt
```

You can split a Bash command into multiple lines. There are two ways for doing that:

1. Add the line break right after the logical operator (&& or ||).

2. Add the line break after the backslash \.

We applied the first option in the last `bsdtar` call. The second option looks like this:
{line-numbers: true, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo \
&& echo "bsdtar - OK" > results.txt \
|| echo "bsdtar - FAILS" > results.txt
```

You would need the status of the `cp` call as well. Therefore, we should write it to the log file. Here is the command for that:
```
cp -f ~/photo.tar.bz2 /d &&
echo "cp - OK" >> results.txt ||
echo "cp - FAILS" >> results.txt
```

Now we can combine the `bsdtar` and `cp` calls into a single command. The logical AND should connect these calls. The straightforward solution looks like this:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo &&
  echo "bsdtar - OK" > results.txt ||
  echo "bsdtar - FAILS" > results.txt &&
cp -f ~/photo.tar.bz2 /d &&
  echo "cp - OK" >> results.txt ||
  echo "cp - FAILS" >> results.txt
```

Let's check if this command works correctly. We can replace each command call with a Latin letter. Then we get a convenient form of the Boolean expression. The expression looks like this:
{line-numbers: false, format: Bash}
```
B && O1 || F1 && C && O2 || F2
```

The "B" and "C" letters represent the `bsdtar` and `cp` calls. "O1" is the `echo` call that prints "bsdtar - OK" line in the log file. "F1" is the `echo` call for printing "bsdtar - FAIL" line. Similarly, "O2" and "F2" are the commands for logging the `cp` result.

If the `bsdtar` call succeeds, the "B" operand of our expression equals "true". Then Bash performs the sequence of the following steps:

1. B
2. O1
3. C
4. O2 or F2

If the `bsdtar` fails, the "B" operand equals false. Then Bash does the following steps:

1. B
2. F1
3. C
4. O2 or F2

It means that the shell calls the `cp` utility even when the archiving fails. It does not make sense.

Unfortunately, the `bsdtar` utility makes things even more confusing. It creates an empty archive if it cannot access the target directory or files. Then the `cp` utility copies the empty archive successfully. These operations lead to the following output in the log file:
{line-numbers: true}
```
bsdtar - FAILS
cp - OK
```

Such output confuses you. It does not clarify what went wrong.

Here is our expression again:
{line-numbers: false, format: Bash}
```
B && O1 || F1 && C && O2 || F2
```

Why does Bash call the `cp` utility when `bsdtar` fails? It happens because the `echo` command always succeeds. It returns zero code, which means "true". Thus, the "O1", "F1", "O2" and "F2" operands of our expression are always "true".

Let's fix the issue caused by the `echo` call exit code. We should focus on the `bsdtar` call and corresponding `echo` commands. They match the following Boolean expression:
{line-numbers: false, format: Bash}
```
B && O1 || F1
```

We can enclose the "B" and "O1" operands in brackets this way:
{line-numbers: false, format: Bash}
```
(B && O1) || F1
```

It does not change the expression's result.

We got a logical OR between the "(B && O1)" and "F1" operands. The "F1" operand always equals "true". Therefore, the whole expression is always "true". The value of "(B && O1)" does not matter. We want to get another behavior. If the "(B && O1)" operand equals "false", the entire expression should be "false".

One possible solution is inverting the "F1" operand. The logical NOT operator does that. We get the following expression this way:
{line-numbers: false}
```
B && O1 || ! F1 && C && O2 || F2
```

Let's check the behavior that we got. If the "B" command fails, Bash evaluates "F1". It always equals "false" because of negation. Then Bash skips the "C" and "O2" commands. It happens because there is a logical AND between them and "F1". Finally, Bash comes to the "F2" operand. The shell needs its value. Bash knows that the LHS operand of the logical OR equals "false". Therefore, it needs to evaluate the RHS operand to deduce the result of the whole expression.

We can make the expression clearer with the following parentheses:
{line-numbers: false}
```
(B && O1 || ! F1 && C && O2) || F2
```

Now it is evident that Bash executes the "F2" action when the parenthesized expression equals "false". Otherwise, it cannot deduce the final result.

The last command writes this output into the log file:
{line-numbers: true}
```
bsdtar - FAILS
cp - FAILS
```

This output looks better than the previous one. Now the `cp` utility does not copy an empty archive.

The current result still has room for improvement. Imagine that you extended the backup command. Then it contains 100 actions. If an error occurs at the 50th action, all the remaining operations print their failed results into the log file. Such output makes it complicated to find the problem. The better solution here is to terminate the command right after the first error occurred. Parentheses can help us to reach this behavior. Here is a possible grouping of the expression's operands:
{line-numbers: false}
```
(B && O1 || ! F1) && (C && O2 || F2)
```

Let's check what happens if the "B" operand is false. Then Bash executes the "F1" command. The negation inverts the "F1" result. Therefore, the entire LHS expression equals "false". Here is the LHS expression:
{line-numbers: false}
```
(B && O1 || ! F1)
```

Then the short-circuit evaluation happens. It prevents calculating the RHS operand of the logical AND. Then Bash skips all commands of the RHS expression. Here is the RHS expression:
{line-numbers: false}
```
(C && O2 || F2)
```

We got the proper behavior of the backup command.

We can add one last improvement. The "F2" operand should be inverted. Then the whole expression equals "false" if the "C" command fails. Then the entire backup command fails if `bsdtar` or `cp` call fails. Inverting "F2" operand provides the proper non-zero exit status in the error case.

Here is the final version of our expression with all improvements:
{line-numbers: false}
```
(B && O1 || ! F1) && (C && O2 || ! F2)
```

Let's come back to the real Bash code. The corrected backup command looks like this:
{line-numbers: true, format: Bash}
```
(bsdtar -cjf ~/photo.tar.bz2 ~/photo &&
  echo "bsdtar - OK" > results.txt ||
  ! echo "bsdtar - FAILS" > results.txt) &&
(cp -f ~/photo.tar.bz2 /d &&
  echo "cp - OK" >> results.txt ||
  ! echo "cp - FAILS" >> results.txt)
```

We spent some time writing this command. However, another person would need much more time to read it and understand it correctly. It happens in programming often. This situation is a severe problem for big projects. Therefore, please train yourself to make your code clean and evident from the beginning. Code cleanliness is more important than a high speed of writing it.

### Poor Technical Solution

Our backup command became long and complex after applying all improvements. Therefore, you should store it somewhere. Otherwise, you have to type the command in the terminal window each time. Typing is a bad idea because you can make a mistake or forget something.

Bash has an option to store frequently used commands. The history file saves everything you executed in the terminal. The file is unique for each user and has the `~ / .bash_history` path. When you press the Ctrl+R keystroke in the terminal window, Bash calls the quick search over the history. You can quickly find the required command there.

Can you store the backup command permanently in the history file? This solution seems to be reliable and convenient. Please do not jump to conclusions. Let's take a look at its possible problems.

First, the history file has a limited size. It saves 500 most recently executed commands by default. When this number exceeds, each new command overwrites the oldest one in the file. Therefore, you can lose the backup command accidentally.

You can think about increasing the capacity of the history file. Then the question arises. Which size would be enough? Whatever size you choose, there is a risk of exceeding it. This problem leads to the idea of making the history file unlimited. Then it saves all commands without overwriting anything.

It seems you find a way to store the backup command effectively. The history file with unlimited size does it. Could this decision lead to any problems?

Suppose you use Bash for a couple of years. All commands you executed during this time came to the `.bash_history` file. If you run the same command twice, it appears twice in the file. Therefore, the history size will reach hundreds of megabytes in two years. You do not need most of these commands. Only a small portion of them are significant for regular usage. It leads to inefficient use of your disk drive space.

You might argue that storing two hundred megabytes of the history file is not a problem for modern computers. Yes, it is true. However, there is another overhead that you missed. When you press Ctrl+R, Bash searches the command in the entire `.bash_history` file. The larger it is, the longer the search takes. Over time, you will wait several seconds, even using a powerful computer.

When the history file grows, the searching time increases. There are two reasons for that. First, Bash should process more lines in the history to find your request. Second, the file has many commands that have the same first letters. It leads you to type more letters after pressing Ctrl+R to find the right command. At some point, the history file search becomes inconvenient. That is the second problem with our solution.

What else could go wrong? Suppose that you got new photos. You placed them in the `~/Documents/summer_photo` directory. Our backup command can handle the `~/photo` path only. It cannot archive files from `~/Documents/summer_photo`. Thus, you should write a new command for doing that. The complexity of extending features is the third problem of our solution.

You may have several backup commands for various purposes. The first one archives your photos. The second one archives your documents. It would be hard to combine them. You have to write the third command that includes all required actions.

We can conclude that a history file is a bad option for the long-term storage of commands. There is the same reason for all our problems. We misuse the history file mechanism. It was not intended for storing information permanently. As a result, we came up with a poor technical solution.

Everybody can come up with a poor technical solution. Professionals with extensive experience did such a mistake often. It happens for various reasons. The lack of knowledge played a role in our case. We got how Bash works in the shell mode. Then we applied this experience to the new task. The problem happened because we did not take into account all the requirements.

Here is the complete list of the requirements for our task:

1. The backup command should have a long-term storage.
2. It should be a way to call the command quickly.
3. It should be a possibility to extend the command by new features.
4. The command should be able to combine with other commands.

First, let's evaluate our knowledge of Bash. They are not enough to meet all these requirements. All the mechanisms we know do not fit here. Can a Bash script help us? I propose to explore its features. Then we can check if it is suitable for our task.

### Bash Script

Let's create a Bash script that does our backup command. Here are the steps for doing that:

1. Open the source code editor and create a new file. If you have integrated Notepad++ into Bash, run the following command:
{line-numbers: false, format: Bash}
```
notepad++ ~/photo-backup.sh
```

2. Copy the backup command into the file:
{line-numbers: true, format: Bash}
```
(bsdtar -cjf ~/photo.tar.bz2 ~/photo &&
  echo "bsdtar - OK" > results.txt ||
  ! echo "bsdtar - FAILS" > results.txt) &&
(cp -f ~/photo.tar.bz2 /d &&
  echo "cp - OK" >> results.txt ||
  ! echo "cp - FAILS" >> results.txt)
```

3. Save the file in the home directory with the `photo-backup.sh` name.

4. Close the editor.

Now you have the Bash script file. Call the Bash interpreter and pass the script name there in the first parameter. Here is an example of this command:
{line-numbers: false, format: Bash}
```
bash photo-backup.sh
```

You have run your first script. Any script is a sequence of Bash commands. The file on the disk drive stores them. When Bash runs a script, it reads and executes the file commands one by one. Conditional and loop statements can change this order of execution.

It is inconvenient to call Bash interpreter explicitly when running the script. Instead, you can specify its relative or absolute path. This approach works if you do the following steps to prepare the script:

1. Allow any user to execute the script by the following command:
{line-numbers: false, format: Bash}
```
chmod +x ~/photo-backup.sh
```

2. Open the script in an editor.

3. Add the following line at the beginning of the file:
{line-numbers: false, format: Bash}
```
#!/bin/bash
```

4. Save the modified file.

5. Close the editor.

Now you can run the script by its relative or absolute path. Do it in one of the following ways:
{line-numbers: true, format: Bash}
```
./photo-backup.sh
~/photo-backup.sh
```

Let's consider our preparation steps for launching the script. The first thing that prevents it from running is permissions. When you create a new file, it gets the following permissions by default:
{line-numbers: false}
```
-rw-rw-r--
```

This line means that the owner and his group can read and modify the file. Everyone else can only read it. No one can execute the file.

The `chmod` utility changes the permissions of the specified file. If you call it with the `+x` option, the utility allows everyone to execute the file. It gets the following permissions in this case:
{line-numbers: false}
```
-rwxrwxr-x
```

When you run the script, your shell tries to interpret its lines. You may switch your shell from Bash to another one. It can be the [Csh](https://ru.wikipedia.org/wiki/Csh) for example. In this case, you cannot execute our script. It happens because Bash and Csh have different syntax. They use different language constructions for the same things. We wrote the script in the Bash language. Therefore, the Bash interpreter should execute it.

There is an option to specify the interpreter that should execute the script. To do that, add the [**shebang**](https://en.wikipedia.org/wiki/Shebang_(Unix)) at the beginning of the script file. Shebang is a combination of the number sign and exclamation mark. It looks like this:
{line-numbers: false}
```
#!
```

Add the absolute path to the interpreter after the shebang. It looks like this in our case:
{line-numbers: false, format: Bash}
```
#!/bin/bash
```

Now the Bash interpreter always executes the script. It happens even if you use another shell for typing commands.

The `file` utility prints the type of the specified file. If the script does not have the shebang, the utility defines it as a regular text file. Here is an example output:
{line-numbers: false, format: Bash}
```
~/photo-backup.sh: ASCII text
```

If you add the shebang, the utility defines this file as the Bash script:
{line-numbers: false, format: Bash}
```
~/photo-backup.sh: Bourne-Again shell script, ASCII text executable
```

The Bash interpreter has the same path `/bin/bash` for most Linux systems. However, this path differs for some Unix systems (for example, FreeBSD). It can be a reason why your script does not work there. The following shebang solves this problem:
{line-numbers: false, format: Bash}
```
#!/usr/bin/env bash
```

Here we call the `env` utility. It searches the path of the Bash executable in the list of the `PATH` variable.

### Commands Sequence

Listing 3-1 demonstrates the current version of our script.

{caption: "Listing 3-1. The script for making the photos backup", line-numbers: true, format: Bash}
![`photo-backup.sh`](code/BashScripting/photo-backup.sh)

Now the script contains one command. The command is too long. Therefore, it isn't easy to read and modify it. We can split the command into two parts. Listing 3-2 shows the result.

{caption: "Listing 3-2. The script with two commands", line-numbers: true, format: Bash}
![`photo-backup-commands.sh`](code/BashScripting/photo-backup-commands.sh)

Unfortunately, the behavior of the script has changed. Now the logical AND does not take place between the commands. Therefore, Bash executes the `cp` utility regardless of the `bsdtar` result. This behavior is wrong.

The script should finish if the `bsdtar` utility fails. We can apply the `exit` Bash built-in to terminate the script. The command receives the exit status as the parameter. The script returns this code on termination.

Listing 3-3 shows the script with the `exit` call.

{caption: "Listing 3-3. The script with the `exit` call", line-numbers: true, format: Bash}
![`photo-backup-exit-subshell.sh`](code/BashScripting/photo-backup-exit-subshell.sh)

We changed the command that calls the `bsdtar` utility. First, it looks like this:
{line-numbers: false}
```
B && O1 || ! F1
```

It becomes like this after adding the `exit` call:
{line-numbers: false}
```
B && O1 || (F1 ; E)
```

The "E" letter means the `exit` command here.

If `bsdtar` returns an error, Bash evaluates the right operand of the logical OR. It is equal to "(F1; E)". We removed the negation of the `echo` command. Its result is not important anymore. Then Bash calls `exit`. We expect that the call terminates the script.

The current version of the script does not solve the problem. The `exit` call does not terminate the script. It happens because parentheses create a [child process](https://en.wikipedia.org/wiki/Child_process). The child process is called **subshell**. It executes the commands specified in parentheses. When the commands are done, Bash continues executing the parent process. The parent process is one that spawned the subshell.

The `exit` command means finishing the subshell in our script. Then Bash calls the `cp` utility. To solve this problem, we should replace the parentheses with braces. Bash executes the commands in braces in the current process. The subshell is not spawned in this case.

Listing 3-4 shows the fixed version of the script.

{caption: "Listing 3-4. The fixed script with the `exit` call", line-numbers: true, format: Bash}
![`photo-backup-exit.sh`](code/BashScripting/photo-backup-exit.sh)

Notice the semicolon before the closing brace. The semicolon is mandatory here. Also, spaces after the opening brace and before closing one are mandatory too.

There is another solution for our problem. It is more elegant than calling the `exit` command. Suppose you want to terminate the script after the first failed command. The `set` Bash built-in does that. It changes the parameters of the interpreter. Call the command with the `-e` option like this:
{line-numbers: false, format: Bash}
```
set -e
```

You can specify the same option when starting the Bash. Here is an example:
{line-numbers: false, format: Bash}
```
bash -e
```

The `-e` option has [several problems](http://mywiki.wooledge.org/BashFAQ/105). The option changes the behavior of the current Bash process only. The subshells it spawns work as usual.

Bash executes each command of a pipeline or logical operator in a separate subshell. Therefore, the `-e` option does not affect these commands. It means that the option does not fit in our case.

### Changing Parameters

Suppose you have moved photos from the `~/photo` path to `~/Documents/Photo`. Then you should change the backup script. Listing 3-5 shows the script with the fixed path.

{caption: "Listing 3-5. The script with the new path", line-numbers: true, format: Bash}
![`photo-backup-path.sh`](code/BashScripting/photo-backup-path.sh)

Every time you change the path of photos, you have to fix the script. It is inconvenient. The better solution is to make a universal script. Such a script should receive the path of photos as an input parameter.

When you run a Bash script, you can pass command-line parameters there. It works the same as for any GNU utility. Specify the parameters separated by a space after the script name. Then Bash passes it to the script. Here is an example:
{line-numbers: false, format: Bash}
```
./photo-backup.sh ~/Documents/Photo
```

This command runs our script. Bash passes there the path `~/Documents/Photo` as an input parameter. You can access the path in the script via the variable called `$1`. If the script receives more parameters, they are available through the variables `$2`, `$3`, `$4`, etc. The variable name matches the number of the parameter. They are called **positional parameters**.

There is a special positional parameter `$0`. It stores the path to the launched script. In our case, it equals `./Photo-backup.sh`.

Let's improve our script. It will read the path to the photos in the first positional parameter. Listing 3-6 shows the new source code.

{caption: "Listing 3-6. The script uses the positional parameter", line-numbers: true, format: Bash}
![`photo-backup-parameter-path.sh`](code/BashScripting/photo-backup-parameter-path.sh)

The `$1` variable stores the path to the photos. We use it in the `bsdtar` call. There are quotes around the variable name. They prevent the word splitting mechanism.

Suppose you want to backup photos from the `~/photo album` path. Here is a command to call our script for that:
{line-numbers: false, format: Bash}
```
./photo-backup.sh "~/photo album"
```

If you skip quotes around the variable name in the script, the `bsdtar` call looks like this:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/photo.tar.bz2 ~/photo album &&
  echo "bsdtar - OK" > results.txt ||
  { echo "bsdtar - FAILS" > results.txt ; exit 1 ; }
```

In this case, the `bsdtar` utility receives the "~/photo album" string in parts. Instead of one parameter, there are two: "~/photo" and "album". There are no such directories. Therefore, the script fails.

Our example showed that it is not enough to quote parameters when calling a script. You should quote all occurrences of the variable name in the script. It happens because of the way how the Bash runs scripts. When you call a script from the shell, Bash spawns a child process. This process executes the script. The child process does not receive quotes from the command-line. Bash removes them. Therefore, you need quotes inside the script.

We added the parameter to our script. What are the benefits of this solution? This way, we get a universal script for making backups. It processes any input files: documents, photos, videos, source code, etc.

Adding a parameter to our script leads to the problem. Suppose you call it twice for making backups of photos and documents:
{line-numbers: true, format: Bash}
```
./photo-backup.sh ~/photo
./photo-backup.sh ~/Documents
```

These commands create the `~/photo.tar.bz2` archive. Then they copy the archive to the D disk. When the second command copies it, it overwrites the existing `/d/photo.tar.bz2` file. This file is a result of the first command. So, we lose it.

To solve this problem, we should use the script's parameter for naming the archive. This way, we avoid filename conflicts. Listing 3-7 shows the new version of the script.

{caption: "Listing 3-7. The script with the unique archive name", line-numbers: true, format: Bash}
![`photo-backup-parameter-name.sh`](code/BashScripting/photo-backup-parameter-name.sh)

Now the script creates the archive in the target path. For example, we call it this way:
{line-numbers: false, format: Bash}
```
./photo-backup.sh ~/Documents
```

The command creates an archive in the `~/Documents.tar.bz2` path. Then it copies the file to the D disk. In this case, the filename does not conflict with the photo archive `/d/photo.tar.bz2`.

There is the last improvement of the script. We can call the `mv` utility instead of `cp`. It deletes the temporary archive. Listing 3-8 shows the result.

{caption: "Listing 3-8. The script with removing the temporary archive", line-numbers: true, format: Bash}
![`photo-backup-mv.sh`](code/BashScripting/photo-backup-mv.sh)

Now we get the universal backup script. Its old name `photo-backup.sh` does not fit anymore. The new version of the script can copy any data. Let's rename it to `make-backup.sh`.

### Combination with Other Commands

Now you can call the script by an absolute or relative path. If you integrate it into Bash, you can call the script by name. Then it will be more convenient to combine it with other programs.

We learned two ways how to integrate an application with Bash. There is also the third way. Here is a complete list of these options:

1. Add the script's path to the `PATH` variable. To do that, edit the `~/.bash_profile` file.

2. Define an alias with an absolute path to the script. Do that in the file `~/.bashrc`.

3. Copy the script to the `/usr/local/bin` directory. The `PATH` variable contains its path by default. If there is no such directory in your MSYS2 environment, create it.

I> Call the `unalias` Bash command to remove a declared alias. Here is an example:
{line-numbers: false, format: Bash}
```
unalias make-backup.sh
```

Suppose that you have integrated the backup script with Bash in one of three ways. Now you can launch it by name like this:
{line-numbers: false, format: Bash}
```
make-backup.sh ~/photo
```

You can combine the script with other commands in pipelines and logical operators. It works the same way as for any Bash built-in or GNU utility.

Here is an example. Suppose we want to backup all PDF documents of the `~/Documents` directory. The `find` utility can find them by the following call:
{line-numbers: false, format: Bash}
```
find ~/Documents -type f -name "*.pdf"
```

We can apply our script to archive and copy each found file. Here is the command for that:
{line-numbers: false, format: Bash}
```
find ~/Documents -type f -name "*.pdf" -exec make-backup.sh {} \;
```

I> There is the escaped semicolon at the end of the `find` call. It means that action is executed on each found file separately.

The command copies archives to disk D. Each archive matches one PDF file. This approach is inconvenient. It would be better to collect all PDF files into one archive. Let's try the following command for that:
{line-numbers: false, format: Bash}
```
find ~/Documents -type f -name *.pdf -exec make-backup.sh {} +
```

The command should processes all found files in the single `make-backup.sh` call. However, it produces an archive with the first found PDF file only. Where are the rest of the documents? Let's take a look at the `bsdtar` call inside our script. For simplicity, we omit all echo outputs there. The call looks like this:
{line-numbers: false, format: Bash}
```
bsdtar -cjf "$1".tar.bz2 "$1"
```

The problem happens because we process the first positional parameter only. The `$1` variables stores it. The `bsdtar` call ignores other parameters in variables `$2`, `$3`, etc. But they contain all results of the `find` utility. Therefore, we cut off all results except the first one.

We should use the `$@` variable instead of `$1` to solve the problem. Bash stores all script parameters into `$@`. Here is the fixed `bsdtar` call:
{line-numbers: false, format: Bash}
```
bsdtar -cjf "$1".tar.bz2 "$@"
```

Now the `bsdtar` utility processes all script's parameters. Note that we still use the first parameter `$1` as the archive name. It should be a single word. Otherwise, `bsdtar` fails.

Listing 3-9 shows the fixed version of the backup script. It handles an arbitrary number of input parameters.

{caption: "Listing 3-9. The script with an arbitrary number of input parameters", line-numbers: true, format: Bash}
![`make-backup.sh`](code/BashScripting/make-backup.sh)

Bash has an alternative variable for `$@`. It is called `$*`. If you put the `$*` variable in double-quotes, Bash interprets its value as a single word. It interprets the `$@` variable as a set of words in the same case.

Here is an example. Suppose you call the backup script this way:
{line-numbers: false, format: Bash}
```
make-backup.sh "one two three"
```

Then substitution of the "$*" value gives the following result:
{line-numbers: false, format: Bash}
```
"one two three"
```

Here is the result for the "$@" substitution:
{line-numbers: false, format: Bash}
```
"one" "two" "three"
```

W> Always prefer to use `$@` instead of `$*`. The only exception is when a single word must represent all input parameters.

### Scripts Features

When solving the backup task, we considered the features of the Bash scripts.

Here are the requirements for the task:

1. The backup command should have long-term storage.
2. The command has to be called quickly.
3. It must be possible to extend it.
4. It should be possible to combine it with other commands.

The final version of the `make-backup.sh` script meets all these requirements. Let's check each of them:

1. The script is stored on the hard disk. It is long-term memory.

2. The script is easy to integrate with Bash. Then you can quickly call it.

3. The script is a sequence of commands. Each one starts on a new line. It is easy to read and edit. Thanks to parameterization, it is easy to generalize it for solving tasks of the same type.

4. Due to integration with Bash, the script is easy to combine with other commands. You can do it with pipelines and logical operators.

If your task requires any of these features, write a Bash script for that.
