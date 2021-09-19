## Operating Systems

### History of OS Origin

Most computer users understand why an [**operating system**](https://en.wikipedia.org/wiki/Operating_system) (OS) is needed. Before launching a new [**application**](https://en.wikipedia.org/wiki/Application_software), you usually check its system requirements. These requirements specify the [**hardware**](https://en.wikipedia.org/wiki/Computer_hardware) and OS that you need to launch the application.

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

Tabulators used rotating cylinders for performing calculations. The next generation of computers replaced the cylinders with [**relays**](https://en.wikipedia.org/wiki/Relay). A relay is a electromechanical element that changes its state due to an electric current.

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

[**Application Programming Interface**](https://en.wikipedia.org/wiki/API) or API is the interface that the OS provides to an application to interact with system libraries. In general, the API term means a set of agreements for interacting components of the information system. These agreements become a well-known standard often. For example, the POSIX standard describes the portable API for a family of OSes. The standard guarantees the compatibility of the OS and applications.

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

The kernel (see Figure 1-4) of the OS provides a mechanism for managing access to the hard drive. This mechanism is called [**file system**](https://en.wikipedia.org/wiki/File_system). Similarly, the OS manages access to all [**peripheral**](https://en.wikipedia.org/wiki/Peripheral) and internal devices of the computer. Device drivers provide access to the hardware for OS and applications.

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

If the OS is multi-user, it controls access to the data. It is an important security feature. This feature allows the user to access the following file system objects:

* Files and directories that the user owns.
* Files and directories that somebody has shared with the user.

It allows several persons to use the same computer safely.

Here is the summary. The modern OS has all following features:

1. It provides and manages access to hardware resources of the computer.

2. It provides its own software resources.

3. It launches applications.

4. It organizes the interaction of applications with each other.

5. It controls access to users' data.

You can guess that it is impossible to launch several applications in parallel without the OS. You are right. When you develop an application, you have no idea how a user will launch it. The user can launch your application together with another one. You cannot foresee this use case. However, the OS responds for launching all applications. It means that the OS has enough information to allocate computer resources properly.

### Modern OSes

We have reviewed the OS features in general. Now we will consider modern operating systems. Today you can pick any OS and get very similar features. However, their developers follow different approaches. This leads to implementation difference that can be important for some users.

There is the [**software architecture**](https://en.wikipedia.org/wiki/Software_architecture) term. It means the implementation aspects of the specific software and the solutions that led to them.

All modern OSes have two features that determine the way how users interact with them. These features are multitasking and the graphical user interface. Let's take a closer look at them.

#### Multitasking

All modern OSes support [**multitasking**](https://en.wikipedia.org/wiki/Computer_multitasking). It means that they can execute multiple programs in parallel. The systems with this feature displaced OSes without it. Why does multitasking so important?

The challenge of efficient usage of computers came in the 1960s. Computers were expensive at that time. Only large companies and universities were able to buy them. These organizations counted every minute of working with their machines. They did not accept any idle time of the hardware because of its huge cost.

Early operating systems executed programs one after another without delays. This approach saves time for switching computer tasks. If you use such an OS, you should prepare several programs and their input data in advance. Then you should write them on the storage device (e.g., magnetic tape). You load the tape to the computer's reading device. Afterward, the computer executes the programs sequentially and prints their results to an output device (e.g., a printer). This mode of operation is called [**batch processing**](https://en.wikipedia.org/wiki/Batch_processing).

Batch processing increased the efficiency of using computers in the 1960s. This approach has automated program loading. The human operators became unnecessary for this task. However, the computers still had the [**bottleneck**](https://en.wikipedia.org/wiki/Bottleneck_(production)). The computational power of processors was increasing significantly every year. The speed of peripherals has remained almost the same. It led to CPU idles all the time while waiting for input/output.

I> A bottleneck is a component or resource of an information system that limits its overall performance or bandwidth.

Why does CPU idle and wait for peripheral devices? Here is an example. Suppose that the computer from the 1960s runs programs one by one. It reads data from a magnetic tape and prints the results on the printer. The OS loads each program and executes its instructions. Then it loads the next one, and so on.

The problem happens when reading data and printing the results. The time for reading data on the magnetic tape is huge on the CPU scale. This time is enough for the processor to perform many calculations. However, it does not do that. The reason for that is the currently loaded program occupies all computer resources. The same CPU idle happens when printing the results. The printer is a slow electromechanical device.

The CPU idle led OS developers to the concept of [**multiprogramming**](https://en.wikipedia.org/wiki/Computer_multitasking#Multiprogramming). This concept implies that OS loads several programs into the computer memory at the same time. The first program works as long as all resources it needs are available. It stops executing once a required resource is busy. Then OS switches to another program.

Here is an example. Suppose that your application wants to read data from your hard disk. While the disk controller reads the data, it is busy. It cannot process the following requests from the program. Thus, the application waits for the controller. In this case, OS stops executing it and switches to the second program. The computer executes it to the end or until it has all the required resources. When the second program finishes or stops, OS switches tasks again.

Multiprogramming differs from multitasking that modern OSes have. Multiprogramming fits the batch processing mode very well. However, this load balancing concept is not suitable for [**interactive systems**](https://en.wikipedia.org/wiki/Interactivity#Computing_science). An interactive system considers each user action as an event (for example, a keystroke). The system should process events immediately when they happen. Otherwise, the user cannot work with the system.

Here is an example of workflow with an interactive system. Suppose that you are typing text in the MS Office document. You press a key and expect to see this symbol on the screen. If the computer requires several seconds to process your keystroke and display the symbol, you cannot work like that. Most of the time, you will wait and check if the computer has processed your keystroke or not. This is inefficient.

Multiprogramming cannot handle events in the interactive system. It happens because you cannot predict when task switching happens next time. OS switches tasks when a program finishes or when it requires a busy resource. Suppose that your text editor is not an active program now. Then you do not know when it can process your keystroke. It can happen in a second or in several minutes. This is unacceptable for a good user interface.

The multitasking concept solves the task of processing events in interactive systems. There were several versions of multitasking before it comes to the current state. Modern OSes use [**displacing multitasking**](https://en.wikipedia.org/wiki/Preemption_(computing)) with pseudo-parallel tasks processing. The idea behind it is to allow the OS to choose an appropriate task for executing at the moment. The OS takes into account the priorities of the running programs. Therefore, a higher priority program receives hardware resources more often than a lower priority one. OS kernel provides this task-switching mechanism. It is called [**task scheduler**](https://en.wikipedia.org/wiki/Scheduling_(computing)).

Pseudo-parallel processing means that the computer executes one task only at any given time. The OS switches tasks so quickly that you can suppose the processing of several programs at once. This concept allows the OS to react immediately to any event. Even though every program and OS component uses hardware resources at strictly defined moments.

There are computers with multiple processors or with [multi-core processors](https://en.wikipedia.org/wiki/Multi-core_processor). Only these computers can execute several programs at once. The number of the running programs equals the number of cores of all processors approximately. The preemptive multitasking mechanism with constant task switching works on such systems well. It is a universal approach that balances the load regardless of the number of cores. This way, the computer responds to the user's actions quickly. The number of processor cores does not matter.

#### User Interface

Modern OSes are able to solve a wide range of tasks. These tasks depend on the computer type where you run the OS. Here are the main types of computers:

* [Personal computers](https://en.wikipedia.org/wiki/Personal_computer) (PC) and notebooks.
* Smartphones and tablets.
* Servers.
* [Embedded systems](https://en.wikipedia.org/wiki/Embedded_system).

We will consider OSes for PCs and notebooks only. Apart from multitasking, they provide [**graphic user interface**](https://en.wikipedia.org/wiki/Graphical_user_interface) (GUI). This interface means the way to interact with the system. You launch applications, configure computer devices and OS components via the user interface. Let's take a look at its history and find how it has reached the current state.

Nobody works with commercial computers interactively before 1960. [Digital Equipment Corporation](https://en.wikipedia.org/wiki/Digital_Equipment_Corporation) implemented the interactive mode for their [minicomputer](https://en.wikipedia.org/wiki/Minicomputer) [PDP-1](https://en.wikipedia.org/wiki/PDP-1) in 1959. It was a fundamentally new approach. Before that, IBM computers dominated the market in the 1950s. They worked in batch processing mode only. This mode automated program loading and provided high performance for calculation tasks.

The idea of interactive work with the computer appeared first in the SAGE military project. The US Air Force was its customer. The goal of the project was to develop an automated air defense system to detect Soviet bombers.

When working on the SAGE project, engineers faced the problem. The user of the system should analyze data from radars in real-time. If he detects a threat, he should react as quickly as possible and command to intercept the bombers. However, the existed methods of interaction with the computer did not fit this task. They did not allow showing information to the user in real-time and receive his input at any moment.

Engineers came to the idea of the interactive mode. They implemented it in the first interactive computer [AN/FSQ-7](https://en.wikipedia.org/wiki/AN/FSQ-7_Combat_Direction_Central) in 1955 (see Figure 1-5). The computer used the monitor with a [**cathode-ray tube**](https://en.wikipedia.org/wiki/Cathode-ray_tube) to display information from radars. The [**light pen**](https://en.wikipedia.org/wiki/Light_pen) allowed the user to command the system.

{caption: "Figure 1-5. Computer AN/FSQ-7"}
![Computer AN/FSQ-7](images/GeneralInformation/AN-FSQ-7.jpg)

The new way of interaction with computers became known in scientific circles. It gained popularity quickly. The existing batch processing mode coped with program execution well. However, this mode was inconvenient for development and [**debugging**](https://en.wikipedia.org/wiki/Debugging) applications.

I> Debugging a program is searching and eliminating its errors.

Suppose that you are writing a program for the computer with batch processing. You should prepare your code and write it to the storage device. When the device is ready, you put it in a queue. The computer's operator takes devices from the queue and loads them to the computer one by one. Therefore, your task can wait in the queue for several hours. Now assume that an error happened in your program. In this case, you should fix it, prepare the new version of the program and write it to the device. You put it in the queue again and wait for hours. Because of this workflow, you need several days to make even a small program working.

The software development workflow differs when you use an interactive mode. You prepare your program and load it to the computer. Then it launches the program and shows you results. Immediately, you can analyze a possible error, fix it and relaunch the program. This workflow accelerates software development and debugging tasks significantly.  Now you spend few hours on the task that requires days with batch processing mode.

The interactive mode brought new challenges for computer engineers. This mode requires a system that reacts to user actions immediately. A short reaction time required a new load-balancing mechanism. The multitasking concept became a solution for this issue.

There are alternative solutions for providing interactive mode. For example, there are interactive single-tasking OSes like [MS-DOS](https://en.wikipedia.org/wiki/MS-DOS). MS-DOS was the system for cheap PCs of the 1980s.

However, it was inadvisable to apply single-tasking in the 1960s when computers were too expensive. These computers executed many programs in parallel. Such a mode was called [**time-sharing**](https://en.wikipedia.org/wiki/Time-sharing). It allows sharing expensive hardware resources among several users. The single-tasking approach does not fit such a use case because it is not compatible with time-sharing.

When the first relatively cheap personal computers appeared in the 1980s, they used single-tasking OSes. Such systems require fewer hardware resources than their analogs with multitasking. Despite its simplicity, single-tasking OSes support interactive mode for the running program. This mode became especially attractive for PC users.

When interactive mode became more and more popular, computer engineers meet a new challenge. The existing devices for interacting with computers turned out to be inconvenient. Magnetic tapes and printers were widespread through the 1950s and early 1960s. They did not fit interactive mode absolutely.

[**Teletype**](https://en.wikipedia.org/wiki/Teleprinter) (TTY) became a prototype of a device for interactive work with a computer. The original idea behind this device was to connect two of them via wires. It allows users on both sides to send each other text messages. One user types the message on the keyboard. Then his device transmits the keystrokes to the receiver. When the teletype on the other side receives data, it prints the text on paper.

Figure 1-6 shows the Model 33 teletype. It was one of the most popular devices in the 1960s.

{caption: "Figure 1-6. A Teletype Model 33", height: "50%"}
![Teletype Model 33](images/GeneralInformation/teletype.jpg)

Computer engineers connected the teletype to the computer. This solution allowed the user to send text commands to the machine and receive results. Such a workflow became known as a [**command-line interface**](https://en.wikipedia.org/wiki/Command-line_interface) (CLI).

Teletype uses the printer as an output device. It works very slow and requires around 10 seconds to print a single line. The next step of developing the user interface was replacing the printer with the monitor. This increased the data output speed several times. The new device with a keyboard and monitor was called the [**terminal**](https://en.wikipedia.org/wiki/Computer_terminal). It replaced teletypes in the 1970s.

Figure 1-7 shows a modern command-line interface. You can see the [**terminal emulator**](https://en.wikipedia.org/wiki/Terminal_emulator) application there. This application emulates the terminal device for the sake of compatibility. It allows you to run programs that work with the real terminal only. The emulator application in Figure 1-7 is called [Terminator](https://en.wikipedia.org/wiki/Terminator_(terminal_emulator)). The Bash command-line interpreter is running in the Terminator window. The window displays the results of the ping and ls programs.

{caption: "Figure 1-7. Command-line interface", height: "50%"}
![Command-line interface](images/GeneralInformation/cli.png)

The command-line interface is still in demand today. It has several advantages over the graphical interface. For example, CLI does not require as many resources as GUI. CLI runs reliably on low-performance embedded computers as well as on powerful servers. If you use CLI to access the computer remotely, you can use a low bandwidth communication channel. The server will receive your commands in this case.

The command-line interface has some disadvantages. Learning to use CLI effectively is hard and takes time. You have to remember around a hundred commands. Each command has several modes that change its behavior. Therefore, you should keep in mind these modes too. It takes some time to remember at least a minimum set of commands for daily work.

There is an option to make the command-line interface more user-friendly. You can give a hint to the user about available commands. It was done in the [**text-based interface**](https://en.wikipedia.org/wiki/Text-based_user_interface) (TUI). The interface uses [**box-drawing characters**](https://en.wikipedia.org/wiki/Box-drawing_character) along with alphanumeric symbols. The box-drawing characters display the graphic primitives on the screen. Primitives are lines, rectangles, triangles, etc. They guide the user about the available actions he can do with the application.

Figure 1-8 shows a typical text-based interface. There is an output of system resource usage by the htop program.

{caption: "Figure 1-8. Text-based user interface", height: "50%"}
![Text-based user interface](images/GeneralInformation/tui.png)

The further performance gain of computers allowed OS developers to replace box-drawing characters with real graphic elements. There are examples of such elements: windows, icons, buttons, etc. It was a moment when the full-fledged graphical interface came. Modern OSes provide this kind of interface.

The first GUI appeared in the [Xerox Alto](https://en.wikipedia.org/wiki/Xerox_Alto) minicomputer (see Figure 1-10). It was developed in the research center [Xerox PARC](https://en.wikipedia.org/wiki/PARC_(company)) in 1973. However, the graphical interface did not spread widely until the 1980s. It happens because GUI requires a lot of memory and high computer performance. PCs with such features were too expensive for ordinary users at that time.

Apple produced the first relatively cheap PC with GUI in 1983. It was called Lisa.

{caption: "Figure 1-10. Minicomputer Xerox Alto", height: "50%"}
![Minicomputer Xerox Alto](images/GeneralInformation/xerox-alto.jpg)

Figure 1-9 demonstrates the Windows GUI. You can see the desktop. There are windows of three applications there. The applications are Explorer, Notepad and Calculator. They work in parallel.

{caption: "Figure 1-9. Windows GUI"}
![Windows GUI](images/GeneralInformation/gui.png)

#### Families of OSes

There are three [families of OSes](https://en.wikipedia.org/wiki/Category:Operating_system_families) that dominate the market today. Here are these families:

* [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows)
* [Linux](https://en.wikipedia.org/wiki/Linux)
* [macOS](https://en.wikipedia.org/wiki/MacOS)

The term "family" means several OS versions that follow the same architectural solutions. Therefore, most functions in these versions are implemented in the same way.

The developers of the OS family follow the same architecture. They do not offer something fundamentally new in the upcoming versions of their product. Why?

Actually, changes in modern OSes happen gradually and slowly. The reason for this is a [**backward compatibility**](https://en.wikipedia.org/wiki/Backward_compatibility) problem. This compatibility means that newer OS versions provide the features of older versions. Most existing programs require these features for their work. You can suppose that backward compatibility is an optional requirement. However, it is a severe limitation for software development. Let's find out why it is.

Imagine that you wrote a program for Windows and sell it. Sometimes users meet errors in the program. You receive bug reports and fix them. Also, you add new features from time to time.

Your business goes well until the new Windows version comes. Let's assume that Microsoft has changed its architecture completely. Therefore, your program does not work on the new OS version. This leads users of your program to the following choice:

* Update Windows and wait for the new version of your program that works there.

* Do not update Windows and continue to use your program.

If users need your program for daily work, they refuse the Windows update. Using the program is more important than getting new OS features.

We know that Microsoft has changed the Windows architecture completely. It means that you should rewrite your program from scratch. Now count all the time that you have spent fixing bugs and adding new features. You should repeat all this work as soon as possible. Most likely, you will give up this idea. Then your users should stay with the old Windows version.

Windows is a very popular and widespread OS. It means that there are many programs like yours. Their developers will come to the same decision as you. As a result, nobody updates to the new Windows version. This situation demonstrates the backward compatibility problem. This problem forces OS developers to be careful with changing their products. The best solution for them is to make a family of similar OSes.

There is a significant influence of user applications on OS development. For example, Windows and IBM computers owe their success to a table processor [Lotus 1-2-3](https://en.wikipedia.org/wiki/Lotus_1-2-3). You need both IBM PC and Windows to lunch Lotus 1-2-3. For the sake of Lotus 1-2-3, users bought both the computer and OS. The specific combination of the hardware and software is called the [**computing platform**](https://en.wikipedia.org/wiki/Computing_platform). The popular application, which brings the platform to the broad market, is called [**killer application**](https://en.wikipedia.org/wiki/Killer_application).

The tabular processor [VisiCalc](https://en.wikipedia.org/wiki/VisiCalc) was another killer application. It promoted the distribution of the [Apple II](https://en.wikipedia.org/wiki/Apple_II_series) computers. In the same way, free compilers for C, Fortran and Pascal languages help Unix OS to become popular in university circles.

There was the killer application behind each of the modern OS families. This application gave these OSes the initial success. Further distribution of the OS happened thanks to the [network effect](https://en.wikipedia.org/wiki/Network_effect). This effect means that developers tend to choose the most widespread computing platforms for their new applications.

What are the differences between the OS families? Windows and Linux are remarkable because they do not depend on the hardware. It means that you can install them on any modern PC or laptop. macOS runs on Apple computers only. If you want to use macOS on different hardware, you would need the unofficial [modified version](https://en.wikipedia.org/wiki/Hackintosh) of OS.

Hardware compatibility is an example of the design decision of the OS development. There are many such decisions. Together they define the features and design of each OS family.

There is one more important point for software development besides the OS design. OS dictates the infrastructure for the programmer. The infrastructure means development tools. Examples of these tools are IDE, compiler, build system. Tools together with OS API impose some design decisions for the applications. It leads to a specific culture for program development. Please keep in mind that you should develop applications differently for each OS. Take it into account when you design your programs.

Let's consider the origins of software development cultures for Windows and Linux.

#### Windows

Windows is [proprietary software](https://en.wikipedia.org/wiki/Proprietary_software). The source code of such software is unavailable for users. You cannot read or modify it as you want. In other words, there is no legal way to know about proprietary software more than its documentation tells you.

If you want to install Windows on your computer, you should buy it from Microsoft. However, manufacturers of computers pre-install Windows on their devices often. In this case, the final cost of the computer includes the price of the OS.

The target devices for Windows are relatively cheap PCs and laptops. Many people can buy such a device. Therefore, there is a huge market of potential users. Microsoft tends to keep its competitive edge in this market. The best way to reach it is to prevent appearing of Windows analogs with the same features from other companies. For reaching this goal, Microsoft takes care of protecting its intellectual property. The company does it in both technical and legal ways. An example of legal protection is the user agreement. It prohibits you to explore the internals of the OS.

The Windows OS family has a long history. Also, it is popular and widespread. It leads many developers to chose this OS as the target for their applications. However, the Microsoft company has developed the first Windows applications on its own. An example is the package of office programs [Microsoft Office](https://en.wikipedia.org/wiki/Microsoft_Office). Such applications became a standard to follow for other developers.

Microsoft followed the same principle when developing both Windows and applications for it. It is a secrecy principle:

* Source codes are not available to users.

* Data formats are undocumented.

* Third-party utilities do not have access to software features.

The goal of these decisions is to protect intellectual property.

Other software developers have followed the example of Microsoft. They stuck with the same philosophy of secrecy. As a result, their applications are self-contained and independent of each other. The formats of their data are encoded and undocumented.

If you are an experienced computer user, you immediately recognize a typical Windows application. It has a window with [control elements](https://en.wikipedia.org/wiki/Graphical_widget) like buttons, input fields, tabs, etc. You manipulate some data using these control elements. Examples of data are text, image, sound record, video. When you are done, you save your results on the hard disk. You can open it again in the same application. If you write your own Windows program, it will look and work similarly. This succession of solutions is called the development culture.

#### Linux

Linux has borrowed most of the ideas and solutions from the [Unix](https://en.wikipedia.org/wiki/Unix). Both OSes follow the set of standards that is called [POSIX](https://en.wikipedia.org/wiki/POSIX) (Portable Operating System Interface). POSIX defines interfaces between applications and the OS. Linux and Unix got the same design because they follow the same standard. We should have a look at the Unix origins to get this design.

The Unix appeared in the late 1960s. Two engineers from the Bell Labs company have developed it. Unix was a hobby project of [Ken Thompson](https://en.wikipedia.org/wiki/Ken_Thompson) and [Dennis Ritchie](https://en.wikipedia.org/wiki/Dennis_Ritchie). In their daily work, they developed the [**Multics**](https://en.wikipedia.org/wiki/Multics) OS. It was a joint project of the Massachusetts Institute of Technology (MIT), General Electric (GE) and Bell Labs. General Electric planned to use Multics for its new computer GE-645. Figure 1-11 demonstrates this machine.

{caption: "Figure 1-11. Mainframe GE-645", height: "30%"}
![Mainframe GE-645](images/GeneralInformation/ge-645.jpg)

The Multics developers have invented several innovative solutions. One of them was time-sharing. It allows several users to work with the computer at the same time. Multics uses the multitasking concept to share resources among all users.

Because of many innovations and high requirements, Multics turned out to be too complicated. The project consumed more time and money than it was planned. This was a reason why Bell Labs left the project.

The Multics project was interesting from a technical point of view. Therefore, many Bell Labs engineers wanted to continue working on it. Ken Thompson was one of them. He decided to create his own operating system for the computer GE-645. Thompson started to write the system kernel and duplicated some Multics mechanisms. However, General Electric demanded the return of its GE-645 soon. Bell Labs has received this computer on loan only. As a result, Thompson lost a hardware platform for his development.

When working on the Multics analog, Thompson had a pet project to create a computer game. It was called [Space Travel](https://en.wikipedia.org/wiki/Space_Travel_(video_game)). He launched the game on the past generation computer GE-635 from General Electric. It had the [GECOS](https://en.wikipedia.org/wiki/General_Comprehensive_Operating_System) OS. GE-635 consisted of several modules. Each module was a cabinet with electronics. The overall computer cost was about $7500000. Bell Labs engineers actively used this machine. Therefore, Thompson was rarely able to work with it to develop his game.

The limited access to the GE-635 machine was a problem. Therefore, Thompson decided to port his game to a relatively inexpensive and rarely used computer [PDP-7](https://en.wikipedia.org/wiki/PDP-7) (see Figure 1-12). Its cost was about $72000. When doing that, Thompson met one problem. Space Travel used the features of the GECOS OS. The software of PDP-7 did not provide such features. Thompson was joined by his colleague Dennis Ritchie. They implemented GECOS features for PDP-7 together. It was a set of libraries and subsystems. Over time, these modules were developed into a self-sufficient OS. It was called Unix.

{caption: "Figure 1-12. Minicomputer PDP-7", height: "30%"}
![Minicomputer PDP-7](images/GeneralInformation/pdp-7.jpg)

Thompson and Ritchie were not going to sell Unix. Therefore, they never had a goal to protect their intellectual property. They developed Unix for their own needs. Afterward, they distributed it for free with the source code. Everyone could copy and use this OS. It was reasonable because the first Unix users were Bell Labs employees only.

Unix became popular among Bell Labs employees. Thompson and Ritchie presented the OS at the Symposium on Operating Systems Principles conference. Then they got a lot of requests for the system. However, Bell Labs belonged to AT&T company. Therefore, Bell Labs did not have the right to distribute any software on its own.

AT&T noticed the new perspective OS. The company started to sell its source code to universities for $20000. Thus, university circles got a chance to improve and develop Unix.

[Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds) met Unix when he had studied at the University of Helsinki. Unix encouraged him to create his own OS called Linux. It was not a pet project for fun. Torvalds met a practical problem. He needed a Unix-compatible OS for his PC to do university tasks at home. Such OS was not available at that moment.

At the University of Helsinki, students performed study assignments using the MicroVAX computer running Unix. Many of them had PCs at home. However, there was no Unix version for PC. The only Unix alternative for students was [Minix](https://en.wikipedia.org/wiki/MINIX) OS.

Andrew Tanenbaum developed Minix for IBM PCs with Intel 80268 processors in 1987. He created Minix for educational purposes only. This was a reason why he refused to apply changes to his OS for supporting modern PCs. Tanenbaum was afraid that his system becomes too complicated. Then he cannot use it for teaching students.

Torvalds had a goal to write a Unix-compatible OS for his new IBM computer with Intel 80386 processor. He used Minix OS for development but did not import any part of it to Linux. Like the Unix creators, Torvalds had no commercial interests and was not going to sell his software. He developed the OS for his own needs and wanted to share it with everyone. Linux became free in this way. Torvalds decided to distribute it with source code for free via the Internet. This decision made Linux well known and popular.

Torvalds developed the kernel of OS only. The kernel provides memory management, file system, peripherals drivers and processor time scheduler. However, users needed an interface to access the kernel's features. It means that the Linux OS was not ready for use as it is.

The solution to the problem came from the [GNU software project](https://en.wikipedia.org/wiki/GNU_Project). [Richard Stallman](https://en.wikipedia.org/wiki/Richard_Stallman) started this project at MIT in 1983. His idea was to develop the most necessary software for computers and make it free. The major products of the GNU project are the GCC compiler, glibc system library, system utilities and Bash shell. Torvalds included these products in his project and released the first [Linux distribution](https://en.wikipedia.org/wiki/Linux_distribution) in 1991.

The first versions of Linux did not have a graphical interface. The only way to interact with the system was a command-line shell. Some complex applications had a text interface, but they were the minority. Linux got a GUI in the middle of the 1990s. This interface was based on [X Window System](https://en.wikipedia.org/wiki/X_Window_System) free software. X Window allowed developers to create graphical applications.

Unix and Linux evolved in very specific conditions. They differ from a typical cycle of commercial software development. These conditions made a unique development culture. Both systems developed in university circles. Computer science teachers and students used the OSes in daily work. They understood this software well. Therefore, they fixed software errors and added new features there willingly.

Let's have a look at what is the Unix development culture. Unix users prefer to use highly specialized command-line utilities. You can find a tool almost for each specific task. Such tools are well written, tested many times and worked as efficiently as possible. However, all features of one utility are focused on one specific task. The utility is not universal software to cover most of your needs.

When you meet a complex task, there is no single utility to solve it. However, you can easily combine several utilities and solve your task this way. Such an interaction becomes available thanks to a clear data format. Most Unix utilities use the [text data](https://en.wikipedia.org/wiki/Plain_text) format. It is simple and self-explained. You can start working with it immediately.

The Linux development culture follows the Unix traditions. It differs from the standards that are adopted in Windows. Every application is monolithic and performs all its tasks by itself in the Windows world. The application does not rely on third-party utilities. The reason is the most software for Windows costs money and can be unavailable to the user. Therefore, each developer relies on himself. He cannot force the user to buy something extra to make the specific application working.

The software dependency looks different in Linux. Most of the utilities are free, interchangeable and accessible via the Internet. Therefore, it is natural that one program requires you to download and install a missing system component or another program.

The interaction of programs is crucial in Linux. Even monolithic graphical Linux applications usually provide a command-line interface. This way, they fit smoothly into the ecosystem. It leads that you can integrate them with other utilities and applications.

Suppose that you are solving a complex task in Linux. You should assemble a single computing process from a combination of highly specialized utilities. It means that you make a computation algorithm that can be complex by itself. Linux provides a tool for this specific task. The tool is called [shell](https://en.wikipedia.org/wiki/Unix_shell). Using the shell, you type commands and the system performs them. The first Unix shell appeared in 1979. It was called [Bourne shell](https://en.wikipedia.org/wiki/Bourne_shell). Now it is deprecated. The [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) shell has replaced it in most Linux distributions. We will consider Bash in this book.

We have considered Linux and Windows cultures. You cannot give a preference to one or another. Comparing them causes endless disputes on the Internet. Each culture has its advantages and disadvantages. For example, the Window-style monolithic applications cope well the tasks that require intensive calculations. When you combine specialized Linux utilities for the same task, you get an overhead. The overhead happens because of launching many utilities and transferring data between them. This requires extra time.  As a result, you wait longer to complete your task.

Today, we observe a synthesis of Windows and Linux cultures. Microsoft started to contribute to open-source projects: Linux kernel, the [samba](https://en.wikipedia.org/wiki/Samba_(software)) network protocol, [PyTorch](https://en.wikipedia.org/wiki/PyTorch) machine learning library, the [Chromium](https://en.wikipedia.org/wiki/Chromium_(web_browser)) web browser, etc. The company has released some of its projects with a free license: [.NET Framework](https://en.wikipedia.org/wiki/.NET_Framework), PowerShell, VS Code IDE, etc.

On the other side, more and more commercial applications get ported to Linux: browsers, development tools, games, messengers, etc. However, their developers are not ready for changes that the Linux culture dictates. Such changes require too much time and effort. They also make it more challenging to maintain the product. Instead of one application, there are two: each platform has a different version. Therefore, developers port their applications without significant changes. As a result, you find more and more Windows-style applications on Linux.

One can argue about the pros and cons of this process. However, the more applications run on the specific OS, the more popular it becomes, thanks to the network effect.

I> Read more about the development culture in Unix and Linux in Eric Raymond's book ["The Art of Programming in Unix"](https://en.wikipedia.org/wiki/Unix_philosophy#Eric_Raymond's_17_Unix_Rules).
