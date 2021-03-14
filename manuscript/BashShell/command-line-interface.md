## Command Interpreter

Interpreters work in two modes: non-interactive and interactive. In the first mode, the interpreter executes a program. The program is loaded from the disk into RAM. Then it is executed line by line.

In interactive mode, the user types a command in the terminal emulator window. After pressing the Enter key, the command is executed. The interactive mode of the interpreter is called [**command shell**](https://en.wikipedia.org/wiki/Shell_(computing)) or shell.

A command shell is built into the operating system often. It provides access to the settings and functions of the OS. In Linux, the shell allows you to do the following actions:

* Run programs and system services.
* Control peripherals and internal devices.
* Access the kernel features.

### Demand of the CLI

Why would somebody learn the command-line interface (CLI) today? It was created 40 years ago for computers that are thousands of times slower than today. The graphical interface has dominated PCs and laptops for a long time.

The CLI seems to be outdated technology. This statement is wrong. There is a reason why Bash is included in all [distributions](https://en.wikipedia.org/wiki/Linux_distribution) of macOS and Linux. Windows also has a command interpreter [Cmd.exe](https://en.wikipedia.org/wiki/Cmd.exe). In 2006, Microsoft replaced it with the new interpreter [PowerShell](https://en.wikipedia.org/wiki/PowerShell). Think about this fact. The developer of the most popular PC operating system has created a new command shell. So, the CLI is useful after all.

What tasks does the shell perform in modern OSes? First, it is a tool for [system administration](https://en.wikipedia.org/wiki/System_administrator). In addition to the kernel, the operating system consists of software modules: libraries, services and utilities. They have settings and special modes of operation. The regular user does not need most of the settings and modes. These are extra features. Therefore, the graphical interface does not give access to them.

If the OS fails, extra features are needed to recover it. Besides, the graphical interface often does not work in this case. That is why all recovery tools have a command-line interface.

I> The Bash interpreter is integrated into Linux and macOS. The functions of these OSes are available through it. Bash does not work well with Windows. Instead, Microsoft offers its PowerShell shell. In this book, we study Bash. First, it is compatible with the POSIX standard. Second, Bash is more common than PowerShell. It is available on all modern OSes.

In addition to administration tasks, a command interface is used when [connecting computers over a network](https://en.wikipedia.org/wiki/Remote_desktop_software). There are GUI programs for such connection: TeamViewer, Remote Desktop and others. But they require a stable and fast network connection. If the connection is not reliable, these programs are slow and fail often. The command interface is not demanding to the quality of the connection. Even if it is slow, the remote computer will receive and execute the command.

Knowledge of the command interface is useful not only for administrators but also for regular users. It is much faster to perform daily tasks with the command shell. These are examples of the tasks:

* Operations on files and directories.
* Creating data backups.
* Downloading files from the Internet.
* Collecting statistics about your computer's resource usage.

Let's look at an example. Suppose you rename files on the disk. You add the same suffix to their names. It is easy to do with the [Windows Explorer](https://en.wikipedia.org/wiki/File_Explorer) for a dozen files. But what happens if there are thousands of files? Renaming with Explorer would take the whole day. You can solve this task with the shell by launching a single command.

The file renaming example showed the strength of the CLI that is scalability. Scalability generally means that the same solution handles both small and large amounts of input well. In the case of a shell, the solution is a command. It is equally fast at handling ten and a thousand files.

Knowledge of the command interface would be helpful for any programmer. When developing a complex application, he has to modify many files. There are GUI editors to work with source code. But sometimes, the same change should be made in several files. For example, there is changing the header with the license information. Working with the editor is inefficient in this case. Command-line utilities solve this task much faster.

Command-line skills are needed to run compilers and interpreters. These programs usually do not have a graphical interface. They are run from the command-line. You should pass the names of the source code files to a compiler. There can be many files. Thus, GUI cannot handle them well.

There are special programs to work with source code. Such a program is called [**integrated development environments**](https://en.wikipedia.org/wiki/Integrated_development_environment) (IDE). It compiles your source code files through a graphical interface. But IDE is just a wrapper over the compiler command-line interface. When you press a button in the IDE window, it calls the compiler. If you need to change the compiler's options, you should deal with its command-line interface.

If you are an experienced programmer, the command-line will help you develop helper utilities. The fact is that an application with a text interface is faster and easier to write than one with a GUI. The speed of development is important when solving one-off tasks.

Suppose that you have a task. You can solve it by repeating the same action many times. In this case, calculate how much time you need to do manual work and how much time you need to write a utility for automation. Writing a utility with a graphical interface is long. Solving the task on your own will be faster. But if you apply the command-line interface, it will be more profitable to automate the task. This way, you save time and eliminate errors that are typical for manual work.

Whether the command-line interface is worth learning is up to you. I have only given examples from practice. They show the usefulness of this skill. Switching from a graphical interface to a command-line interface is hard. You have to re-learn many of the things that you are used to doing through Windows Explorer. But once you get the hang of the command shell, your productivity will surprise you.
