## Development Tools

In the previous chapter, we typed Bash commands in the terminal window. Then the memory of the terminal process stores these commands. It means that physically the computer's RAM stores them. RAM is a place for the temporary storage of information. Whenever you shut down the computer, this memory is cleared.

The terminal window is not sufficient for program development. You would need a convenient [source code editor](https://en.wikipedia.org/wiki/Source-code_editor). This application allows you to create, edit and save source code files on your hard drive. The hard disk stores information for the long-term.

### Source Code Editor

You can write Bash scripts in any text editor. Even the standard Windows application [Notepad](https://en.wikipedia.org/wiki/Microsoft_Notepad) fits. But this application is inconvenient for editing the source code. Notepad does not have features for that. Such features can increase your productivity. Try several special editors and choose the one you like.

Here there is a list of three popular source code editors. If none of the three fits you, please look for alternatives on the Internet. There are many editors of this kind.

W> MS Office and its open-source counterpart [LibreOffice](https://en.wikipedia.org/wiki/LibreOffice) are not suitable for writing source code. They save files in binary or [XML-like](https://en.wikipedia.org/wiki/XML) formats. Interpreters and compilers cannot read them. They require text files. Text data is the format of source code editors.

[**Notepad++**](https://en.wikipedia.org/wiki/Notepad%2B%2B) is a fast and minimalistic open-source editor. It runs on Windows only. If you use macOS or Linux, it is better to consider other editors. You can download the latest version of Notepad++ on the [official website](https://notepad-plus-plus.org/downloads/).

[**Sublime Text**](https://en.wikipedia.org/wiki/Sublime_Text) is a proprietary [**cross-platform**](https://en.wikipedia.org/wiki/Cross-platform_software) source code editor. Cross-platform means that the program runs on several OSes and hardware configurations. You can use Sublime Text for free without activation or buying a license. Download it on the [official website](https://www.sublimetext.com/).

[*Visual Studio Code*](https://en.wikipedia.org/wiki/Visual_Studio_Code) is a free cross-platform source code editor from Microsoft. It is open-source software. It means that the program is available for free and without a license. Download the editor on the [official website](https://code.visualstudio.com/).

All three editors have the following features for working with source code:

* [Syntax highlighting](https://en.wikipedia.org/wiki/Syntax_highlighting).
* [Auto-complete](https://en.wikipedia.org/wiki/Autocomplete).
* Support of commonly used [character encodings](https://en.wikipedia.org/wiki/Character_encoding).

It is possible to edit the source code without these features. But they speed up your work, make it easier to edit the program and find bugs in it. They also help you to get used to the Bash syntax.

### Launching the Editor

You can launch the source code editor through the graphical interface of the OS. In the case of Windows, do it via the Start menu or the icon on the desktop.

There is another possibility. You can launch the editor from the command-line interface. This approach is more convenient in some cases. For example, when the Bash command returns a filename, you can quickly open it via command-line.

There are three ways to run the application in Bash:

1. By absolute path.
2. By relative path.
3. By executable file name.

The last approach is the fastest and most commonly used. If you want to apply it, you should add the program's installation path to the `PATH` variable.

Let's consider how to run the Notepad++ editor by the executable name. The editor has the following installation path by default:
{line-numbers: false}
```
C:\Program Files (86)\Notepad++
```

I> You can clarify the installation path of the program in the properties of the desktop icon or the Start menu item.

In the MSYS2 environment, the same installation path looks like this:
{line-numbers: false}
```
/c/Program Files (x86)/Notepad++
```

First, let's run Notepad++ by this absolute path. If you try to do that, Bash prints the error message as Figure 3-1 shows.

{caption: "Figure 3-1. Result of launching Notepad++"}
![Notepad++ error](images/BashScripting/notepad-error.png)

This command has several problems. We will consider them one by one. First, try to launch the following `cd` command:
{line-numbers: false, format: Bash}
```
cd /c/Program Files
```

Figure 3-2 shows the result.

{caption: "Figure 3-2. Result of the `cd` command"}
![cd result](images/BashScripting/cd-many-arguments.png)

Bash complains that you pass more parameters to `cd` than it requires. This command accepts one path on input only. But you pass two paths here. The mistake happens because of word splitting. Bash handles the space as a separator between two words. Therefore, it splits the single path "/c/Program Files" into two paths "/c/Program" and "Files".

There are two ways to solve such errors:

1. Enclose the path in double-quotes:
{line-numbers: false, format: Bash}
```
cd "/c/Program Files"
```

2. Escape all spaces with backslashes:
{line-numbers: false, format: Bash}
```
cd /c/Program\ Files
```

Bash executes each of these commands correctly.

Now let's try to navigate the `/c/Program Files (x86)` path. Here is a command for that:
{line-numbers: false, format: Bash}
```
cd /c/Program Files (x86)
```

We found out that Bash handles spaces on its own. Therefore, we should prevent it and escape them with backslashes. Then we get the following command:
{line-numbers: false, format: Bash}
```
cd /c/Program\ Files\ (x86)
```

This command still fails. Figure 3-3 shows its error message.

{caption: "Figure 3-3. Result of the `cd` command"}
![cd result](images/BashScripting/cd-unexpected-token.png)

This message looks the same as the error in Figure 3-1 when we tried to launch Notepad++. The problem happens because the parentheses are part of the Bash syntax. Therefore, the interpreter treats them as a language construct. We met this problem before when grouping conditions of the `find` utility. Escaping or double-quotes solves this issue. Here is an example:
{line-numbers: true, format: Bash}
```
cd /c/Program\ Files\ \(x86\)
cd "/c/Program Files (x86)"
```

If we choose the approach with double-quotes, the command to launch Notepad++ looks like this:
{line-numbers: false, format: Bash}
```
"/c/Program Files (x86)/Notepad++/notepad++.exe"
```

The absolute path of the editor is too long. Typing it every time is inconvenient. It is better to launch Notepad++ via the executable name. Let's add its installation path to the `PATH` Bash variable for making that work.

Add the following line to the end of the `~/.bash_profile` file:
{line-numbers: false, format: Bash}
```
PATH="/c/Program Files (x86)/Notepad++:${PATH}"
```

Close and reopen the terminal window. Now you can start Notepad++ by the following command:
{line-numbers: false, format: Bash}
```
notepad++.exe
```

There is an alternative solution. Instead of changing the `PATH` variable, you can declare an alias. The alias mechanism replaces the entered command with another one. It allows you to abbreviate long lines in the terminal window.

Let's declare an alias with the `notepad++` name for the following command:
{line-numbers: false, format: Bash}
```
"/c/Program Files (x86)/Notepad++/notepad++.exe"
```

The following call of `alias` Bash built-in does that:
{line-numbers: false, format: Bash}
```
alias notepad++="/c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe"
```

After declaring the alias, Bash translates the command "notepad++" into the absolute path of the editor's executable. This solution has one problem. You should declare the alias whenever launching the terminal window. There is a way to automate this declaration. Just add the `alias` command at the end of the `~/.bashrc` file. Bash executes all commands of this file at every terminal startup.

Now you can open the source code files in Notepad++ via command-line. To do that, pass the filename as the first parameter to the `notepad++` executable. Here is an example:
{line-numbers: false, format: Bash}
```
notepad++ test.txt
```

If the `test.txt` file does not exist, Notepad++ shows the dialog to create it.

Suppose that you run a GUI application in the terminal window. After that, you cannot enter the commands in this window. The GUI program controls it and prints the diagnostic messages there. The terminal window starts working in normal mode after finishing the application.

If you want to continue working with the terminal window, run the GUI application in the **background mode**. To do that, add the ampersand & at the end of the command. Here is an example:
{line-numbers: false, format: Bash}
```
notepad++ test.txt &
```

This command starts the Notepad++. The editor still prints error messages to the terminal window. But at the same time, you can type and execute commands there.

There is an option to separate the terminal window and the running GUI application completely. Run the application in the background mode. Then call the `disown` Bash built-in with the `-a` option. Here is an example:
{line-numbers: true, format: Bash}
```
notepad++ test.txt &
disown -a
```

Notepad++ stops printing its messages to the terminal after these commands. Also, if you close the terminal window, the editor continues its work.

You can combine Notepad++ and `disown` calls into one command. Here is an example:
{line-numbers: false, format: Bash}
```
notepad++ test.txt & disown -a
```

The `-a` option of the `disown` command detaches all programs that work in the background. You can detach the specific application instead. There is the Bash environment variable called `$!`. It stores the [**process identifier**](https://en.wikipedia.org/wiki/Process_identifier) (PID) of the last launched application. PID is a unique number that OS assigns to each process. You can manipulate the process by this number. Also, you can pass the PID to the `disown` command for detaching the specific application. Here is an example of doing that:
{line-numbers: false, format: Bash}
```
notepad++ test.txt & disown $!
```

If you want to list all applications that work in the background, use the `jobs` Bash built-in. It has the `-l` for that. Here is an example:
{line-numbers: false, format: Bash}
```
jobs -l
```

The command shows the PIDs of all background processes you have launched in the current terminal window.