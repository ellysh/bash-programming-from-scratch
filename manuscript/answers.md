# Solutions for Exercises

## General Information

##### Exercise 1-1. Numbers conversion from binary to hexadecimal

{line-numbers: false}
```
* 10100110100110 = 0010 1001 1010 0110 = 2 9 A 6 = 29A6

* 1011000111010100010011 = 0010 1100 0111 0101 0001 0011 = 2 C 7 5 1 3 = 2C7513

* 1111101110001001010100110000000110101101 = 1111 1011 1000 1001 0101 0011 0000 0001 1010 1101 = F B 8 9 5 3 0 1 A D = FB895301AD
```

##### Exercise 1-2. Numbers conversion from hexadecimal to binary

{line-numbers: false}
```
* FF00AB02 = F F 0 0 A B 0 2 = 1111 1111 0000 0000 1010 1011 0000 0010 = 11111111000000001010101100000010

* 7854AC1 = 7 8 5 4 A C 1 = 0111 1000 0101 0100 1010 1100 0001 = 111100001010100101011000001

* 1E5340ACB38 = 1 E 5 3 4 0 A C B 3 8 = 0001 1110 0101 0011 0100 0000 1010 1100 1011 0011 1000 = 11110010100110100000010101100101100111000
```

## Bash Shell

##### Exercise 2-1. Glob patterns

The correct answer is "README.md".

The "00_README.txt" string does not fit. It happens because the "*ME.??"" pattern requires two characters after the dot. But the string has three characters.

The "README" string does not fit because it does not have a dot.

##### Exercise 2-2. Glob patterns

The following three lines match the "*/doc?openssl*" pattern:

* `/usr/share/doc/openssl/IPAddressChoice_new.html`
* `/usr/share/doc_openssl/IPAddressChoice_new.html`
* `/doc/openssl`

The "doc/openssl" string does not fit. It does not have the slash symbol before the "doc" word.

##### Exercise 2-3. Searching for files with the `find` utility

The following command searches text files in the system paths:
{line-numbers: false, format: Bash}
```
find /usr -name "*.txt"
```

The `/usr` path stores text files. So, there is no reason to check other system paths.

Now let's count the number of lines in the found files. We should add the `-exec` action with the `wc` utility call to do this. The resulting command looks like this:
{line-numbers: false, format: Bash}
```
find /usr -name "*.txt" -exec wc -l {} +
```

You can find all text files on the disk if you start searching from the root directory. Here is the example command:
{line-numbers: false, format: Bash}
```
find / -name "*.txt"
```

If you add the `wc` call to the command, it fails when running in the MSYS2 environment. In other words, the following command does not work:
{line-numbers: false, format: Bash}
```
find / -name "*.txt" -exec wc -l {} +
```

The problem happens because of the error message that Figure 2-17 shows. The `find` utility passes the message to the `wc` input. The `wc` utility treats each word it receives as a file path. The error message is not a path. Therefore, `wc` fails.

##### Exercise 2-4. Searching for files with the `grep` utility

Look for information about application licenses in the `/usr/share/doc` system path. It contains documentation for all installed software.

