## Computer Program

We got acquainted with operating systems. They are responsible for starting and running computer programs. The programs solve the user's application tasks. For example, a text editor allows working with text.

A program is a set of elementary steps or instructions. The computer performs these steps sequentially. This way, it copes with complex tasks. Let us consider in detail how the program is launched and executed.

### Computer Memory

The computer program instructions are stored on a hard disk as a file. For launching the application, the OS loads the content of this file into RAM. Then the OS allocates processor time for program execution. At specified intervals, the processor executes its instructions.

Let's see how the OS loads the program into RAM. We start with how computer memory works.

The single unit of the computer memory is [**byte**](https://en.wikipedia.org/wiki/Byte). The byte is the minimum amount of information that the processor can reference and load into its memory. The CPU can handle smaller amounts of data. They are called bits.  The [**bit**](https://en.wikipedia.org/wiki/Bit) is the minimum amount of information that cannot be broken down. The bit is a logical state with two possible values. There are several ways to interpret the value of the bit:

* 0 or 1
* True or False
* Yes or No
* + or —
* On or Off.

Imagine a bit like a lamp switch. It has two possible states:

* The switch closes the circuit. Then the lamp is on.
* The switch opens the circuit. Then the lamp is off.

Eight bits make up a memory block of one byte.

Packaging bits in bytes raises questions. Operations with individual bits are possible. Why cannot the processor refer to a specific bit in memory? This limitation has historical reasons. The first computers did arithmetic calculations mainly. The example is calculating the [ballistic tables](https://www.wikiwand.com/en/Ballistic_table). For solving such tasks, the computers operated with integers and fractional numbers. One bit is not enough to store a number in memory. Therefore, memory blocks that are larger than the bits needed. Such blocks are bytes. The combining bits into bytes reflected on the architecture of processors. Processor designers expected that most calculations are performed over numbers. Therefore, loading and processing all bits of numbers at a time increases computer performance by order of magnitude. So, it led that processors work with bytes only.

There is one more question. Why does a byte consist of eight bits? In the first computers, a byte's size was equal to [six bits](https://en.wikipedia.org/wiki/Six-bit_character_code). Such a memory block was enough to encode all the English alphabet characters in upper and lower case, numbers, punctuation marks and mathematical operations. Over time, this size has become insufficient. The byte was expanded to seven bits. At that moment, the [ASCII table](https://en.wikipedia.org/wiki/ASCII) appeared. The table became the standard for encoding characters. The ASCII table defines characters for codes from 0 to 127. 127 is the maximum seven-bit number. Later, IBM has released the mainframe [IBM System/360](https://en.wikipedia.org/wiki/IBM_System/360). The size of a byte was eight bits in this computer. IBM chose this size for supporting old character encodings from the past projects. Such packaging of bits has become the industry standard. It happened because of the popularity and widespread of IBM System/360.

Table 1-1 shows frequently used [units of information](https://en.wikipedia.org/wiki/Units_of_information).

{caption: "Таблица 1-1. Units of information", width: "70%"}
| Title | [Abbreviation](https://docs.microsoft.com/en-us/style-guide/a-z-word-list-term-collections/term-collections/bits-bytes-terms) | Number of bytes | Number of bits |
| --- | --- | --- | --- |
| kilobyte | KB | 1000 | 8000 |
| megabyte | MB | 1000000 | 8000000 |
| gigabyte | GB | 1000000000 | 8000000000 |
| terabyte | TB | 10000000000 | 8000000000000 |

Table 1-2 shows standard storage devices and their capacity.

{caption: "Table 1-2. Storage devices", width: "50%"}
| Storage device | Capacity |
| --- | --- |
| [Floppy disk 3.5"](https://en.wikipedia.org/wiki/Floppy_disk) | 1.44 MB |
| [Compact disk](https://en.wikipedia.org/wiki/Compact_disc) | 700 MB |
| [DVD](https://en.wikipedia.org/wiki/DVD) | up to 17 GB |
| [USB flash drive](https://en.wikipedia.org/wiki/USB_flash_drive) | up to 2 TB |
| [Hard disk drive](https://en.wikipedia.org/wiki/Hard_disk_drive) | up to 16 TB |
| [Solid State Drive](https://en.wikipedia.org/wiki/Solid-state_drive) | up to 100 TB |

We got acquainted with units of information. Now let's get back to the execution of the program. Why does the OS load it into RAM? The processor could read the program instructions directly from the hard disk drive.

All memory is divided into [four levels](https://en.wikipedia.org/wiki/Memory_hierarchy) in a modern computer. Each level matches the red rectangle in Figure 1-13. There is a physical division of memory. Memory levels match different devices. The only exception is the processor. In the CPU chip, there are both registers and memory cache. But these are separate modules of the chip.

The arrows in Figure 1-13 represent data flows. Data transfer occurs only between adjacent memory levels. The processor works with data from its registers only. If the CPU needs something from the disk drive, it is loaded in the following way:

1. Disk drive -> RAM
2. RAM -> Processor cache
3. Processor cache -> Processor registers

Data is written to the disk drive in reverse order of steps.

{caption: "Figure 1-13. Memory hierarchy", height: "50%"}
![Memory hierarchy](images/GeneralInformation/memory-levels.png)

The memory levels differ from each other by the following parameters:

1. **Access speed** means how much data is read or written to the media per unit of time. Units of measure are bytes per second (KBps).

2. **Capacity** is the maximum amount of data that a medium can store. The units are bytes.

3. **Cost** is a price of a medium concerning its capacity. The units are dollars or cents per byte or bit.

4. **Access time** is the time between when data was needed and when it became available to the processor. Units are [**clock signals**](https://en.wikipedia.org/wiki/Clock_signal) of the CPU.

Table 1-3 shows the ratio of parameters of different memory types.

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

Table 1-3 raises questions. The speed of access to disk drives is huge. Why is it impossible to read data from the disk into registers directly? Actually, the access speed is not so important. More critical is processor idle time. How long does the processor idle waiting for access to the requested data? The unit of this idle time is the number of clock signals. The signal synchronizes all operations of the processor. It takes one or several clock cycles for executing a single program instruction.

Suppose that the processor reads the program instructions directly from the hard disk. In this case, the execution of the simplest algorithm would take weeks. Most of this time, the processor would idle while waiting for reading operations. Hierarchical organization of memory speeds up access to the data that are needed by the processor.

We will consider a simple program. It reads a file from the disk drive and displays the file content on the screen. According to Figure 1-13, the first step is reading data from the disk into the RAM. The next step is loading data from RAM to the CPU cache. The caching mechanism guesses which data the CPU would need next. The processor reads needed data from the cache to registers. After that, the CPU calls an API function of the system library. The function receives data for printing on the screen. The CPU provides these data to the function. The system library refers to the video card driver. It displays the data on the screen.

The problem may occur when the processor calls a function and pass data to it. If data are in the cache but not in registers, the CPU spends waiting from 2 to 100 cycles (see Table 1-3). If data is in the RAM, the waiting time increases by order of magnitude (up to 1000 cycles). Suppose that the read file is too big. It did not fit into the RAM entirely. The CPU can refer to the part of the file that is not in the RAM. In this case, the CPU idle time increases by four orders of magnitude (up to 10000000 clock cycles). For comparison, the CPU could execute about 1000000 program instructions during this time.

The caching mechanism loads data into the CPU cache. An example of reading a file showed how each error of this mechanism is expensive. Such an error is called **cache miss**. Remember the memory hierarchy and consider it when developing algorithms. Some algorithms and data structures cause more cache misses than others.

The memory devices with shorter access times are placed closer to the processor. Figure 1-14 demonstrates this principle. For example, the internal memory of the CPU (registers and cache) is inside its chip. The RAM is located on [**motherboard**](https://en.wikipedia.org/wiki/Motherboard) next to the CPU. There is the high-frequency [**data bus**](https://en.wikipedia.org/wiki/Bus_(computing)) between CPU and RAM. The disk drive is connected to the motherboard via a relatively slow data bus. [**SATA**](https://en.wikipedia.org/wiki/Serial_ATA) is an example of such a bus.

There is a system controller that uploads data from RAM to the CPU cache. The controller is called [**northbridge**](https://en.wikipedia.org/wiki/Northbridge_(computing)). In earlier versions of personal computers, it was a separate chip on the motherboard. Processor manufacturing technology has evolved. As a result, the northbridge is built into the processor chip nowadays.

The [**southbridge**](https://en.wikipedia.org/wiki/Southbridge_(computing)) controller reads data from the hard drive into RAM.

{caption: "Figure 1-14. PC motherboard", height: "50%"}
![PC motherboard](images/GeneralInformation/motherboard-memory.png)

## Machine code

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