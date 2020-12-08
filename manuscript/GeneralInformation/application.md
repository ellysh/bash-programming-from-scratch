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