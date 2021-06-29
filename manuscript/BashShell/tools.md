## Development Tools

You need a Bash interpreter and a terminal emulator to run the examples of this chapter. You can install them on all modern operating systems. Let's take a look at how to do this.

### Bash Interpreter

Bash is a [**script programming language**](https://en.wikipedia.org/wiki/Scripting_language). It has the following features:

1. It is interpreted language.

2. It operates existing programs or high-level commands.

3. You can use it as a shell to access the OS functions.

If you use Linux or macOS, you have the preinstalled Bash interpreter. If your OS is Windows, you need both Bash interpreter and POSIX-compatible environment. Bash needs this environment to work correctly. There are two ways to install it.

I> You can meet the "Unix environment" and "Linux environment" terms. They both mean a software environment that is compatible with POSIX standards.

The first option is to install the [**MinGW**](https://en.wikipedia.org/wiki/MinGW) toolkit. It contains the [GNU compiler collection](https://en.wikipedia.org/wiki/GNU_Compiler_Collection) in addition to Bash. If you do not need all MinGW features, you can install Minimal SYStem (MSYS) instead. MSYS is the MinGW component that includes Bash, a terminal emulator and [GNU utilities](https://en.wikipedia.org/wiki/GNU_Core_Utilities). These three things make up a minimal Unix environment.

It is always good to clarify the bitness of your Windows before installing any software. Here are steps to read it:

1. If you have a "Computer" icon on your desktop, right-click on it and select the "Properties" item.

2. If there is no "Computer" icon on your desktop, click the "Start" button. Find the "Computer" item in the menu. Right-click on it and select "Properties".

3. You have opened the "System" window. Locate the "System Type" item there as Figure 2-1 demonstrates. This item shows you the bitness of Windows.

{caption: "Figure 2-1. System Type"}
![System Type](images/BashShell/windows-system-type.png)

We are going to install the modern MSYS version called MSYS2. Download its installer from the [official website](https://www.msys2.org). You should choose the installer version that fits the bitness of your Windows.

Now we have everything to install MSYS2. Follow these steps for doing it:

1. Run the installer file. You will see the window as Figure 2-2 shows.

{caption: "Figure 2-2. MSYS2 installation dialog", height: "30%"}
![MSYS2 installation dialog](images/BashShell/msys2-install.png)

2. Click the "Next" button.

3. You see the new window as Figure 2-3 shows. Specify the installation [**path**](https://en.wikipedia.org/wiki/Path_(computing)) there and press the "Next" button.

{caption: "Figure 2-3. Selecting the installation path", height: "30%"}
![Installation process](images/BashShell/msys2-path.png)

4. The next window suggests you to choose the application name for the Windows "Start" menu. Leave it unchanged and click the "Next" button. Then the installation process starts.

4. When the installation finishes, click the "Finish" button. It closes the installer window.

You have installed the MSYS2 Unix environment on your hard drive. You can find its files in the `C:\msys64` directory if you did not change the default installation path. Go to this directory and run the `msys2.exe` file. It opens the window where you can work with the Bash shell. Figure 2-4 shows this window.

{caption: "Figure 2-4. The Bash shell", height: "20%"}
![The Bash shell](images/BashShell/bash-window.png)

The second option is to install a Unix environment from Microsoft. It is called [Windows subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) (WSL). This environment is available for Windows 10 only. It does not work on Windows 8 and 7. You can find the manual to install WSL on the [Microsoft website](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

If you use Linux, you do not need to install Bash. You already have it. Just press the shortcut key Ctrl+Alt+T to open a window with the Bash shell.

If you use macOS, you have everything to launch Bash too. Here are the steps for doing that:

1. Click the magnifying glass icon in the upper right corner of the screen. It opens the Spotlight search program.

2. The dialog box appears. Enter the text "Terminal" there.

3. Spotlight shows you a list of applications. Click on the first line in the list with the "Terminal" text.

### Terminal emulator

Bash shell is not a regular GUI application. It even does not have its own window. When you run the `msys2.exe` file, it opens a window of the terminal emulator program.

An [**emulator**](https://en.wikipedia.org/wiki/Emulator) is a program that mimics the behavior of another program, OS or device. The emulator solves the compatibility task. For example, you want to run a Windows program on Linux. There are several ways to do that. One option is using the emulator of the Windows environment for Linux. It is called [Wine](https://en.wikipedia.org/wiki/Wine_(software)). Wine provides its own version of the Windows system libraries. When you run your program, it uses these libraries and supposes that it works on Windows.

The terminal emulator solves the compatibility task too. Command-line programs are designed to work through a terminal device. Nobody uses such devices today. Cheap personal computers and laptops have replaced them. However, there are still many programs that require a terminal for working. You can run them using the terminal emulator. It uses the shell to pass data to the program. When the program returns some results, the shell passes them to the terminal emulator. Then the emulator displays the results on the screen.

Figure 2-5 explains the interaction between input/output devices, the terminal emulator, the shell and the command-line program.

{caption: "Figure 2-5. The workflow of the terminal emulator", height: "25%"}
![Terminal Emulator](images/BashShell/terminal-emulator.png)

The terminal emulator window in Figure 2-4 shows the following two lines:
{line-numbers: false}
```
ilya.shpigor@DESKTOP-1NBVQM4 MSYS ~
$
```

The first line starts with the username. The username is `ilya.shpigor` in my case. Then there is the @ symbol and the computer name `DESKTOP-1NBVQM4`. You can change the computer name via Windows settings. The word `MSYS` comes next. It means the platform where Bash is running. At the end of the line, there is the symbol ~. It is the path to the current directory.
