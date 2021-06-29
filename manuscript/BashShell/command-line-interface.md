## Command Interpreter

All interpreters have two working modes: non-interactive and interactive. When you choose the non-interactive mode, the interpreter loads the source code file from the disk and executes it. You do not need to type any commands or control the interpreter. It does everything on its own.

When you choose the interactive mode, you type each command to the interpreter manually. If the interpreter is integrated with the OS and works in the interactive mode, it is called a [**command shell**](https://en.wikipedia.org/wiki/Shell_(computing)) or shell.

A command shell provides access to the settings and functions of the OS. You can perform the following tasks using it:

* Run programs and system services.

* Manage the file system.

* Control peripherals and internal devices.

* Access the kernel features.

### Demand of the CLI

Why would somebody learn the command-line interface (CLI) today? It appeared 40 years ago for computers that are thousands of times slower than today. Then the graphical interface supplanted CLI on PCs and laptops. Everybody prefers to use GUI nowadays.

The CLI seems to be outdated technology. However, this statement is wrong. It should be a reason why developers include Bash in all modern macOS and [Linux distributions](https://en.wikipedia.org/wiki/Linux_distribution). Windows also has a command shell called [Cmd.exe](https://en.wikipedia.org/wiki/Cmd.exe). Microsoft has replaced it with [PowerShell](https://en.wikipedia.org/wiki/PowerShell) in 2006. Just think about this fact. The developer of the most popular desktop OS has created a new command shell in the 2000s. All these points confirm that CLI is still in demand.

What tasks does the shell perform in modern OSes? First of all, it is a tool for [system administration](https://en.wikipedia.org/wiki/System_administrator). The OS consist of the kernel and software modules. These modules are libraries, services and system utilities. Most of the modules have settings and special modes of operation. You do not need them in your daily work. Therefore, you cannot access these settings via GUI in most cases.

I> The Bash shell has good integration with Linux and macOS. You can access most OS functions using Bash there. However, it does not work with Windows smoothly. Microsoft offers you their own PowerShell. We study Bash in this book for two reasons. First, it is compatible with the POSIX standard. Second, Bash is more common than PowerShell. You can use it on all modern OSes.

If the OS fails, you need system utilities to recover it. They have a command-line interface because a GUI often is not available after the failure.

Besides the administration tasks, you would need CLI when [connecting computers over a network](https://en.wikipedia.org/wiki/Remote_desktop_software). There are GUI programs for such connection. The examples are TeamViewer and Remote Desktop. They require a stable and fast network connection for working well. If the connection is not reliable, the GUI programs are slow and often fail. The command interface does not have such a limitation. The remote server receives your command even if the link is poor.

You can say that a regular user does not deal with administration tasks and network connections. Even if you do not have such tasks, using command shell speeds up your daily work with the computer. Here are few things that you can do more effective with CLI than with GUI:

* Operations on files and directories.
* Creating data backups.
* Downloading files from the Internet.
* Collecting statistics about your computer's resource usage.

An example will explain the effectiveness of CLI. Suppose you rename several files on the disk. You add the same suffix to their names. If you have a dozen of files, you can do this task with [Windows Explorer](https://en.wikipedia.org/wiki/File_Explorer) in a couple of minutes. Now imagine that you should rename thousands of files this way. You will spend the whole day doing that with the Explorer. If you use the shell, you need to launch a single command and wait for several seconds. It will rename all your files automatically.

The example with renaming files shows the strength of the CLI that is scalability. Scalability means that the same solution handles well both small and large amounts of input data. The solution implies a command when we are talking about the shell. The command renames ten and a thousand files with the same speed.

Experience with the command interface is a great benefit for any programmer. When you develop a complex project, you manage plenty of text files with the source code. You use the GUI editor to change the single file. It works well until you do not need to introduce the same change in many files. For example, it can be the new version of the license information in the file headers. You waste your time when solving such a task with the editor. Command-line utilities make this change much faster.

You need to understand the CLI to deal with compilers and interpreters. These programs usually do not have a graphical interface. You should run them via the command line and pass the names of the source code files. The reason for such workflow is the poor scalability of the GUI. If you have plenty of source code files, you cannot handle them effectively via the GUI.

There are special programs to edit and compile source code. Such programs are called [**integrated development environments**](https://en.wikipedia.org/wiki/Integrated_development_environment) (IDE). You can compile a big project using IDE and its GUI. However, IDE calls the compiler via the command line internally. Therefore, you should deal with the compiler's CLI if you want to change its options or working mode.

If you are an experienced programmer, knowing the CLI encourages you to develop helper utilities. It happens because writing a program with a command interface is much faster than with a GUI. The speed of development is essential when solving one-off tasks.

Here is an example situation when you would need to write a helper utility. Suppose that you have to make a massive change in the source code of your project. You can do it with IDE by repeating the same action many times.

Another option is to spend time writing a utility that will do this job. You should compare the required time for both ways of solving your task. If you are going to write a GUI helper utility, it takes more time than for a CLI utility. This can lead you to the wrong decision to solve the task manually using the IDE. Automating your job is the best option in most cases. It saves your time and helps to avoid mistakes.

You decide if you need to learn the CLI. I have only given few examples of when it is beneficial. It is hard to switch from using a GUI to a CLI. You have to re-learn many things that you do with Windows Explorer regularly. But once you get the hang of the command shell, your new productivity will surprise you.
