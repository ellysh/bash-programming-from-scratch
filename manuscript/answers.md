# Solutions for Exercises

## General Information

##### Exercise 1-1. Numbers conversion from binary to hexadecimal

{line-numbers: false}
```
* 10100110100110 = 0010 1001 1010 0110 = 2 9 A 6 = 29A6

* 1011000111010100010011 = 0010 1100 0111 0101 0001 0011 = 2 C 7 5 1 3 = 2C7513

* 1111101110001001010100110000000110101101 =
1111 1011 1000 1001 0101 0011 0000 0001 1010 1101 = F B 8 9 5 3 0 1 A D =
FB895301AD
```

##### Exercise 1-2. Numbers conversion from hexadecimal to binary

{line-numbers: false}
```
* FF00AB02 = F F 0 0 A B 0 2 = 1111 1111 0000 0000 1010 1011 0000 0010 =
11111111000000001010101100000010

* 7854AC1 = 7 8 5 4 A C 1 = 0111 1000 0101 0100 1010 1100 0001 =
111100001010100101011000001

* 1E5340ACB38 = 1 E 5 3 4 0 A C B 3 8 =
001 1110 0101 0011 0100 0000 1010 1100 1011 0011 1000 =
11110010100110100000010101100101100111000
```

## Bash Shell

##### Exercise 2-1. Glob patterns

The correct answer is "README.md".

The "00_README.txt" string does not fit. It happens because the "*ME.??"" pattern requires two characters after the dot. However, the string has three characters.

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

## Bash Scrips

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

##### Exercise 3-4. The `if` statement

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

##### Exercise 3-5. The [[ operator

Let's compare the contents of the two directories. The result of the comparison is a list of files that differ.

First, we have to go through all the files in each directory. The `find` utility does this task. Here is a command to search files in the `dir1` directory:
{line-numbers: false, format: Bash}
```
find dir1 -type f
```

The command's output can look like this:
{line-numbers: false}
```
dir1/test3.txt
dir1/test1.txt
dir1/test2.txt
```

We got a list of files in the `dir1` directory. We should check that each of them presents in the `dir2` directory. Add the following `-exec` action for this check:
{line-numbers: true, format: Bash}
```
cd dir1
find . -type f -exec test -e ../dir2/{} \;
```

