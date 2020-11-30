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

Multitasking solves the problem of quick response to user actions. This approach was developed gradually and became complicated in the end. Modern operating systems use [**displacing multitasking**](https://en.wikipedia.org/wiki/Preemption_(computing)) with pseudo-parallel processing of tasks. It means that the OS chooses a program to run at the moment. The choice takes into account the priorities of the running applications. This way, a higher priority application receives hardware resources more often than a lower priority one. The task switching mechanism is implemented in the OS kernel. It is called [**task scheduler**] (https://en.wikipedia.org/wiki/Scheduling_(computing)).

Pseudo-parallel processing means that only one task is executed at any given time. At the same time, the OS switches between tasks so quickly that the user does not notice it. It seems to him that the computer is running several programs simultaneously. With such an approach, the GUI reacts immediately to any action. But in fact, every program and OS component gets its hardware resources at strictly defined moments.

There are computers with multiple processors or with [multi-core processors](https://en.wikipedia.org/wiki/Multi-core_processor). Only these computers can execute several programs simultaneously. The number of the executed programs equals the number of cores of all processors approximately. The preemptive multitasking mechanism with constant task switching still works on such systems. It is universal and balances the load regardless of the number of cores. This way, a user gets an adequate response time to his actions.

#### User Interface

Modern operating systems solve different tasks. These tasks depend on the type of computer where the OS is running. The main computer types are the following:

* [Personal computers](https://en.wikipedia.org/wiki/Personal_computer) (PC) and notebooks.
* Cell phones and tablets.
* Servers.
* [Embedded systems](https://en.wikipedia.org/wiki/Embedded_system).

We will consider operating systems for PCs and notebooks only. Apart from multitasking, they provide [**graphic user interface**](https://en.wikipedia.org/wiki/Graphical_user_interface) (GUI). Here the interface means the way to interact with the system. Through the interface, the user launches applications, configures computer devices and OS components. Let's take a look at the history of the GUI.

Users of commercial computers learned about the interactive mode in 1960. This mode was supported by a new [minicomputer] (https://en.wikipedia.org/wiki/Minicomputer) [PDP-1] (https://en.wikipedia.org/wiki/PDP-1) from [Digital Equipment Corporation](https://en.wikipedia.org/wiki/Digital_Equipment_Corporation). Why did computer manufacturers and users become interested in interactivity in general? In the 1950s, IBM computers dominated the mainframe market. They worked in batch processing mode and coped well with computational tasks. Their operating systems with multi-programming support automated program loading and provided high performance.

The idea of interactive work with the computer appeared in the SAGE military project. The US Air Force ordered it. The project developed an automated air defense system to detect Soviet bombers. During development, the engineers faced the problem of processing data from radars. According to the requirements, the computer had to output data in real-time. The human operator reacted to data as quickly as possible and gave commands to the system. The existing methods of interaction with the computer did not fit this task. Because in an air defense system, the speed of response to a threat is essential.