## Loop Constructs

You have learned the conditional statements. They manage the [**control flow**](https://en.wikipedia.org/wiki/Control_flow) of a program. The control flow is the execution order of the program's commands.

The conditional statement chooses a branch of execution depending on the result of a Boolean expression. However, this statement is not enough in some cases. You need extra features to manage the control flow. The [**loop construct**](https://en.wikipedia.org/wiki/Control_flow#Loops) helps you to handle these cases.

The loop construct repeats the same block of commands multiple times. The single execution of this block is called the **loop iteration**. The loop checks its condition after each iteration. The check result defines if the next iteration should be executed.

### Repetition of Commands

Why does somebody need to repeat the same block of commands in his program? Several examples will help us to answer this question.

You are already familiar with the `find` utility. It looks for files and directories on the disk drive. If you add the `-exec` option to the `find` call, you can specify some action. The utility performs this action for each found object.

For example, the following command deletes all PDF documents in the `~/Documents` directory:
{line-numbers: false, format: Bash}
```
find ~/Documents -name "*.pdf" -exec rm {} \;
```

Here `find` calls the `rm` utility several times. It passes the next found file on each call. It means that the `find` utility executes the loop implicitly. The loop ends when `find` finishes the processing of all found files.

The `du` utility is another example of the repetition of commands. The utility estimates the amount of occupied disk space. It has one optional parameter. The parameter sets the path to start the estimation.

Here is an example of the `du` call:
{line-numbers: false, format: Bash}
```
du ~/Documents
```

Here the utility traverses all `~/Documents` subdirectories recursively. It adds the size of each found file to the final result. This way, incrementing the result repeats several times.

The `du` utility performs a loop implicitly. The loop traverses over all files and subdirectories. It does the same actions on each iteration. The only difference between iterations is a file system object to check.

You can meet the repetition of operations in regular mathematical calculations. A canonical example here is the calculation of [**factorial**](https://en.wikipedia.org/wiki/Factorial). The factorial of the number N is a multiplication of natural numbers from 1 to N inclusive.

Here is an example of calculating the factorial of number 4:
{line-numbers: false, format: Bash}
```
4! = 1 * 2 * 3 * 4 = 24
```

You can calculate the factorial easily when using the loop. The loop should pass through the integers from 1 to N in sequence. You should multiply the final result by each passed integer. This way, you repeat the multiplication operation several times.

Here is the last example of action repetition in a computer system. Repetition is an effective approach to manage some events.

Suppose that you write a program. It downloads files to your computer from the Internet. First, the program establishes a connection to a server. If the server doesn't respond, the program has two options to do. The first one is to terminate with a non-zero exit status. The second option is to wait for the server response. This behavior of the program is preferable. There are many reasons why the packets from the server can delay. It can be an overload of the network, for example. Waiting for a couple of seconds is enough to get the packet. Then your program can continue to work.

Now the question arises: how can you wait for the event to occur in the program? The easiest way to get it is using a loop operator. The operator's condition should check if the event occurs. When it happens, the operator stops.

Let's come back to our example. The loop should stop when the program receives a response from the server. While it does not happen, the loop continues. You do not need any actions on each iteration. Instead, you leave the loop body empty. This technique is called [**busy waiting**](https://en.wikipedia.org/wiki/Busy_waiting).

Busy waiting does nothing but can consume a lot of CPU time. This is a reason why you should optimize it when possible. Add the command, which stops the program for a short time, to the loop body. It gives OS a chance to execute another task while your program is waiting.

We have considered examples when the program repeats the same action several times. Let's write down the tasks that such repetition solves:

1. Process multiple entities monotonously. The `find` utility processes the search results this way.

2. Accumulate intermediate data for calculating the final result. The `du` utility does it for collecting statistics.

3. Mathematical calculations. You can calculate factorial using the loop.

4. Wait for some event to happen. You can wait for the server response in the busy waiting loop.

This list is far from being complete. It demonstrates just the most common programming tasks that require the loop operator.

### While Statement

Bash provides two loop operators: `while` and `for`. We will start with the `while` statement because it is more straightforward than `for`.

The `while` syntax resembles the `if` statement. If you write `while` in the general form, it looks this way:
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

Both CONDITION and ACTION can be a single command or block of commands. The ACTION is called the **loop body**.

When Bash executes the `while` loop, it checks the CONDITION first. If a command of the CONDITION returns the zero exit status, it means "true". Bash executes the ACTION in the loop body in this case. Then it rechecks the CONDITION. If it still equals "true", the ACTION is performed again. The loop execution stops when the CONDITION becomes "false".

Use the `while` loop when you do not know the number of iterations beforehand. A good example of this case is busy waiting for some event.

Suppose that you write a script that checks if some web server is available. The simplest check looks this way:

1. Send a request to the server.

2. Receive the response.

3. If there is no response, the server is unavailable.

When the script receives the response from the server, it should print a message and stop.

You can call the [`ping`](https://en.wikipedia.org/wiki/Ping_(networking_utility)) utility to send a request to the server. The utility uses the [ICMP](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol) **protocol**.

The protocol is an agreement for the format of messages between the computers of the network. The ICMP protocol describes the messages to serve the network. For example, you need them to check if some computer is available.

When calling the `ping` utility, you should specify an [IP address](https://en.wikipedia.org/wiki/IP_address) or [URL](https://en.wikipedia.org/wiki/URL) of the target **host**. A host is a computer or device connected to the network.

Here is an example of the `ping` call:
{line-numbers: false, format: Bash}
```
ping google.com
```

We have specified the Google server as the target host. The utility sends ICMP messages there. The server replies to them. The utility output looks like this:
{line-numbers: true, format: Bash}
```
PING google.com (172.217.21.238) 56(84) bytes of data.
64 bytes from fra16s13-in-f14.1e100.net (172.217.21.238): icmp_seq=1 ttl=51 time=17.8 ms
64 bytes from fra16s13-in-f14.1e100.net (172.217.21.238): icmp_seq=2 ttl=51 time=18.5 ms
```

You see information about each sent and received ICMP message. The "time" field means the delay between sending the request and receiving the server response.

The utility runs in the infinite loop by default. You can stop it by pressing Ctrl+C.

You do not need to send several requests to check if some server is available. It is sufficient to send a single ICMP message instead. The `-c` option of the `ping` utility specifies the number of messages to send. Here is an example of how to use it:
{line-numbers: false, format: Bash}
```
ping -c 1 google.com
```

If the `google.com` server is available, the utility returns the zero exit status. Otherwise, it returns a non-zero value.

The `ping` utility expects the server response until you do not interrupt it. The `-W` option limits this waiting time. You can specify one second to wait this way:
{line-numbers: false, format: Bash}
```
ping -c 1 -W 1 google.com
```

Now you have the condition for the `while` statement. There is time to write this statement:
{line-numbers: true, format: Bash}
```
while ! ping -c 1 -W 1 google.com &> /dev/null
do
  sleep 1
done
```

The output of the `ping` utility does not matter in our case. Therefore, you can redirect it to the `/dev/null` file.

The exit status of the `ping` utility is inverted in our `while` condition. Therefore, Bash executes the loop body as long as the utility returns a non-zero exit status. It means that the loop continues as long as the server stays unavailable.

The loop body contains the `sleep` utility call only. It stops the script execution for the specified number of seconds. The stop lasts for one second in our case.

I> You can specify a suffix for a parameter when calling the `sleep` utility. The suffix defines the units of time. The suffix "s" matches seconds. It is "m" for minutes, "h" for hours and "d" for days.

Listing 3-18 shows the complete script for checking server availability.

{caption: "Listing 3-18. Script for checking server availability", line-numbers: true, format: Bash}
![`while-ping.sh`](code/BashScripting/while-ping.sh)

The `while` statement has an alternative form called `until`. It executes the ACTION until the CONDITION stays "false". It means that the loop continues as long as the CONDITION returns a non-zero exit status. Use the `until` statement when you need to invert the condition of the `while` loop.

The general form of the `until` statement looks this way:
{line-numbers: true}
```
until CONDITION
do
  ACTION
done
```

You can write it in one line, the same way as you do it for `while`:
{line-numbers: false}
```
until CONDITION; do ACTION; done
```

Let's replace the `while` statement with `until` in Listing 3-18. You should remove the negation of the `ping` result for that. Listing 3-19 shows the changed script.

{caption: "Listing 3-19. Script for checking server availability", line-numbers: true, format: Bash}
![`until-ping.sh`](code/BashScripting/until-ping.sh)

The scripts in Listing 3-18 and Listing 3-19 behave the same.

Choose the `while` or `until` statement, depending on the loop condition. Your goal is to avoid negations there. Negations make the code harder to read.

#### Infinite Loop

The `while` statement fits well when you need to implement an [**infinite loop**](https://en.wikipedia.org/wiki/Infinite_loop). This kind of loop continues as long as the program is running.

You can meet infinite loops in system software. They run the whole time while a computer stays powered on. An example is the microcontroller firmware that checks some sensors cyclically. It happens in the infinite loop. Also, such loops are used in computer games, antiviruses, monitors of computer resources, etc.

The `while` loop becomes infinite if its condition always stays true. The easiest way to make such a condition is to call the `true` Bash built-in. Here is an example for doing that:
{line-numbers: true, format: Bash}
```
while true
do
  sleep 1
done
```

The `true` built-in always returns the "true" value. It means that it returns zero exit status. There is the symmetric command called `false`. It always returns exit status one that matches the "false" value.

I> Words "true" and "false" are [**literals**](https://en.wikipedia.org/wiki/Literal_(computer_programming)) in most programming languages. They represent the corresponding Boolean values. Literals are reserved words for representing fixed values.

You can replace the `true` built-in in the `while` condition with a colon. Then you will get the following statement:
{line-numbers: true, format: Bash}
```
while :
do
  sleep 1
done
```

The colon is synonymous with the `true` command. This synonymous solves the [compatibility task](https://stackoverflow.com/questions/3224878/what-is-the-purpose-of-the-colon-gnu-bash-builtin) with the Bourne shell. This shell does not have `true` and `false` built-ins. Bourne shell scripts use a colon instead, and Bash should support it.

The POSIX standard includes all three keywords: colon, `true`, and `false`. However, you should avoid using a colon in your scripts. It is a deprecated syntax that makes your code harder to understand.

Here is an example of an infinite loop. Suppose that you need a script that displays statistics of disk space usage. The `df` utility can help you in this case. It provides the following output when called without parameters:
{line-numbers: true, format: Bash}
```
$ df
Filesystem     1K-blocks      Used Available Use% Mounted on
C:/msys64       41940988  24666880  17274108  59% /
Z:             195059116 110151748  84907368  57% /z
```

The utility shows "Used" and "Available" disk space in bytes. You can improve this output by adding the `-h` option to the utility call. Then `df` shows kilobytes, megabytes, gigabytes and terabytes instead of bytes. Another option that you can apply is `-T`. It shows the file system type for each disk. You will get the following output after all improvements:
{line-numbers: true, format: Bash}
```
$ df -hT
Filesystem     Type  Size  Used Avail Use% Mounted on
C:/msys64      ntfs   40G   24G   17G  59% /
Z:             hgfs  187G  106G   81G  57% /z
```

If you need to get information about all mount points, add the `-a` option.

Now you should write the infinite loop. It calls the `df` utility on each iteration. This way, you will get a simple script to monitor the file system. Listing 3-20 shows how it looks like.

{caption: "Listing 3-20. The script to monitor the file system", line-numbers: true, format: Bash}
![`while-df.sh`](code/BashScripting/while-df.sh)

The first action of the loop body is the `clear` utility call. It removes all text in the terminal window. Thanks to this step, the terminal shows the output of your script only.

When working with Bash, you often face the task of executing a command in a cycle. The `watch` utility does it. The utility is a part of the `procps` package. If you need it, the following command installs it to the MSYS2 environment:
{line-numbers: false, format: Bash}
```
pacman -S procps
```

Now you can replace the script from Listing 3-20 with a single command this way:
{line-numbers: false, format: Bash}
```
watch -n 2 "df -hT"
```

The `-n` option of the `watch` utility specifies the interval between command calls. The command to execute follows all options of `watch`.

The `-d` utility option highlights the difference of the command output at the current and past iterations. This way, it is easier to keep track of occurred changes.

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

The `read` command receives data from the standard input stream. It means that you can redirect the file contents to the command.

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

#### The Second Form of For

The second form of the `for` statement allows you to specify an arithmetic expression as a condition. Let's consider cases when do you need it.

Suppose we need a script to calculate the factorial. The solution for this task depends on the way we enter the data. The first option is we have a predefined integer. Then the first form of the `for` loop fits well. Listing 3-30 shows this solution.

{caption: "Listing 3-30. The script for calculating the factorial for integer 5", line-numbers: true, format: Bash}
![`for-factorial-brace.sh`](code/BashScripting/for-factorial-brace.sh)

The second option is to receive the integer as an input parameter of the script. We can try the following loop's condition to process the `$1` parameter:
{line-numbers: false, format: Bash}
```
for i in {1..$1}
```

We expect that Bash will do brace expansion for integers from one to the `$1` value. However, it does not work this way.

According to Table 3-2, the brace expansion happens before the parameter expansion. Thus, the loop condition gets the string "{1...$1}" instead of "1 2 3 4 5". Bash does not recognize the brace expansion because the upper bound of the range is not an integer. Then Bash writes the "{1...$1}" string to the `i` variable. Therefore, the following (( operator fails.

The `seq` utility can solve our problem. It generates a sequence of integers or fractions.

Table 3-21 shows the ways to call the `seq` utility.

{caption: "Table 3-21. The ways to call the `seq` utility", width: "100%"}
| Number of parameters | Description | Example | Result |
| --- | --- | --- | --- |
| 1 | The parameter defines the last number in the generated sequence. The sequence starts with one. | `seq 5` | 1 2 3 4 5 |
|  | | | |
| 2 | The parameters are the first and last numbers of the sequence. | `seq -3 3` | -2 -1 0 1 2 |
|  | | | |
| 3 | The parameters are the first number, step and last numbers of the sequence. | `seq 1 2 5` | 1 3 5 |

The `seq` utility splits integers on the output by line breaks. The `-s` option allows you to specify another delimiter. The `IFS` variable contains the line break symbol. Therefore, you do not need the `-s` option in our case.

There are line breaks instead of spaces in the "Result" column of Table 3-21. This is done for convenience.

Let's apply the `seq` utility and write the script to calculate a factorial for any integer. Listing 3-31 shows this script.

{caption: "Listing 3-31. The script for calculating a factorial", line-numbers: true, format: Bash}
![`for-factorial-seq.sh`](code/BashScripting/for-factorial-seq.sh)

This solution works properly. However, it is ineffective. The performance overhead comes because of calling the external `seq` utility. It costs the same time as launching an application (for example, Windows Calculator). The OS kernel performs several complicated operations whenever Bash creates a new process. They take significant time on the processor's scale. Therefore, apply the built-in Bash commands whenever possible.

We need the second form of the `for` statement to solve the task effectively. This form looks like this in general:
{line-numbers: true, format: Bash}
```
for (( EXPRESSION_1; EXPRESSION_2; EXPRESSION_3 ))
do
  ACTION
done
```

You can write it in one line this way:
{line-numbers: false, format: Bash}
```
for (( EXPRESSION_1; EXPRESSION_2; EXPRESSION_3 )); do ACTION; done
```

Bash executes the `for` loop with an arithmetic condition this way:

1. Bash calculates the EXPRESSION_1 once before the first iteration of the loop.

2. The loop continues as long as EXPRESSION_2 remains true. The loop stops when it returns "false".

3. Bash calculates the EXPRESSION_3 at the end of each iteration.

Let's replace the `seq` utility call with the arithmetic expression in Listing 3-31. Listing 3-32 shows the result.

{caption: "Listing 3-32. The script for calculating a factorial", line-numbers: true, format: Bash}
![`for-factorial.sh`](code/BashScripting/for-factorial.sh)

This script works faster. It uses Bash built-in commands only. There is no need to create new processes here.

The `for` statement in the script follows this algorithm:

1. Declare the `i` variable before the first iteration of the loop. Assign it integer 1. The variable is a loop counter.

2. Compare the loop counter with the input parameter `$1`.

3. If the counter is smaller than the `$1` parameter, do the loop iteration.

4. If the counter is greater than the parameter, stop the loop.

5. Calculate the arithmetic expression "result *= i" in the loop's body. It multiplies the `result` variable by `i`.

6. When the loop iteration is done, calculate the "++i" expression of the `for` condition. It increments the `i` variable by one.

7. Go to the 2nd step of the algorithm.

I> In the general case, you do not need the dollar sign for variables names in the (( operator and `let` command. However, it is necessary for code in Listing 3-32. Without the sign, Bash confuses the `$1`parameter and literal 1.

We use the prefix increment form in the loop. It works faster than the postfix form.

Use the second form of the `for` whenever you should calculate the loop counter. There are no other effective solutions in this case.

### Controlling the Loop Execution

The loop stops according to its condition. There are additional ways to control the loop execution. They allow you to interrupt it or skip the current iteration. Let's consider them in detail.

#### break

The `break` command stops the loop immediately. It is useful for handling an error or finishing an infinite loop.

Here is an example. We want to write the script that searches an array's element by value. When the script finds it, there is no reason to continue the loop. We can finish it immediately with the `break` command. Listing 3-33 shows how to do it.

{caption: "Listing 3-33. The script for searching an array's element", line-numbers: true, format: Bash}
![`for-break.sh`](code/BashScripting/for-break.sh)

The script receives an element's value to search via the `$1` parameter.

The `is_found` stores the search result. The `if` statement checks the value of the current array's element. If it matches the `$1` parameter, we set the `is_found` variable to one. Then we interrupt the loop with the `break` command.

There is the `if` statement after the loop. It checks the `is_found` variable. Then the `echo` command prints if the searching has succeeded.

Use the `break` command to take as much as possible out of the loop body. When the loop body is short, it is easier to read and understand.

Here is an example. We can print the searching result right in the loop body in Listing 3-33. Then we do not need to store the result in the `is_found` variable. On the other hand, the processing of the found element can be complex. In this case, take it out of the loop body.

Sometimes it does not make sense to continue the script when interrupting the loop. Use the `exit` command instead of `break` in this case.

For example, it can be an error in the input data that we catch in the loop body. Then printing an error message and calling the `exit` command is the best choice to stop the script.

The `exit` command makes your code cleaner if you process the result in the loop body. Just call `exit` when you are done.

Let's replace the `break` command with `exit` in Listing 3-33. Listing 3-34 shows the result.

{caption: "Listing 3-34. The script for searching an array's element", line-numbers: true, format: Bash}
![`for-exit.sh`](code/BashScripting/for-exit.sh)

Using the `exit` command, we handle the search result in the loop body. In this case, it has shortened our code and made it simpler. But you get the opposite effect if the result processing requires a block of commands.

The scripts in Listing 3-33 and Listing 3-34 give the same result.

#### continue

The `continue` command skips the current loop iteration. The loop does not stop in this case. It starts the next iteration instead.

Here is an example. Suppose we want to calculate the sum of positive integers in an array. Thus, we should distinguish the signs of the integers. The `if` statement fits well for this task. If the integer's sign is positive, we add the integer to the result. Listing 3-35 shows the final script.

{caption: "Listing 3-35. The script for calculating the sum of positive integers in an array", line-numbers: true, format: Bash}
![`for-sum.sh`](code/BashScripting/for-sum.sh)

If the `element` variable is greater than zero, we add it to the result `sum`.

Let's use the `continue` command to get the same behavior. Listing 3-36 shows the result.

{caption: "Listing 3-36. The script for calculating the sum of positive integers in an array", line-numbers: true, format: Bash}
![`for-continue.sh`](code/BashScripting/for-continue.sh)

We have inverted the condition of the `if` statement. Now it is "true" for negative numbers. Bash calls the `continue` command in this case. The command interrupts the current loop iteration. It means that all further operations are ignored. Then the next iteration starts with the next array element.

We have applied the early return pattern in the context of the loop.

Use the `continue` command to handle errors. It is also helpful for conditions where it does not make sense to execute the loop body to the end. This way, you avoid the nested `if` statements. This solution makes your code cleaner.

{caption: "Exercise 3-12. Loop Constructs", format: text, line-numbers: false}
```
Write a game called "More or Fewer". The first participant chooses a number from
1 to 100.
The second participant tries to guess it in seven tries.

Your script chooses a number. The user enters his guess.
The script answers if the guess is more or less than the chosen number.
The user then tries to guess the number six more times.
```
