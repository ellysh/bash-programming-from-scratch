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

Now let's count the number of lines in the found files. The `wc` utility can do this task. We should call the utility using the `-exec` action. Then the resulting command looks like this:
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

The problem happens because of the error message that Figure 2-17 shows. The `find` utility passes its error message to the `wc` input. The `wc` utility treats each word it receives as a file path. The error message is not a path. Therefore, `wc` fails.

##### Exercise 2-4. Searching for files with the `grep` utility

Look for information about application licenses in the `/usr/share/doc` system path. It contains documentation for all installed software.

If the program has the [GNU General Public License](https://en.wikipedia.org/wiki/GNU_General_Public_License), its documentation contains the "General Public License" phrase. The following command searches this phrase in all documents:
{line-numbers: false, format: Bash}
```
grep -Rl "General Public License" /usr/share/doc
```

The `/usr/share/licenses` path is the place where you can find license information for all installed software. You can search the "General Public License" phrase there with the following command:
{line-numbers: false, format: Bash}
```
grep -Rl "General Public License" /usr/share/licenses
```

The MSYS2 environment has two extra paths for installing programs: `/mingw32` and `/mingw64`. They do not match the POSIX standard. The following `grep` calls check these paths:
{line-numbers: true, format: Bash}
```
grep -Rl "General Public License" /mingw32/share/doc
grep -Rl "General Public License" /mingw64/share
```

You can find applications with other licenses than GNU General Public License. Here is the list of licenses and corresponding phrases for searching:

* MIT - "MIT license"
* Apache - "Apache license"
* BSD - "BSD license"

##### Exercise 2-6. Operations with files and directories

First, you should create directories for saving photos. Each directory should match a specific month of the year. The following commands create them:
{line-numbers: true, format: Bash}
```
mkdir -p ~/photo/2019/11
mkdir -p ~/photo/2019/12
mkdir -p ~/photo/2020/01
```

Suppose that the `D:\Photo` directory contains all your photos. You can use the `find` utility to search photos created in November 2019. The `-newermt` option of the utility checks the creation date. Here is an example command of how to use it:
{line-numbers: false, format: Bash}
```
find /d/Photo -type f -newermt 2019-11-01 ! -newermt 2019-12-01
```

This command looks for files in the `/d/Photo` directory. It matches the `D:\Photo` path in the Windows environment.

The first expression `-newermt 2019-11-01` points to files changed since November 1, 2019. The second expression `! -newermt 2019-12-01` excludes files modified since December 1, 2019. The exclamation point before the expression is a negation. There is no condition between expressions. The `find` utility inserts the logical AND by default. The resulting expression looks like: "files created after November 1, 2019, but no later than November 30, 2019". It means "the files created in November 2019".

The file search command is ready. Now we should add the copy action there. The result looks like this:
{line-numbers: false, format: Bash}
```
find /d/Photo -type f -newermt 2019-11-01 ! -newermt 2019-12-01 -exec cp {} ~/photo/2019/11 \;
```

This command copies the files created in November 2019 into the `~/photo/2019/11` directory.

Here are the similar commands for copying the December and January files:
{line-numbers: true, format: Bash}
```
find /d/Photo -type f -newermt 2019-12-01 ! -newermt 2020-01-01 -exec cp {} ~/photo/2019/12 \;
find /d/Photo -type f -newermt 2020-01-01 ! -newermt 2020-02-01 -exec cp {} ~/photo/2020/01 \;
```

Let's assume that you do not need old files in the `D:\Photo` directory. Then you should replace the copying action with renaming. This way, you get the following commands:
{line-numbers: true, format: Bash}
```
find /d/Photo -type f -newermt 2019-11-01 ! -newermt 2019-12-01 -exec mv {} ~/photo/2019/11 \;
find /d/Photo -type f -newermt 2019-12-01 ! -newermt 2020-01-01 -exec mv {} ~/photo/2019/12 \;
find /d/Photo -type f -newermt 2020-01-01 ! -newermt 2020-02-01 -exec mv {} ~/photo/2020/01 \;
```

Note the scalability of our solution. The number of files in the `D:\Photo` directory does not matter. You need only three commands to process them.

##### Exercise 2-7. Pipelines and I/O streams redirection

First, let's figure out how the `bsdtar` utility works. Call it with the `--help` option. It shows you a brief help. The help tells you that the utility archives a target directory if you apply the `-c` and `-f` options. You should specify the archive name after these options. Here is an example call of the `bsdtar` utility:
{line-numbers: false, format: Bash}
```
bsdtar -c -f test.tar test
```

This command creates the `test.tar` archive. It includes the contents of the `test` directory. Note that the command does not [compress data](https://en.wikipedia.org/wiki/Data_compression). It means that the archive occupies the same disk space as the files it contains.

The purposes of archiving and compression operations differ. You need archiving for storing and copying a large number of files. Compression reduces the amount of the occupied disk memory. These operations are combined into one often, but they are not the same.

Suppose that you want to create an archive and compress it. Then you need to add the `-j` option to the `bsdtar` call. Here is an example:
{line-numbers: false, format: Bash}
```
bsdtar -c -j -f test.tar.bz2 test
```

You can combine the `-c`, `-j` and `-f` options into one group. Then you get the following command:
{line-numbers: false, format: Bash}
```
bsdtar -cjf test.tar.bz2 test
```

Let's write a command for processing all photos. The command should archive each directory with the photos of the specific month.

First, you need to find the directories for archiving. The following command does it:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/*
```

Next, you redirect the output of the `find` call to the `xargs` utility. It will generate the `bsdtar` call. This way, you get the following command:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/* | xargs -I% bsdtar -cf %.tar %
```

You can add the `-j` option to force `bsdtar` to compress archived data. The command became like this:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/* | xargs -I% bsdtar -cjf %.tar.bz2 %
```

I> The data compression usually takes longer than archiving.

We pass the `-I` parameter to the `xargs` utility. It specifies the place to insert the arguments into the generated command. There are two such places in the `bsdtar` utility call: the archive's name and the directory's path to be processed.

Do not forget about filenames with line breaks. To process them correctly, add the `-print0` option to the `find` call. This way, you get the following command:
{line-numbers: false, format: Bash}
```
find ~/photo -type d -path */2019/* -o -path */2020/* -print0 | xargs -0 -I% bsdtar -cjf %.tar.bz2 %
```

Suppose that you want to keep the files in the archives without relative paths (e.g. `2019/11`). The `--strip-components` option of `bsdtar` removes them. The following command uses this option:
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

Apply the && operator and the `echo` built-in to print the `cp` result into the log file. Then you get the following command:
{line-numbers: false, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > result.log
```

The second step is archiving the file. You can call the `bsdtar` or `tar` utility for that. Here is an example:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/README.tar.bz2 ~/README
```

Add `echo` built-in to print the result of the archiving utility. The command becomes like this:
{line-numbers: false, format: Bash}
```
bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> result.log
```

Here the `echo` command appends the string to the end of the existing log file.

Let's combine the `cp` and `bsdtar` utilities into one command. You should call `bsdtar` only if the `README` file has been copied successfully. To achieve this dependency, put the && operator between the calls. This way, you get the following command:
{line-numbers: false, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > result.log && bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> result.log
```

The last step is deleting the `README` file. Do it by the `rm` call this way:
{line-numbers: false, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > ~/result.log && bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> ~/result.log && rm ~/README && echo "rm - OK" >> ~/result.log
```

Run this command in your terminal. If it succeeds, you get the following log file:
{line-numbers: true}
```
cp - OK
bsdtar - OK
rm - OK
```

The current version of our command calls three utilities in a row. It looks cumbersome and inconvenient for reading. Let's break the command into lines. There are several ways to do that.

The first way is to break lines after logical operators. If you apply this approach, you get the following result:
{line-numbers: true, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > ~/result.log &&
bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> ~/result.log &&
rm ~/README && echo "rm - OK" >> ~/result.log
```

Copy this command to your terminal and execute it. It works properly.

The second way to add line breaks is to use the backslash symbol. Put a line break right after it. This method fits well when there are no logical operators in the command.

For example, you can put backslashes before the && operators in our command. Then you get this result:
{line-numbers: true, format: Bash}
```
cp /usr/share/doc/bash/README ~ && echo "cp - OK" > ~/result.log \
&& bsdtar -cjf ~/README.tar.bz2 ~/README && echo "bsdtar - OK" >> ~/result.log \
&& rm ~/README && echo "rm - OK" >> ~/result.log
```

Run this command in your terminal. It works properly too.

## Bash Scrips

##### Exercise 3-2. The full form of parameter expansion

The `find` utility searches for files recursively. It starts from the specified path and passes through all subdirectories. If you want to exclude subdirectories from the search, apply the `-maxdepth` option.

Here is the command for searching TXT files in the current directory:
{line-numbers: false, format: Bash}
```
find . -maxdepth 1 -type f -name "*.txt"
```

Let's add an action to copy the found files to the user's home directory. The command becomes like this:
{line-numbers: false, format: Bash}
```
find . -maxdepth 1 -type f -name "*.txt" -exec cp -t ~ {} \;
```

Now create a script and name it `txt-copy.sh`. Copy the `find` call to this file.

The script should choose an action to apply for each found file. It can be copying or moving. The straightforward way is to pass the parameter to the script. This parameter defines the required action.

You can choose any values for parameters. However, the most obvious values are the names of GNU utilities to perform actions on files. The names are `cp` and `mv`. If you pass them, the script can extract the utility name from the parameter and call it.

The script copies found files when you call it like this:
{line-numbers: false, format: Bash}
```
./txt-copy.sh cp
```

If you need to move files, you call the script this way:
{line-numbers: false, format: Bash}
```
./txt-copy.sh mv
```

The first parameter of the script is available via the `$1` variable. Expand it in the `-exec` action of the`find` call. Then you get the following command:
{line-numbers: false, format: Bash}
```
find . -maxdepth 1 -type f -name "*.txt" -exec "$1" -t ~ {} \;
```

If you do not specify an action, the script should copy the files. It means that the following call should work well:
{line-numbers: false, format: Bash}
```
./txt-copy.sh
```

Add a default value to the parameter expansion to handle the case of the missing parameter.

Listing 5-1 shows the final script that you get this way.

{caption: "Listing 5-1. The script for copying TXT files", line-numbers: true, format: Bash}
![`find-txt.sh`](code/Answers/find-txt.sh)

##### Exercise 3-4. The `if` statement

The original command looks this way:
{line-numbers: false, format: Bash}
```
( grep -RlZ "123" target | xargs -0 cp -t . && echo "cp - OK" || ! echo "cp - FAILS" ) && ( grep -RLZ "123" target | xargs -0 rm && echo "rm - OK" || echo "rm - FAILS" )
```

Note the negation of the `echo` call with the "cp - FAILS" output. The negation prevents the second `grep` call if the first one fails.

First, replace the && operator between `grep` calls with the `if` statement. Then you get the following code:
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

Next, replace the || operator in the second `grep` call with the `if` statement. The result looks like this:
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

You get the nested `if` statement. Apply the early return pattern to get rid of it.

The last step is adding the shebang at the beginning of the script. Listing 5-2 shows the final result.

{caption: "Listing 5-2. The script for searching a string in files", line-numbers: true, format: Bash}
![`search-copy-remove.sh`](code/Answers/search-copy-remove.sh)

##### Exercise 3-5. The [[ operator

Let's compare the contents of the two directories. The result of the comparison is a list of files that differ.

First, you have to pass through all files in each directory. The `find` utility does this task. Here is a command to search files in the `dir1` directory:
{line-numbers: false, format: Bash}
```
find dir1 -type f
```

Here is an example output of the command:
{line-numbers: false}
```
dir1/test3.txt
dir1/test1.txt
dir1/test2.txt
```

You got a list of files in the `dir1` directory. Next, you should check that each of them presents in the `dir2` directory. Add the following `-exec` action for this check:
{line-numbers: true, format: Bash}
```
cd dir1
find . -type f -exec test -e ../dir2/{} \;
```

Here you should use the `test` command instead of the [[ operator. The reason is the built-in interpreter of the `find` utility can not handle this Bash operator. This is one of the few exceptions when you need to apply the `test` command. In general, the [[ operator should be used instead.

If the `dir2` directory does not contain some file, let's print its name. You need two things to do that. The first one is inverting the `test` command result. Second, you should add an extra `-exec` action with the `echo` call. Place the logical AND these two `-exec` actions. This way, you get the following command:
{line-numbers: true, format: Bash}
```
cd dir1
find . -type f -exec test ! -e ../dir2/{} \; -a -exec echo {} \;
```

You found files of the `dir1` directory that miss in `dir2`. Now you should repeat the search and check the vice versa case. The similar `find` call can print `dir2` files that miss in `dir1`.

Listing 5-3 shows the complete `dir-diff.sh` script for directory comparison.

{caption: "Listing 5-3. The script for directory comparison", line-numbers: true, format: Bash}
![`dir-diff.sh`](code/Answers/dir-diff.sh)

W> You wrote the directory comparison script for training purposes. Please do not use it for real tasks. The `diff` GNU utility should be used instead.

##### Exercise 3-6. The `case` statement

Let's write the script for switching between two Bash configurations. It will create a symbolic link for the `~/.bashrc` file.

I> You cannot create a symbolic link in a Unix environment running on Windows.

The `ln` utility creates a link. It does so when you launch it on Linux or macOS. The utility copies the file or directory instead of creating a link on Windows.

Symbolic links are useful when you want to access a file or directory from the specific location of the file system. Suppose that you have a link to the file. You open the link and make some changes. Then, OS applies your changes to the file that the link points to. A link to a directory works the same way. OS applies your changes to the target directory.

The algorithm for switching between Bash configurations looks like this:

1. Remove the existing symbolic link or file `~/.bashrc`.

2. Check the command-line option passed to the script.

3. Depending on the option, create the `~/.bashrc` link to the `~/.bashrc-home` or `~/.bashrc-work` file.

Let's implement this algorithm using the `case` statement. Listing 5-4 shows the result.

{caption: "Listing 5-4. The script for switching Bash configurations", line-numbers: true, format: Bash}
![`switch-config-case.sh`](code/Answers/switch-config-case.sh)

There are two calls of the `ln` utility in this script. They differ by the target filename. This similarity gives us a hint that you can replace the `case` statement with an associative array. Then you get the script from Listing 5-5.

{caption: "Listing 5-5. The script for switching Bash configurations", line-numbers: true, format: Bash}
![`switch-config-array.sh`](code/Answers/switch-config-array.sh)

Consider the last line of the script. In our case, double quotes are not necessary when you insert the array element. However, they prevent a potential error of processing filenames with spaces.

##### Exercise 3-7. Arithmetic operations with numbers in the two's complement representation

Here are the results of adding single-byte integers:
{line-numbers: false}
```
* 79 + (-46) = 0100 1111 + 1101 0010 = 1 0010 0001 -> 0010 0000 = 33

* -97 + 96 = 1001 1111 + 0110 0000 = 1111 1111 -> 1111 1110 -> 1000 0001 = -1
```

Here are the result of adding two-byte integers:
{line-numbers: false}
```
* 12868 + (-1219) = 0011 0010 0100 0100 + 1111 1011 0011 1101 =
1 0010 1101 1000 0001 -> 0010 1101 1000 0001 = 11649
```

Use the [online calculator](https://planetcalc.com/747/) to check your conversion of integers to the two's complement.

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

You can use this [Python script](https://github.com/ellysh/bash-programming-from-scratch/blob/master/manuscript/resources/code/Answers/remainer-modulo.py) to check your calculations. Call the `getRemainder` and `getModulo` functions for your pair of numbers. Then print the results using the `print` function. Take the existing function calls in this script as examples.

##### Exercise 3-9. Bitwise NOT

First, let's calculate bitwise NOT for unsigned two-byte integers. You get the following results:
{line-numbers: false}
```
 56 = 0000 0000 0011 1000
~56 = 1111 1111 1100 0111 = 65479

 1018 = 0000 0011 1111 1010
~1018 = 1111 1100 0000 0101 = 64517

 58362 = 1110 0011 1111 1010
~58362 = 0001 1100 0000 0101 = 7173
```

If you apply bitwise NOT for signed two-byte integers, you get other results. They look this way:
{line-numbers: false}
```
 56 = 0000 0000 0011 1000
~56 = 1111 1111 1100 0111 -> 1000 0000 0011 1001 = -57

 1018 = 0000 0011 1111 1010
~1018 = 1111 1100 0000 0101 -> 1000 0011 1111 1011 = -1019
```

You cannot represent the 58362 number as a signed two-byte integer. The reason is an overflow. If you write bits of the number in a variable of this type, you get -7174. The following conversion of the 58362 number to two's complement explains it:
{line-numbers: false}
```
58362 = 1110 0011 1111 1010 -> 1001 1100 0000 0110 = -7174
```

Now you can apply the bitwise NOT and get the following result:
{line-numbers: false}
```
  -7174  = 1110 0011 1111 1010
~(-7174) = 0001 1100 0000 0101 = 7173
```

You can check the results of your calculations for the signed integers using Bash. Here are the commands for that:
{line-numbers: true, format: Bash}
```
$ echo $((~56))
-57
$ echo $((~1018))
-1019
$ echo $((~(-7174)))
7173
```

Bash does not allow you to calculate the bitwise NOT for the two-byte unsigned integer 58362. It happens because the interpreter stores this number as a signed eight-byte integer. Then the NOT operation gives you the following result:
{line-numbers: true, format: Bash}
```
$ echo $((~58362))
-58363
```

##### Exercise 3-10. Bitwise AND, OR and XOR

Let's calculate bitwise operations for unsigned two-byte integers. You will get the following results:
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

If the integers are signed, the bitwise operations give the same results for the first pair of numbers 1122 and 908.

Let's calculate the bitwise operations for signed two-byte integers 49608 and 33036. First, you should represent these numbers in the two's complement this way:
{line-numbers: false}
```
49608 = 1100 0001 1100 1000 -> 1011 1110 0011 1000 = -15928

33036 = 1000 0001 0000 1100 -> 1111 1110 1111 0100 = -32500
```

The integer overflow happened here. So, you get negative numbers instead of positive ones.

Then you do bitwise operations:
{line-numbers: false}
```
-15928 & -32500 = 1100 0001 1100 1000 & 1000 0001 0000 1100 =
1000 0001 0000 1000 -> 1111 1110 1111 1000 = -32504

-15928 | -32500 = 1100 0001 1100 1000 | 1000 0001 0000 1100 =
1100 0001 1100 1100 -> 1011 1110 0011 0100 = -15924

-15928 ^ -32500 = 1100 0001 1100 1000 ^ 1000 0001 0000 1100 =
0100 0000 1100 0100 = 16580
```

If you need to check your results, Bash can help you. Here are the commands:
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

Let's perform bit-shifts for the signed two-byte integers. Then you will get the following results:
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

Here are the Bash commands for checking the calculations:
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

Bash results for the second and fourth cases differ from our calculations. It happens because the interpreter stores all integers in eight bytes.

The [online calculator](https://onlinetoolz.net/bitshift) allows you to specify the integer type. Therefore, it is a more reliable tool for checking bit shifts than Bash.

##### Exercise 3-12. Loop Constructs

The player has seven tries to guess a number. The same algorithm handles each try. Therefore, the loop with seven iterations can handle the user input.

Here is the algorithm for processing one player action:

1. Read the input with the `read` command.

2. Compare the entered number with the number chosen by the script.

3. If the player makes a mistake, print a hint and go to step 1.

4. If the player guessed the number, finish the script.

The script can pick a random number using the `RANDOM` Bash variable. When you read it, you get a random value from 0 to 32767. The next read gives you another value.

You can convert the `RANDOM` value to the range from 1 to 100. Here is the algorithm for doing that:

1. Divide the value from the `RANDOM` variable by 100 this way. It gives you a random number in the 0 to 99 range.

2. Add one to the result. It gives you a number in the 1 to 100 range.

The following command writes a random number of the 1 to 100 range to the `number` variable:
{line-numbers: false, format: Bash}
```
number=$((RANDOM % 100 + 1))
```

Listing 5-6 shows the script that implements the game's algorithm.

{caption: "Listing 5-6. The script for playing More or Fewer", line-numbers: true, format: Bash}
![`more-less-game.sh`](code/Answers/more-less-game.sh)

You need to apply the [**binary search**](https://en.wikipedia.org/wiki/Binary_search_algorithm) for winning this game. The idea behind this algorithm is to divide an array of numbers into halves. Let's look at how to use the binary search in the "More or Fewer" game.

Once the game starts, you guess a number in the 1 to 100 range. The middle of this range is 50. You should enter this value on the first step.

The script gives you the first hint. Suppose the script prints that 50 is less than the required number. This means that you should search for it in the 50-100 range. Now you enter the middle of this range, i.e. the number 75.

The script says that 75 is less than the required number. Then you truncate the searching range again and get 75-100. The middle of this range equals 87.5. You can round it up or down. It doesn't matter. Round it down and type number 87.

If the number is still wrong, keep dividing the searching range in half. Then seven steps are enough to find the required number.

##### Exercise 3-13. Functions

We have considered the `code_to_error` function in the section "Using Functions in Scripts". Your task is to extend this function for supporting two languages. The straightforward solution is to split it. Then each variant of the function corresponds to a specific language.

In the first step, let's combine the code of the `print_error` and `code_to_error` functions into one file. You will get the script from Listing 5-7 this way.

{caption: "Listing 5-7. The script for printing error messages", line-numbers: true, format: Bash}
![`print-error.sh`](code/Answers/print-error.sh)

The function `code_to_error` prints messages in English. You can rename it to `code_to_error_en`. Then the language of the messages becomes clear from the function name.

The next step is adding the `code_to_error_de` function to your script. It prints the message in German according to the received error code. The function looks like this:
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

Now you need to modify the `print_error` function. It should choose `code_to_error_en` or `code_to_error_de` to call. The regional settings of a user can help you with this choice. The environment variable `LANG` stores these settings. If its value matches the "de_DE*" pattern, you should call the `code_to_error_de` function. Otherwise, it should be `code_to_error_en` call.

Listing 5-8 shows the complete code of the script.

{caption: "Listing 5-8. The script for printing error messages", line-numbers: true, format: Bash}
![`print-error-local.sh`](code/Answers/print-error-local.sh)

You can replace the `if` statement in the `print_error` function with `case`. Then you get the following code:
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

There is code duplication in the `print_error` function. You call the `echo` command in each block of the `case` statement. The only difference between the blocks is the function for converting an error code into text. You can introduce the `func` variable to get rid of the code duplication. This variable stores the function name to call. Here is an example of how to use the variable:
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

There is another option to solve the code duplication problem. The first step is to replace the `case` statements in the functions `code_to_error_de` and `code_to_error_en` with indexed arrays. You get the following code this way:
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

The second step is moving the code of `code_to_error_de` and `code_to_error_en` functions into `print_error`. For doing that, you need to combine messages in all languages into one associative array. The array keys are combinations of the `LANGUAGE` value and the error code. Listing 5-9 shows the modified `print_error` function.

{caption: "Listing 5-9. The script for printing error messages", line-numbers: true, format: Bash}
![`print-error-array.sh`](code/Answers/print-error-array.sh)

##### Exercise 3-14. Variable scope

When you launch the script from Listing 3-37, it prints the following text:
{line-numbers: true, format: text}
```
main1: var =
foo1: var = foo_value
bar1: var = foo_value
bar2: var = bar_value
foo2: var = bar_value
main2: var =
```

Let's start with the output of "main1" and "main2" strings. The `var` variable is declared in the `foo` function. It has the `local` attribute. The attribute makes the variable available in the `foo` and `bar` functions only. Hence, Bash deduces that `var` is undefined before and after calling the `foo` function. The undefined variable has an empty value in Bash.

When the script prints the `var` variable at the beginning of the `foo` function, it equals "foo_value". This output happens right after the `var` declaration.

The next output happens in the `bar` function. There, the first echo call prints the "foo_value" value. It happens because the body of the `bar` function is also the scope of `var` declared in `foo`.

The script assigns the new "bar_value" value to the `var` variable in the `bar` function. Note that this is not a declaration of the new global `var` variable. This is the overwriting of the existing local variable. Therefore, you get the "bar_value" strings in both "bar2" and "foo2" outputs.