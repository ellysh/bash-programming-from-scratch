## Loop Constructs

Conditional statements manage the [**control flow**](https://en.wikipedia.org/wiki/Control_flow) of a program. The control flow is the order in which the operators and commands of a program are executed.

The conditional operator chooses a branch of execution depending on the Boolean expression. This operator is not enough sometimes. You want additional features to manage the control flow. [**Loop constructs**](https://en.wikipedia.org/wiki/Control_flow#Loops) solve tasks that the conditional operator cannot handle.

The loop construct repeats the same block of commands multiple times. The single execution of this block is called the **loop iteration**. At each iteration, the loop checks its condition. The check result defines to perform the next iteration or not.

### Repetition of Commands

Why do you need to repeat the same block of commands in a program? Several examples will help us to answer this question.

We are already familiar with the `find` utility. It looks for files and directories on the hard disk. If you add the `-exec` option to the `find` call, you can specify an action. The utility performs this action on each object found.

For example, the following command deletes all PDF documents in the `~/Documents` directory:
{line-numbers: false, format: Bash}
```
find ~/Documents -name "*.pdf" -exec rm {} \;
```

In this case, `find` calls the `rm` utility several times. It passes the next found file on each call. It means that the `find` utility executes a loop. The loop ends when all the files found have been processed.

The `du` utility is another example of the repetition of commands. The utility estimates the amount of disk space used on the disks. It has an optional parameter. The parameter sets the path where the estimation starts.

You can call `du` like this, for example:
{line-numbers: false, format: Bash}
```
du ~/Documents
```

Here the utility recursively traverses all `~/Documents` subdirectories. It adds the size of each file found to the final result. This way, incrementing the result value repeats over and over again.

The `du` utility has an internal loop. It traverses over all files and subdirectories. There are the same actions on each loop iteration. The only difference is the checked file system object.

Repetition of operations happens in mathematical calculations often. A canonical example is the calculation of [**factorial**](https://en.wikipedia.org/wiki/Factorial). The factorial of the number N is a multiplication of natural numbers from 1 to N inclusive.

Here is an example of calculating the factorial of number 4:
{line-numbers: false, format: Bash}
```
4! = 1 * 2 * 3 * 4 = 24
```

You can calculate the factorial easily by using the loop operator. The loop should pass through the integers from 1 to N in sequence. Multiply each integer to the final result on the loop iteration. This way, you repeat the multiplication operation several times.

Here is the last example of repetition actions in a computer system. Repetition helps to manage some events.

Suppose that you write a program. It downloads files to your computer from the Internet. First, the program establishes a connection to a server. If the server doesn't respond, the program has two options to do. The first one is to terminate with a non-zero exit status. The second option is to wait for the server's response. This option is preferable. There are many reasons why the server's response delays. There is an overload of the network or the server, for example. A couple of seconds waiting is enough to get a response. Then our program can continue to work.

Now the question arises: how can you wait for the event to occur in the program? The easiest way is to use the loop operator. Its condition should check if the event occurs. In this case, the operator stops.

Let's come back to our example. The loop should stop when the program receives a response from the server. While it does not happen, the loop continues. You do not need any actions on each loop's iteration. Thus, you can leave this code block empty. This technique is called [**busy waiting**](https://en.wikipedia.org/wiki/Busy_waiting).

You can optimize the busy waiting. Replace the loop's empty code block with a command that stops the program for a short while. This way, OS gets a chance to execute another task while your program is waiting.

We have considered several examples where the program repeats the same actions. Let's write down the tasks that we have solved in each example. Here is the list:

1. Process of multiple entities monotonously. The `find` utility processes the search results this way.

2. Apply the intermediate data to accumulate the final result. The `du` utility does it for collecting statistics.

3. Mathematical calculations. You can calculate factorial using the loop operator.

4. Wait for some event to happen. You can wait for the server's response in a busy waiting loop.

The list is far from being complete. These are just the most common programming tasks that require a loop operator.

### While Statement

There are two loop operators in Bash: `while` and `for`. First, we will consider the `while` statement. It works simpler than `for`.

The `while` syntax resembles the `if` statement. It looks like this in general:
{line-numbers: true, format: Bash}
```
while CONDITION
do
  ACTION
done
```

You can write the `while` statement in one line:
{line-numbers: false, format: Bash}
```
while CONDITION; do ACTION; done
```

The CONDITION is a single command or block of commands. The same is true for the ACTION. It resembles the `if` statement again. The ACTION is called the **loop body**.

Bash checks the CONDITION of the `while` statement first. If the CONDITION command returns null exist status, it equals "true". In this case, Bash executes the ACTION. Then it checks the CONDITION again. If it is still true, the ACTION is performed again. The loop execution stops when the CONDITION becomes "false".

Use the while loop when you do not know the number of iterations beforehand. The example is busy waiting for some event.

Let's write a script with the `while` statement. It should check if the server is available on the Internet. The simplest way for that is by sending a request to the server. When the server replies, the script displays a message and stops.

We can call the [`ping`](https://en.wikipedia.org/wiki/Ping_(networking_utility)) utility to send a request to the server. The utility uses the [ICMP](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol) **protocol**. The protocol is an agreement for the format of the messages between the computers on the network. The ICMP protocol describes the format of the messages to serve the network. You need them, for example, to check if some computer is available.

The `ping` utility takes one mandatory input parameter. It is [URL](https://en.wikipedia.org/wiki/URL) or [IP address](https://en.wikipedia.org/wiki/IP_address) of the target **host**. A host is any computer or device connected to the network.

Here is the command to call the `ping` utility:
{line-numbers: false, format: Bash}
```
ping google.com
```

We have specified the Google server as the target host. The utility sends ICMP messages to it. The server replies to each of them. The output of the utility looks like this:
{line-numbers: true, format: Bash}
```
PING google.com (172.217.21.238) 56(84) bytes of data.
64 bytes from fra16s13-in-f14.1e100.net (172.217.21.238): icmp_seq=1 ttl=51 time=17.8 ms
64 bytes from fra16s13-in-f14.1e100.net (172.217.21.238): icmp_seq=2 ttl=51 time=18.5 ms
```

You see information about each ICMP message sent by the utility. The "time" field means the delay between sending the request and receiving the server's response.

The utility runs in an infinite loop by default. You can stop it by pressing Ctrl+C.

You do not need to send several requests to check the availability of a server. It is sufficient to send a single ICMP message instead. The `-c` option of the `ping` utility specifies the number of messages to send. Here is an example of how to use it:
{line-numbers: false, format: Bash}
```
ping -c 1 google.com
```

If the `google.com` server is available, the utility returns the zero exit status. Otherwise, it returns non-zero.

The `ping` utility waits for the server's response until you do not interrupt it. The `-W` option limits the waiting time to one second. Using the option, we get the following command:
{line-numbers: false, format: Bash}
```
ping -c 1 -W 1 google.com
```

Now we have the condition for the `while` statement. Let's write the whole statement like this:
{line-numbers: true, format: Bash}
```
while ! ping -c 1 -W 1 google.com &> /dev/null
do
  sleep 1
done
```

The output of the `ping` utility is not interested in our case. Therefore, we redirect it to the `/dev/null` file.

We invert the `ping` result in the `while` condition. Therefore, Bash executes the loop's body as long as the utility returns a non-zero exit status. It means that the loop continues as long as the server is unavailable.

We call the `sleep` utility in the loop's body. It stops the script for the specified number of seconds. The stop lasts for one second in our case.

I> You can specify a suffix for the parameter when using the `sleep` utility. It defines units of time. The suffix
"s" matches seconds. It is "m" for minutes, "h" for hours and "d" for days.

Listing 3-18 shows a complete script for checking server availability.

{caption: "Listing 3-18. Script for checking server availability", line-numbers: true, format: Bash}
![`while-ping.sh`](code/BashScripting/while-ping.sh)

The `while` statement has an alternative form called `until`. Here the ACTION is executed as long as the CONDITION is "false". It means that the loop continues as long as the CONDITION returns a non-zero exit status. Use the `until` statement when you want to invert the condition of the `while` loop.

Here is the `until` statement in general:
{line-numbers: true}
```
until CONDITION
do
  ACTION
done
```

You can write it in one line the same way as `while`:
{line-numbers: false}
```
until CONDITION; do ACTION; done
```

Let's replace the `while` statement with `until` in Listing 3-18. You should remove the negation of the `ping` utility result for that. Listing 3-19 shows the resulting script.

{caption: "Listing 3-19. Script for checking server availability", line-numbers: true, format: Bash}
![`until-ping.sh`](code/BashScripting/until-ping.sh)

The scripts in Listing 3-18 and Listing 3-19 behave the same.

Choose the `while` or `until` statement depending on the loop condition. Try to avoid negations in conditions. Negations make the code harder to read.

#### Infinite Loop

The `while` statement fits well to implement [**infinite loops**](https://en.wikipedia.org/wiki/Infinite_loop). This kind of loop continues as long as the program is running.

You can find infinite loops in system software that runs until the computer is powered off. Examples are OS or microcontroller firmware. Computer games and monitor programs for collecting statistics also use such loops.

The `while` loop becomes infinite if its condition is always true. The easiest way to set such a condition is to call the `true` command. Here is an example of using it:
{line-numbers: true, format: Bash}
```
while true
do
  sleep 1
done
```

The `true` command always returns the "true" value. It means that it returns zero exit status. There is the symmetric command called `false`. It always returns exit status one that matches the "false" value.

I> Words "true" and "false" are [**literals**](https://en.wikipedia.org/wiki/Literal_(computer_programming)) in most programming languages. Literals are reserved words for representing fixed values. In our case, they represent the "true" and "false" values.

You can replace the `true` command in the `while` condition with a colon. This way, you get the following:
{line-numbers: true, format: Bash}
```
while :
do
  sleep 1
done
```

The colon is synonymous with the `true` command. The synonymous solves the [compatibility task](https://stackoverflow.com/questions/3224878/what-is-the-purpose-of-the-colon-gnu-bash-builtin) with the Bourne shell. This shell does not have `true` and `false` commands. Therefore, Bourne shell scripts use colons and Bash should support them.

The POSIX standard includes all three commands: colon, `true`, and `false`. However, avoid using a colon in your scripts. It is a deprecated syntax that makes your code harder to understand.

Here is an example of an infinite loop. We want to write a script that displays statistics of disk space usage. The `df` utility can help us in this case. It prints the following when called without parameters:
{line-numbers: true, format: Bash}
```
$ df
Filesystem     1K-blocks      Used Available Use% Mounted on
C:/msys64       41940988  24666880  17274108  59% /
Z:             195059116 110151748  84907368  57% /z
```

The utility shows "Used" and "Available" disk space in bytes. We can add the `-h` option to the utility call. Then it shows kilobytes, megabytes, gigabytes and terabytes instead of bytes. Also, we add an option `-T`. It shows the file system type for each disk. This way, we get the following output:
{line-numbers: true, format: Bash}
```
$ df -hT
Filesystem     Type  Size  Used Avail Use% Mounted on
C:/msys64      ntfs   40G   24G   17G  59% /
Z:             hgfs  187G  106G   81G  57% /z
```

If you want to get information about all mount points, add the `-a` option.

Now let's write an infinite loop. It calls the `df` utility on each iteration. This way, we get a simple script to monitor the file system. Listing 3-20 shows the script.

{caption: "Listing 3-20. The script to monitor the file system", line-numbers: true, format: Bash}
![`while-df.sh`](code/BashScripting/while-df.sh)

The first action of the cycle iteration is the `clear` utility call. It clears the terminal window of text. Thanks to this step, the terminal shows the output of our script only.

Executing a command in a cycle is a common task that arises when working with Bash. The `watch` utility solves this task. The utility is a part of the `procps` package. The following command installs this package to the MSYS2 environment:
{line-numbers: false, format: Bash}
```
pacman -S procps
```

Now you can replace the script from listing 3-20 with a single command. It looks like this:
{line-numbers: false, format: Bash}
```
watch -n 2 "df -hT"
```

The `-n` option of the `watch` utility specifies the interval between command calls. The command to execute follows all utility options.

The `-d` utility option highlights the difference in the command's output at the current iteration and the last iteration. This way, it is easier to keep track of changes that have occurred.

#### Reading a Standard Input Stream

The `while` loop fits well for handling an input stream. Here is an example of such a task. We want to write a script that reads a text file. The script makes an associative array from the file's content.

Listing 3-10 shows the script for managing the list of contacts. The script stores contacts in the format of the Bash array declaration. It makes adding a new person to the list inconvenient. The user must know the Bash syntax. Otherwise, he can make a mistake when initializing an array element. It will break the script.

We can solve the problem of editing the contacts list. Let's put the list in a separate text file. Our script should read it at startup. This way, we separate data and code. It is a well-known and good practice in software development.

Listing 3-21 shows a possible format of the file with contacts.

{caption: "Listing 3-21. The file with contacts `contacts.txt`", line-numbers: true, format: text}
![`contacts.txt`](code/BashScripting/contacts.txt)

Let's write a script to read this file. It is convenient to read the list of contacts directly into the associative array. This way, we keep the searching mechanism over the list as effective as before.

When reading the file, we should process its lines in the same manner. It means that we will repeat our actions. Therefore, we need a loop statement. At the beginning of the loop, we don't know the size of the file.  Thus, we do not know the number of iterations to do. The `while` statement fits this case perfectly.

Why do we not know the number of iterations in advance? It happens because the script reads the file line by line. It cannot count the lines before it reads them all. We can make two loops. The first one counts the lines. The second loop processes them. However, this solution works slower and less ineffective.

We can use the `read` built-in command for reading lines of the file. The command receives a string from the standard input stream. Then it writes the string into the specified variable. You can pass the variable's name as a parameter. Here is an example of doing that:
{line-numbers: false, format: Bash}
```
read var
```

Run this command. Then type the string and press Enter. The `read` command writes your string into the `var` variable. You can call `read` without parameters. It writes the string into the reserved variable `REPLY` in this case.

When `read` receives the string, it removes backslashes \ there. They escape special characters. Therefore, the `read` command considers the backslashes unnecessary. The `-r` option disables this feature. Use it always to prevent losing characters of the input string.

You can pass several variable names to the `read` command. Then it divides the input text into parts. The command uses the delimiters from the reserved variable `IFS` in this case. Default delimiters are spaces, tabs and line breaks.

Here is an example of multiple variables for the `read` command. Suppose that we want to store the input string into two variables. They are called `path` and `file`. The following command reads them:
{line-numbers: false, format: Bash}
```
read -r path file
```

The user types the following string for this command:
{line-numbers: false, format: text}
```
~/Documents report.txt
```

Then the `read` command writes the `~/Documents` path into the `path` variable. The filename `report.txt` comes into the `file` variable.

If the path or filename contains spaces, an error occurs. Suppose the user type the following string:
{line-numbers: false, format: text}
```
~/My Documents report.txt
```

Then the command writes the `~/My` string into the `path` variable. The `file` variable stores the rest part of the input: `Documents report.txt`. This is a wrong result. Don't forget about such behavior when using the `read` command.

We can solve the problem of splitting the input string. This can be done by redefining the `IFS` variable. Here is an example to specify comma as only one possible delimiter:
{line-numbers: false, format: text}
```
IFS=$',' read -r path file
```

Here we have applied the Bash-specific [type of quotes](http://mywiki.wooledge.org/Quotes) `$'...'`. Bash does not perform any expansions inside them. At the same time, you can place some control sequences there: `\n` (new line), `\\\` (escaped backslash), `\t` (tabulation) and `\xnn` (bytes in hexadecimal).

The new `IFS` declaration allows to process the following input string properly:
{line-numbers: true, format: text}
```
~/My Documents,report.txt
```

The comma separates the path and filename. Therefore, the `read` command writes the `~/My Documents` string into the `path` variable. The `report.txt` string comes into the `file` variable.

The `read` command receives data from the standard input stream. It means that you can redirect the file's content to the command.

Here is an example to read the first line of the `contacts.txt` file from Listing 3-21. The following command does it:
{line-numbers: false, format: Bash}
```
read -r contact < contacts.txt
```

This command writes the "Alice=alice@gmail.com" string into the `contact` variable.

We can write the name and contact information into two different variables. Let's define the equal sign as a delimiter to do that. Then our `read` command looks like this:
{line-numbers: false, format: Bash}
```
IFS=$'=' read -r name contact < contacts.txt
```

Now the `name` variable gets the "Alice" name. The e-mail address comes into the `contact` variable.

Let's try the following `while` loop for reading the entire `contacts.txt` file:
{line-numbers: true, format: Bash}
```
while IFS=$'=' read -r name contact < "contacts.txt"
do
  echo "$name = $contact"
done
```

Unfortunately, it does not work. Here we got an infinite loop accidentally. It happens because the `read` command always reads only the first line of the file. Then the command returns the zero exit status. The zero status leads to the loop body execution. It happens over and over again.

We should force the `while` loop to pass through all lines of the file. The following form of the loop does it:
{line-numbers: true, format: Bash}
```
while CONDITION
do
  ACTION
done < FILE
```

You can handle the input from the keyboard this way. Specify the `/dev/tty` file in this case. The loop will read keystrokes until you press Ctrl+D.

Here is the right `while` loop to read the `contacts.txt` file:
{line-numbers: true, format: Bash}
```
while IFS=$'=' read -r name contact
do
  echo "$name = $contact"
done < "contacts.txt"
```

This loop prints the entire contents of the contact file.

There is the last step left to finish our task. We should write the `name` and `contact` variables to the array on each iteration. The `name` variable is the key and `contact` is the value.

Listing 3-22 shows the final version of the script for reading the contacts from the file.

{caption: "Listing 3-22. The script for managing the contacts", line-numbers: true, format: Bash}
![`while-contacts.sh`](code/BashScripting/while-contacts.sh)

This script behaves the same way as one in Listing 3-10.

### For Statement

There is another loop statement in Bash called `for`. Unlike `while`, use it when you know the number of iterations in advance.

The `for` statement has two forms. The first one processes words in a string sequentially. The second form applies an arithmetic expression in the loop's condition.

#### The First Form of For

Let's start with the first form of the `for` statement. It looks like this in general:
{line-numbers: true, format: Bash}
```
for VARIABLE in STRING
do
  ACTION
done
```

You can write the same construction in a single line like this:
{line-numbers: false, format: Bash}
```
for VARIABLE in STRING; do ACTION; done
```

The ACTION in the `for` statement is a single command or a block of commands. It is the same as in the `while` statement.

Bash performs all expansions in the `for` condition before starting the first iteration of the loop. What does it mean? Suppose you specified the command instead of a STRING. Then Bash executes this command and replaces it with its output. Also, you can specify a pattern instead of STRING. Then Bash expands it before starting the loop.

BASH splits the STRING into words when there are no commands or patterns left in the `for` condition. It takes separators for splitting from the `IFS` variable.

Then Bash executes the first iteration of the loop. The first word of the STRING is available via VARIABLE inside the loop body on the first iteration. Then Bash writes the second word of the STRING to the VARIABLE and starts the second iteration. It happens again and again until we pass all words of the STRING.

Here is an example of the `for` loop. We want to write a script to print words in a string one by one. The script receives the string via the first parameter.

Listing 3-23 shows the script.

{caption: "Listing 3-23. The script for printing words of a string", line-numbers: true, format: Bash}
![`for-string.sh`](code/BashScripting/for-string.sh)

Here you should not enclose the position parameter `$1` in quotes. Quotes prevent word splitting, but we want it in this case. Otherwise, Bash passes the whole string to the first iteration of the `for` loop. Then the loop finishes. We do not want this behavior. The script should process each word of the string separately.

When you call the script, you should enclose the input string in double-quotes. Then the whole string comes into the `$1` parameter. Here is an example of calling the script:

There is a way to get rid of the double-quotes when calling the script. Replace the `$1` parameter in the `for` condition with `$@`. Then the loop statement becomes like this:
{line-numbers: true, format: Bash}
```
for word in $@
do
  echo "$word"
done
```

Now both following script calls work properly:
{line-numbers: true, format: Bash}
```
./for-string.sh this is a string
./for-string.sh "this is a string"
```

The `for` loop condition has a short form. Use it when you want to pass through all input parameters of the script. This short form looks like this:
{line-numbers: true, format: Bash}
```
for word
do
  echo "$word"
done
```

It does the same as the script in Listing 3-23. We just dropped the "in $@" part in the condition. It did not change the loop behavior.

Let's make the task a bit more complicated. Suppose the script receives a list of paths on input. Commas separate them. The paths may contain spaces. We should redefine the `IFS` variable to process such input correctly.

Listing 3-24 shows the `for` loop to print the list of paths.

{caption: "Listing 3-24. The script for printing the list of paths", line-numbers: true, format: Bash}
![`for-path.sh`](code/BashScripting/for-path.sh)

We have specified only one allowable delimiter in the `IFS` variable. The delimiter is the comma. Therefore, the `for` loop ignores spaces when splitting the input string.

You can call the script this way:
{line-numbers: false, format: Bash}
```
./for-path.sh "~/My Documents/file1.pdf,~/My Documents/report2.txt"
```

Here double-quotes for the input string are mandatory. You cannot replace the `$1` parameter with `$@` in the `for` condition and omit quotes. This will lead to an error. The error happens because Bash does word splitting when calling the script. This word splitting applies spaces as delimiters. It happens before our redeclaration of the `IFS` variable. Thus, Bash ignores our change of the variable in this case

If there is a comma in one of the paths, it leads to an error.

The `for` loop can pass through the elements of an indexed array. It works the same way as processing words in a string. Listing 3-25 shows an example of doing that.

{caption: "Listing 3-25. The script for printing all elements of the array", line-numbers: true, format: Bash}
![`for-array.sh`](code/BashScripting/for-array.sh)

Suppose you need the first three elements. Then you should expand only the elements you need in the loop condition. Listing 3-26 shows how to do that.

{caption: "Listing 3-26. The script for printing the first three elements of the array", line-numbers: true, format: Bash}
![`for-elements.sh`](code/BashScripting/for-elements.sh)

There is another option to pass through the array. You can iterate over the indexes instead of the array's elements. Write the string with indexes of the elements you need. Spaces should separate them. Put the string into the `for` condition. Then the loop gives you an index on each iteration. The loop looks like this:
{line-numbers: true, format: Bash}
```
array=(Alice Bob Eve Mallory)

for i in 0 1 2
do
  echo "${array[i]}"
done
```

This loop passes only through elements with indexes 0, 1 and 2.

You can apply the brace expansion to specify the indexes list. Here is an example:
{line-numbers: true, format: Bash}
```
array=(Alice Bob Eve Mallory)

for i in {0..2}
do
  echo "${array[i]}"
done
```

The loop behaves the same way. It prints the first three elements of the array.

Do not iterate over the element's indexes when processing arrays with gaps. Expand the array's elements in the loop condition instead. Listing 3-25 and Listing 3-26 show how to do that.

#### Files Processing

The `for` loop fits well for processing a list of files. When solving this task, you should compose the loop condition correctly. There are several common mistakes here. Let's consider them by examples.

The first example is a script that prints types of files in the current directory. We can do it by calling the `file` utility for each file.

The most common mistake when composing the `for` loop condition is neglecting patterns (globbing). Users often call the `ls` or `find` utility to get the STRING. It happens this way:
{line-numbers: true, format: Bash}
```
for filename in $(ls)
for filename in $(find . - type f)
```

This is wrong. Such a solution leads to the following problems:

1. Word splitting breaks names of files and directories with spaces.

2. If the filename contains an asterisk, Bash performs globbing before starting the loop. Then it writes the expansion result to the `filename` variable. This way, you lose the actual filename.

3. The output of the `ls` utility depends on the regional settings. Therefore, you can get question marks instead of the national alphabet characters in filenames. Then the `for` loop cannot process these files.

Always use patterns in the `for` loop to enumerate filenames. It is the only correct solution for this task.

We should write the following `for` loop condition in our case:
{line-numbers: false, format: Bash}
```
for filename in *
```

Listing 3-27 shows the complete script.

{caption: "Listing 3-27. The script for printing the file types", line-numbers: true, format: Bash}
![`for-file.sh`](code/BashScripting/for-file.sh)

Do not forget to use double-quotes when accessing the `filename` variable. They prevent word splitting of filenames with spaces.

You can still use the pattern in the `for` loop condition if you want to process files from a specific directory. Here is an example of such a pattern:
{line-numbers: false, format: Bash}
```
for filename in /usr/share/doc/bash/*
```

A pattern can filter out files with a specific extension or name. It looks like this:
{line-numbers: false, format: Bash}
```
for filename in ~/Documents/*.pdf
```

There is a new feature for patterns in Bash version 4. You can pass through directories recursively. Here is an example:
{line-numbers: true, format: Bash}
```
shopt -s globstar

for filename in **
```

This feature is disabled by default. Activate it by enabling the `globstar` interpreter option with the `shopt` command.

When Bash meets the `**` pattern, it inserts a list of all subdirectories and their files starting from the current directory. You can combine this mechanism with regular patterns.

For example, let's process all files with the PDF extension from the user's home directory. The following `for` loop condition does that:
{line-numbers: true, format: Bash}
```
shopt -s globstar

for filename in ~/**/*.pdf
```

There is another common mistake when using the `for` loop. Sometimes you just do not need it. For example, you can replace the script in Listing 3-27 with the following `find` call:
{line-numbers: false, format: Bash}
```
find . -maxdepth 1 -exec file {} \;
```

This command is more efficient than the `for` loop. It is compact and works faster because of fewer operations to do.

When should you use the `for` loop instead of the `find` utility? Use `find` when one short command processes found files. If you need a conditional statement or block of commands for this job, use the `for` loop.

There are cases when patterns are not enough in the `for` loop condition. You want to do a complex search with checking file types, for example. In this case, use the `while` loop instead of `for`.

Let's replace the `for` loop in Listing 3-27 with `while`. The `find` utility will provide us a list of files. But we should call it with the `-print0` option. This way, we avoid word splitting issues. Listing 3-28 shows how to combine the `find` utility and `while` loop properly.

{caption: "Listing 3-28. The script for printing the file types", line-numbers: true, format: Bash}
![`while-file.sh`](code/BashScripting/while-file.sh)

There are several tricky solutions in this script. Let's take a closer look at them. The first question is why we need to assign an empty value to the `IFS` variable? If we keep the variable unchanged, Bash splits the `find` output by default delimiters (spaces, tabs and line breaks). It can break filenames with these characters.

The second solution is applying the `-d` option of the `read` command. The option defines a delimiter character for splitting the input text. When using it, the `filename` variable gets the part of the string that comes before the next delimiter.

The `-d` option specifies the empty delimiter. It means a NULL character. You can also specify it explicitly. Do it like this:
{line-numbers: false, format: Bash}
```
while IFS= read -r -d $'\0' filename
```

Thanks to the `-d` option, the read command handles the `find` output correctly. There is the `-print0` option in the utility call. It means that `find` separates found files by a NULL character. This way, we reconcile the `read` input format and the `find` output.

Note that you cannot specify a NULL character as a delimiter using the `IFS` variable. In other words, the following solution does not work:
{line-numbers: false, format: Bash}
```
while IFS=$'\0' read -r filename
```

The problem comes from the peculiarity when [interpreting the `IFS` variable](https://mywiki.wooledge.org/IFS). If the variable is empty, Bash does not do word splitting at all. When you assign a NULL character to the variable, it means an empty value for Bash.

There is the last tricky solution in Listing 3-28. We use process substitution for passing the `find` output to the `while` loop. Why did we not use the command substitution instead? We can do it like this:
{line-numbers: true, format: Bash}
```
while IFS= read -r -d '' filename
do
  file "$filename"
done < $(find . -maxdepth 1 -print0)
```

Unfortunately, this redirection does not work. The < operator couples the input stream and the specified file descriptor. But there is no file descriptor when using the command substitution. Bash calls the `find` utility and inserts its output instead of `$(...)`. When you use process substitution, Bash writes the `find` output to a temporary file. This file has a descriptor. Therefore, the stream redirection works fine.

There is only one issue with process substitution. It is not part of the POSIX standard. If you need to follow the standard, use a pipeline instead. Listing 3-29 demonstrates how to do it.

{caption: "Listing 3-29. The script for printing the file types", line-numbers: true, format: Bash}
![`while-file-pipe.sh`](code/BashScripting/while-file-pipe.sh)

Combine the `while` loop and `find` utility only when you have both following cases at the same time:

1. You need a conditional statement or code block to process files.

2. You have a complex condition for searching files.

When combining `while` and `find`, always use a NULL character as a delimiter. This way, you avoid the word splitting problems.
