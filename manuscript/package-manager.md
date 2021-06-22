# Package Manager

You have learned basic Bash built-ins and GNU utilities. These tools are installed in the Unix environment by default. It can happen that they cannot solve your task. In this case, you should find an appropriate program or utility and install it on your own.

Installing software in the Unix environment is not the same as it happens in Windows. Let's have a look at how to install and update software in any Unix environment or Linux distribution properly.

## Repository

Whenever you install the software in the Unix environment, you should use a [**repository**](https://help.ubuntu.com/community/Repositories). The repository is a server that stores all available programs. These programs are prepared by [**maintainers**](https://en.wikipedia.org/wiki/Software_maintainer). Maintainers are persons who take open source software and compile it for some repository. Most of these persons are volunteers and free software enthusiasts.

The repository stores each program as a separate file. All these files have the same format. The format depends on the Linux distribution. Thus, each Linux distribution has its own repository. Examples of the formats are DEB, RPM, ZST, etc. A single file with some application is called a **package**. A package is a unit for installing software in your system.

The repository stores packages with applications, libraries and resource files. Besides that, the repository has meta-information about all packages. One or more files store this meta-information. They are called the **package index**.

You can install packages to your Unix environment from several repositories at once. It can be useful in some cases. For example, one repository provides new versions of packages, and another offers special builds of them. Depending on your requirements, you can choose the repository for installing each package.

## Package Operating

Each Unix environment provides a special program for accessing the repository. It is called a [**package manager**](https://en.wikipedia.org/wiki/Package_manager).

Why does the Unix environment need a package manager? Windows does not have such a program. Users of this OS download all software from the Internet and install it manually.

I>There are several third-party package managers for Windows. The most popular one is [Chocolatey](https://chocolatey.org). Microsoft plans to develop the [official package manager](https://devblogs.microsoft.com/commandline/windows-package-manager-1-0) in the nearest future.

The package manager installs and removes packages in the Unix environment. Its main task is to keep track of **package dependencies**. Suppose that some program from one package uses features of the library from another package. Then the first package depends on the second one. It means that you should install the second package whenever you install the first one.

Package dependency allows you to have a single copy of every program and library in your file system. All dependent programs know the installation path of the software they need. This way, they can share it.

You should install all software to your Unix environment or Linux system using the package manager. This rule has one exception. If you need a proprietary program, you have to install it manually. Usually, such a program is distributed in a single package. It includes all dependencies, which are necessary programs and applications. There is no need to track dependencies in this case. Therefore, you can install the program without the package manager.

Here is the algorithm to install a package from the repository:

1. Download a package index from the repository.

2. Find the required program or library in the package index.

3. Download the package with the program or library from the repository.

4. Install the downloaded package.

The package manager does all these steps. It has parameters and options that choose an action to do. You need to know them for installing packages properly.

The MSYS2 environment uses the package manager called [`pacman`](https://wiki.archlinux.org/index.php/Pacman). It was developed for the Arch Linux distribution. The `pacman` manager operates packages of the ZST format. You do not need any extra knowledge about this format now.

Let's take the `pacman` manager as an example and consider the commands for accessing the repository.

The following command downloads the package index of the repository:
{line-numbers: false, format: Bash}
```
pacman -Syy
```

When you get the package index on your computer, you can find the required package there. This command finds it by the KEYWORD:
{line-numbers: false, format: Bash}
```
pacman -Ss KEYWORD
```

Suppose that you are looking for a utility for processing MS Word documents. The following command finds the right package for that:
{line-numbers: false, format: Bash}
```
pacman -Ss word
```

This command gives you two options:

* mingw-w64-i686-antiword
* mingw-w64-x86_64-antiword

These are builds of the `antiword` utility for 32-bit and 64-bit systems. The utility converts MS Word documents to text format.

Now you can run the following command that  installs the PACKAGE:
{line-numbers: false, format: Bash}
```
pacman -S PACKAGE
```

This command installs the package with the `antiword` utility:
{line-numbers: false, format: Bash}
```
pacman -S mingw-w64-x86_64-antiword
```

When this command finishes, you get the `antiword` utility and all packages that it needs for running.

Now you can launch the `antiword` utility for the `my_report.doc` file this way:
{line-numbers: false, format: Bash}
```
antiword my_report.doc
```

This command prints the document contents in text format.

You have installed the new package in your system. If it becomes unnecessary, you can uninstall it. When you do it, the package manager uninstalls both the package and all its dependencies. It happens only when there are no other programs that require them.

Here is the command to uninstall some PACKAGE:
{line-numbers: false, format: Bash}
```
pacman -Rs PACKAGE
```

The following command uninstalls the package of the `antiword` utility:
{line-numbers: false, format: Bash}
```
pacman -Rs mingw-w64-x86_64-antiword
```

Suppose that you have installed several new packages in your system. After a while, maintainers compile new versions of these packages and push them to the repository. You want to get these new versions because of their features. The following command does that:
{line-numbers: false, format: Bash}
```
pacman -Syu
```

This command updates all installed packages in your system to their actual versions in the repository.

We have considered the basic `pacman` commands. Other package managers work the same way. They follow the same algorithm as `pacman` when installing and removing packages. However, they have other command-line parameters.

Table 4-1 shows how to use package managers of several well-known Linux distributions.

{caption: "Table 4-1. The commands of package managers", width: "100%"}
| Command | MSYS2 and Arch Linux | Ubuntu | CentOS | Fedora |
| --- | --- | --- | --- | --- |
| Download a package index. | `pacman -Syy` | `apt-get update` | `yum check-update` | `dnf check-update` |
|  | | | | |
| Search for a package by some keyword. | `pacman -Ss KEYWORD` | `apt-cache search KEYWORD` | `yum search KEYWORD` | `dnf search KEYWORD` |
|  | | | | |
| Install the package from the repository. | `pacman -S PACKAGE_NAME` | `apt-get install PACKAGE_NAME` | `yum install PACKAGE_NAME` | `dnf install PACKAGE_NAME` |
|  | | | | |
| Install the package from the local file. | `pacman -U FILENAME` | `dpkg -i FILENAME` | `yum install FILENAME` | `dnf install FILENAME` |
|  | | | | |
| Remove the installed package. | `pacman -Rs PACKAGE_NAME` | `apt-get remove PACKAGE_NAME` | `yum remove PACKAGE_NAME` | `dnf erase PACKAGE_NAME` |
|  | | | | |
| Update all installed packages. | `pacman -Syu` | `apt-get upgrade` | `yum update` | `dnf upgrade` |
