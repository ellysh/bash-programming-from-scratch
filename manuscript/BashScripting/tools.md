## Development Tools

You have used the interactive mode of Bash in the previous chapter. The workflow of this mode looks like this:

1. You type a command in the terminal window.
2. The Bash process loads your command in RAM.
3. The interpreter executes the command.
4. Bash removes your command from RAM.

If you want to write a program, RAM is not the appropriate place to store it. This is a temporary memory. Whenever you shut down the computer, RAM is cleared.

When you write a program, you should store it on the disk drive. The disk drive is long-term information storage. Then you need a special program to create and edit source code files. This program is called a [source code editor](https://en.wikipedia.org/wiki/Source-code_editor).

Let's consider source code editors that work well with Bash.

### Source Code Editor

Potentially, you can write Bash scripts in any text editor. Even the standard Windows application called [Notepad](https://en.wikipedia.org/wiki/Microsoft_Notepad) can work this way. However, text editors are inconvenient for writing the source code. Notepad does not have any features for doing that. Meanwhile, these features increase your productivity significantly.

Today you can find plenty of free and proprietary source code editors. Some of them are more widespread than others. The popularity of the editor does not mean that it fits you perfectly. You should try several programs and choose one that you like.

Here there is a list of three popular source code editors. You can start with them. If no one fits you, please look for alternatives on the Internet.

W> MS Office and its open-source counterpart [LibreOffice](https://en.wikipedia.org/wiki/LibreOffice) are not suitable for writing source code at all. They save files in the binary or [XML-like](https://en.wikipedia.org/wiki/XML) format. Interpreters and compilers cannot read them. These programs expect text files on input. Text data is the format of all source code editors.

[**Notepad++**](https://en.wikipedia.org/wiki/Notepad%2B%2B) is a fast and minimalistic source code editor. It is available for free. You can use it on Windows only. If your OS is macOS or Linux, please consider other editors. The latest Notepad++ version is available on the [official website](https://notepad-plus-plus.org/downloads).

[**Sublime Text**](https://en.wikipedia.org/wiki/Sublime_Text) is a proprietary [**cross-platform**](https://en.wikipedia.org/wiki/Cross-platform_software) source code editor. Cross-platform means that the program runs on several OSes and hardware configurations. Sublime Text works well on Windows, Linux and macOS. You can use it for free without buying a license. Download the editor on the [official website](https://www.sublimetext.com).

[*Visual Studio Code*](https://en.wikipedia.org/wiki/Visual_Studio_Code) is a free cross-platform source code editor from Microsoft. It works on Windows, Linux and macOS. You do not need to buy a license for using the editor. Download it on the [official website](https://code.visualstudio.com/).

All three editors have the following features for working with source code:

* [Syntax highlighting](https://en.wikipedia.org/wiki/Syntax_highlighting).
* [Autocomplete](https://en.wikipedia.org/wiki/Autocomplete).
* Support of commonly used [character encodings](https://en.wikipedia.org/wiki/Character_encoding).

It is possible to edit the source code without these features. However, they make it easier to read and edit the program. They also help you to get used to the Bash syntax.

### Launching the Editor

There are several ways to run the source code editor. The first option is using the GUI of your OS. Launch the editor via the Start menu or the desktop icon. It is the same way you run any other program.

The second option is using the command-line interface. This approach is more convenient in some cases. Here is an example of when you would need it. You call the `find` utility for searching several files. You can pass the `find` output to the source code editor input and open all found files. It is possible because most modern editors support CLI.

There are three ways to run an application in Bash:

1. By the name of the executable.
2. By the absolute path.
3. By the relative path.

The first approach is the most convenient. However, you need to add the installation path of the application to the `PATH` variable. Then Bash can find the program's executable when you call it.

Let's consider how to run the Notepad++ editor by the executable name. The program has the following installation path by default:
{line-numbers: false}
```
C:\Program Files (86)\Notepad++
```

I> Clarify the installation path of your editor in the properties of its desktop icon or the Start menu item.

When you work in the MSYS2 environment, the Notepad++ installation path looks like this:
{line-numbers: false}
```
/c/Program Files (x86)/Notepad++
```

Try to run the editor using this absolute path. Figure 3-1 shows that it does not work. Bash reports about the syntax error in this case.

{caption: "Figure 3-1. Result of launching Notepad++"}
![Notepad++ error](images/BashScripting/notepad-error.png)

This command has several problems. We will investigate them one by one. The `cd` Bash built-in can give you the first hint about what is going wrong. Call `cd` this way:
{line-numbers: false, format: Bash}
```
cd /c/Program Files
```

Figure 3-2 shows the result.

{caption: "Figure 3-2. Result of the `cd` command"}
![cd result](images/BashScripting/cd-many-arguments.png)

Bash complains that you have passed too many parameters to `cd`. This command expects only one parameter, which is a path. It looks like you provided two paths instead of one here. This mistake happens because of the word splitting mechanism. Bash separated the path by the space into two parts: "/c/Program" and "Files".

You have two option to suppress the word splitting mechanism:

1. Enclose the path in double-quotes:
{line-numbers: false, format: Bash}
```
cd "/c/Program Files"
```

2. Escape all spaces using the backslash:
{line-numbers: false, format: Bash}
```
cd /c/Program\ Files
```

When you suppress word splitting, Bash executes the `cd` command properly.

Now try to navigate the `/c/Program Files (x86)` path. The following command does not work:
{line-numbers: false, format: Bash}
```
cd /c/Program Files (x86)
```

We found out that the issue happens because of word splitting. You can suppress it by escaping the spaces this way:
{line-numbers: false, format: Bash}
```
cd /c/Program\ Files\ (x86)
```

Figure 3-3 shows that this command still fails.

{caption: "Figure 3-3. Result of the `cd` command"}
![cd result](images/BashScripting/cd-unexpected-token.png)

This is the same error message as Bash has printed when launching Notepad++ in Figure 3-1. This problem happens because of the parentheses. They are part of the Bash syntax. It means that the shell treats them as a language construct. We met this problem when grouping conditions of the `find` utility. Escaping or double-quotes solves this issue too. Here are possible solutions for our case:
{line-numbers: true, format: Bash}
```
cd /c/Program\ Files\ \(x86\)
cd "/c/Program Files (x86)"
```

Using double-quotes is simpler than escaping. Apply them to launch the Notepad++ this way:
{line-numbers: false, format: Bash}
```
"/c/Program Files (x86)/Notepad++/notepad++.exe"
```

Now Bash launches the editor properly.

Launching Notepad++ by the absolute path is inconvenient. You should type a long command in this case. Launching the editor by the name of the executable is much better. Let's change the `PATH` Bash variable for making that work.

Add the following line at the end of the `~/.bash_profile` file:
{line-numbers: false, format: Bash}
```
PATH="/c/Program Files (x86)/Notepad++:${PATH}"
```

Restart the MSYS2 terminal. Now the following command launches Notepad++:
{line-numbers: false, format: Bash}
```
notepad++.exe
```

There is one more option to launch the editor from the shell. Instead of changing the `PATH` variable, you can declare an **alias**. The alias is a Bash mechanism. It replaces the command you typed with another one. This way, you can abbreviate long lines.

We have the following command for launching Notepad++:
{line-numbers: false, format: Bash}
```
"/c/Program Files (x86)/Notepad++/notepad++.exe"
```

Let's declare the alias for this command. The `alias` Bash built-in does this job. Call it this way for our example:
{line-numbers: false, format: Bash}
```
alias notepad++="/c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe"
```

This command declares the alias with the "notepad++" name. Now Bash replaces the "notepad++" command by the absolute path to the Notepad++ executable.

Using the alias has one problem. You should declare it whenever launching the terminal window. There is a way to automate this declaration. Just add our `alias` command at the end of the `~/.bashrc` file. Bash executes this file at every terminal startup. Then you get declared alias in each new terminal window.

Now you can open the source code files in Notepad++ using the shell. Here is an example to open the `test.txt` file:
{line-numbers: false, format: Bash}
```
notepad++ test.txt
```

If the `test.txt` file does not exist, Notepad++ shows you the dialog to create it.

### Background Mode

Suppose that you run a GUI application in the terminal window. Then you cannot use this window for typing the Bash commands. The GUI program controls it and prints the diagnostic messages there. The terminal window becomes available again when the application finishes.

You can run the GUI application in the **background mode**. Then the terminal window stays available, and you can use it normally. Add the ampersand & at the end of a Bash command to launch it in the background mode. Here is an example:
{line-numbers: false, format: Bash}
```
notepad++ test.txt &
```

After this command, you can type text in the terminal window. The only problem is the error messages from Notepad++. The editor still prints them here. They make it inconvenient to use this terminal window.

You can detach the running GUI application from the terminal window completely. Do it with the `disown` Bash built-in. Call `disown` with the `-a` option this way:
{line-numbers: true, format: Bash}
```
notepad++ test.txt &
disown -a
```

Now Notepad++ does not print any messages in the terminal. The `disown` call has one more effect. It allows you to close the terminal window and keep the editor working. Without the `disown` call, Notepad++ finishes when you close the terminal.

You can combine Notepad++ and `disown` calls into one command. It looks like this:
{line-numbers: false, format: Bash}
```
notepad++ test.txt & disown -a
```

The `-a` option of the `disown` command detaches all programs that work in the background. If you skip this option, you should specify the [**process identifier**](https://en.wikipedia.org/wiki/Process_identifier) (PID) of the program to detach. PID is a unique number that OS assigns to each new process.

Suppose that you want to call `disown` for the specific program. You should know its PID. Bash prints the PID of the background process when you launch it. Here is an example:
{line-numbers: false, format: Bash}
```
notepad++ test.txt &
[1] 600
```

The second line has two numbers. The second number 600 is PID. The first number "[1]" is the job ID. You can use it to switch the background process to the foreground mode. The `fg` command does it this way:
{line-numbers: false, format: Bash}
```
fg %1
```

If you want to detach the Notepad++ process from our example, call `disown` this way:
{line-numbers: false, format: Bash}
```
disown 600
```

If you want to list all programs that work in the background, use the `jobs` Bash built-in. When you call it with the `-l` option, it prints both job IDs and PIDs. Use it this way:
{line-numbers: false, format: Bash}
```
jobs -l
```

This command lists all background processes that you have launched in the current terminal window.

You can call Notepad++ and detach it from the terminal in a single command. In this case, you should use the special Bash variable called `$!`. It stores the PID of the last launched command. Pass this PID to the `disown` call, and you are done. Here is an example of how to apply this approach:
{line-numbers: false, format: Bash}
```
notepad++ test.txt & disown $!
```

