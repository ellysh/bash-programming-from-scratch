# Package Manager

We are already familiar with the basic Bash built-in commands and the standard set of GNU utilities. These tools are installed in the Unix environment by default. It can happen that their features are not enough to solve your task. You can solve this problem by installing additional programs and utilities.

Installing software in the Unix environment is not the same as in Windows. Let's look at how to properly install and update software in any Unix environment or Linux distribution.

## Repository

Whenever you install software in the Unix environment, you should use [**repository**](https://help.ubuntu.com/community/Repositories). A repository is a server that stores all available applications. **Maintainers** take open sources of these applications and build them. Most maintainers are volunteers and free software enthusiasts.

The repository stores each application as a separate file. This file has a special format. The format depends on the Linux distribution. Thus, each Linux distribution has its own software repository. Examples of the formats are deb, RPM, zst, etc. A file with an application is called a **package**. A package is a unit for installing software in a system.

The repository stores packages with applications and libraries. Besides, the repository has meta-information about all packages. One or more files store this meta-information. They are called **the package index**.

You can install packages in a Unix environment from several repositories at once. For example, one repository provides new versions of packages, and another offers special builds of them. Depending on your requirements, you can choose the repository for installing the package.

## Package Operating

The Unix environment provides a special program to work with the repository. It is called [**package manager**](https://en.wikipedia.org/wiki/Package_manager).

Why does the Unix environment need a package manager? For example, Windows does not have one. Users of this OS download programs from the Internet and install them manually.

The package manager installs and removes packages in the Unix environment. Its main task is to keep track of **package dependencies**. Suppose a program from one package uses features of an application or library from another package. Then the first package depends on the second one.

Package dependency prevents the same application or library from being installed multiple times on the system. Instead, the packages you need are installed once. All dependent programs know where to install them on disk and share them.

Package dependency prevents duplicating of applications and libraries in your system. It is enough to install all required packages once. Then all dependent programs know where to access files from these packages.

Install applications in a Unix environment or Linux system using the package manager only. This rule has one exception. If you need a proprietary program, you have to install it manually. Usually, such a program is distributed in a single package. It includes all dependencies (necessary libraries and applications). There is no need to track dependencies in this case. Therefore, you can install the program without the package manager.

Here is the algorithm to install a package from the repository:

1. Download a package index from the repository.

2. Find the required application or library in the package index.

3. Download the package with the application or library from the repository.

4. Install the downloaded package.

The package manager does all these steps. You need to know its interface and call it with the right parameters.

The MSYS2 environment uses the package manager [`pacman`](https://wiki.archlinux.org/index.php/Pacman). It is designed for the Arch Linux distribution. The `pacman` manager operates packages, which have a simple format. You do not need any special skills or experience to build applications and libraries into these packages.

Let's take the `pacman` manager as an example and look at the commands for working with the repository.

The following command downloads a package index from the repository:
{line-numbers: false, format: Bash}
```
pacman -Syy
```

This command finds the package by the keyword in the loaded index:
{line-numbers: false, format: Bash}
```
pacman -Ss KEYWORD
```

Suppose you are looking for a utility for accessing MS Word documents. Then the following command finds the right package for that:
{line-numbers: false, format: Bash}
```
pacman -Ss word
```

The list of results will contain two packages:

* mingw-w64-i686-antiword
* mingw-w64-x86_64-antiword

These are builds of the `antiword` utility for 32-bit and 64-bit systems. The utility converts MS Word documents to text format.

Run the command to install the package:
{line-numbers: false, format: Bash}
```
pacman -S PACKAGE_NAME
```

This command installs the `antiword` utility:
{line-numbers: false, format: Bash}
```
pacman -S mingw-w64-x86_64-antiword
```

As a result, `pacman` will install `antiword` and all the packages that it needs for running.

Now you can launch the `antiword` utility by the following command:
{line-numbers: false, format: Bash}
```
antiword
```

You have installed a package in the system. If it becomes unnecessary, uninstall it. The package manager will uninstall all dependencies of the package if other applications do not use them. Here is the command to uninstall a package:
{line-numbers: false, format: Bash}
```
pacman -Rs PACKAGE_NAME
```

This command uninstalls the `antiword` utility:
{line-numbers: false, format: Bash}
```
pacman -Rs mingw-w64-x86_64-antiword
```

Suppose you have installed several packages in your system. After a while, their new versions appear in the repository. You decide to upgrade your packages to the new versions. The following command does it:
{line-numbers: false, format: Bash}
```
pacman -Syu
```

The command updates all installed packages to their actual versions in the repository.

We have considered the basic `pacman` commands. Other package managers work along the same lines. They follow the same steps as `pacman` to install and remove packages. The only differences are their name and their command-line parameters.

Table 4-1 shows the commands for working with packages in different Linux distributions.

{caption: "Table 4-1. The commands for working with packages", width: "100%"}
| Command | MSYS2 and Arch Linux | Ubuntu | CentOS | Fedora |
| --- | --- | --- | --- | --- |
| Download a package index | `pacman -Syy` | `apt-get update` | `yum check-update` | `dnf check-update` |
|  | | | | |
| Search for a package by the keyword
 | `pacman -Ss KEYWORD` | `apt-cache search KEYWORD` | `yum search KEYWORD` | `dnf search KEYWORD` |
|  | | | | |
| Install the package from the repository | `pacman -S PACKAGE_NAME` | `apt-get install PACKAGE_NAME` | `yum install PACKAGE_NAME` | `dnf install PACKAGE_NAME` |
|  | | | | |
| Install the package from the local file | `pacman -U FILENAME` | `dpkg -i FILENAME` | `yum install FILENAME` | `dnf install FILENAME` |
|  | | | | |
| Remove the installed package | `pacman -Rs PACKAGE_NAME` | `apt-get remove PACKAGE_NAME` | `yum remove PACKAGE_NAME` | `dnf erase PACKAGE_NAME` |
|  | | | | |
| Update all installed packages | `pacman -Syu` | `apt-get upgrade` | `yum update` | `dnf upgrade` |
