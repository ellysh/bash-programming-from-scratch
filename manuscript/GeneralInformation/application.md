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

4. **Access time** is the time between the moment when the processor needs some data from the device and when it receives them. Units are [**clock signals**](https://en.wikipedia.org/wiki/Clock_signal) of the CPU.

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

Table 1-3 raises questions. You can read the data from the disk drive at high speed. Why is there no way to read these data to the CPU registers directly? Actually, you can do it, but it leads to a significant performance drawback.

The high speed of accessing a memory storage is not so crucial for performance in practice. The critical parameter here is the access time. It measures the idle time of the CPU until it receives the required data. You can measure this idle time in clock signals or cycles. Such a signal synchronizes all operations of the processor. The CPU requires roughly from 1 to 10 clock cycles to execute one instruction of the program.

High access time can cause serious performance issues. For example, suppose that the CPU reads the program instructions directly from the hard disk. The problem happens because CPU registers have a small capacity. There is no chance to load the whole program from the hard disk to the registers. Therefore, when the CPU did one part of the program, it should load the next one. This loading operation takes up to 10000000 clock cycles. It means that loading data from the disk takes a much longer time than processing them. The CPU spends most of the time idling. The memory hierarchy solves exactly this problem.

Let's consider data flow between memory levels by example. Suppose that you launch a simple program. It reads a file from the hard disk and displays its contents on the screen. Reading data from the disk happens in several steps. The hardware does them.

The first step is reading data from the hard disk into the RAM according to Figure 1-13. The next step is loading data from RAM to the CPU cache. There is a sophisticated **caching mechanism**. It guesses the data from RAM that the CPU requires next. This mechanism reduces the access time to the data and decreases the idle time of the CPU.

When data comes to the CPU chip, it manages them on its own. The processor reads the required data from the cache to registers and manipulates them. The program instructions reach the CPU the same way as the data.

The program displays data on the screen in our example. It should call the corresponding API function for that. Then the system library changes the screen picture. The CPU does the actual work here. It loads the instructions of the system library and the video card driver. Then the CPU applies these instructions to the data in its registers. This way, the video card driver displays the data on the screen.

The required data may absent in the specific memory level. Here are few examples. Suppose that the CPU needs data to process them in the video driver code. If these data are in the CPU cache but not in the registers, the processor waits for 2-100 clock cycles to get them. If data are in the RAM, the CPU's waiting time increases by order of magnitude up to 1000 cycles.

Our program can display both small and big files. Some big file does not fit the RAM. Then the RAM contains only part of it. The CPU can require the missing file part. In this case, the CPU idle time increases by four orders of magnitude up to 10000000 clock cycles. For comparison, the processor could execute about 1000000 program instructions instead of this idle time. This is really a lot.

Both CPU and disk drives use hardware caching mechanisms. The idea of [caching for disk drives](https://en.wikipedia.org/wiki/Disk_buffer) is to store some data in the small and fast access memory. It speeds up reading and writing blocks of data. There are caching mechanisms on the software level too. They are parts of the OS in most cases.

All caching mechanisms increase a computer's performance significantly. When such a mechanism makes a mistake, it leads to the CPU idle. This mistake is called **cache miss**. Any cache miss is expensive from the performance point of view. Therefore, remember the memory hierarchy and caching mechanisms. Consider them when developing algorithms. Some algorithms and data structures cause more cache misses than others.

The storage devices with lower access times are placed closer to the CPU. Figure 1-14 demonstrates this principle. For example, registers and cache is the internal CPU memory. They are part of the processor's chip.

Both CPU and RAM are two chips that are plugged into the [**motherboard**](https://en.wikipedia.org/wiki/Motherboard) near each other. The high-frequency [**data bus**](https://en.wikipedia.org/wiki/Bus_(computing)) connects them. This data bus provides low access time.

The motherboard is the [printed circuit board](https://en.wikipedia.org/wiki/Printed_circuit_board) that connects computer components. You can plug in some chips right into the motherboard. However, there are devices that you should connect via cables there. The disk drive is an example of such a device. It connects to the motherboard via a relatively slow interface. There are several standards for such an interface: ATA, SATA, SCSI, PCI Express.

The old motherboard models have an embed chip that transfers data between CPU and RAM. This chip is called [**northbridge**](https://en.wikipedia.org/wiki/Northbridge_(computing)). Thanks to improving technologies for chip manufacturing, the CPUs take northbridge's functions since 2011.

The [**southbridge**](https://en.wikipedia.org/wiki/Southbridge_(computing)) is another motherboard's chip. It presents there nowadays. The southbridge transfers data between RAM and devices that are connected via slow interfaces like PCI, USB, SATA, etc.

{caption: "Figure 1-14. PC motherboard", height: "50%"}
![PC motherboard](images/GeneralInformation/motherboard-memory.png)

### Machine code

Suppose that the OS has loaded the contents of an executable file into RAM. This file contains both instructions and data of the program. Examples of data are text strings, box-drawing characters, predefined constants, etc.

Program instructions are called [**machine code**](https://en.wikipedia.org/wiki/Machine_code). The processor executes them one by one. A single instruction is an elementary operation on the data from the CPU registers.

The CPU has logical blocks for executing each type of instruction. The available blocks determine the operations that the CPU can perform. If the processor does not have an appropriate logical block to accomplish a specific instruction, it combines several blocks to do this job. The execution takes more clock cycles in this case.

When the OS has loaded the program instructions and its data into RAM, it allocates the CPU time slots for that. The program becomes a [**computing process**](https://en.wikipedia.org/wiki/Process_(computing)) or process since this moment. The process means the running program and the resources it uses. Examples of the resources are memory area and OS objects.

How do the program instructions look like? You can see them using the special program for reading and editing executable files. Such a program is called [**hex editor**](https://en.wikipedia.org/wiki/Hex_editor). The editor represents the program's machine code in [**hexadecimal numeral system**](https://en.wikipedia.org/wiki/Hexadecimal). The actual contents of the executable file is [**binary code**](https://en.wikipedia.org/wiki/Binary_code). This code is a sequence of zeros and ones. The CPU receives program instructions and data in this format. The hex editor makes them easy to read for humans.

There are advanced programs to read machine code. They are called [**disassemblers**](https://en.wikipedia.org/wiki/Disassembler). These programs guess how the program instructions look like in terms of the CPU commands. You can get a better representation of the program using the disassembler than the hex editor.

If you take a specific number, it looks different in various numeral systems. The numeral system determines the symbols and their order to write a number. For example, binary allows 0 and 1 symbols only.

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

I> Most calculator applications can convert numeral systems. If you use Windows, convert numbers with the standard Windows calculator in the [**programmer mode**](https://en.wikipedia.org/wiki/Windows_Calculator#Features).

Why do programmers use both binary and hexadecimal numeral systems? It is more convenient to use only one of them, right? We should know more about computer hardware to answer this question.

The binary numeral system and [**Boolean algebra**](https://en.wikipedia.org/wiki/Boolean_algebra) are the basis of [**digital electronics**](https://en.wikipedia.org/wiki/Digital_electronics). An electrical [**signal**](https://en.wikipedia.org/wiki/Signal#Digital_signal) is the smallest portion of the information there. When you work with such signals, you need a way to encode them. Encoding means associating specific numbers with the signal states. The signal has two states only. It can present or absent. Therefore, the simplest way to encode the signal is to take the first two integers: zero and one. Then you use zero when there is no signal. Otherwise, you use the number one. Such encoding is very compact. You can use one bit to encode one signal.

The basic element of digital electronics is a [**logic gate**](https://en.wikipedia.org/wiki/Logic_gate). It converts electrical signals. You can implement the logic gate using various physical devices. Examples of such devices are an electromagnetic relay, vacuum tube and transistor. Each device has its own physics in the background. However, they work in the same way in terms of signal processing. This processing contains two steps:

1. Receive one or more signals on the input.
2. Transmit the resulting signal to the output.

The signal processing follows the rules of Boolean algebra. This algebra has an elementary operation for each type of logic gate. When you combine logic gates together, you can calculate the result using a Boolean expression. Combining logic gates provides a complex behavior. You need it if your digital device follows some non-trivial logic. For example, the CPU is a huge network of logic gates.

When you deal with digital electronics, you should apply the binary numeral system. This way, you convert signal states to logical values that Boolean algebra operates. Then you can calculate the resulting signals. The level of signals and logic gates is close to the computer hardware. You have to work on this level sometimes when programming. We can say that the hardware design dictates you to use the binary numeral system.

The binary numeral system is a language of hardware. Why do you need the hexadecimal system then? When you develop a program, you need decimal and binary systems only. Decimal is convenient for writing a general logic of the program. For example, you count repeating the same action in decimal.

You need the binary system when your program deals with computer hardware. For example, you send data to some device in binary format. There is one problem with binary. It is hard to write, read, memorize and pronounce the numbers in this system for humans. Conversion from decimal to binary takes effort. The hexadecimal system solves both problems of representing and converting numbers.  It is a compact and convenient as the decimal system. At the same time, you can convert a number from hexadecimal to binary form easily.

Follow these steps to convert a number from binary to hexadecimal form:

1. Split the number into groups of four digits. Start the splitting from the end of the number.

2. If the last group is less than four digits, add zeros to the left side of the group.

3. Use Table 1-4 to replace each four-digit group with one hexadecimal number.

Here is an example of converting the binary number 110010011010111:
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

There are the answers for all exercises in the last section of the book. Check yourself there if you are unsure about your results.

Let's come back to executing the program. The OS loads its executable file from the disk drive into RAM. Then the OS loads all libraries that the program requires. The special OS component does both these tasks. It is called [**loader**](https://en.wikipedia.org/wiki/Loader_(computing)). Thanks to preloading libraries, the CPU does not idle too much when the program accesses them. The instructions of the required library are already in RAM. Therefore, the CPU waits for a few hundred clock cycles to access them. When the loader finishes his job, the program becomes a process. The CPU executes it, starting from the first instruction.

Each machine code instruction is called [**opcode**](https://en.wikipedia.org/wiki/Opcode). The opcode dictates the CPU which logic gates it should apply for data in the specific registers. When the operation is done, the opcode specifies the register for storing the result. Opcodes have a binary format that is a natural language of the CPU.

While the program is running, its instructions, resources and required libraries occupy the RAM area. The OS clears this memory area when the program finishes. Then other applications can use it.

### Source Code

Machine code is a low-level representation of a program. This format is convenient for the processor. However, it is hard for a human to write a program in machine code. Software engineers developed the first programs this way. It was possible for early computers because of their simplicity. Modern computers are much more powerful and complex devices. Their programs are huge and have a lot of functions.

Computer engineers invented two types of special applications. They solve the problem of the machine code complexity. These applications are [**compilers**](https://en.wikipedia.org/wiki/Compiler) and [**interpreters**](https://en.wikipedia.org/wiki/Interpreter_(computing)). They translate the program from a human-readable language into machine code. Compilers and interpreters solve this task differently.

Software developers use [**programming languages**](https://en.wikipedia.org/wiki/Programming_language) in their work nowadays. Compilers and interpreters take programs written in such languages and produce the corresponding machine code.

Humans use one of [**natural language**](https://en.wikipedia.org/wiki/Natural_language) to communicate with each other. Programming languages are different from them. They are formal and very limited. Using a programming language, you can express only actions that a computer can perform. There are strict rules on how you should write these actions. For example, you can use a small set of words and combine them in specific orders. [**Source code**](https://en.wikipedia.org/wiki/Source_code) is a text of the program you write in a programming language.

The compiler and interpreter process source code differently. The compiler reads the entire program text, generates machine code instructions and saves them on a disk drive. The compiler does not execute the resulting program on its own. The interpreter reads the source code in parts, generates machine code instructions and executes them immediately. The interpreter stores its results in RAM temporarily. When the program finishes, you lose these results.

Let's consider how the compiler works step by step. Suppose that you have written the program. You saved its source code to a file on the hard disk. Then you run a compiler that fits the language you have used. Each programming language has the corresponding compiler or interpreter. The compiler reads your file, processes it and writes the resulting machine code in the executable file on a disk. Now you have two files: one with source code and one with machine code. Every time you change the source code file, you should generate the new executable file. You can run the executable file to launch your program.

Figure 1-15 shows how the compiler processes a program written in C and C++ languages.

{caption: "Figure 1-15. The compilation process", height: "50%", width: "100%"}
![Compilation process](images/GeneralInformation/compiler.png)

The compilation process consists of two steps. The compiler does the first step. The second step is called **linking**. The special program called [**linker**](https://en.wikipedia.org/wiki/Linker_(computing)) performs it.

The compiler produces intermediate **object files**. The linker takes them and converts them to one executable file.

Why do you need two steps for compiling the source code? In theory, you can combine the compiler and linker into a single application. However, such a solution has several problems.

The limited RAM size causes the first problem. There is a common practice to split source code into several files. Each file matches a separate part of the program that solves the specific task. This way, you simplify your work with the source code. The compiler processes these files separately. It produces an object file for each source code file. They store the intermediate results of compilation.

If you combine the compiler and linker into one application, storing the intermediate results on the disk becomes a controversial decision. If you do it, you get the bottleneck because of slow disk operations. In theory, you can keep all data in RAM and get better performance. However, you cannot do it. When you deal with a big program, the compilation process consumes all your RAM and crashes.

Suppose that you have a combined compiler-linker that stores temporary files on the disk. In this case, storing temporary files brings the performance overhead. At the same time, you do not get any benefits from it. You avoided the RAM limitation this way. However, you can get the benefit by splitting the compiler and linker. Then you simplify both applications and make it cheaper to support them. The developers of compilers chose this way.

The second problem of the compiler-linker application is resolving dependencies. There are blocks of commands that call each other in the source code. Such references are called **dependencies**. Tracking them is the linker task.

When the compiler produces the object files, they contain machine code but not the source code. It is simpler for the linker to track dependencies in the machine code.

If you combine compiler and linker, you need extra passes through the whole program source code for resolving dependencies. The compiler needs much more time for a single pass over the source code than the linker for processing the machine code. Therefore, when you have the compiler and linker separated, you speed up the overall compilation process.

The program can call blocks of commands from the library. The linker process the library file together with the object files of your program in this case. The compiler cannot process the library. Its file contains machine code but not the source code. Therefore, the compiler does not understand it. Splitting the compilation into two steps resolves the task of using libraries too.

We have considered the basics of how the compiler works. Now suppose that you choose an interpreter instead to execute your program. You have the file with its source code on the disk drive. The file is ready for execution. When you run it, the OS loads the interpreter first. Then the interpreter reads your source code file into RAM and executes it line by line. The translation of source code commands to machine code instructions happens in RAM. Some interpreters save files with an intermediate representation of the program to the disk drive. It speeds up the program execution if you restart it. However, you always need to run an interpreter first for executing your program.

Figure 1-16 shows the process of interpreting the program.

{caption: "Figure 1-16. Interpreting the program", height: "50%", width: "100%"}
![Interpreting the program](images/GeneralInformation/interpreter.png)

Figure 1-16 can give an idea that the interpreter works the same way as the compiler and linker combined into one application. The interpreter loads source code files into RAM and translates them into machine code. Why are there no problems with the RAM overflow and dependency resolution?

The interpreter avoids problems because it processes the source code differently than the compiler does. The interpreter processes and executes the program code line by line. Therefore, it does not store the machine code of the whole program in memory. The interpreter processes the parts of the source code file that it requires at the moment. When the interpreter executes them, it unloads these parts and frees the corresponding RAM area.

Interpreting the program looks more convenient for software development than compiling. However, it has some drawbacks.

First, all interpreters work slowly. It happens because every time you run the program, the interpreter should translate its source code to machine code. This process takes some time. You should wait for it. Another reason for the low performance of interpreters is disk operations. Loading the program's source code from the disk drive into RAM causes the CPU to idle. It takes up to 10000000 clock cycles, according to Table 1-3.

Second, the interpreter itself is a complex program. It requires some portion of the computer's hardware resources to launch and work. Therefore, the computer executes both interpreter and your program in parallel and shares resources among them. It is an extra overhead that reduces the performance of your program.

Interpreting the program is slow. Does it mean that compilation is better? The compiler generates an executable file with machine code. Therefore, you reach almost the program's performance when you compile it or write machine code on your own. However, you pay for using the programming language at the compilation stage. A couple of seconds and a few megabytes of RAM are enough to compile a small program. When you compile a large project (for example, the Linux kernel), it takes several hours. If you change the source code, you should recompile the project and wait hours again.

Keep in mind the overhead of interpreters and compilers when choosing a programming language for your project. The interpreter is a good choice in the following cases:

* You want to develop a program quickly.

* You do not care about the program's performance.

* You work on a small and relatively simple project.

The compiler would be better in the following cases:

* You work on a complex and large project.

* Your program should work as fast as possible.

* You want to speed up debugging of your program.

Both compilers and interpreters have an overhead. Does it make sense to discard a programming language and write a program in machine code? You do not waste your time waiting for compilation in this case. Your program works as fast as possible. These benefits sound reasonable. Please do not hurry with your conclusions.

One simple example helps you to realize all advantages of using a programming language. Listing 1-1 shows the source code written in C. This program prints the "Hello world!" text on the screen.

{caption: "Listing 1-1. Source code of the C program", format: C}
![`HelloWorld.c`](code/GeneralInformation/HelloWorld.c)

Listing 1-2 shows the machine code of this program in the hexadecimal format.

{caption: "Listing 1-2. Machine code of the program"}
![`MachineCode.txt`](code/GeneralInformation/MachineCode.txt)

Even if you don't know the C language, you would prefer to deal with the code in Listing 1-1. You can read and edit it easily. At the same time, you need significant efforts to decode the numbers in Listing 1-2.

Perhaps a professional programmer with huge experience can write a small program in machine codes. However, another programmer will spend a lot of time and effort to figure it out. Developing a large project in machine codes is a challenging and time-consuming task for any developer.

Using programming language saves your effort and time significantly when developing programs. Also, it reduces the cost of maintaining the existing project. There is no way to develop modern complex software using the machine code only.
