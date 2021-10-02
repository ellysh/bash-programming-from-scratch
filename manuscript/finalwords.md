# Finalwords

Here we finish our introduction to Bash. We have covered the language basics only. This book skips several important Bash topics. You will need them if you plan to use Bash for professional software development.

Here are the topics that would be a good start for advanced learning of Bash:

* [Strings manipulation](https://tldp.org/LDP/abs/html/string-manipulation.html).

* [Regular expressions](https://tldp.org/LDP/abs/html/x17129.html).

* [The `sed` stream editor](https://tldp.org/LDP/abs/html/x23170.html).

* [The `awk` text processing language](https://tldp.org/LDP/abs/html/awk.html).

I> GNU utilities `sed` and `awk` are not part of Bash. However, they give you advanced features for processing strings.

These topics are material for advanced study. You can skip them if you are using Bash for simple tasks and basic automation only.

Perhaps you liked writing programs. Now you want to know more about this topic. What is the next step after reading this book?

First, you should accept the idea that Bash is not the **general-purpose programming language**. This term means a language for developing applications in various [**domains**](https://en.wikipedia.org/wiki/Domain_(software_engineering)). Such a language does not contain features that are suitable for the specific domain and useless in another one.

Bash is the [**domain-specific language**](https://en.wikipedia.org/wiki/Domain-specific_language). It does not mean that Bash is useless for you. It is a powerful auxiliary tool for each software developer. Today it is used for integrating large projects, testing, building software and automating routine tasks. However, you would not find any commercial project written in Bash only. This language copes well with the tasks for which it was created. On the other side, there are many domains where Bash cannot compete with modern general-purpose languages.

Nobody creates some programming language just for fun. Its author faced some applied task. Then he found that all existing languages are inconvenient for solving it. At some point, this developer writes the new language that is focused on his specific task. Then there are two options for developing this language.

The first option is the language can provide universal and well-known constructs that fit several domains. It becomes general-purpose in this case. The author adds new features and libraries that adapt the language for various domains.

The second option is the new language has many domain-specific features that are useful only for a limited range of tasks. It becomes domain-specific in this case. The author does not pay efforts for adding any features outside one specific domain.

There is one important conclusion of the typical language development process. All modern general-purpose languages have strong advantages in a few domains only. No language fits any tasks perfectly. It means that the domain dictates you the language to use.

Let's come back to our question regarding your next step for learning programming. You have read this book. Now it is time to choose the applied domain that is interested to you. How can you do it?

You already know something about software from your user experience. Read articles on the Internet about the programs that you use every day. Think about them this way: do you want to develop similar programs? It can happen that your user experience will help you to find the right applied domain.

Suppose that you find the applied domain that you want to learn. The next step is choosing the appropriate programming language that fits this domain well.

Table 5-1 will help you to find the right programming language for your applied domain.

{caption: "Table 5-1. Applied domains of software development", width: "100%"}
| Domain | Programming language |
| --- | --- |
| [Mobile applications](https://en.wikipedia.org/wiki/Mobile_app) | Java, C, C++, HTML5, JavaScript |
|  | |
| [Web applications](https://en.wikipedia.org/wiki/Web_application) ([front end](https://en.wikipedia.org/wiki/Front_end_and_back_end)) | JavaScript, PHP, HTML5, CSS, SQL |
|  | |
| [Web applications](https://en.wikipedia.org/wiki/Web_application) ([back end](https://en.wikipedia.org/wiki/Front_end_and_back_end)) | JavaScript, Python, Ryby, Perl, C#, Java, Go |
|  | |
| [High Load Systems](https://en.wikipedia.org/wiki/Server_(computing)) | C++, Python, Ruby, SQL |
|  | |
| [System administration](https://en.wikipedia.org/wiki/System_administrator) | Bash, Python, Perl, Ruby |
|  | |
| [Embedded systems](https://en.wikipedia.org/wiki/Embedded_system) | C, C++, Assembler |
|  | |
| [Machine learning ](https://en.wikipedia.org/wiki/Machine_learning) and [data analysis](https://en.wikipedia.org/wiki/Data_analysis) | Python, Java, C++ |
|  | |
| [Information security](https://en.wikipedia.org/wiki/Information_security) | C, C++, Python, Bash |
|  | |
| [Enterprise software](https://en.wikipedia.org/wiki/Enterprise_software) | Java, C#, C++, SQL |
|  | |
| [Video games](https://en.wikipedia.org/wiki/Video_game) | C++ |

Unfortunately, it is not enough to know one specific programming language to become a lead developer. You need to know the technologies that are used in the specific applied domain. For example, an information security expert must understand the architecture of computer networks and operating systems. As you grow professionally, you will get the list of technologies that you should learn.

Suppose that you have chosen the applied domain and programming language. Now it is time to enroll in the corresponding online course. This book has introduced you to the basics of programming. Thus, learning the new language will go faster. You will find that some Python and C++ statements look the same as in Bash. However, these languages have concepts that you have to learn from scratch. Do not lose your motivation. Apply the new knowledge into practice and learn from your mistakes. This is the only way to get results.

I hope that you learned something new from this book and had an enjoyable time while reading it. If you like the book, please share it with your friends. I would also appreciate it if you would take a few minutes to score it on [Goodreads](https://www.goodreads.com/book/show/57301128-bash-programming-from-scratch).

If you have any questions or comments about this book, please write to me here: [petrsum@gmail.com](mailto:petrsum@gmail.com). Also, you can ask questions in the "Issues" section of the [GitHub repository of the book](https://github.com/ellysh/bash-programming-from-scratch/issues).

Thank you for reading ["Bash programming from scratch"](https://leanpub.com/bash-programming-from-scratch/)!

# Acknowledgements

Nobody writes his book alone. Several people helped me a lot with this work. Some of them suggested just general ideas. Others gave me comments and recommendations. These are the people I want to thank here.

Thanks to Sophia Kayunova for the idea of the programming book for beginners. It gave me a strong motivation to write a book for my friends who asked me about programming.

Thanks to Vitaly Lipatov for introducing me to Linux and Bash. He taught me programming basics and showed me the world of open-source software.

Thanks to Ruslan Piasetskyi for consulting on some Bash topics. He explained to me the idioms and pitfalls of the language.

Thanks also to everyone who supported me and motivated me to finish this work.