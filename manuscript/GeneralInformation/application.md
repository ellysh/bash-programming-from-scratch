## Computer Program

We got acquainted with operating systems. They are responsible for starting and running computer programs. The program or application solves the user's specific task. For example, a text editor allows you to write and edit documents.

A program is a set of elementary steps. They are called instructions. The computer performs these steps sequentially. It follows the strict order of actions and copes with complex tasks. Let's consider how the computer launches and executes the program in detail.

### Computer Memory

A hard disk stores all instructions of the program. If the program is relatively small and simple it fits a single file. Complex applications occupy several files.

Suppose that you have a single file program. When you launch it, the OS loads the file into the computer memory called RAM. Then the OS allocates a part of processor time for the new task. This way, the processor performs the program's instructions at specified intervals.

The first step of launching a program is to load it into RAM. We should consider the computer memory internals to understand this step better.

The single unit of the computer memory is [**byte**](https://en.wikipedia.org/wiki/Byte). The byte is the minimum amount of information that the processor can reference and load into its memory. However, the CPU can handle smaller amounts of data if you apply special techniques. You operate bits in this case. A [**bit**](https://en.wikipedia.org/wiki/Bit) is the smallest amount of information you cannot divide. You can imagine the bit as a single logical state. It has one of two possible values. There are several ways to interpret them:

* 0 or 1
* True or False
* Yes or No
* + or —
* On or Off.

Another way to imagine one bit is to compare it with a lamp switch. It has two possible states:

* The switch closes the circuit. Then the lamp is on.
* The switch opens the circuit. Then the lamp is off.

A byte is a memory block of eight bits. Here you can ask why do we need this packaging? CPU can operate a single bit, right? Then it should be able to refer to a specific bit in memory.

CPU cannot refer to a single bit. There are technical reasons for that. The primary task of the first computers was arithmetic calculations. For example, these computers calculated the [ballistic tables](https://www.wikiwand.com/en/Ballistic_table). You should operate integers and fractional numbers to solve such a task. The computer does the same. However, a single bit is not enough to store a number in memory. Therefore, the computer needs memory blocks to store numbers. The bytes became such blocks.

Introducing bytes affected the architecture of processors. Engineers have expected that the CPU performs most operations over numbers. Therefore, they added a feature to load and process all bits of the number at once. This solution increased computers' performance by order of magnitude. At the same time, loading of the single bit in the CPU happens rarely. Supporting this feature in hardware brings significant overhead. Therefore, engineers have excluded it from modern processors.

There is one more question. Why does a byte consist of eight bits? It was not always this way. The byte was equal to [six bits](https://en.wikipedia.org/wiki/Six-bit_character_code) in the first computers. Such a memory block was enough to encode all the English alphabet characters in upper and lower case, numbers, punctuation marks and mathematical operations.

Six-bits encodings were insufficient for representing control and box-drawing characters. Therefore, these encodings were extended to seven bits in the early 1960s. The [ASCII encoding](https://en.wikipedia.org/wiki/ASCII) appeared at that moment. It became the standard for encoding characters. ASCII defines characters for codes from 0 to 127. The maximum seven-bit number 127 limits this range.

Then IBM released the computer [IBM System/360](https://en.wikipedia.org/wiki/IBM_System/360) in 1964. The size of a byte was eight bits in this computer. IBM chose this size for supporting old character encodings from the past projects. The IBM System/360 computer was popular and widespread. It led that eight-bit packaging became the industry standard.

Table 1-1 shows frequently used [units of information](https://en.wikipedia.org/wiki/Units_of_information) besides bits and bytes.

{caption: "Table 1-1. Units of information", width: "70%"}
| Title | [Abbreviation](https://docs.microsoft.com/en-us/style-guide/a-z-word-list-term-collections/term-collections/bits-bytes-terms) | Number of bytes | Number of bits |
| --- | --- | --- | --- |
| kilobyte | KB | 1000 | 8000 |
| megabyte | MB | 1000000 | 8000000 |
| gigabyte | GB | 1000000000 | 8000000000 |
| terabyte | TB | 10000000000 | 8000000000000 |

Table 1-2 shows standard storage devices and their capacity. You can compare them using Table 1-1.

{caption: "Table 1-2. Storage devices", width: "50%"}
| Storage device | Capacity |
| --- | --- |
| [Floppy disk 3.5"](https://en.wikipedia.org/wiki/Floppy_disk) | 1.44 MB |
| [Compact disk](https://en.wikipedia.org/wiki/Compact_disc) | 700 MB |
| [DVD](https://en.wikipedia.org/wiki/DVD) | up to 17 GB |
| [USB flash drive](https://en.wikipedia.org/wiki/USB_flash_drive) | up to 2 TB |
| [Hard disk drive](https://en.wikipedia.org/wiki/Hard_disk_drive) | up to 16 TB |
| [Solid State Drive](https://en.wikipedia.org/wiki/Solid-state_drive) | up to 100 TB |

We got acquainted with units of information. Now let's get back to the execution of the program. Why does the OS load it into RAM? In theory, the processor can read the program instructions directly from the hard disk drive, right?

A modern computer has four levels of the [memory hierarchy](https://en.wikipedia.org/wiki/Memory_hierarchy). Each level matches the red rectangle in Figure 1-13. Each rectangle match a separate device. The only exception is the CPU chip. It contains both registers and a memory cache. These are separate modules of the chip.

You see the arrows in Figure 1-13. They represent data flows. Data transfer occurs between adjacent memory levels.

Suppose that you want to process some data on the CPU. Then you should load these data to its registers. This is the only place where the processor can take data for calculations. If the CPU needs something from the disk drive, the following data transfers happen:

1. Disk drive -> RAM
2. RAM -> Processor cache
3. Processor cache -> Processor registers

When the CPU writes data back to the disk, it happens in the reverse order of steps.

{caption: "Figure 1-13. Memory hierarchy", height: "50%"}
![Memory hierarchy](images/GeneralInformation/memory-levels.png)

Data storage devices have the following parameters:

1. **Access speed** defines the amount of data that you can read or write to the device per unit of time. Units of measure are bytes per second (KBps).

2. **Capacity** is the maximum amount of data that a device can store. The units are bytes.

3. **Cost** is a price of a device concerning its capacity. The units are dollars or cents per byte or bit.

4. **Access time** is the time between the moment when the process needs some data from the device and when it receives them. Units are [**clock signals**](https://en.wikipedia.org/wiki/Clock_signal) of the CPU.

These parameters vary for devices on each level of the memory hierarchy. Table 1-3 shows the ratio of parameters for modern storage devices.

{caption: "Table 1-3. Memory levels", width: "100%", column-widths: "10%,30%,*"}
| Level | Memory | Capacity | Access speed | Access time | Cost |
| --- | --- | --- | --- | --- | --- |
| 1 | [**CPU registers**](https://en.wikipedia.org/wiki/Processor_register) | up to 1000 bytes | - | 1 tick | - |
| | | | | | |
| 2 | [**CPU cache**](https://en.wikipedia.org/wiki/CPU_cache) | from one KB to several MB | from 700 to 100 GBps | from 2 to 100 cycles | - |
| | | | | | |
| 3 | RAM | dozens of GB | 10 GBps | up to 1000 clock cycles | $10^-9^/byte |
| | | | | | |
| 4 | Disk drive ([**hard drive**](https://en.wikipedia.org/wiki/Hard_disk_drive) or [**solid drive**](https://en.wikipedia.org/wiki/Solid-state_drive)) | several TB | 2000 Mbps | up to 10000000 cycles | $10^-12^/byte |

Table 1-3 raises questions. You can read the data from the disk drive at high speed. Why is there no way to read these data to the CPU registers directly? The high access speed is not so crucial for performance in practice. The critical parameter here is the access time. It measures the idle time of the CPU until it receives the required data. You can measure this idle time in clock signals or cycles. Such a signal synchronizes all operations of the processor. The CPU requires roughly from 1 to 10 clock cycles to execute one instruction of the program.

High access time can cause serious performance issues. For example, suppose that the CPU reads the program instructions directly from the hard disk. The problem happens because CPU registers have a small capacity. There is no chance to load the whole program from the hard disk to the registers. Therefore, when the CPU did one part of the program, it should load the next one. This loading operation takes up to 10000000 clock cycles. It means that loading data from the disk takes a much longer time than processing them. The CPU spends most of the time idling. The memory hierarchy solves exactly this problem.

Let's consider data flow between memory levels by example. Suppose that you launch a simple program. It reads a file from the hard disk and displays its content on the screen. Reading data from the disk happens in several steps. The hardware does them.

The first step is reading data from the hard disk into the RAM according to Figure 1-13. The next step is loading data from RAM to the CPU cache. There is a sophisticated **caching mechanism**. It guesses the data from RAM that the CPU requires next. This mechanism reduces the access time to the data and decreases the idle time of the CPU.

When data comes to the CPU chip, it manages them on its own. The processor reads the required data from the cache to registers and manipulates them. The program instructions reach the CPU the same way as the data.

The program displays data on the screen in our example. It should call the corresponding API function for that. Then the system library changes the screen picture. The CPU does the actual work here. It loads the instructions of the system library and the video card driver. Then the CPU applies these instructions to the data in its registers. This way, the video card driver displays the data on the screen.

The required data may absent in the specific memory level. Here are few examples. Suppose that the CPU needs data to process them in the video driver code. If these data are in the CPU cache but not in the registers, the processor waits for 2-100 clock cycles to get them. If data are in the RAM, the CPU's waiting time increases by order of magnitude up to 1000 cycles.

Our program can display both small and big files. Some big file does not fit the RAM. Then the RAM contains only part of it. The CPU can require the missing file part. In this case, the CPU idle time increases by four orders of magnitude up to 10000000 clock cycles. For comparison, the processor could execute about 1000000 program instructions instead of this idle time. This is really a lot.

Both CPU and disk drives use hardware caching mechanisms. The idea of [caching for disk drives](https://en.wikipedia.org/wiki/Disk_buffer) is to store some data in the small and fast access memory. It speeds up reading and writing blocks of data. There are caching mechanisms on the software level too. They are parts of the OS in most cases.

All caching mechanisms increase a computer's performance significantly. When such a mechanism makes a mistake, it leads to the CPU idle. This mistake is called **cache miss**. Any cache miss is expensive from the performance point of view. Therefore, remember the memory hierarchy and caching mechanisms. Consider them when developing algorithms. Some algorithms and data structures cause more cache misses than others.

The storage devices with lower access times are placed closer to the CPU. Figure 1-14 demonstrates this principle. For example, registers and cache is the internal CPU memory. They are part of the processor's chip.

The RAM is a component of the [**motherboard**](https://en.wikipedia.org/wiki/Motherboard). It is very close to the CPU. The motherboard is the [printed circuit board](https://en.wikipedia.org/wiki/Printed_circuit_board) that connects all computer components. There is the high-frequency [**data bus**](https://en.wikipedia.org/wiki/Bus_(computing)) between RAM and CPU. This data bus provides high access speed and low access time.

The disk drive is not a component of the motherboard. They are separate devices. A relatively slow data bus connects them. There are several standards for such interface: ATA, SATA, SCSI, PCI Express.

There is a system controller that uploads data from RAM to the CPU cache. The controller is called [**northbridge**](https://en.wikipedia.org/wiki/Northbridge_(computing)). In earlier versions of personal computers, it was a separate chip on the motherboard. Processor manufacturing technology has evolved. As a result, the northbridge is built into the processor chip nowadays.

The [**southbridge**](https://en.wikipedia.org/wiki/Southbridge_(computing)) controller reads data from the hard drive into RAM.

{caption: "Figure 1-14. PC motherboard", height: "50%"}
![PC motherboard](images/GeneralInformation/motherboard-memory.png)

### Machine code

Suppose that the OS has loaded the content of an executable file into RAM. This file contains both instructions and data of the program. Examples of data are text strings, icons, pictures, predefined constants, etc.

Program instructions are called [**machine code**](https://en.wikipedia.org/wiki/Machine_code). The processor executes them one by one. The CPU has different logical blocks. Each block executes instructions of the specific type. The set of blocks determines the operations that the CPU supports. If the processor does not have a special block to execute an operation, it combines several blocks to do this job. The execution will take more time and resources in this case. A single instruction is an elementary operation on the data that the CPU registers store.

After loading the program into RAM, the CPU executes it. The execution of the program is called [**computing process**](https://en.wikipedia.org/wiki/Process_(computing)). (process). The process also includes the resources that the running program uses. The resources are memory area and OS objects.

There are special programs for reading and editing executable files. They are called [**hex editors**](https://en.wikipedia.org/wiki/Hex_editor). Such editors represent the program's machine code in [**hexadecimal numeral system**](https://en.wikipedia.org/wiki/Hexadecimal). The actual content of the executable file is [**binary code**](https://en.wikipedia.org/wiki/Binary_code). This code is a sequence of zeros and ones. The hex editor translates them into hexadecimal for readability. The processor receives instructions and data in binary code.

The same number looks differently in different numeral systems. The system determines the symbols and their order to write a number. For example, binary allows 0 and 1 symbols only.

Table 1-4 shows matching of numbers in binary (BIN), decimal (DEC), and hexadecimal (HEX).

{caption: "Table 1-4. Numbers in decimal, hexadecimal and binary", width: "50%"}
| Decimal | Hexadecimal | Binary |
| --- | --- | --- |
| 0 | 0 | 0000 |
| 1 | 1 | 0001 |
| 2 | 2 | 0010 |
| 3 | 3 | 0011 |
| 4 | 4 | 0100 |
| 5 | 5 | 0101 |
| 6 | 6 | 0110 |
| 7 | 7 | 0111 |
| 8 | 8 | 1000 |
| 9 | 9 | 1001 |
| 10 | A | 1010 |
| 11 | B | 1011 |
| 12 | C | 1100 |
| 13 | D | 1101 |
| 14 | E | 1110 |
| 15 | F | 1111 |

I> Use the standard Windows calculator for conversion from one numeral system to another. This feature is available in the [**programmer mode**](https://en.wikipedia.org/wiki/Windows_Calculator#Features).

Why are binary and hexadecimal used in programming? Binary and Boolean algebra is the basis of [**digital electronics**](https://en.wikipedia.org/wiki/Digital_electronics). In digital electronics, the smallest portion of the information is an electrical [**signal**](https://en.wikipedia.org/wiki/Signal#Digital_signal). The simplest way to encode it is to distinguish between states when it is present and does not. The number one encodes the presence of the signal. Its absence matches number zero. One bit is enough for such coding.

The basic element in digital electronics is a [**logic gate**](https://en.wikipedia.org/wiki/Logic_gate). It converts electrical signals. Different physical parts can play the role of a logic gate. They can be electromagnetic relays, vacuum tubes or transistors. All these devices work in the same way in terms of signal processing. This processing consists of two steps:

1. Receive one or more signals as input.
2. Transmit the resulting signal to the output.

Such processing is performed according to the rules of [**Boolean algebra**](https://en.wikipedia.org/wiki/Boolean_algebra). Each operation of Boolean algebra corresponds to a logic gate. If you connect them in series, you get a complex signal conversion. In essence, the CPU is a huge network of logic gates.

A binary numeral system allows you to work with digital electronics at the lowest level. This level is logical gates and electrical signals. It turns out that the hardware design imposes usage of the binary system.

The hardware works in the binary numeral system. Why do we need the hexadecimal then? Programmers use either the decimal or binary system. The first one is convenient when writing high-level logic of the program. For example, you count the number of repeating the same action in decimal. The binary system is needed to communicate with the hardware. For example, you prepare and send data to a device in binary. There is one problem with binary. It is hard to write, read, memorize and pronounce the numbers in this system. Translation from decimal to binary is difficult. The hexadecimal solves the problem of translation. It is as compact and convenient as the decimal system. You can do translation from hexadecimal to the binary system and back in mind.

Consider converting a number from binary to hexadecimal. The first step is dividing the number into groups of four digits starting from the end. If the last group is less than four digits, add zeros to the left side. Then use Table 1-4 to replace each four-digit group with a hexadecimal number. Here is an example of the conversion:
```
110010011010111 = 110 0100 1101 0111 = 0110 0100 1101 0111 = 6 4 D 7 = 64D7
```

{caption: "Exercise 1-1. Numbers conversion from binary to hexadecimal", line-numbers: false}
```
Convert the following numbers from binary to hexadecimal:
* 10100110100110
* 1011000111010100010011
* 1111101110001001010100110000000110101101
```

{caption: "Exercise 1-2. Numbers conversion from hexadecimal to binary", line-numbers: false}
```
Convert the following numbers from hexadecimal to binary:
* FF00AB02
* 7854AC1
* 1E5340ACB38
```

You can find the answers to the exercises in the last section of the book. Check yourself if you are unsure about the results.

Let's come back to our executable file of the program. The OS loads the file into RAM together with all libraries that are necessary for the program. The special OS component is responsible for this job. It is called [**loader**](https://en.wikipedia.org/wiki/Loader_(computing)). Thanks to preloading libraries, there is no CPU idle when the program accesses them. The required library code is already in RAM. Thus, it is available to the CPU for a few hundred clock cycles. When the loader finishes his job, the program becomes a process. The CPU executes it, starting from the first instruction.

While the program is running, its instructions, resources and required libraries occupy the RAM area. When the program finishes, the OS clears this memory area. From now on, other applications can use it.

### Source Code

Machine code is a low-level representation of a program. This format of instructions and data is convenient for the processor. However, it is hard for a human to write a program in machine code. It became more complicated since computers got more performance and the complexity of their programs increased. There are two types of special applications to solve this problem: [**compilers**](https://en.wikipedia.org/wiki/Compiler) and [**interpreters**](https://en.wikipedia.org/wiki/Interpreter_(computing)). They perform the same task in different ways. The task is a translation of the program from a human-readable language into machine code.

Nowadays, programs are written in [**programming languages**](https://en.wikipedia.org/wiki/Programming_language). They differ from the [**natural languages**](https://en.wikipedia.org/wiki/Natural_language) that humans use to communicate. Programming languages are very limited. They can express only actions that a computer can perform. These languages also have strict rules. For example, they allow a small set of words. You can combine these words in a specific order only. [**Source code**](https://en.wikipedia.org/wiki/Source_code) is a text of the program that is written in a programming language.

The compiler and interpreter handle source code differently. The difference is when the machine code is generated from source code. The compiler reads the entire program text, generates processor instructions and saves them on a disk. The compiler does not execute the program. The interpreter reads the source code in parts, generates processor instructions and executes them immediately. The result of the interpreter is stored in RAM temporarily.

Let's consider how the compiler handles a program. Suppose that you have written the program. You saved its source code to a file on the hard disk. Next, you run a suitable compiler. Each programming language has an appropriate compiler or interpreter. The compiler writes its result in an executable file on a disk. This file contains machine code. It corresponds to the source code of the program. Now you can run the executable file to launch the program.

Figure 1-15 shows how the compiler handles a program written in C or C++.

{caption: "Figure 1-15. Compilation process", height: "50%", width: "100%"}
![Compilation process](images/GeneralInformation/compiler.png)

The compilation consists of two steps. The compiler does the first step. The second step is called **linking**. The special program performs it. The program is called [**linker**](https://en.wikipedia.org/wiki/Linker_(computing)).

The compiler creates intermediate **object files**. The linker uses them to produce an executable file. Why can't the compiler and the linker be combined into one program? There are several problems with this solution. The first one has to do with limited RAM size. There is common practice to split source code into several files. The compiler processes them separately and writes the results to the disk in the object files. These files are the intermediate results of compilation. If you combine the compiler and linker, you can not save the intermediate results to the disk. You will have to compile the entire program at once. In this case, you can reach the RAM limit.

The second problem is resolving dependencies. In the source code, there are blocks of commands that refer to each other. For tracking such cross-calls, the compiler needs additional passes through the whole program code. It increases the compilation time several times over. Linker solves this problem faster.

The program can call blocks of commands from the library. In this case, the linker receives the library file on input along with the object files. The compiler cannot process the library. Because, it is provided in machine code but not in source code. Splitting the compilation into two steps solves this problem.

Now suppose that you have chosen an interpreter to translate the source code of a program. In this case, the source code file is ready for execution. To run it, the OS first loads the interpreter. Then the interpreter reads the source code file from the disk into RAM. Then it executes the file line by line. The translation of source code commands to machine code is done in RAM. Some interpreters save files with an intermediate representation of the program to the disk. It speeds up the program execution. However, the interpreter always executes the program.

Figure 1-16 shows the process of interpreting the program.

{caption: "Figure 1-16. Interpreting the program", height: "50%", width: "100%"}
![Interpreting the program](images/GeneralInformation/interpreter.png)

From the diagram 1-16, you may conclude that the interpreter works as a compiler combined with a linker. The interpreter loads text files into RAM and translates them into machine code. Why is there no problem with RAM size and cross-calls to blocks of code?

The interpreter handles source code differently than the compiler. The interpreter reads and executes the program line by line. It means that there is no need to store the machine code of the entire application in memory. Instead, it is enough to process source code text files as needed. To save memory, the interpreter periodically removes commands that have already been executed.

All interpreters work slowly. Loading the program's source code from the disk into RAM causes the processor to idle. According to Table 1-3, this loading takes up to 10000000 clock cycles. Besides, the interpreter itself is a complex program. Its work requires some of the computer's hardware resources. As a result, the computer executes both the interpreter and the program in parallel. It is an extra overhead. They slow down the work of the program.

Interpreting programs is expensive. What about compilation? The compiler generates an executable file with machine code. Therefore, when you compile the program and write it in machine code, you reach almost the same execution speed. However, you pay for the convenience of the programming language at the compilation stage. A couple of seconds and a few megabytes of RAM are enough to compile a small program. But compiling large projects (e.g. the OS kernel) takes several hours. Keep in mind the overhead when choosing a programming language. The interpreter better handles some tasks. Others are done better by the compiler.

Is it worth using programming languages at all? The time to compile a project can be spent writing the program in machine code. It seems that you save time and computer resources in this way. An example will help us to evaluate the advantage of programming languages. Listing 1-1 shows the source code of a C program. It prints the text "Hello world!" on the screen.

{caption: "Listing 1-1. Source code of the C program", format: C}
![`HelloWorld.c`](code/GeneralInformation/HelloWorld.c)

Listing 1-2 shows the same program in machine code format. It is a hexadecimal representation.

{caption: "Listing 1-2. Machine code of the program"}
![`MachineCode.txt`](code/GeneralInformation/MachineCode.txt)

Even if you don't know the C language, the code in Listing 1-1 looks more evident than Listing 1-2. It is easier to read and edit this code. Perhaps a professional developer can quickly write machine code for a small program. But another programmer will spend a lot of time and effort to figure it out.

A programming language is more convenient and expressive than machine code. It makes programs easier to develop and maintain.
