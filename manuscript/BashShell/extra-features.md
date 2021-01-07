## Extra Bash Features

We have learned the built-in Bash commands and GNU utilities for operating on the file system. Now you can run a program and copy a file in the command line. The graphical interface provides the same features. If you are solving such simple tasks, the interface does not matter.

The Bash interpreter provides several features that the GUI does not have. Thanks to them, some tasks are faster to perform in the command-line interface. If you have such a task, knowing Bash saves you time thanks to automation.

We will take a look at the following Bash features:

1. I/O redirection.
2. Pipelines.
3. Logical operators.

### Unix Philosophy

[Douglas McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy) is one of the Unix developers. He summarized the philosophy of this OS in three points:

1. Write programs that do one thing and do it well.
2. Write programs to work together.
3. Write programs to handle text streams, because that is a universal interface.

The plain text format is the cornerstone of the Unix philosophy. It is the foundation for the first two points.

The text format allows programs to share data easily. Suppose that two developers independently of each other wrote two utilities. Both utilities accept text data on input. They print results in text format too. You have a task. If you combine two utilities, you solve it. Because of the text interface, it is quite simple to do. You have to pass the output of the first utility to the input of the second one.

When it is easy for programs to interact, there is no need to overload them with extra features. For example, you write a program to copy files. It does the job well. But eventually, you realize that it lacks a search function. With this feature, it would be faster to find and copy the files at once. Then you decide that it is convenient to create directories and copy files by one program. This example shows that the requirements for a self-contained application grow rapidly.

When applications work together, each solves a single task only. If you need an extra feature, you call the corresponding special utility. You don't have to add this feature to your application. The feature is already available and well tested. Just call an external utility that does what you need.