If the program has the [GNU General Public License](https://en.wikipedia.org/wiki/GNU_General_Public_License), its documentation contains the "General Public License" line. The following command searches such documents:
{line-numbers: false, format: Bash}
```
grep -Rl "General Public License" /usr/share/doc
```

You also should check the files in the `/usr/share/licenses` path. Here is the command for doing that:
{line-numbers: false, format: Bash}
```
grep -Rl "General Public License" /usr/share/licenses
```

The MSYS2 environment has two extra paths for installing programs: `/mingw32` and `/mingw64`. They do not match the POSIX standard. The following commands check documents in these paths:
{line-numbers: true, format: Bash}
```
grep -Rl "General Public License" /mingw32/share/doc
grep -Rl "General Public License" /mingw64/share
```

You can find applications with other licenses than GNU General Public License. This is the list of licenses and possible lines for searching:

* MIT - "MIT license"
* Apache - "Apache license"
* BSD - "BSD license"

##### Exercise 2-6. Operations with files and directories

First, you should create directories for saving photos by each year and month. The following commands do this task:
{line-numbers: true, format: Bash}
```
mkdir -p ~/photo/2019/11
mkdir -p ~/photo/2019/12
mkdir -p ~/photo/2020/01
```

Suppose that the `D:\Photo` directory contains all photos. You can use the `find` utility for searching files with a creation date equals to November 2019. The `-newermt` option of the utility checks the creation date. Here is an example command:
{line-numbers: false, format: Bash}
```
find /d/Photo -type f -newermt 2019-11-01 ! -newermt 2019-12-01
```

This command looks for files in the `/d/Photo` directory. It corresponds to the `D:\Photo` path in the Windows environment.

The first expression `-newermt 2019-11-01` means to search for files changed since November 1, 2019. The second expression `! -newermt 2019-12-01` excludes files modified since December 1, 2019. The exclamation point before the expression is a negation. There is no condition between expressions. But the find utility inserts the logical AND by default. The resulting expression looks like: "files created after November 1, 2019, but no later than November 30, 2019". It means "files for November".

The file search command is ready. Now add the copy action to it. The result looks like this:
{line-numbers: false, format: Bash}
```
find /d/Photo -type f -newermt 2019-11-01 ! -newermt 2019-12-01 -exec cp {} ~/photo/2019/11 \;
```

This command copies the November 2019 files into the `~/photo/2019/11` directory.

Here are similar commands for copying the December and January files:
{line-numbers: true, format: Bash}
```
find /d/Photo -type f -newermt 2019-12-01 ! -newermt 2020-01-01 -exec cp {} ~/photo/2019/12 \;
find /d/Photo -type f -newermt 2020-01-01 ! -newermt 2020-02-01 -exec cp {} ~/photo/2020/01 \;
```

Let's assume that you do not need old files in the `D:\Photo` directory. Then replace copying action with renaming. The result is the following commands:
{line-numbers: true, format: Bash}
```
find /d/Photo -type f -newermt 2019-11-01 ! -newermt 2019-12-01 -exec mv {} ~/photo/2019/11 \;
find /d/Photo -type f -newermt 2019-12-01 ! -newermt 2020-01-01 -exec mv {} ~/photo/2019/12 \;
find /d/Photo -type f -newermt 2020-01-01 ! -newermt 2020-02-01 -exec mv {} ~/photo/2020/01 \;
```

Note the scalability of our solution. The number of files in the `D:\Photo` directory is not important. You need only three commands to break them up into three months.

##### Exercise 2-7. Pipelines and I/O streams redirection

First, let's figure out how the `bsdtar` utility works. Call it with the `--help` option. It shows you a brief help. The help tells you that the utility archives the directory if you apply the `-c` and `-f` options. The name of the archive follows the options. Here is an example call of the `bsdtar` utility:
{line-numbers: false, format: Bash}
```
bsdtar -c -f test.tar test
```

This command creates an archive named `test.tar`. It has the contents of the `test` directory inside. Note that the command does not [compress data](https://en.wikipedia.org/wiki/Data_compression). It means that the archive occupies the same disk space as the files it contains.

The purposes of archiving and compression operations are different. Archiving is for storing and copying large numbers of files. Compression reduces the amount of the occupied disk memory. Often these operations are combined into one. But they are not the same.

To create an archive and compress it, add the `-j` option to the `bsdtar` call. Here is an example:
{line-numbers: false, format: Bash}
```
bsdtar -c -j -f test.tar.bz2 test
```

You can combine the `-c`, `-j` and `-f` options into one group. Then you get the following command:
{line-numbers: false, format: Bash}
```
bsdtar -cjf test.tar.bz2 test
```

Let's write a command to navigate through the catalog of photos. It should create a separate archive for each month.

The following `find` utility call finds directories that match specific months:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/*
```

Next, we redirect the output of this command to the `xargs` utility. It will generate the `bsdtar` call. Our command looks like this now:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/* | xargs -I% bsdtar -cf %.tar %
```

We can add the `-j` option to force `bsdtar` to compress archived data. The command became like this:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/* | xargs -I% bsdtar -cjf %.tar.bz2 %
```

I> The data compression takes longer than archiving.

We pass the `-I` parameter to the `xargs` utility. It specifies where to insert the arguments into the generated command. There are two such places in the `bsdtar` utility call: the archive's name and the directory's path to be processed.

Do not forget about filenames with line breaks. To process them correctly, add the `-print0` option to the `find` utility call. This way, we get the following command:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/* -print0 | xargs -0 -I% bsdtar -cjf %.tar.bz2 %
```

Suppose that we want to keep the files in the archives without relative paths (e.g. `2019/11`). The `--strip-components` option of `bsdtar` removes them. Here is the command with this option:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/* -print0 | xargs -0 -I% bsdtar --strip-components=3 -cjf %.tar.bz2 %
```

##### Exercise 2-8. Logical operators

Let's implement the algorithm step by step. The first action is to copy the `README` file to the user's home directory. The following command does it:
{line-numbers: false, format: Bash}
```
cp /usr/share/doc/bash/README ~
```

Use the && operator and the `echo` command to print the command's result into the log file. The command became like this:
{line-numbers: false, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > result.log
```

Call the `bsdtar` or `tar` utility to archive a file. Here is an example:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/README.tar.bz2 ~/README
```

We can print the result of archiving operation using the `echo` command again:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> result.log
```

In this case, the `echo` command appends a line to the end of the existing log file.

Let's combine the `cp` and `bsdtar` calls into one command. We should call the `bsdtar` utility only if the `README` file has been successfully copied. To achieve this dependency, we put the && operator between the commands. We get the following command:
{line-numbers: false, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > result.log && bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> result.log
```

The last missing step is deleting the `README` file. We can add it this way:
{line-numbers: false, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > ~/result.log && bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> ~/result.log && rm ~/README && echo "rm - OK" >> ~/result.log
```

Run this command. If it succeeds, the log file looks like this:
{line-numbers: true}
```
cp - OK
bsdtar - OK
rm - OK
```

The command with calls to three utilities in a row looks cumbersome. It is inconvenient to read and edit. Let's break the command into lines. There are several ways to do this.

The first way is to break lines after logical operators. We apply it and get the following:
{line-numbers: true, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > ~/result.log &&
bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> ~/result.log &&
rm ~/README && echo "rm - OK" >> ~/result.log
```

Try to copy this command into a terminal window and execute it. It will run without errors.

The second way to add line breaks is to use the backslash character. Put a line break right after it. Use this method when there are no logical operators in the command.

For example, let's put backslashes before the && operators in our command. Then we get this result:
{line-numbers: true, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > ~/result.log \
&& bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> ~/result.log \
&& rm ~/README && echo "rm - OK" >> ~/result.log
```

##### Exercise 3-2. The full form of parameter expansion

The `find` utility searches for files recursively. It starts from the specified path and passes through all subdirectories. Use the `-maxdepth` option to exclude subdirectories from the search.

The command for searching TXT files in the current directory looks like this:
{line-numbers: false, format: Bash}
```
find . -maxdepth 1 -type f -name "*.txt"
```

Let's add an action to copy the found files to the user's home directory. The command became like this:
{line-numbers: false, format: Bash}
```
find . -maxdepth 1 -type f -name "*.txt" -exec cp -t ~ {} \;
```

Now create a script and name it `txt-copy.sh`. Copy our `find` call into the file.

The script should receive an input parameter. The parameter defines an action to apply for each found file. There are two possible actions: copy or move. It is convenient to pass the utility's name as a parameter. Thus, it can be `cp` or `mv`. The script will call the utility by its name.

According to our idea, the script copies the files when it is called like this:
{line-numbers: false, format: Bash}
```
./txt-copy.sh cp
```

When you want to move files, you call the script like this:
{line-numbers: false, format: Bash}
```
./txt-copy.sh mv
```

You can access the first parameter of the script by the `$1` name. Place this name in the `-exec` action of the`find` call. This way, we get the following command:
{line-numbers: false, format: Bash}
```
find . -maxdepth 1 -type f -name "*.txt" -exec "$1" -t ~ {} \;
```

If you do not specify an action, the script should copy the files. It means that the following call is acceptable:
{line-numbers: false, format: Bash}
```
./txt-copy.sh
```

To make this work, add a default value to the parameter expansion. Listing 5-1 shows the final script that we get this way.

{caption: "Listing 5-1. The script for copying TXT files", line-numbers: true, format: Bash}
![`find-txt.sh`](code/Answers/find-txt.sh)

##### Exercise 3-4. The if statement

The original command looks like this:
{line-numbers: false, format: Bash}
```
( grep -RlZ "123" target | xargs -0 cp -t . && echo "cp - OK" || ! echo "cp - FAILS" ) && ( grep -RLZ "123" target | xargs -0 rm && echo "rm - OK" || echo "rm - FAILS" )
```

Note the negation of the `echo` call with the "cp - FAILS" output. The negation prevents the second `grep` call if the first one fails.

Replace the && operator between `grep` calls with the `if` statement. We get the following code:
{line-numbers: true, format: Bash}
```
if grep -RlZ "123" target | xargs -0 cp -t .
then
  echo "cp - OK"
  grep -RLZ "123" target | xargs -0 rm && echo "rm - OK" || echo "rm - FAILS"
else
  echo "cp - FAILS"
fi
```

Now replace the || operators in the second `grep` call with the `if` statement. The result looks like this:
{line-numbers: true, format: Bash}
```
if grep -RlZ "123" target | xargs -0 cp -t .
then
  echo "cp - OK"
  if grep -RLZ "123" target | xargs -0 rm
  then
    echo "rm - OK"
  else
    echo "rm - FAILS"
  fi
else
  echo "cp - FAILS"
fi
```

To avoid nested `if` statements, we will apply the early return pattern. We will also add a shebang at the beginning of the script. Listing 5-2 shows the result.

{caption: "Listing 5-2. The script for searching a string in files", line-numbers: true, format: Bash}
![`search-copy-remove.sh`](code/Answers/search-copy-remove.sh)
