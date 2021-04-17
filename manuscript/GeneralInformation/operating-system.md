## Operating Systems

### History of OS Origin

Most of the computer users understand why [**operating system**](https://en.wikipedia.org/wiki/Operating_system) (OS) is needed. Before launching a new [**application**](https://en.wikipedia.org/wiki/Application_software), they usually check its system requirements. These requirements specify the [**hardware**](https://en.wikipedia.org/wiki/Computer_hardware) and operating system that a user needs to launch the application.

The system requirements bring us the idea that the OS is a software platform. The application requires this platform for correct working. But where did this requirement come from? Why can't you just buy a computer and launch the application without any OS?

Our questions seem meaningless at first blush. But let's consider them from the following point of view. Modern operating systems are multipurpose, and they offer users many features. Each specific user would not use most of these features. However, you cannot disable them. The OS utilizes the computer's resources intensively for maintaining its features. As a result, the user has much fewer computation resources for his applications. This overhead leads to the computer's slow work, hanging of the programs, and even rebooting the whole system.

Let's turn to history to find out the origins of operating systems. The first commercial OS was called [GM-NAA I/O](https://en.wikipedia.org/wiki/GM-NAA_I/O). It appeared for the computer [IBM 704](https://en.wikipedia.org/wiki/IBM_704) in 1956. All earlier computers have worked without any OS. Why didn't they need it?

The main reason for having an OS is high computational speed. For example, let's consider the first [**electromechanical computer**](https://en.wikipedia.org/wiki/Tabulating_machine#1890_census). [Herman Hollerith](https://en.wikipedia.org/wiki/Herman_Hollerith) constructed it in 1890. This computer was called a tabulator. It does not require an OS and a [program](https://en.wikipedia.org/wiki/Computer_program) in the modern sense. The tabulator performs a limited set of arithmetic operations only. Its hardware design defines this set of operations.

The tabulator loads input data for computation from [**punched cards**](https://en.wikipedia.org/wiki/Punched_card). These cards look like sheets of thick paper with punched holes. A human operator prepares these sheets manually and stacks them in special receivers. The sheets are threaded on the needles in the receivers. Then a short circuit happens in each punched hole. Each short circuit increases the mechanical counter, which is a rotating cylinder. The tabulator displays calculation results on dials that resemble watches.

Figure 1-1 shows the tabulator that Hermann Hollerith has constructed.

{caption: "Figure 1-1. Hollerith tabulating machine", height: "30%"}
![Hollerith tabulating machine](images/GeneralInformation/tabulating-machine.jpg)

By modern standards, the tabulator works very slowly. There are several reasons for this. The first one is you need a lot of manual work. At the beginning, you should prepare input data. There was no way to punch the cards automatically. Then you manually load punched cards into the receivers. Both operations require significant efforts and time.

The second reason for low computation speed is mechanical parts. The tabulator contains many of them: needles to read data, rotating cylinders as counters, dials to output the result. All these mechanics work slowly. It takes about one second to perform one elementary operation. No automation can accelerate these processes.

If you look at how the tabulator works, you find no place for OS there. OS just does not have any tasks to do on such a kind of computer.

Tabulators used rotating cylinders for performing calculations. The next generation of computers replaced the cylinders with [**relays**](https://en.wikipedia.org/wiki/Relay). A relay is a mechanical element that changes its state due to an electric current.

The German engineer [Konrad Zuse](https://en.wikipedia.org/wiki/Konrad_Zuse) designed one of [the first relay computers](https://en.wikipedia.org/wiki/Z2_(computer)) called Z2 in 1939. Then he improved this computer in 1941 and called it Z3. These machines perform a single elementary operation in milliseconds. They are much faster than tabulators. This performance gain happens thanks to applying relays instead of rotating cylinders.

The increased computation speed is the first feature of Zuse's computers. The second feature is the concept of a computer program. The idea of the universal machine, which follows the [**algorithm**](https://en.wikipedia.org/wiki/Algorithm) you choose, was fundamentally new at that time.

I> An algorithm is a finite sequence of instructions to perform a particular calculation or task.

Z3 computer uses two input devices in parallel for supporting programs. The first one is a receiver for punched cards that resembles the tabulator's receiver. It reads the program to execute from the card. The second input device is the keyboard. It allows the user to type input data for the program.

The computers with the feature of changing their algorithms became known as [**programmable**](https://en.wikipedia.org/wiki/General_purpose_computer) or **general-purpose**.

The invention of programmable computers was a milestone in the development of computer science. Until this moment, machines were able to perform highly specialized tasks only. The construction of these machines was too expensive and unprofitable. This was a reason why commercial investors did not join the projects to design new computers. Only governments invested money there. However, this situation has changed since programmable computers came.

The next step in computer design is the construction of the [**ENIAC**](https://en.wikipedia.org/wiki/ENIAC) (see Figure 1-2) computer in 1946 by [John Eckert](https://en.wikipedia.org/wiki/J._Presper_Eckert) and [John Mauchly](https://en.wikipedia.org/wiki/John_Mauchly). ENIAC uses a new type of element for performing computations. [**Vacuum tubes**](https://en.wikipedia.org/wiki/Vacuum_tube) replaced relays there. The tube is a purely electronic device. It does not have any mechanical component as the relay has. Therefore, when the electrical signal comes, the tube's reaction time is much faster than the relay one. This change increased ENIAC performance by order of magnitude comparing to relay-based machines. The new computer performs single elementary operation in 200 microseconds instead of milliseconds.

{caption: "Figure 1-2. ENIAC", height: "30%"}
![ENIAC](images/GeneralInformation/eniac.jpg)

Most computer engineers were skeptical about vacuum tubes in the 1940s. The tubes were known for their low reliability and high power consumption. Nobody believed that a tube-based machine could work at all. ENIAC contains around 18,000 vacuum tubes. They burn out often. However, the computer performed the calculations efficiently between the failures. ENIAC was the first successful case of applying vacuum tubes. This case convinced many engineers that such an approach works well.

ENIAC is a programmable computer. You can set its algorithm using a combination of switches and jumpers on the control panels. This task requires considerable time and simultaneous work of several people. Figure 1-3 shows one of the panels for programming ENIAC.

{caption: "Figure 1-3. ENIAC control panel", height: "30%"}
![ENIAC control panel](images/GeneralInformation/eniac-programming.jpg)

ENIAC uses punched cards for reading input data and to output results. This is the same approach as previous models of computers have used. The new feature of ENIAC was storing intermediate results on the cards.

When the ENIAC should calculate a complex task, it can come to a leak of computation resources. However, you can split the task into several subtasks. Then the computer can solve each subtask separately. Storing the intermediate results on the cards helps you to move data from one subtask to another while you reprogram the computer.

Using ENIAC gave a new experience to engineers. It shows that all mechanical operations limit computer performance. These are the mechanical operations in ENIAC: manual reprogramming with switches and jumpers, reading and punching the cards. Each of these operations takes a significant time. Therefore, solving practical tasks with ENIAC is ineffective. The computer itself had an unprecedented performance at that time. However, it was idling most of the time and waiting for reprogramming or receiving input data. These findings initiated the development of new devices for both data input and output.

The next step in computer design is replacing vacuum tubes with [**transistors**](https://en.wikipedia.org/wiki/Transistor). It again increased the computation speed by an order of magnitude. Transistors came together with new [**input/output**](https://en.wikipedia.org/wiki/Input/output) devices. It allowed to increase the loading of the computers and reprogram them more often.

When the epoch of transistors started, computers spread beyond government and military projects. Banks and corporations began to exploit machines too. It increases the number and variety of programs running on computers significantly.

Commercial usage of computers brings new requirements. When the computer works in a company, it should execute programs one after another without any delays. Otherwise, the machine does not justify the money spent on it.

New solutions were needed to meet new requirements. The most time-consuming task was switching between programs. Therefore, engineers of General Motors and North American Aviation came to an idea to automate it. They created the first commercial operating system [**GM-NAA I/O**](https://en.wikipedia.org/wiki/GM-NAA_I/O). The primary goal of the system was managing the execution of programs.

The heavy load of computers and the variety of their programs brought another new task. When the computer of that time loads a program, the program defines the hardware's available features. For example, if the program includes a code to control an output device, you can use it. Otherwise, this device is unavailable.

Suppose that you are a company. You use a particular computer model all the time. The hardware always stays the same. Therefore, you do not change the code that controls your hardware. You just copy this code from one program to another. It takes extra efforts.

Copying hardware-specific code brought engineers to an idea of a special service program. The service program loads together with the user's application and provides the hardware support. These service programs became part of the first-generation operating systems after a while.

Now it is time to come back to the question, why do you need an OS. We found out that applications could work without them in general. Such applications are still in use today. For example, they are [**utilities**](https://en.wikipedia.org/wiki/Utility_software) for memory checks and disk partitioning, antiviruses, recovery tools. However, developing such applications takes more time and efforts. They should include the code for supporting all required hardware.

OS usually provides the code for supporting hardware. Why would you not use it? Most modern developers choose this way. It reduces the amount of work and speeds up the release of the applications.

However, a modern OS is a vast complex system. It provides much more features than just hardware support. Let's consider them too.

### OS Features

Why did we start studying programming by considering the OS? OS features are the basis for the application. Let's consider how it works.

Figure 1-4 demonstrates the interaction between the OS, an application and hardware. Applications are programs that solve practical user tasks. Examples are text editor, calculator, browser. Hardware is all electronic and mechanical components of a computer. For example, these are keyboard, monitor, central processor, video card.

{caption: "Figure 1-4. The interaction between the OS, an application and hardware", height: "50%"}
![Interaction Scheme](images/GeneralInformation/operating-system.png)

According to Figure 1-4, the application does not interact with hardware directly. The program does it through [**system libraries**](https://en.wikipedia.org/wiki/Library_(computing)). The system libraries are part of the OS. There are rules to access the system libraries. Each application should follow them.

[**Application Programming Interface**](https://en.wikipedia.org/wiki/API) or API is the interface that the OS provides to an application to interact with system libraries. In general, the API term means a set of agreements for interacting components of the information system. These agreements become a well-known standard often. For example, the POSIX standard describes the API for portable OSes. The standard guarantees the compatibility of the OS and applications.

OS [**kernel**](https://en.wikipedia.org/wiki/Kernel_(operating_system)) and [**device drivers**](https://en.wikipedia.org/wiki/Device_driver) are part of OS. They dictate which hardware features the application can access. When the application interacts with system libraries, the libraries request capabilities of kernel and drivers. If you need the hardware feature and OS does not support it, you cannot use it.

When the application accesses the system library, it calls a library's [**function**](https://en.wikipedia.org/wiki/Subroutine). A function is a program fragment or an independent block of code that performs a certain task. You can imagine the API as a list of all available functions that the application can call. Besides that, API describes the following aspects of the interaction between the OS and applications:

1. What action does the OS perform when the application calls the specific system function?

2. What data does the function receive as input?

3. What data does the function return as a result?

Both the OS and application should follow the API agreements. It guarantees the compatibility of their current versions and future modifications. Such compatibility is impossible without a well-documented and standardized interface.

We have discovered that some applications work without an OS. They are called [bare-metal software](https://www.quora.com/What-is-bare-metal-programming-in-Embedded-systems). This approach works well in some cases. However, the OS provides ready-made solutions for interaction with the computer's hardware. Without these solutions, developers should take responsibility for managing hardware. It requires significant efforts. Imagine the variety of devices of a modern computer. The application should support all popular models of each device (for example, video cards). Without such support, the application would not work for all users.

Let's consider the features that the OS provides via the API. We can treat the computer's hardware as resources. The application uses these resources for performing calculations. The API reflects the list of hardware features that the program can use. Also, the API dictates the order of interaction between several applications and the hardware.

There is an example. Two programs cannot write data to the same area of the [hard disk](https://en.wikipedia.org/wiki/Hard_disk_drive#Magnetic_recording) simultaneously. There are two reasons for that:

1. A single magnetic head records data on the hard disk. The head can do one task at a time.

2. One program can overwrite data of another program in the same memory area. It leads to losing data.

You should place all requests to write data on the disk in a queue because of these two problems. Then each request should be performed separately. The OS takes care of this task.

The kernel (see Figure 1-4) of the OS provides a mechanism for managing access to the hard drive. This mechanism is called [**file system**](https://en.wikipedia.org/wiki/File_system). Similarly, the OS manages access to all [**peripheral**](https://en.wikipedia.org/wiki/Peripheral) and internal devices of the computer. Besides kernel, there are special programs called device drivers (see Figure 1-4). They help the OS to control devices.

We have mentioned peripheral and internal devices. What is the difference between them? Peripherals are all devices that are responsible for inputting, outputting, and storing data permanently. Here are the examples:

* Keyboard
* Mouse
* Microphone
* Monitor
* Speakers
* Hard drive

Internal devices are responsible for processing data, i.e. for executing programs. These are internal devices:

* [**Central Processing Unit**](https://en.wikipedia.org/wiki/Central_processing_unit) (CPU)
* [**Random-Access Memory**](https://en.wikipedia.org/wiki/Random-access_memory) (RAM)
* [**Video Card**](https://en.wikipedia.org/wiki/Video_card) (graphics processing unit or GPU).

The OS provides access to the computer's hardware. At the same time, the OS has something besides the hardware management to share with user's applications. The system libraries have grown from the program modules to serve the devices. However, some libraries of modern OSes provide complex algorithms for processing data. Let's consider an example.

There is the Windows OS component called [**Graphics Device Interface**](https://en.wikipedia.org/wiki/Graphics_Device_Interface) (GDI). It provides algorithms for manipulating graphic objects. GDI allows you to create a user interface for your application with minimal efforts. Then you can use the monitor to display this interface.

The system libraries with useful algorithms (like GDI) are software resources of the OS. These resources are already installed on your computer. You just need to know how to use them. Besides that, the OS also provides access to third-party libraries and their algorithms. You can install these libraries separately and use them in your applications.

The OS manages hardware and software resources. Also, it organizes the joint work of running programs. The OS performs several non-trivial tasks to launch an application. Then the OS tracks its work. If the application violates some agreements (like memory usage), the OS terminates it. We will consider launching and executing the program in detail in the next section.

If the OS is multi-user, it controls access to the data. It is an important security feature. Thanks to such control, each user can access his own files only. Therefore, they can work with the same computer safely.

Here is the summary. The modern OS has all following features:

1. It provides and manages access to hardware resources of the computer.

2. It provides its own software resources.

3. It launches applications.

4. It organizes the interaction of applications with each other.

5. It controls access to users' data.

You can guess that it is impossible to launch several applications in parallel without the OS. You are right. When you develop an application, you have no idea how a user will launch it. The user can launch your application together with another one. You cannot foresee this use case. However, the OS responds for launching all applications. It means that the OS has enough information to allocate computer resources properly.

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

Modern operating systems solve different tasks. These tasks depend on the type of computer where the OS is running. Here are the main types of computers:

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

The first GUI was intended for a minicomputer [Xerox Alto](https://en.wikipedia.org/wiki/Xerox_Alto) (see Figure 1-10). The computer was developed in 1973 in the research center [Xerox PARC](https://en.wikipedia.org/wiki/PARC_(company)). However, the interface was not widespread until the 1980s. It required a lot of memory and high computer performance. At that time, such PCs were too expensive for ordinary users.

Apple produced the first PC with GUI in 1983. It was called Lisa.

{caption: "Figure 1-10. Minicomputer Xerox Alto", height: "50%"}
![Minicomputer Xerox Alto](images/GeneralInformation/xerox-alto.jpg)

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

Software developers have followed the example of Microsoft. They stuck with the same philosophy of secrecy. As a result, their applications were self-contained and independent of each other. The formats of their data are encoded and undocumented.

If you are an experienced computer user, you immediately recognize a typical Windows application. There is a window with [control elements](https://en.wikipedia.org/wiki/Graphical_widget) like buttons, input fields, tabs, etc. In this window, the user manipulates the data. Examples of data are text, image or sound record. The result of the work is saved on the hard disk. You can open it again in the same application. If you write your own Windows program, it will look and work similarly. This succession of solutions is called the development culture.

#### Linux

Linux has borrowed ideas and solutions from the [Unix](https://en.wikipedia.org/wiki/Unix). Both OSes follow the set of standards that is called [POSIX](https://en.wikipedia.org/wiki/POSIX) (Portable Operating System Interface). POSIX defines interfaces between applications and the operating system. Following Linux and Unix to the same standard led to their similar behavior.

The Unix appeared in the late 1960s. It was created by two engineers from the Bell Labs company. The OS was a hobby project of [Ken Thompson](https://en.wikipedia.org/wiki/Ken_Thompson) and [Dennis Ritchie](https://en.wikipedia.org/wiki/Dennis_Ritchie). In their daily work, they developed the OS [**Multics**](https://en.wikipedia.org/wiki/Multics). It was a joint project of the Massachusetts Institute of Technology (MIT), General Electric (GE) and Bell Labs. Multics was planned as an OS for the new mainframe GE-645 (see Figure 1-11) by General Electric.

{caption: "Figure 1-11. Mainframe GE-645", height: "30%"}
![Mainframe GE-645](images/GeneralInformation/ge-645.jpg)

In Multics, the developers have applied several innovative solutions. One of them is time-sharing. Therefore, the mainframe GE-645 was the first commercial computer where several users could work simultaneously. In this case, multitasking responds for sharing resources among the users.

Multics turned out to be too complicated. The project consumed more time and money than it was initially planned. That is why Bell Labs decided to leave the project. But the project was interesting from the technical point of view. Therefore, many Bell Labs engineers wanted to continue working on it. Ken Thompson was one of them. He decided to create his own operating system for the computer GE-645. Ken started to write the system kernel and duplicated some Multics mechanisms. However, General Electric soon demanded the return of its GE-645. Bell Labs received the computer on loan only. As a result, Ken Thompson lost a hardware platform for his development.

In parallel with his work on the Multics analog, Ken wrote a computer game [Space Travel](https://en.wikipedia.org/wiki/Space_Travel_(video_game)). The game worked on the past generation mainframe GE-635 from General Electric. This computer had the [GECOS](https://en.wikipedia.org/wiki/General_Comprehensive_Operating_System) OS. GE-635 consisted of several modules. Each module was a cabinet with electronics. The overall mainframe cost was about 7 500 000$. Bell Labs engineers actively used this computer. Therefore, Ken was rarely able to work with it.

Ken decided to port his game to a relatively inexpensive and rarely used minicomputer [PDP-7](https://en.wikipedia.org/wiki/PDP-7) (see Figure 1-12). It cost about 72 000$. But there was one problem. Space Travel used the features of the GECOS OS. PDP-7 did not provide such features. Ken was joined by his colleague Dennis Ritchie. They implemented GECOS features for PDP-7. It was a set of libraries and subsystems. Over time, they developed into a self-sufficient OS. It was called Unix.

{caption: "Figure 1-12. Minicomputer PDP-7", height: "30%"}
![Minicomputer PDP-7](images/GeneralInformation/pdp-7.jpg)

Ken and Dennis were not going to sell their software. Therefore, there was never a goal to protect intellectual property. They wrote Unix for their own needs and distributed it in open source. Everyone could copy and use the OS. Initially, the active Unix users were Bell Labs employees only.

Bell Labs belonged to AT&T company. After some time, AT&T provided Unix source code to US universities. Thus, university circles continued the development of the OS.

[Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds) created the Linux OS in 1991. At that time, he was studying at the University of Helsinki. Linus solved a practical problem. He needed a Unix-compatible OS for PC. Such OS was not available at that moment.

At the University of Helsinki, students performed study assignments on a MicroVAX minicomputer running Unix. At home, they had PCs. But the Unix was not running on such computers. There was a Unix alternative for PCs. There is [Minix](https://en.wikipedia.org/wiki/MINIX) OS. It was developed by Andrew Tanenbaum in 1987 for IBM PCs with Intel 80268 processors. He created Minix for educational purposes only. So Andrew refused to apply changes to his OS for supporting modern PCs. The complexity of the system was a reason for this decision. If the system becomes too complicated, it is unsuitable for teaching students.

Linus had a goal to write a Unix-compatible OS for his new IBM computer with Intel 80386 processor. The prototype of this OS became Minix. Like the Unix creators, Linus had no commercial interests and was not going to sell his software. He developed the OS for his own needs and wanted to share it with everyone. Linux OS became free in this way. It was freely distributed with source code via the Internet.

Linux is just the kernel of OS. It provides memory management, file system, peripherals drivers and processor time scheduler. The general features of the system are available through free [GNU software](https://en.wikipedia.org/wiki/GNU_Project). [Richard Stallman](https://en.wikipedia.org/wiki/Richard_Stallman) has developed this software at MIT. It was also distributed for free. Therefore, Linus included GNU software in his first [Linux distribution](https://en.wikipedia.org/wiki/Linux_distribution).

The first versions of Linux did not have a graphical subsystem. The user should launch all applications from the command-line. Only some complex applications had a text interface. With time, Linux got a windowing system. It was called [X Window System](https://en.wikipedia.org/wiki/X_Window_System). Using X Window, the developers started to add a graphical interface to their applications.

The application development culture for Unix and Linux was defined by conditions in which these OSes have evolved. Both systems were developed in university circles. Their users were teachers and students of the IT domain. They understood well how the OS works. So, they fixed software errors willingly.

In Unix culture, users prefer to use highly specialized command-line utilities. Each specific task has its own utility to solve. Such programs are well written, tested many times and worked as efficiently as possible.

If you need to solve a complex task, one specialized utility cannot cope with it. But you can combine several utilities. This way, you solve the task quickly and efficiently. For better interaction, the utilities accept the input data and output the results in an open format. As a rule, this is [text data](https://en.wikipedia.org/wiki/Plain_text). The source code of the utilities is always available for study and correction.

The Linux development culture follows the Unix tradition. It is different from the standards that are adopted in Windows. In Windows, every application is monolithic and performs all its tasks by itself. It does not rely on third-party utilities. They may cost money or unavailable to the user. Thus, each developer relies on himself only. He should not force the user to buy something extra to make the application working. However, the situation differs on Linux. Most of the utilities are free, interchangeable and easily accessible via the Internet. Therefore, it is natural that one application requires to download and install a missing system component or another application.

The interaction of programs is crucial in Linux. Even monolithic graphical Linux-applications usually provide a command-line interface. This way, they fit smoothly into the ecosystem. So, you can integrate them easily with other utilities and applications.

When using Linux, the user assembles a complex computing process from a combination of highly specialized programs. He should create a general computation algorithm if he wants to get an effective solution. The [shell](https://en.wikipedia.org/wiki/Unix_shell) solves exactly this task. It is a special application for typing user commands. The first widespread shell was [Bourne shell](https://en.wikipedia.org/wiki/Bourne_shell). Now it is deprecated and substituted by [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) in most Linux distributions. In this book, we will consider Bash only.

You cannot give a preference to the Linux or Windows culture. Comparing them causes endless disputes on the Internet. Each culture has its advantages and disadvantages. For example, the Window-style monolithic applications are better to handle tasks that require intensive calculations. When combining specialized Linux utilities for the same task, there is an overhead. It is caused by launching the utilities and transferring data between them. All this requires extra time. As a result, the task takes longer to complete.

Today, Windows and Linux cultures are synthesized. More and more commercial applications are being ported to Linux: browsers, development tools, games, messengers, etc. However, their developers are not ready to make changes that are dictated by the Linux culture. Such changes take time and effort. They also make it more challenging to maintain the product. Instead of one application, there are two: each platform has a different version. It is much easier to port an application as it is already running on Windows. As a result, you will find more and more Windows-style applications on Linux. One can argue about the pros and cons of this process. But one thing is obvious: the more applications run on an OS, the more popular it becomes thanks to the network effect.

I> Read more about the development culture in Unix and Linux in Eric Raymond's book ["The Art of Programming in Unix"](https://en.wikipedia.org/wiki/Unix_philosophy#Eric_Raymond's_17_Unix_Rules).
