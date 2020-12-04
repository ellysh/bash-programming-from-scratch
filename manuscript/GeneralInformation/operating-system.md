## Operating Systems

### History of OS Origin

Most computer users understand why [**operating system**](https://en.wikipedia.org/wiki/Operating_system) (OS) is needed. Usually, when you buy or download an application from the Internet, you check its system requirements. They specify the required hardware and an operating system to launch the application. It means that the OS is a software platform, which is necessary for the application to work. But where did this requirement come from? Why can't you just buy a computer and launch an application on it without any OS?

These questions seem meaningless at first blush. Let's consider them from the following side. Modern operating systems are multipurpose and offer the user many functions. Each specific user would not use most of these functions. But he usually cannot disable them. To maintain these functions, the OS utilizes computer's resources intensively. As a result, the user has much fewer computation resources for his applications. This leads to slow work, hangs and even reboots of the computer.

Let's turn to history to find out the causes of the OS. The first commercial OS [GM-NAA I/O](https://en.wikipedia.org/wiki/GM-NAA_I/O) appeared in 1956 for the computer [IBM 704](https://en.wikipedia.org/wiki/IBM_704). All earlier computer models have worked without an OS. Why didn't they need it?

The main reason for having an OS is high computational speed. For example, let's consider the first [**electromechanical computer**](https://en.wikipedia.org/wiki/Tabulating_machine#1890_census) designed by [Herman Hollerith](https://en.wikipedia.org/wiki/Herman_Hollerith) in 1890. This computer called a tabulator does not require an OS and a [program](https://en.wikipedia.org/wiki/Computer_program) in the modern sense. The tabulator performs a limited set of arithmetic operations only. The computer design defines this set of operations. The data for calculations is loaded from [**punched cards**](https://en.wikipedia.org/wiki/Punched_card). These cards look like sheets of thick paper with punched holes. A human operator prepares these sheets manually and stacks them in special receivers. In the receivers, the sheets are threaded on the needles. Then a short circuit happens in each punched hole. Each short circuit increases the mechanical counter, which is a rotating cylinder. The calculation results are displayed on dials that resemble watches.

Figure 1-1 shows a tabulator, which is built by Hermann Hollerith.

{caption: "Figure 1-1. Hollerith tabulating machine", height: "30%"}
![Hollerith tabulating machine](images/GeneralInformation/tabulating-machine.jpg)

By modern standards, the tabulator works very slowly. There are several reasons for this. First, the data for the calculations are prepared manually. There was no way to punch through the cards automatically. Then loading of punch cards into the computer is also manual work. The tabulator itself contains many mechanical parts: needles to read data, rotating cylinders as counters, dials to output the result. All these mechanics work slowly. It takes about one second to perform one elementary operation. No automation can accelerate these processes.

Tabulators used rotating cylinders for performing calculations. The next generation of computers used [**relays**](https://en.wikipedia.org/wiki/Relay) for that. A relay is a mechanical element that changes its state due to an electric current. 

In 1939, the German engineer [Konrad Zuse](https://en.wikipedia.org/wiki/Konrad_Zuse) designed one of [the first relay computers](https://en.wikipedia.org/wiki/Z2_(computer)) called Z2. Then this computer was improved in 1941 and was named Z3. In these computers, the time for each elementary operation was reduced from seconds to milliseconds. It was achieved thanks to applying relays.

The increased speed of computation is one feature of Zuse's computers. Another feature is the concept of a computer program. The punched cards stored source data for calculations in case of tabulating machines. Similar cards store [**algorithms**](https://en.wikipedia.org/wiki/Algorithm) for doing computations in Zuse's computers. It was a fundamentally new idea. For data input, Zuse used keyboards in his computers. These first keyboards resemble typewriters of that time.

I> An algorithm is a finite sequence of instructions to perform a particular calculation or task.

The computers with the feature of changing their algorithms became known as [**programmable**](https://en.wikipedia.org/wiki/General_purpose_computer) or general-purpose.

The invention of programmable computers was a milestone in the development of computer science. Until this moment, machines were able to perform highly specialized tasks only. The construction of these machines was too expensive and inefficient. For this reason, many investors avoided investing money in projects to design new computers. These projects served only military needs during World War II.

The next big step in computer design is the construction of the [**ENIAC**](https://en.wikipedia.org/wiki/ENIAC) (see Figure 1-2) computer in 1946 by [John Eckert](https://en.wikipedia.org/wiki/J._Presper_Eckert) and [John Mauchly](https://en.wikipedia.org/wiki/John_Mauchly). ENIAC has a new type of element for performing computations. [**Vacuum tubes**](https://en.wikipedia.org/wiki/Vacuum_tube) replaced relays there. In other words, the electromechanical parts with a long response time were replaced by faster electronic components. This improvement increased computer performance by order of magnitude. Then one elementary operation took 200 microseconds instead of milliseconds.

{caption: "Figure 1-2. ENIAC", height: "30%"}
![ENIAC](images/GeneralInformation/eniac.jpg)

Most computer engineers were skeptical about vacuum tubes at that time. The tubes were known for their low reliability and high power consumption. Nobody believed that a machine, which uses them, could work at all. ENIAC has around 18,000 vacuum tubes. They failed often. But between the failures, the computer performed the calculations successfully. ENIAC was the first successful case of applying vacuum tubes for a computer. This case convinced many designers that such a design works.

ENIAC is a programmable computer. A human operator can set the algorithm of calculations using a combination of switches and jumpers on the control panels. Such programming requires considerable time and simultaneous work of several people. Figure 1-3 shows one of the panels for programming ENIAC.

{caption: "Figure 1-3. ENIAC control panel", height: "30%"}
![ENIAC control panel](images/GeneralInformation/eniac-programming.jpg)

Punched cards were used for inputting source data and outputting results. Thus, ENIAC uses the same approach as previous models of computers. Sometimes punched cards stored results of intermediate calculations. It is needed if the computer cannot solve the task at once because of its complexity. In this case, the task is divided into several subtasks. After resolving each subtask, the results are written on the punched cards. Then operators reprogrammed the computer. Finally, the punched cards were loaded back as input data.

Experience gained by using ENIAC showed that all mechanical operations limit the computer performance. These are the mechanical operations: manual reprogramming with switches and jumpers, reading and punching the punched cards. Because of them, solving a specific task with ENIAC took considerable time. The computer itself had an unprecedented performance at that time. But most of the time, the computer was idling and waiting for a program or input data. These findings initiated the development of new devices for both data input and output.

The next step in computer design is replacing vacuum lamps with [**transistors**](https://en.wikipedia.org/wiki/Transistor). It again increased the computing power of computers by order of magnitude. Together with improved [**input/output**](https://en.wikipedia.org/wiki/Input/output), transistors lead to heavy use and frequent reprogramming of the computers. By that time, computing machines have spread beyond military projects. Large banks and corporations started to exploit them too. As a result, the number and variety of programs running on computers increased.

Commercial usage of computers brings new requirements. The computers should execute their programs one after another without delays. Otherwise, the equipment idles and a company loses its money. Special solutions were needed to automate loading programs and printing their results. This requirement leads to creating the first commercial operating system [**GM-NAA I/O**](https://en.wikipedia.org/wiki/GM-NAA_I/O). The primary goal of the system was managing the execution of programs.

The heavy use of computers and the variety of their programs bring one more task. The loaded program defines the available features of the computer. For example, the program includes a code to control devices for input/output. It makes these devices available. If the program does not provide such code, the devices do not work for the user.

Let's consider a particular computer model. Its equipment is changed rarely. Therefore, the code for working with this equipment is rarely changed too. It leads to copying this code from one program to another and occupying extra space on storage devices. At some point, engineers came to an idea to bring the devices-related code to a separate service program. This service program was loaded together with the primary one. Finally, these service programs became part of the first generation operating systems.

Now we return to the question about the necessity of operating systems. We found out that applications could work without them. Such applications are still in use today. For example, they are [**utilities**](https://en.wikipedia.org/wiki/Utility_software) for memory checks and disk partitioning, antiviruses, recovery tools. However, developing such applications takes more time and effort. They should include the code for supporting hardware.

OS usually provides the code for supporting hardware. Why not use it? Most modern developers choose this way. It reduces the amount of work and speeds up the release of the applications.

### OS Features

Why did we start studying programming by considering the OS? Figure 1-4 explains interaction between the OS, [**applications**](https://en.wikipedia.org/wiki/Application_software) and [**hardware**](https://en.wikipedia.org/wiki/Computer_hardware). Applications are programs that solve user tasks. There are examples: text editor, calculator, browser. Hardware is all electronic and mechanical components of a computer. For example, these are keyboard, monitor, central processor, video card.

{caption: "Figure 1-4. Interaction scheme of an OS with applications and hardware", height: "50%"}
![Interaction Scheme](images/GeneralInformation/operating-system.png)

According to Figure 1-4, applications do not access hardware directly. They do it through [**system libraries**](https://en.wikipedia.org/wiki/Library_(computing)). The system libraries are part of the OS. Each application should follow specific rules for interacting with them.

The application can access only the features of devices that are supported by the OS. [**Application Programming Interface**](https://en.wikipedia.org/wiki/API) or API of the OS defines available devices features. Also, the API dictates a set of rules for working with devices. The API is a set of agreements for interacting components of the information system. Often a standard describes an interface of the specific OS (for example, POSIX). Such standards guarantee the compatibility of the OS and applications. The system libraries provide API.

The API describes the following aspects of the interaction between the OS and applications:

1. Which action does the OS perform when the application calls the specific system function?

2. Which data does the function receive as an input?

3. Which data does the function return as a result?

Both the OS and application should follow the API agreements. It guarantees the compatibility of their current versions and future modifications. Such compatibility would be unreachable without a well documented and standardized interface.

We have discovered that applications can operate without an OS. However, the OS provides ready-made solutions for interaction with computer hardware. Without such solutions, developers of applications should solve this task on their own. It requires significant efforts. For example, consider the variety of devices of a modern computer. The software should support all popular models of each device. For example, all video cards should be supported. Without such support, the application would not work stably for all users.

Let's consider the features that the OS provides via its API. We can treat all electronic and mechanical components of the computer (hardware) as resources. The software uses these resources for performing calculations. In other words, hardware executes all user's applications. The API reflects the list of hardware features that the application can use. Also, the API dictates the order of interaction between several applications and the hardware.

There is an example. Two programs cannot write data to the same area of the [hard disk](https://en.wikipedia.org/wiki/Hard_disk_drive#Magnetic_recording) simultaneously. There are two reasons for that:

1. A single magnetic head records data on the hard disk. The head can do one task at a time.

2. One program overwrites data of another program in the same memory area. It leads to losing data.

Therefore, all programs' writing requests should be placed in a queue and executed one after another. The OS responses for this job. The [**kernel**](https://en.wikipedia.org/wiki/Kernel_(operating_system)) (see Figure 1-4) of the OS provides a mechanism for managing access to the hard drive. This mechanism is called [**file system**](https://en.wikipedia.org/wiki/File_system). In the same way, the OS manages access to all [**peripheral**](https://en.wikipedia.org/wiki/Peripheral) and internal devices of the computer. There are special programs called [**device drivers**](https://en.wikipedia.org/wiki/Device_driver) (see Figure 1-4). They help the OS to manage devices.

What is the difference between the peripheral and internal devices? Peripherals are all devices that are responsible for inputting, outputting, and storing data permanently. These are a few examples:

* Keyboard
* Mouse
* Microphone
* Monitor
* Speakers
* Hard drive

Internal devices are responsible for processing data, i.e. for programs execution. These are internal devices:

* [**Central Processing Unit**](https://en.wikipedia.org/wiki/Central_processing_unit) (CPU)
* [**Random-Access Memory**](https://en.wikipedia.org/wiki/Random-access_memory) (RAM)
* [**Video Card**](https://en.wikipedia.org/wiki/Video_card) (graphics processing unit or GPU).

The OS provides access to computer resources (hardware). At the same time, the OS has its own software resources for sharing with user's applications. Do you remember the copied code for supporting devices from the first generation of OSes? This code has become a service program. Later, it has transformed into the system libraries (see Figure 1-4).

Some system libraries serve the devices. Other system libraries process data using a complex algorithm. There is an example: the Windows component called [**Graphics Device Interface**](https://en.wikipedia.org/wiki/Graphics_Device_Interface) (GDI). It provides an interface for manipulating graphic objects. Using GDI, developers create a user interface for their applications. All software resources of OS are already installed on your computer. You just need knowledge of how to use them. Besides, the OS also provides access to third-party algorithms or libraries.

The OS manages hardware and software resources. Also, it organizes the joint work of running programs. The OS performs several non-trivial tasks to launch an application. Then the OS tracks its work. If the application violates some agreements (like memory usage), the OS terminates it. We will consider the process of launching and executing the program in the next section.

If the OS is multi-user, it controls access to the data. It is an important security feature. Thanks to such control, each user can access his own files only.

Let's summarize. The OS has the following features:

1. It provides and arranges access to hardware resources of the computer.

2. It provides its own software resources.

3. It launches applications.

4. It organizes the interaction of applications with each other.

5. It controls access to users' data.

You can guess that without the OS, it is impossible to execute several applications simultaneously. Yes, it is true. The developers can not foresee the combination of launched applications. The OS launches these applications. So, only the OS has enough information to allocate computer resources in real-time effectively.

### Modern OSes

We reviewed the OSes capabilities in general. Now we will apply our new knowledge and consider modern operating systems. Their features are similar. But the approaches of their implementation cause most differences between modern OSes. The term [**software architecture**](https://en.wikipedia.org/wiki/Software_architecture) describes these approaches. The architecture means the implementation aspects and the solutions that led to them.

All modern OSes have two important features. The features determine behavior of OS and the way they interact with the user. These are multitasking and the GUI. Let us take a closer look at them.

#### Multitasking

The most modern OSes support [**multitasking**](https://en.wikipedia.org/wiki/Computer_multitasking). It means that they execute multiple programs simultaneously. Why was this property important? The systems with this property supplanted OSes without it.

In the 1960s, the challenge of increasing computer efficiency came. Computers were expensive that time. It leads that their owners count every minute of the hardware work. Only large companies and universities were able to buy computers. These organizations considered unacceptable any idle time of the hardware.

Early operating systems allowed programs to be executed one after the other without delay. This approach saved the time needed to switch computers from one task to another. In such systems, several programs and their input data were prepared in advance and written to a storage device (e.g., magnetic tape). This tape was loaded to a computer reading device. Then the computer executed the programs sequentially and printed their results to an output device (e.g., a printer). This mode of operation is called [**batch processing**](https://en.wikipedia.org/wiki/Batch_processing).

Batch processing increased the efficiency of mainframe usage. It automated program loading and partially eliminated the human operator from the process. However, the computer system still has the [**bottleneck**](https://en.wikipedia.org/wiki/Bottleneck_(production)). The computational power of processors has increased significantly. But the speed of peripherals has remained almost the same. Thus, the CPU often stayed idle while waiting for input/output.

I> Bottleneck is a component or resource of an information system that limits its overall performance or bandwidth.

Let's look at an example. Imagine that the mainframe runs programs sequentially. It reads data from a magnetic tape and prints the results on the printer. The OS loads each program and executes its instructions, then downloads the next one, and so on. The problem occurs at the stages of data reading and printing the results. The time for accessing data on a magnetic tape is huge in the CPU scale. Between the two reading operations, the CPU would be able to perform many calculations. But it does not do that. All computer resources are used only by a program that is loaded into memory now. The same happens with printing the results. The printer is a purely mechanical device. It works very slowly.

The problem of CPU idle led to the idea of [**multiprogramming**](https://en.wikipedia.org/wiki/Computer_multitasking#Multiprogramming). It means that several programs are loaded into the computer memory at the same time. The first one is running as long as all the resources it needs are available. Once one of the resources is busy, the program stops executing. For example, it requires the data stored on your hard disk. While the disk controller reads the first part of the data, it is busy and cannot process the request to read the next part. In this case, the OS stops executing the first program and switches to the second one. The second program is executed to the end or to the point when the required resource is busy. After that, OS switches tasks again.

Multiprogramming has become a prototype of multitasking, which is implemented in modern operating systems. Multiprogramming copes well with the batch processing mode. However, this load balancing approach is not suitable for [**interactive systems**](https://en.wikipedia.org/wiki/Interactivity#Computing_science). On such systems, each user action is an event (for example, a keystroke). Each event is processed immediately. For example, the computer adds a new character in a text document. The response time of the system should be minimum. Otherwise, the user will notice the program hangs.

Multiprogramming cannot manage interactive systems. The problem appears because the moment of task switching is unpredictable. It happens only when a program finishes or when it accesses a busy resource. Therefore, the computer does not process user actions until the next task switching. The user cannot wait for an unpredictable time.

Multitasking solves the problem of quick response to user actions. This approach was developed gradually and became complicated in the end. Modern operating systems use [**displacing multitasking**](https://en.wikipedia.org/wiki/Preemption_(computing)) with pseudo-parallel processing of tasks. It means that the OS chooses a program to run at the moment. The choice takes into account the priorities of the running applications. This way, a higher priority application receives hardware resources more often than a lower priority one. The task switching mechanism is implemented in the OS kernel. It is called [**task scheduler**](https://en.wikipedia.org/wiki/Scheduling_(computing)).

Pseudo-parallel processing means that only one task is executed at any given time. At the same time, the OS switches between tasks so quickly that the user does not notice it. It seems to him that the computer is running several programs simultaneously. With such an approach, the GUI reacts immediately to any action. But in fact, every program and OS component gets its hardware resources at strictly defined moments.

There are computers with multiple processors or with [multi-core processors](https://en.wikipedia.org/wiki/Multi-core_processor). Only these computers can execute several programs simultaneously. The number of the executed programs equals the number of cores of all processors approximately. The preemptive multitasking mechanism with constant task switching still works on such systems. It is universal and balances the load regardless of the number of cores. This way, a user gets an adequate response time to his actions.

#### User Interface

Modern operating systems solve different tasks. These tasks depend on the type of computer where the OS is running. The main computer types are the following:

* [Personal computers](https://en.wikipedia.org/wiki/Personal_computer) (PC) and notebooks.
* Cell phones and tablets.
* Servers.
* [Embedded systems](https://en.wikipedia.org/wiki/Embedded_system).

We will consider operating systems for PCs and notebooks only. Apart from multitasking, they provide [**graphic user interface**](https://en.wikipedia.org/wiki/Graphical_user_interface) (GUI). Here the interface means the way to interact with the system. Through the interface, the user launches applications, configures computer devices and OS components. Let's take a look at the history of the GUI.

Users of commercial computers learned about the interactive mode in 1960. This mode was supported by a new [minicomputer](https://en.wikipedia.org/wiki/Minicomputer) [PDP-1](https://en.wikipedia.org/wiki/PDP-1) from [Digital Equipment Corporation](https://en.wikipedia.org/wiki/Digital_Equipment_Corporation). Why did computer manufacturers and users become interested in interactivity in general? In the 1950s, IBM computers dominated the mainframe market. They worked in batch processing mode and coped well with computational tasks. Their operating systems with multi-programming support automated program loading and provided high performance.

The idea of interactive work with the computer appeared in the SAGE military project. The US Air Force ordered it. The project developed an automated air defense system to detect Soviet bombers. During development, the engineers faced the problem of processing data from radars. According to the requirements, the computer had to output data in real-time. The human operator reacted to data as quickly as possible and gave commands to the system. The existing methods of interaction with the computer did not fit this task. Because in an air defense system, the speed of response to a threat is essential.

The SAGE project has led to the creation of the first interactive computer [AN/FSQ-7](https://en.wikipedia.org/wiki/AN/FSQ-7_Combat_Direction_Central) (see Figure 1-5). The computer used the monitor with a [cathode-ray tube](https://en.wikipedia.org/wiki/Cathode-ray_tube). An operator entered commands using the [**light pen**](https://en.wikipedia.org/wiki/Light_pen).

{caption: "Figure 1-5. Computer AN/FSQ-7"}
![Computer AN/FSQ-7](images/GeneralInformation/AN-FSQ-7.jpg)

The method of interactive work with the computer became known in scientific circles. It gained popularity quickly. Batch processing successfully coped with program execution. However, this approach was inconvenient for development and debugging applications. The developer should make his algorithm and wrote it on a storage device. Then he placed the application in a queue for execution on the mainframe. Waiting in the queue took hours. If an error was detected after the program execution, the developer should fix it and put the application in the queue again. As a result, it took days to fix all the errors even in a small program.

The software development differs in the interactive mode. The developer makes an algorithm, loads it on a computer and launches the program. When it completes, the developer sees results on the screen. Such a process accelerates the development and debugging of applications significantly. Now the work, which takes several days with batch processing, was done in a few hours.

The interactive mode brought new tasks. This mode makes sense only if the system immediately reacts to user actions. Such a reaction required a new load-balancing mechanism. The multitasking mode of the latest operating systems was able to meet this requirement.

Single-tasking OSes support the interactive mode too. An example of such OS is [MS-DOS](https://en.wikipedia.org/wiki/MS-DOS). Combining interactivity and single-tasking was inexpedient in times of expensive mainframes. Several users used the resources of one mainframe at once. Their programs were executed in parallel and independently of each other. This mode was called [**time-sharing**](https://en.wikipedia.org/wiki/Time-sharing). It allows sharing expensive hardware among several users. The single-tasking approach was not suitable for such a use case because it is not compatible with time-sharing.

When the first relatively cheap personal computers appeared, they used single-tasking operating systems. Such systems require fewer hardware resources than their mainframe counterparts. Despite its simplicity, single-tasking operating systems support interactive mode. For PC users, this mode became especially attractive.

The interactive mode brought another task besides load balancing of a system. Users needed new ways of interacting with computers. The existing magnetic tapes and printers of the 1960s were not suitable for this purpose.

[**Teletype**](https://en.wikipedia.org/wiki/Teleprinter) (TTY) became a prototype of a device for interactive work with a computer. Figure 1-6 shows the Model 33 teletype. It is an electromechanical typewriter. It is connected to the same typewriter through wires. Once two teletypes are connected, operators can send text messages to each other. The sender types text on his device. The keystrokes are transmitted to the receiver's device. It prints out each received letter on paper.

{caption: "Figure 1-6. A Teletype Model 33", height: "50%"}
![Teletype Model 33](images/GeneralInformation/teletype.jpg)

Teletype fitted well for interacting with mainframes. Such a device was called [**terminal**](https://en.wikipedia.org/wiki/Computer_terminal). The user types a command on the terminal's keyboard. The mainframe receives the command, executes it and sends the result back. The terminal prints out the received data on paper. Later on, a monitor replaced the printing device. As a result, [**command-line interface**](https://en.wikipedia.org/wiki/Command-line_interface) (CLI) appeared. It has the same work principle as a teletype. The user enters commands one by one. The computer executes the commands one by one and displays the results on the screen.

Figure 1-7 shows a modern command-line interface. There is the window of [**terminal emulator**](https://en.wikipedia.org/wiki/Terminal_emulator). It is called [Terminator](https://en.wikipedia.org/wiki/Terminator_(terminal_emulator)). The Bash command-line interpreter is running in this window. It displays the results of the ping and ls programs.

{caption: "Figure 1-7. Command-line interface", height: "50%"}
![Command-line interface](images/GeneralInformation/cli.png)

The command-line interface is still in demand today. It has several advantages over the graphical interface. The main advantage of the CLI is low requirements for computing resources. It runs reliably on low-performance embedded computers as well as on powerful servers. If you access a computer remotely via CLI, the communication channel's quality and bandwidth may be low. Even with a slow connection, the server will receive commands.

The command-line interface has disadvantages. Its main problem is the complexity of learning. There are hundreds of commands available to the user. They have different input parameters that define their working mode. It takes a lot of time to remember at least a minimum set of commands for daily work.

The problem of visual representation of available commands was solved by [**text-based user interface**](https://en.wikipedia.org/wiki/Text-based_user_interface) (TUI). It uses [**box-drawing characters**](https://en.wikipedia.org/wiki/Box-drawing_character) along with alphanumeric characters. The box-drawing characters display the graphic primitives on the screen. Primitives are lines, rectangles, triangles, etc. Figure 1-8 shows a typical text interface. There is an output of system resource usage by the htop program.

{caption: "Figure 1-8. Text-based user interface", height: "50%"}
![Text-based user interface](images/GeneralInformation/tui.png)

Further growth of computer performance allowed replacing box-drawing characters with real graphic elements. There are examples of such elements: windows, icons, buttons, etc. As a result, a full-fledged graphical interface appeared. Modern operating systems provide this kind of interface.

Figure 1-9 demonstrates the Windows GUI. There is a screenshot of the desktop. The desktop contains the windows of three applications: Explorer, Notepad and Calculator. They work simultaneously.

{caption: "Figure 1-9. Windows GUI"}
![Windows GUI](images/GeneralInformation/gui.png)

The first GUI was intended for a mini-computer [Xerox Alto](https://en.wikipedia.org/wiki/Xerox_Alto) (see Figure 1-10). The computer was developed in 1973 in the research center [Xerox PARC](https://en.wikipedia.org/wiki/PARC_(company)). However, the interface was not widespread until the 1980s. It required a lot of memory and high computer performance. At that time, such PCs were too expensive for ordinary users.

Apple produced the first PC with GUI in 1983. It was called Lisa.

{caption: "Figure 1-10. Mini-computer Xerox Alto", height: "50%"}
![Mini-computer Xerox Alto](images/GeneralInformation/xerox-alto.jpg)

#### Families of OSes

Today the market of personal computers is dominated by three [families of operating systems](https://en.wikipedia.org/wiki/Category:Operating_system_families):

* [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows)
* [Linux](https://en.wikipedia.org/wiki/Linux)
* [macOS](https://en.wikipedia.org/wiki/MacOS)

The term "family" means several OS versions that follow the same architectural solutions. Besides, most functions in these OS versions are implemented in the same way.

OS developers adhere to the same architecture. They do not offer something fundamentally new in the next versions of their product. Why?

Changes in modern operating systems are taking place, but gradually and slowly. The reason for this is [**backward compatibility**](https://en.wikipedia.org/wiki/Backward_compatibility). This compatibility means that newer OS versions repeat the features of older versions. These features are needed to run existing programs. At first glance, this seems to be an optional requirement. But it is a severe limitation for software development. Let us find out why it is.

Imagine that you wrote a program for Windows and sell it. Sometimes users find errors in the program. You fix them. From time to time, you add new features.

Now imagine that a new version of Windows has been released. Your program does not work on this version. Therefore, your users have two solutions: 

* Wait for the update of your program, which is compatible with the new Windows.

* Refuse to update Windows.

If users need your program for daily work, they refuse the Windows update.

Suppose that the new Windows is fundamentally different from the previous one. It means that you should rewrite your program completely. Count all the time you have already spent fixing bugs and adding new features. You should repeat all this work. You will most likely give up this idea and suggest users stay on the old Windows version.

There are many programs like yours. Their developers will come to the same solution as you. As a result, nobody will update to the new Windows version. This situation is the essence of the backward compatibility problem. Because of this problem, there are families of operating systems.

The impact of applications on OS development is great. For example, Windows and personal computers from IBM owe their success to a table processor [Lotus 1-2-3](https://en.wikipedia.org/wiki/Lotus_1-2-3). Lotus 1-2-3 has worked on IBM PC with Windows only. For the sake of Lotus 1-2-3, users bought both PC and OS. The popular application, which brings the platform to the broad market, is called [**killer application**](https://en.wikipedia.org/wiki/Killer_application).

The tabular processor [VisiCalc](https://en.wikipedia.org/wiki/VisiCalc) had a similar influence. It promoted the distribution of computers [Apple II](https://en.wikipedia.org/wiki/Apple_II_series). Similarly, the C, Fortran and Pascal languages' free compilers fuelled interest in Unix in university circles. There was the killer application behind each of the three dominating OSes today. Further distribution of these OSes happened thanks to the [network effect](https://en.wikipedia.org/wiki/Network_effect). Developers of new applications chose the software platform, which most users already had.

Let us return to the list of OS families. Windows and Linux are remarkable because they do not depend on hardware. It means that you can install them on any PC or laptop. macOS will run on Apple devices only. You would need the unofficial [modified version](https://en.wikipedia.org/wiki/Hackintosh) of macOS for installing it on different hardware.

Hardware compatibility is an example of an architectural solution. There are many such solutions. Together they define the features of each family.

OS defines the infrastructure for the programmer. It dictates the development tools. Examples of tools are IDE, compiler, build system. Also, the OS imposes architectural solutions for the applications. There is a culture of developing programs for a specific OS. It is an important point: you should develop applications differently for different OSes. Please take it into account when you design your programs.

Let's consider the different cultures of software development on the example of Windows and Linux.

#### Windows

Windows is [proprietary software](https://en.wikipedia.org/wiki/Proprietary_software). The source code of such software is closed. You will not be able to read and modify it. In other words, there is no legal way to know about proprietary software more than its documentation tells you.

If you want to install Windows on your computer, you should buy it from Microsoft. However, this OS is often pre-installed on new computers and notebooks. Therefore, its price is included in the final cost of the devices.

The target platform for Windows is relatively cheap PCs and notebooks. Many people can afford to buy such a device. Therefore, the market of potential users is huge. Microsoft tends to maintain a competitive edge in this market. The company is afraid that Windows analogs with the same features appear. So, Microsoft takes care of protecting its intellectual property. They do it in both technical and legal ways. For example, the user agreement prohibits you from exploring the internals of the OS.

Many applications have been written for the Windows OS family. Microsoft itself developed the first applications. There is a package of office applications [Microsoft Office](https://en.wikipedia.org/wiki/Microsoft_Office) and standard Windows applications. For third-party developers, they have become a standard to follow.

Microsoft followed the same principle when developing both the OS and applications for it. It is a secrecy principle: source codes are not available to users, data formats are undocumented, and third-party utilities do not have access to software features. These solutions protect Microsoft's intellectual property.