Here we use the `test` command instead of the [[ operator. The reason is the built-in interpreter of the `find` utility can not handle this operator correctly. This is one of the exceptions when [[ must be replaced by the `test` command. In general, prefer the [[ operator.

If the `dir2` directory does not contain some file, let's print its name. We need two things for doing that. The first one is inverting the `test` command's result. Then we should add the second `-exec` action with the `echo` command call. Place the logical AND between these two actions. This way, we got the following command:
{line-numbers: true, format: Bash}
```
cd dir1
find . -type f -exec test ! -e ../dir2/{} \; -a -exec echo {} \;
```

We found files of the `dir1` directory that miss in `dir2`. Now we should do vice versa. The similar `find` call can print `dir2` files that miss in `dir1`.
s

Listing 5-3 shows the complete `dir-diff.sh` script for directory comparison.

{caption: "Listing 5-3. The script for directory comparison", line-numbers: true, format: Bash}
![`dir-diff.sh`](code/Answers/dir-diff.sh)

W> We wrote the directory comparison script for training purposes. Please do not use it for real tasks. Prefer the `diff` GNU utility instead.

##### Exercise 3-6. The `case` statement

The script for switching between configuration files will create symbolic links.

I> You cannot create a symbolic link in a Unix environment running on Windows. Instead, the `ln` utility copies the file or directory corresponding to the link. The utility works fine on Linux and macOS.

Symbolic links are useful when you want to access a file or directory from the file system's specific location. When you open a link, you edit the file to which it points. The link to a directory works the same way. Any changes apply to the target directory.

The algorithm for switching between configuration files looks like this:

1. Remove the existing symbolic link or file in the `~/.bashrc` path.

2. Check the command-line option passed to the script.

3. Depending on the option, create a symlink to the `.bashrc-home` or `.bashrc-work` file.

Let's implement this algorithm by using the `case` operator. Listing 5-4 shows the result.

{caption: "Listing 5-4. The script for switching configuration files", line-numbers: true, format: Bash}
![`switch-config-case.sh`](code/Answers/switch-config-case.sh)

The `ln` calls differ only by the target filename. This similarity hints that you can replace the case statement with an associative array. Then we get a script similar to Listing 5-5.

{caption: "Listing 5-5. The script for switching configuration files", line-numbers: true, format: Bash}
![`switch-config-array.sh`](code/Answers/switch-config-array.sh)

Consider the last line of the script. Double-quotes are not necessary when inserting an array element here. But they will prevent an error if the filename gets spaces in the future.

##### Exercise 3-7. Arithmetic operations with numbers in the two's complement representation

The results of the adding of single-byte integers:
{line-numbers: false}
```
* 79 + (-46) = 0100 1111 + 1101 0010 = 1 0010 0001 -> 0010 0000 = 33

* -97 + 96 = 1001 1111 + 0110 0000 = 1111 1111 -> 1111 1110 -> 1000 0001 = -1
```

The result of adding two-byte integers:
{line-numbers: false}
```
* 12868 + (-1219) = 0011 0010 0100 0100 + 1111 1011 0011 1101 =
1 0010 1101 1000 0001 -> 0010 1101 1000 0001 = 11649
```

Use the [online calculator](https://planetcalc.com/747/) to check the conversion integers' correctness to the two's complement.

##### Exercise 3-8. Modulo and the remainder of a division

{line-numbers: false}
```
* 1697 % 13
q = 1697 / 13 ~ 130.5385 ~ 130
r = 1697 - 13 * 130 = 7

* 1697 modulo 13
q = 1697 / 13 ~ 130.5385 ~ 130
r = 1697 - 13 * 130 = 7

* 772 % -45
q = 772 / -45 ~ -17.15556 ~ -17
r = 772 - (-45) * (-17) = 7

* 772 modulo -45
q = (772 / -45) - 1 ~ -18.15556 ~ -18
r = 772 - (-45) * (-18) = -38

* -568 % 12
q = -568 / 12 ~ -47.33333 ~ -47
r = -568 - 12 * (-47) = -4

* -568 modulo 12
q = (-568 / 12) - 1 ~ -48.33333 ~ -48
r = -568 - 12 * (-48) = 8

* -5437 % -17
q = -5437 / -17 ~ 319.8235 ~ 319
r = -5437 - (-17) * 319 = -14

* -5437 modulo -17
q = -5437 / -17 ~ 319.8235 ~ 319
r = -5437 - (-17) * 319 = -14
```

You can use this [Python script](https://github.com/ellysh/bash-programming-from-scratch/blob/master/manuscript/resources/code/Answers/remainer-modulo.py) to check your calculations.

##### Exercise 3-9. Bitwise NOT

First, let us calculate bitwise NOT for unsigned two-byte integers.
{line-numbers: false}
```
 56 = 0000 0000 0011 1000
~56 = 1111 1111 1100 0111 = 65479

 1018 = 0000 0011 1111 1010
~1018 = 1111 1100 0000 0101 = 64517

 58362 = 1110 0011 1111 1010
~58362 = 0001 1100 0000 0101 = 7173
```

If you apply bitwise NOT on signed two-byte integers, the results differ:
{line-numbers: false}
```
 56 = 0000 0000 0011 1000
~56 = 1111 1111 1100 0111 -> 1000 0000 0011 1001 = -57

 1018 = 0000 0011 1111 1010
~1018 = 1111 1100 0000 0101 -> 1000 0011 1111 1011 = -1019
```

You cannot represent the 58362 number as a signed two-byte integer. The reason is an overflow. If we write bits of the number in a variable of this type, we get -7174. Conversion this number to two's complement looks like this:
{line-numbers: false}
```
58362 = 1110 0011 1111 1010 -> 1001 1100 0000 0110 = -7174
```

Now let's apply bitwise NOT:
{line-numbers: false}
```
  -7174  = 1110 0011 1111 1010
~(-7174) = 0001 1100 0000 0101 = 7173
```

The following Bash commands check the results for the signed integers:
{line-numbers: true, format: Bash}
```
$ echo $((~56))
-57
$ echo $((~1018))
-1019
$ echo $((~(-7174)))
7173
```

You cannot check the bitwise NOT of a two-byte unsigned integer 58362 with Bash. The interpreter will store the number in a signed four-byte integer. Then the NOT operation gives the following result:
{line-numbers: true, format: Bash}
```
$ echo $((~58362))
-58363
```

##### Exercise 3-10. Bitwise AND, OR and XOR

Let's calculate bitwise operations for unsigned two-byte integers. Here are the results:

{line-numbers: false}
```
1122 & 908 = 0000 0100 0110 0010 & 0000 0011 1000 1100 = 0000 0000 000 0000 = 0

1122 | 908 = 0000 0100 0110 0010 | 0000 0011 1000 1100 = 0000 0111 1110 1110 = 2030

1122 ^ 908 = 0000 0100 0110 0010 ^ 0000 0011 1000 1100 = 0000 0111 1110 1110 = 2030


49608 & 33036 = 1100 0001 1100 1000 & 1000 0001 0000 1100 = 1000 0001 0000 1000 =
33032

49608 | 33036 = 1100 0001 1100 1000 | 1000 0001 0000 1100 = 1100 0001 1100 1100 =
49612

49608 ^ 33036 = 1100 0001 1100 1000 ^ 1000 0001 0000 1100 = 0100 0000 1100 0100 =
16580
```

If the integers are signed, the bitwise operations for the first pair (1122 and 908) are the same. For the second pair, the calculation is different. Let's consider it.

First, we get the value of the 49608 and 33036 numbers in the two's complement:
{line-numbers: false}
```
49608 = 1100 0001 1100 1000 -> 1011 1110 0011 1000 = -15928

33036 = 1000 0001 0000 1100 -> 1111 1110 1111 0100 = -32500
```

Then we do bitwise operations:
{line-numbers: false}
```
-15928 & -32500 = 1100 0001 1100 1000 & 1000 0001 0000 1100 =
1000 0001 0000 1000 -> 1111 1110 1111 1000 = -32504

-15928 | -32500 = 1100 0001 1100 1000 | 1000 0001 0000 1100 =
1100 0001 1100 1100 -> 1011 1110 0011 0100 = -15924

-15928 ^ -32500 = 1100 0001 1100 1000 ^ 1000 0001 0000 1100 =
0100 0000 1100 0100 = 16580
```

You can check the results with the following Bash commands:
{line-numbers: true, format: Bash}
```
$ echo $((1122 & 908))
0
$ echo $((1122 | 908))
2030
$ echo $((1122 ^ 908))
2030

$ echo $((49608 & 33036))
33032
$ echo $((49608 | 33036))
49612
$ echo $((49608 ^ 33036))
16580

$ echo $((-15928 & -32500))
-32504
$ echo $((-15928 | -32500))
-15924
$ echo $((-15928 ^ -32500))
16580
```

##### Exercise 3-11. Bit shifts

Here are the results of the bit shifts:
{line-numbers: false}
```
* 25649 >> 3 = 0110 0100 0011 0001 >> 3 =
0110 0100 0011 0 = 0000 1100 1000 0110 = 3206

* 25649 << 2 = 0110 0100 0011 0001 << 2 =
10 0100 0011 0001 -> 1001 0000 1100 0100 -> 1110 1111 0011 1100 = -28476

* -9154 >> 4 = 1101 1100 0011 1110 >> 4 =
1101 1100 0011 -> 1111 1101 1100 0011 -> 1000 0010 0011 1101 = -573

* -9154 << 3 = 1101 1100 0011 1110 << 3 =
1 1100 0011 1110 -> 1110 0001 1111 0000 -> 1001 1110 0001 0000 = -7696
```

These Bash commands should calculate the same:
{line-numbers: true, format: Bash}
```
$ echo $((25649 >> 3))
3206
$ echo $((25649 << 2))
102596
$ echo $((-9154 >> 4))
-573
$ echo $((-9154 << 3))
-73232
```

Bash gives different results for the second and fourth cases. It happens because Bash stores all integers in eight bytes.

Check your calculations with the [online calculator](https://onlinetoolz.net/bitshift).

##### Exercise 3-12. Loop Constructs

The player has seven tries to guess a number. The same algorithm handles each try. Therefore, we can apply a loop with seven iterations.

Here is the algorithm for processing a player's action:

1. Read the input with the `read` command.

2. Compare the entered number with the number chosen by the script.

3. If the player makes a mistake, print a hint and go to step 1.

4. If the player guessed the number, finish the script.

The script can pick a random number using the `RANDOM` Bash variable. The variable returns the new random value from 0 to 32767 each time you read it. We need a number between 1 and 100. The following algorithm gets it:

1. Get a random number in the 0 to 99 range. To do this, divide the value from the `RANDOM` variable by 100 using the following formula:
{line-numbers: false, format: Bash}
```
number=$((RANDOM % 100))
```

2. Get a number in the 1 to 100 range. To do this, add one to the previous result.

Here is the complete formula for calculating a random number from 1 to 100:
{line-numbers: false, format: Bash}
```
number=$((RANDOM % 100 + 1))
```

Listing 5-6 shows the script that implements the game's algorithm.

{caption: "Listing 5-6. The script for playing More or Fewer", line-numbers: true, format: Bash}
![`more-less-game.sh`](code/Answers/more-less-game.sh)

To guess a number in seven tries, use the [**binary search**](https://en.wikipedia.org/wiki/Binary_search_algorithm). The idea behind it is to divide an array of numbers into halves. Let's look at an example of applying the binary search for the "More or Fewer" game.

Once the game has started, we guess a number in the range from 1 to 100. The middle of this range is the number 50. Enter this value first. The script will give you the first hint. Suppose the script prints that 50 is less than the number you are looking for. This means that you should search in the range from 50 to 100. Enter the middle of this range, i.e. the number 75. The answer is that 75 is also less than the number you are looking for. The conclusion is that the number you are looking for is between 75 and 100. You can calculate the middle of this range this way:
{line-numbers: false, format: text}
```
X = 75 + (100 - 75) / 2 = 87.5
```

Round the result up or down. It doesn't matter. Round it down and get the number 87 for the next input. If the number is still not guessed, keep dividing the range of expected numbers in half. Then you will have enough seven steps to find the right number.

##### Exercise 3-13. Functions

We have considered the `code_to_error` function in the section "Using Functions in Scripts".

Let's combine the code of the `print_error` and `code_to_error` functions into one file. We will get the script from Listing 5-7.

{caption: "Listing 5-7. The script for printing error messages", line-numbers: true, format: Bash}
![`print-error.sh`](code/Answers/print-error.sh)

Now the function `code_to_error` prints messages in English. Let's rename it to `code_to_error_en`. Then the language of the messages will be clear from the function name.

Let's add a function `code_to_error_de` to the script. It prints the message in German according to the received error code. The function looks like this:
{line-numbers: true, format: Bash}
```
code_to_error_de()
{
  case $1 in
    1)
      echo "Der Datei wurde nicht gefunden:"
      ;;
    2)
      echo "Berechtigung zum Lesen der Datei verweigert:"
      ;;
  esac
}
```

Now we have to choose which `code_to_error` function to call from `print_error`. We can check the regional settings to make the right choice.  The environment variable `LANG` stores these settings. If the variable's value matches the "de_DE*" pattern, call the function `code_to_error_de`. Otherwise, call `code_to_error_en`.

Listing 5-8 shows the complete code of the script.

{caption: "Listing 5-8. The script for printing error messages", line-numbers: true, format: Bash}
![`print-error-local.sh`](code/Answers/print-error-local.sh)

You can replace the `if` statement in the `print_error` function with `case`. For example, do it like this:
{line-numbers: true, format: Bash}
```
print_error()
{
  case $LANG in
    de_DE*)
      echo "$(code_to_error_de $1) $2" >> debug.log
      ;;
    en_US*)
      echo "$(code_to_error_en $1) $2" >> debug.log
      ;;
    *)
      echo "$(code_to_error_en $1) $2" >> debug.log
      ;;
  esac
}
```

The `case` statement is convenient if you need to support more than two languages.

There is code duplication in the `print_error` function. The same `echo` command is called in each block of the `case` statement. The only difference between the blocks is the name of the function for converting the error code into text. We can introduce the `func` variable to get rid of the code duplication. The variable will store the function name. Use the variable this way:
{line-numbers: true, format: Bash}
```
print_error()
{
  case $LANG in
    de_DE)
      local func="code_to_error_de"
      ;;
    en_US)
      local func="code_to_error_en"
      ;;
    *)
      local func="code_to_error_en"
      ;;
  esac

  echo "$($func $1) $2" >> debug.log
}
```

There is a second option to solve the code duplication problem. We can replace the `case` statements in the functions `code_to_error_de` and `code_to_error_en` with indexed arrays. Here is an example:
{line-numbers: true, format: Bash}
```
code_to_error_de()
{
  declare -a messages

  messages[1]="Der Datei wurde nicht gefunden:"
  messages[2]="Berechtigung zum Lesen der Datei verweigert:"

  echo "${messages[$1]}"
}

code_to_error_en()
{
  declare -a messages

  messages[1]="File not found:"
  messages[2]="Permission to read the file denied:"

  echo "${messages[$1]}"
}
```

We can simplify the code and go without `code_to_error` functions. Let's combine messages in all languages into one associative array. Put it in the function `print_error`. The array's keys will combine the `LANGUAGE` variable's value and the error code. We get the `print_error` function like Listing 5-9 shows.

{caption: "Listing 5-9. The script for printing error messages", line-numbers: true, format: Bash}
![`print-error-array.sh`](code/Answers/print-error-array.sh)

##### Exercise 3-14. Variable scope

The script in Listing 3-37 prints the following text:
{line-numbers: true, format: text}
```
main1: var =
foo1: var = foo_value
bar1: var = foo_value
bar2: var = bar_value
foo2: var = bar_value
main2: var =
```

Let's start with the output of "main1" and "main2" strings. The `var` variable is declared as local in the `foo` function. Thus, it is only available in the `foo` and `bar` functions. Hence, Bash supposes that `var` is undeclared before and after calling the `foo` function.

When we print the `var` value from the beginning of the `foo` function, we get it equal to "foo_value".

Next is the output of "bar1". The variable `var` is declared in the `foo` function. This function calls `bar`. Therefore, the body of the `bar` function is also the scope of `var`.

Then we assign the new value "bar_value" to `var`. Note that we are not declaring a new global variable called `var`. We overwrite an existing local variable. We get its value "bar_value" in both outputs "bar2" and "foo2".
