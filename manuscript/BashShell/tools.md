## Development tools

You need a Bash interpreter and a terminal emulator to run the examples of this chapter. They can be installed on all modern operating systems. Let's take a look at how to do this.

### Bash Interpreter

Bash is a [**script programming language**](https://en.wikipedia.org/wiki/Scripting_language). Such languages have the following features:

1. They are interpreted but not compiled.

2. They operate existing programs or high-level commands.

3. They are integrated into a shell or OS.

The Bash language is integrated into Linux and macOS. If you use Windows, you should install a minimal Unix environment. Bash needs it for working correctly. Let's look at two ways to set up an environment.

The terms "Unix-environment" and "Linux-environment" mean a software environment compatible with POSIX standards.

The first option is to install the [**MinGW**](https://en.wikipedia.org/wiki/MinGW) toolkit. In addition to the Bash interpreter, it provides the [free GCC compiler](https://en.wikipedia.org/wiki/GNU_Compiler_Collection). The MinGW component called MSYS (Minimal SYStem) is sufficient for the examples of this book. This component includes a Bash interpreter, a terminal emulator, and [GNU utilities](https://en.wikipedia.org/wiki/GNU_Core_Utilities). Together they make up a minimal Unix environment.

Let's install a version of the Unix environment called [MSYS2](https://www.msys2.org). Before installing it, check the bitness of your Windows operating system. These are steps to take it:

1. If you have a "Computer" icon on your desktop, right-click on it and select "Properties".

2. If there is no "Computer" icon on your desktop, click the "Start" button. Find the "Computer" item in the menu. Do right-click on it and select "Properties".

3. In the "System" window that opens, locate the "System Type" item as Figure 2-1 shows. It shows the bitness of your Windows.

{caption: "Figure 2-1. System Type"}
![System Type](images/BashShell/windows-system-type.png)

Download the MSYS2 installer from the [official website](https://www.msys2.org). The installer file depends on the bitness of your system:

The number `20190524` in the filename means the version of MSYS2. Select the latest available version.

Now let's install MSYS2. These are the steps to take it:

1. Run the installer file. You will see the window as Figure 2-2 shows.

{caption: "Figure 2-2. MSYS2 installation dialog", height: "30%"}
![MSYS2 installation dialog](images/BashShell/msys2-install.png)

2. Click the "Next" button (next). In the new window (see Figure 2-3), select the installation [**path**](https://en.wikipedia.org/wiki/Path_(computing)) and press the "Next" button.

{caption: "Figure 2-3. Selecting the installation path", height: "30%"}
![Installation process](images/BashShell/msys2-path.png)

3. In the next window, you can select the application name for the "Start" menu. Leave it unchanged and click "Next". Then the installation process starts.

4. When the installation is complete, click the "Finish" button. The window will close.

Now the MSYS2 Unix environment is on your hard drive. Its files are located in the `C:\msys64` directory if you keep the default installation path. Go to this directory and run the application `msys2.exe`. The Bash shell window opens as Figure 2-4 shows.

{caption: "Figure 2-4. The Bash shell window", height: "20%"}
![The Bash shell window](images/BashShell/bash-window.png)

The second option is to install a Unix environment from Microsoft. It is called [Windows subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) (WSL). This environment is available for Windows 10 only. It does not work on Windows 8 and 7. You can find the manual to install WSL on the [Microsoft website](https://docs.microsoft.com/ru-ru/windows/wsl/install-win10).

Linux and macOS users do not need to install Bash. It is available on these systems by default.

Press the shortcut key Ctrl+Alt+T to open the Bash window in Linux.

These are the steps to launch Bash on macOS:

1. Launch the Spotlight search program. To do this, click the magnifying glass icon in the upper right corner of the screen.

2. The dialog box appears. Enter the text "Terminal" there.

3. The list of applications opens. Click on the first line with the name "Terminal" there.

### Terminal emulator

When you launch the application `msys2.exe`, the terminal emulator window opens. An [**emulator**](https://en.wikipedia.org/wiki/Emulator) is a program that simulates the behavior of another program, OS or device. Emulators are used for compatibility. For example, you want to run a Windows program on Linux. To do this, install an emulator of the Windows environment on Linux. It is called [Wine](https://en.wikipedia.org/wiki/Wine_(software)). Wine provides its own version of the Windows system libraries. Thanks to the emulator, you can run the Windows program on Linux.

The terminal emulator solves the compatibility problem. Command-line programs are designed to work through a terminal device. Today, nobody uses terminals. Personal computers and laptops have replaced them. To run a program that works only with the terminal, you need a terminal emulator. It sends the program's commands to the shell and displays the results on the screen.

Figure 2-5 shows the interaction between input/output devices, the terminal emulator, the shell and the command-line program.

{caption: "Figure 2-5. The workflow of the terminal emulator", height: "25%"}
![Terminal Emulator](images/BashShell/terminal-emulator.png)

There are two lines in the terminal window after startup (see Figure 2-4):
{line-numbers: false}
```
ilya.shpigor@DESKTOP-1NBVQM4 MSYS ~
$
```

The first line starts with the username. In my case, it equals `ilya.shpigor`. Then there is the computer name `DESKTOP-1NBVQM4` after the symbol @. You can change this name via Windows settings. The word `MSYS` comes next. It means the name of the platform where Bash is running. At the end of the line, there is the symbol ~. It is the **absolute path** to the current directory. Let's pay attention to this point.

There are two types of paths to file system objects: absolute and relative. The address bar of Windows Explorer shows the paths of the first type. An absolute path is a path to the same file system object regardless of the current directory. **Relative path** specifies the path concerning the current directory.

Relative paths are shorter than absolute paths. That is why they are faster to type and easier to use in shells. There is a simple rule to distinguish the type of paths in the Unix environment. Absolute paths start with a slash /. For example, `/c/Windows/system32`. Relative paths start with a directory name. For example, `Windows/system32`.