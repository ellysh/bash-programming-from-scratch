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

Why did we start studying programming by looking at the OS? Figure 1-4 illustrates the OS's interaction with [**applications**] (https://ru.wikipedia.org/wiki/Прикладное_программное_обеспечение) and [**hardware**] (https://ru.wikipedia.org/wiki/Аппаратное_обеспечение). Applications are applications that solve user tasks (e.g. text editor, calculator, browser). Hardware means all electronic and mechanical components of a computer (for example, keyboard, monitor, central processor, video card).

{caption: "Ficgure 1-4. Scheme of interaction between OS and programs and hardware", height: "50%"}
![Схема взаимодействия ОС](images/GeneralInformation/operating-system.png)

According to the scheme, applications do not access hardware resources directly, but through [**system libraries**] (https://ru.wikipedia.org/wiki/Библиотека_(programming)). OS. This access is granted by certain rules. The program works only with those features of devices that are supported by the OS. Device rules are defined in [**application Programming Interface**]((https://ru.wikipedia.org/wiki/API)), also known as the API (Application Programming Interface), which is provided by the system libraries. An API is a set of agreements on how information system components interact. As a rule, the interfaces are described in the standards. Thanks to them, the compatibility of system components is guaranteed.

The API interface describes the following aspects of interaction between programs and the operating system:

1. What operation will be performed when a specific OS function is called?

2. What data should be transferred to it at the input?

3. Which data will the function return as a result?

Following the interface is very important on both the OS and application sides. This guarantees their compatibility at the level of current versions and future modifications. Without a well documented, standardized interface this compatibility would not have been possible.

We have already discovered that applications can operate without an OS. However, it offers ready-made solutions for interaction with the hardware resources of the computer, which otherwise would have to be solved by the developers of applications. It is a huge job. Especially when you consider the variety of components of modern computers. All models of devices (for example, video cards) must be supported, otherwise the program will not be able to work stably with all users.

Let's find out what features the modern OS provides through its API interface.

All electronic and mechanical components of the computer (hardware), can be considered as some resources needed for calculations. It is with these components that user programs are executed.

The interface reflects not only the list of hardware features that the program can use. It also establishes the order of interaction between several programs and the hardware. Let's have a look at an example.

Two programs cannot simultaneously write data to [hard disk] (https://ru.wikipedia.org/wiki/Жёсткий_диск#Технологии_записи_данных) in the same area. First, the recording is performed by a single magnetic head of the hard disk. Secondly, the data recorded by the first application will be wiped with the data of the second one. Therefore, simultaneous requests of the programs for recording should be blocked or placed in a queue and executed one after another. These mechanisms are the responsibility of the OS, to be more precise its [**core**] (https://ru.wikipedia.org/wiki/Ядро_операционной_системы) (see illustration 1-4), in which [**file system**] (https://ru.wikipedia.org/wiki/Файловая_система) is implemented. In a similar fashion, the OS organizes access to all [**peripheral**](https://ru.wikipedia.org/wiki/Периферийное_устройство) and your computer's internal devices. This access is provided through special programs called [**device drivers**](https://ru.wikipedia.org/wiki/Драйвер) (see illustration 1-4).

What are peripherals, and how do they differ from internal devices? Peripherals are all devices that are responsible for inputting, outputting, and storing information permanently. For example, keyboard, mouse, microphone, monitor, speakers, hard drive. Internal devices are responsible for information processing, i.e. direct execution of programs. These include [**central processing unit**] (https://ru.wikipedia.org/wiki/Центральный_процессор) (central processing unit, CPU), [**RAM**] (https://ru.wikipedia.org/wiki/Оперативная_память) (random-access memory, RAM), [**video card**] (https://ru.wikipedia.org/wiki/Видеокарта) (graphics processing unit, GPU).

The hardware access interface is not the only thing the OS provides. In addition to hardware, there are also software resources for the OS. This is the same repetitive code that over time has become a service program and is later processed into system libraries (see illustrations 1-4). Some of them serve the devices, but some perform useful operations on the input data. For example, a Windows component called [**Graphics Device Interface**] (https://ru.wikipedia.org/wiki/GDI) allows applications to manipulate graphics objects. With these, developers can create a user interface for their programs. Software resources include all OS components installed on your computer. In addition, the OS may also provide access to third party algorithms or libraries.

The OS not only manages the resources, but also organizes the work of running applications. First of all the application code should be downloaded from [**information storage devices**] (https://ru.wikipedia.org/wiki/Компьютерная_память) (whether it is a punch card or a hard drive) and placed in the computer RAM. This procedure is non-trivial, because you also need to download the code of all third-party libraries that the application uses while running. We will describe the process of launching and executing the program in more detail in the next section.

If the OS is multi-user, it controls the access to the data. This way, each user can only work with his own files and directories.

Let's sum it up. The operating system has the following functions:

1. Provides and arranges access to hardware resources of the computer.

2. Provides program resources in the form of system libraries.

3. Runs applications, and is responsible for entering data for them and outputting the result.

4. organizes the interaction of applications with each other.

5. Controls user access to their data.

Having studied these functions, the attentive reader may have guessed that without the OS it is impossible to execute several applications simultaneously. After all, their developers can not foresee in what combination the programs will be executed. Only the OS has enough information to effectively allocate computer resources in real time.

### Современные ОС

Мы рассмотрели основные возможности ОС. Теперь с учётом наших новых знаний поговорим о современных ОС. Они отличаются друг от друга не столько предоставляемыми функциями, которые у них аналогичны, сколько способами их реализации. Эти особенности реализации и решения, которые к ним привели, называются [**архитектурой**](https://ru.wikipedia.org/wiki/Архитектура_программного_обеспечения).

У всех современных ОС есть две важные особенности, которые во многом определяют их поведение и способ взаимодействия с пользователем. Речь идёт о многозадачности и графическом интерфейсе. Рассмотрим их подробнее.

#### Многозадачность

Подавляющее большинство современных ОС [**многозадачны**](https://ru.wikipedia.org/wiki/Многозадачность). Это означает, что они поддерживают одновременное исполнение нескольких программ. Почему это свойство оказалось важным? Ведь системы, обладающие этим свойством, вытеснили те, у которых его не было.

Задача увеличения эффективности использования компьютеров стояла особенно остро в 1960-е годы. Тогда компьютеры стоили дорого и, следовательно, дорога была каждая минута их работы. Крупные компании и университеты, которые могли позволить себе купить мейнфрейм, считали неприемлемым любой его простой.

Ранние операционные системы позволяли последовательно исполнять программы друг за другом без задержек. Это экономило время, необходимое на переключение компьютера с одной задачи на другую. В таких системах несколько программ и входные данные для них подготавливались заранее и записывались на устройство хранения (например, магнитную ленту). Эта лента подавалась на устройство чтения компьютера. Он последовательно исполнял программы и выводил их результаты на устройство вывода (например, принтер). Такой режим работы получил название [**пакетная обработка**](https://ru.wikipedia.org/wiki/Пакетное_задание) ([batch processing](https://en.wikipedia.org/wiki/Batch_processing)).

Пакетная обработка увеличила эфективность использования времени мейнфреймов. Она автоматизировала загрузку программ и частично исключила из этого процесса человека-оператора. Однако, у системы оставалось ещё одно [**узкое место**](https://ru.wikipedia.org/wiki/Узкое_место). Дело в том, что вычислительная мощность процессоров стала значительно превосходить скорость работы периферийных устройств. Это привело к простоям CPU.

I> Узкое место (bottleneck) — компонент или ресурс информационной системы, который ограничивает её общую производительность или пропускную способность.

Рассмотрим пример. Представьте, что мейнфрейм последовательно выполняет вычислительные программы. Данные для них считываются с магнитной ленты, а результаты печатаются на принтере. ОС загружает каждую программу и исполняет её инструкции, затем загружает следующую и так далее. Проблемы возникают на этапах чтения данных и печати результата. Время доступа к данным на магнитной ленте огромно в масштабах центрального процессора. Между двумя последовательными операциями чтения, он мог бы выполнить значительный объём вычислений. Но он этого не делает, поскольку все ресурсы компьютера используются только текущей программой, которая в данный момент загружается в память. То же самое происходит с выводом результатов расчётов на печать. Принтер, как чисто механическое устройство, работает очень медленно. Эта проблема простоя оборудования и привела к идее [**мультипрограммирования**](https://ru.wikipedia.org/wiki/Мультипрограммирование).

Мультипрограммирование подразумевает одновременную загрузку сразу нескольких программ в память компьютера. Первая из них начинает выполняться до тех пор, пока доступны все необходимые ей ресурсы. Как только один из ресурсов оказывается занят, её выполнение останавливается. Например, программе нужны данные, хранящиеся на жёстком диске. Пока контроллер читает первую их часть, он занят и не может обработать запрос на чтение следующей части. В этом случае ОС прекращает выполнение первой программы и переключается на вторую. Она в свою очередь исполняется до конца или до того момента, когда нужный ей ресурс окажется занят. После этого опять происходит переключение.

Мультипрограммирование стало ранним прототипом многозадачности, которая реализована во всех современных ОС. Мультипрограммирование хорошо справляется с режимом пакетной обработки. Однако, этот подход распределения нагрузки совершенно не подходит для систем, предусматривающих [**интерактивное взаимодействие**](https://ru.wikipedia.org/wiki/Интерактивность). В них каждое действие пользователя (например, нажатие клавиши) является событием, которое требует какой-то реакции со стороны системы (например, добавление нового символа в текстовый документ). Обработка событий должна происходить с минимальными задержками, иначе пользователь заметит зависания работающей программы. Проблема мультипрограммирования в том, что очередная задача выполняется непредсказуемо долго. До тех пор пока текущая программа не выполнена до конца или ей не был запрошен занятый ресурс, переключения задачи не произойдёт и никакие действия пользователя не могут быть обработаны.

Многозадачность решает проблему быстрого отклика при интерактивной работе с компьютером. Способ её реализации постепенно развивался и усложнялся. В современных ОС применяется [**вытесняющая многозадачность**](https://ru.wikipedia.org/wiki/Вытесняющая_многозадачность) с псевдопараллельной обработкой задач. Это означает, что ОС самостоятельно принимает решение о том, какая программа будет выполняться в данный момент времени. При этом выборе учитываются приоритеты работающих приложений. То есть более приоритетные будут получать аппаратные ресурсы чаще, чем низкоприоритетные. Механизм переключения задач реализован в ядре ОС и называется [**планировщиком задач**](https://ru.wikipedia.org/wiki/Диспетчер_операционной_системы).

Псевдопараллельность обработки означает, что в каждый момент времени выполняется только одна задача. При этом переключение между задачами происходит настолько быстро, что пользователь этого не замечает. Ему кажется, что компьютер сразу реагирует на любое его действие. Однако на самом деле, каждая программа и компонент ОС получают аппаратные ресурсы в строго определённые моменты времени.

В случае компьютеров с несколькими процессорами или [многоядерными](https://ru.wikipedia.org/wiki/Ядро_микропроцессора) процессорами одновременно исполняются несколько программ. Грубо говоря, число одновременно выполняемых задач равно числу ядер всех процессоров компьютера. При этом принцип вытесняющей многозадачности с постоянным переключением задач сохраняется. Он универсален и хорошо справляется с балансировкой нагрузки многопроцессорных и многоядерных систем. Это позволяет выдерживать приемлемое время отклика на действия пользователя.

#### Интерфейс пользователя

Ещё одна общая черта современных ОС для [**персональных компьютеров**](https://ru.wikipedia.org/wiki/Персональный_компьютер) (ПК) и ноутбуков — это наличие [**графического интерфейса пользователя**](https://ru.wikipedia.org/wiki/Графический_интерфейс_пользователя) (graphical user interface или GUI). С его помощью пользователь может запускать приложения, а также конфигурировать аппаратное обеспечение и компоненты ОС. Рассмотрим подробнее историю его возникновения.

Интерактивный способ работы с компьютером стал известен широкому кругу пользователей только в 1960 году после анонса [мини-компьютера](https://en.wikipedia.org/wiki/Minicomputer) [PDP-1](https://ru.wikipedia.org/wiki/PDP-1) фирмой [Digital Equipment Corporation](https://ru.wikipedia.org/wiki/Digital_Equipment_Corporation). Может быть не совсем понятна причина, по которой конструкторы и пользователи компьютеров вообще заинтересовались интерактивностью. В 1950-е годы на рынке мейнфреймов доминировали компьютеры IBM. Они работали в режиме пакетной обработки и успешно справлялись с вычислительными задачами того времени. Их операционные системы с поддержкой мультипрограммирования автоматизировали загрузку программ и обеспечивали хорошую производительность.

Идея интерактивной работы с компьютером возникла в рамках военного проекта SAGE, выполнявшегося по заказу ВВС США. Проект заключался в разработке автоматизированной системы ПВО для обнаружения советских бомбардировщиков. Проблема, которую решали конструкторы, заключалась в обработке данных с радаров. Эти данные выводились человеку-оператору, который в режиме реального времени отдавал команды системе ПВО. Для решения этой задачи требовались новые методы работы с компьютером. Существовавшие в то время подходы (наподобие пакетной обработки) не удовлетворяли требованиям проекта, поскольку система ПВО должна реагировать максимально быстро на обнаруженную угрозу. В ходе проекта SAGE был сконструирован первый интерактивный компьютер [AN/FSQ-7](https://en.wikipedia.org/wiki/AN/FSQ-7_Combat_Direction_Central) (см иллюстрацию 1-5). В нём данные о воздушных угрозах выводились на [**электронно-лучевой монитор**](https://ru.wikipedia.org/wiki/Кинескоп), а для ввода команд использовалось [**световое перо**](https://ru.wikipedia.org/wiki/Световое_перо).

{caption: "Иллюстрация 1-5. Компьютер AN/FSQ-7"}
![Компьютер AN/FSQ-7](images/GeneralInformation/AN-FSQ-7.jpg)

Метод интерактивной работы с компьютером стал известен в научных кругах и быстро набрал популярность. Главная проблема пакетной обработки связана с растянутой по времени разработкой и отладкой программ. После подготовки алгоритма и записи его на устройство хранения, программисту приходилось часами ждать результатов его выполнения на мейнфрейме. Компьютеры в то время были очень загружены работой и все поступающие программы обрабатывались в порядке очереди. Если в программе обнаруживалась ошибка, её алгоритм исправлялся, записывался на устройство хранения и снова попадал в очередь на исполнение. Таким образом до момента исправления всех ошибок и получения нужного результата проходили дни.

Интерактивный режим позволял программисту запускать программу и сразу по её завершению выводить на экран результат. Благодаря этому, продуктивность работы с компьютером значительно возрастала. Можно было за несколько часов добиться результатов, на которые раньше требовались дни.

Появление интерактивного режима привело к новым задачам. Прежде всего понадобился новый способ балансирования нагрузки, который бы позволил добиться приемлемого времени отклика системы на действия пользователя. Как мы уже знаем, многозадачность новых ОС решила эту проблему.

На самом деле интерактивный режим возможен и на однозадачных ОС (например, [MS-DOS](https://ru.wikipedia.org/wiki/DOS)). Однако, совмещение интерактивности и однозадачности стало целесообразно только с появлением относительно дешёвых персональных компьютеров. Во времена дорогих мейнфреймов, ресурсы одного компьютера одновременно предоставлялись нескольким пользователям. Каждый из них запускал свои программы, которые выполнялись параллельно. Такой режим работы получил название [**разделение времени**](https://ru.wikipedia.org/wiki/Разделение_времени) (time-sharing). Без многозадачности обеспечить интерактивную работу нескольких пользователей было невозможно.

Другая задача, поставленная интерактивным режимом, связана со способом взаимодействия пользователя и компьютера. Как именно должны выглядеть и работать устройства ввода и вывода информации, чтобы ими было удобно пользоваться? Однозначных ответов на эти вопросы в 1960-х годах ещё не было.

Прототипом первого пользовательского интерфейса для компьютера стало устройство под названием [**телетайп**](https://ru.wikipedia.org/wiki/Телетайп) (teletype) (см. иллюстрацию 1-6). Он представляет собой электромеханическую печатную машинку, подключённую с помощью проводов к другому такому же устройству. Ранние версии телетайпа использовались для передачи текстовых сообщений между двумя абонентами. Отправитель набирал текст на своём устройстве. Каждое нажатие клавиши передавалось на устройство получателя и распечатывалось в виде буквы на бумаге.

{caption: "Иллюстрация 1-6. Телетайп Model 33", height: "50%"}
![Телетайп Model 33](images/GeneralInformation/teletype.jpg)

Телетайпы стали применять для удалённого доступа к мейнфреймам. Такое устройство получило название [**терминал**](https://ru.wikipedia.org/wiki/Компьютерный_терминал). Пользователи набирали на клавиатуре команды, которые затем отправлялись на компьютер. Он их выполнял и отправлял результат обратно на терминал, который распечатывал полученные данные на бумаге. Позднее устройство печати заменили на монитор. В результате получился [**интерфейс командной строки**](https://ru.wikipedia.org/wiki/Интерфейс_командной_строки) (command-line interface или CLI). Принцип его работы напоминает классический телетайп — пользователь вводит команды одну за другой. Компьютер их последовательно исполняет и выводит на экран результат.

Пример современного интерфейса командной строки приведён на иллюстрации 1-7. Это окно [**эмулятора терминала**](https://ru.wikipedia.org/wiki/Эмулятор_терминала) [Terminator](https://en.wikipedia.org/wiki/Terminator_(terminal_emulator)), в котором запущен интерпретатор командной строки Bash. В окне выведены результаты работы программ ping и ls.

{caption: "Иллюстрация 1-7. Интерфейс командной строки", height: "50%"}
![Интерфейс командной строки](images/GeneralInformation/cli.png)

Интерфейс командной строки активно применяется и сегодня. У него есть ряд преимуществ перед более привычным для пользователей графическим интерфейсом. Главное преимущество CLI в том, что он не требователен к вычислительным ресурсам. Он работает одинаково стабильно и без задержек как на низкопроизводительных встраиваемых компьютерах, так и на мощных серверах. Если применять CLI для удалённого доступа к компьютеру, он не требователен к качеству канала связи и его пропускной способности. Даже с медленным соединением команды будут переданы на сервер без искажений и исполнены.

Главная проблема интерфейса командной строки заключается в сложности его освоения. Пользователю доступны сотни команд с различными входными параметрами, которые определяют их режим работы. Чтобы запомнить хотя бы часто используемые команды, требуется немало времени.

Попытки решить проблему с наглядным представлением доступных команд и результатов их работы, привели к созданию [**текстового интерфейса пользователя**](https://ru.wikipedia.org/wiki/Текстовый_интерфейс_пользователя) (textual user interface или TUI). В нём наряду с буквенными и цифровыми символами используется [**псевдографика**](https://ru.wikipedia.org/wiki/Псевдографика). Псевдографикой называются специальные символы, с помощью которых на экране отображаются графические примитивы (например, линии, прямоугольники, треугольники и т.д.). Иллюстрация 1-8 демонстрирует типичный текстовый интерфейс. Это вывод статистики использования системных ресурсов программой htop.

{caption: "Иллюстрация 1-8. Текстовый интерфейс пользователя", height: "50%"}
![Текстовый интерфейс пользователя](images/GeneralInformation/tui.png)

Дальнейший рост производительности компьютеров позволил заменить псевдографику на реальные графические элементы такие как окна, иконки, кнопки и т.д. В результате возник полноценный графический интерфейс, который применяется в современных ОС.

Графический интерфейс ОС Windows приведён на иллюстрации 1-9. Это скриншот рабочего стола с развёрнутыми окнами трёх одновременно работающих приложений: Проводника, Блокнота и Калькулятора.

{caption: "Иллюстрация 1-9. Графический интерфейс пользователя"}
![Графический интерфейс пользователя](images/GeneralInformation/gui.png)

Первый графический интерфейс был разработан для мини-компьютера [Xerox Alto](https://ru.wikipedia.org/wiki/Xerox_Alto) (см. иллюстрацию 1-10) в 1973 году в исследовательском центре [Xerox PARC](https://ru.wikipedia.org/wiki/Xerox_PARC). Однако, интерфейс не получил широкого распространения вплоть до 1980-х годов из-за его высоких требований к памяти и производительности компьютеров. Первый ПК Lisa с графическим интерфейсом был выпущен на рынок компанией Apple только в 1983 году.

{caption: "Иллюстрация 1-10. Мини-компьютер Xerox Alto", height: "50%"}
![Мини-компьютер Xerox Alto](images/GeneralInformation/xerox-alto.jpg)

#### Семейства ОС

Сегодня на рынке персональных компьютеров доминируют три семейства ОС:

* [Windows](https://ru.wikipedia.org/wiki/Windows)
* [Linux](https://ru.wikipedia.org/wiki/Linux)
* [macOS](https://ru.wikipedia.org/wiki/MacOS)

Что именно подразумевается, когда говорят о семействе ОС? Этот термин означает ряд версий ОС, которые следуют одним и тем же архитектурным решениям, а также сохраняют некоторые особенности реализации тех или иных функций.

Почему разработчики каждой ОС предпочитают придерживаться одной и той же архитектуры, а не предлагают что-то принципиально новое в следующих версиях? На самом деле изменения в современных ОС происходят, но постепенно и медленно. Причина этого в [**обратной совместимости**](https://ru.wikipedia.org/wiki/Обратная_совместимость). Эта совместимость предполагает наличие некоторых старых функций в новой версии ОС. Они нужны для корректной работы написанных ранее программ. На первый взгляд это требование может показаться необязательным. Но на самом деле это серьёзное ограничение для разработки программного обеспечения. Давайте разберёмся, почему это так.

Представьте, что вы разработали программу для ОС Windows и продаёте её. Иногда пользователи обнаруживают в ней ошибки, которые вы успешно исправляете. Время от времени вы добавляете в неё новые функции. Теперь представьте, что выходит новая версия Windows, на которой ваша программа перестаёт работать. У пользователей есть два решения: ждать от вас новой версии программы, в которой проблема решена, или отказаться от обновления Windows. Теперь предположим, что новая версия ОС принципиально отличается от предыдущей. Это значит, что вашу программу придётся переписать буквально с нуля. Посчитайте всё время, которое вы уже потратили на исправление ошибок и добавление новых функций. Эту работу в полном объёме придётся повторить. Скорее всего вы откажетесь от этой идеи и предложите пользователям оставаться на старой версии Windows. Теперь представьте, что таких программ как ваша много. Их разработчики придут к тому же решению, что и вы. В результате новая версия Windows окажется никому не нужна. В этом и заключается проблема обратной совместимости. Именно поэтому и существуют семейства ОС.

Влияние приложений, доступных под конкретную ОС, сложно переоценить. Например, ОС Windows и персональные компьютеры от IBM обязаны своим успехом табличному процессору [Lotus 1-2-3](https://ru.wikipedia.org/wiki/Lotus_1-2-3). Он запускался только на ПК от IBM, работающих под управлением Windows. Ради Lotus 1-2-3 пользователи покупали и первое и второе. Такие популярные приложения, выводящие какую-то платформу на широкий рынок, получили название [**killer application**](https://ru.wikipedia.org/wiki/Killer_application) (букв. убойное приложение). Похожая ситуация сложилась с табличным процессором [VisiCalc](https://ru.wikipedia.org/wiki/VisiCalc), который способствовал распространению компьютеров [Apple II](https://ru.wikipedia.org/wiki/Apple_II). Точно так же бесплатные компиляторы языков C, Fortran и Pascal подогрели интерес к Unix в университетских кругах. За каждой из трёх доминирующих сегодня ОС стоит какое-то killer application. Далее распространению этих ОС способствовал [сетевой эффект](https://ru.wikipedia.org/wiki/Сетевой_эффект), когда разработчики приложений выбирали в качестве целевой программной платформы именно ту, которая уже была установлена на компьютеры большинства пользователей.

Вернёмся к нашему списку семейств ОС. Windows и Linux примечательны тем, что не привязаны к конкретной аппаратной платформе. Это значит, что купив любой персональный компьютер или ноутбук, вы без особых трудностей сможете установить на него эти ОС. macOS в отличие от них рассчитана на запуск только на устройствах Apple. Чтобы установить macOS на другую аппаратную платформу, вам понадобится её неофициальная [модифицированная версия](https://ru.wikipedia.org/wiki/OSx86). Совместимость с аппаратной платформой — это хороший пример архитектурного решения. Но таких решений много, и все вместе они формируют особенности каждого семейства.

ОС во многом определяет инфраструктуру, доступную программисту. Она диктует не только инструменты разработки, такие как IDE, компилятор, система сборки, но и некоторые архитектурные решения самих запускаемых на ней приложений. Можно говорить о некоторой сложившейся культуре написания программ под конкретную ОС. Это очень важный момент, который следует всегда учитывать: под разные ОС программы принято разрабатывать по-разному.

Рассмотрим различие культур разработки программ подробнее на примере Windows и Linux.

#### Windows

Windows — это [проприетарная](https://ru.wikipedia.org/wiki/Проприетарное_программное_обеспечение) ОС. Исходные коды проприетарного программного обеспечения закрыты для постороннего изучения и модификации. Вы не сможете законным способом узнать о нём больше, чем разработчики посчитают нужным вам сообщить. Чтобы установить Windows на свой компьютер, вам надо купить её у компании Microsoft. Однако, часто эта ОС уже предустановлена на новые компьютеры и ноутбуки, а её цена включена в конечную стоимость устройства.

Обратите внимание, что целевой платформой Windows были и остаются относительно дешёвые персональные компьютеры. Многие могут позволить себе купить такое устройство. Следовательно, рынок потенциальных пользователей огромен. Microsoft стремится всеми силами сохранить конкурентное преимущество на этом рынке. Компания опасается появления аналогов своей ОС с такими же возможностями. Именно поэтому Microsoft заботится о защите своей интеллектуальной собственности не только техническими, но и юридическими путями. Строго говоря, пользовательское соглашение запрещает вам исследовать внутреннее устройство ОС.

За всё время существования семейства ОС Windows под него было написано много прикладных программ. Первые из них (например, пакет офисных приложений [Microsoft Office](https://ru.wikipedia.org/wiki/Microsoft_Office) или [стандартные приложения Windows](https://ru.wikipedia.org/wiki/Категория:Стандартные_приложения_Windows)) создавались самой компанией Microsoft. Для сторонних разработчиков они послужили в некотором роде образцом для подражания. Microsoft при разработке своих приложений придерживалась того же принципа закрытости, что и при разработке ОС: исходные коды недоступны конечным пользователям, форматы данных недокументированны, сторонние утилиты не могут получить доступа к возможностям приложений. Опять же все эти решения были продиктованы заботой о защите интеллектуальной собственности компании от конкурентов.

Сторонние разработчики программ последовали примеру Microsoft и зачастую стали придерживаться той же философии закрытости. Большинство получившихся приложений самодостаточны и независимы друг от друга. Форматы их данных, как правило, закодированы и недокументированны.

Если вы опытный пользователь компьютера, то сразу узнаете типичное Windows приложение. Это окно с такими [элементами интерфейса](https://ru.wikipedia.org/wiki/Элемент_интерфейса), как кнопки, поля ввода, вкладки и т.д. Через это окно пользователь манипулирует каким-то данными (например, текстом, изображением или звуковой записью). Результат работы сохраняется на жёсткий диск компьютера и может быть повторно загружен в том же самом приложении. Очень велика вероятность, что если вы напишете собственную Windows-программу, она будет выглядеть и работать похожим образом. Именно такая преемственность решений и имеется ввиду, когда мы говорим о сложившейся культуре разработки под конкретную ОС.

#### Linux

Linux является идейным наследником ОС [Unix](https://ru.wikipedia.org/wiki/Unix) и следует её [**спецификациям**](https://ru.wikipedia.org/wiki/Спецификация). Спецификация — это документ с требованиями к системе, который также определяет её поведение и внутреннее устройство. Получается, что Linux заимствовал многие идеи и решения Unix, что в результате привело к похожему поведению.

Сама Unix возникла в конце 1960-х годов. Она создавалась как хобби-проект двумя инженерами компании Bell Labs: [Кеном Томпсоном](https://ru.wikipedia.org/wiki/Томпсон,_Кен) и [Деннисом Ритчи](https://ru.wikipedia.org/wiki/Ритчи,_Деннис). Они участвовали в крупном проекте компании по разработке ОС [**Multics**](https://ru.wikipedia.org/wiki/Multics) для нового мейнфрейма GE-645 (см. иллюстрацию 1-11) от компании General Electric. Кроме Bell Labs и General Electric над проектом также работал Массачусетский Технологический Институт (MIT).

{caption: "Иллюстрация 1-11. Мэйнфрейм модели GE-645", height: "30%"}
![Мэйнфрейм модели GE-645](images/GeneralInformation/ge-645.jpg)

В ОС Multics планировалось реализовать много инновационных для того времени идей. Одной из них было разделение времени. Как вы помните, это означает, что с одним мейнфреймом одновременно может работать несколько пользователей. При этом вычислительные ресурсы компьютера разделяются между ними с помощью многозадачности.

Разработка Multics затягивалась и Bell Labs решила выйти из проекта. Однако многие инженеры компании хотели продолжать работу над ним. На этой волне Кен Томпсон решил создать собственную ОС для компьютера GE-645. Для этого он начал писать ядро и продублировал некоторые механизмы Multics. Однако, General Electric потребовала вернуть свой дорогой мейнфрйем, переданный Bell Labs во временное пользование. В результате Кен Томпсон остался без аппаратной платформы для разработки.

Параллельно с работой над аналогом Multics Кен писал компьютерную игру [Space Travel](https://ru.wikipedia.org/wiki/Space_Travel). Она запускалась на мейнфрейме General Electric прошлого поколения GE-635, который работал под управлением ОС [GECOS](https://ru.wikipedia.org/wiki/GCOS). Этот компьютер представлял собой шкафы с электроникой и стоил порядка 7 500 000$. Его вычислительные ресурсы активно использовались для нужд компании и были постоянно заняты. Поэтому Кен решил портировать свою игру на относительно недорогой и реже используемый коллегами мини-компьютер [PDP-7](https://ru.wikipedia.org/wiki/PDP-7) (см. иллюстрацию 1-12) стоимостью порядка 72 000$. Проблема заключалась в том, что игра использовала возможности ОС GECOS, которые были недоступны на PDP-7. Поэтому Кену и присоединившемуся к нему Деннису пришлось реализовать эти возможности в виде набора библиотек и систем, которые впоследствии развились в самостоятельную ОС Unix.

{caption: "Иллюстрация 1-12. Мини-компьютер PDP-7", height: "30%"}
![Мини-компьютер PDP-7](images/GeneralInformation/pdp-7.jpg)

Очевидно, в своём проекте разработчики Unix не заботились о защите интеллектуальной собственности, поскольку не собирались её продавать. ОС разрабатывалась для собственных нужд и распространялась с открытым исходным кодом, доступным для изучения и модификации любым желающим. Изначально круг пользователей ограничивался сотрудниками компании Bell Labs. Позднее AT&T, которой принадлежала Bell Labs, предоставила исходный код Unix высшим учебным заведениям США. Таким образом развитие ОС продолжилось уже в университетских кругах.

ОС Linux была создана в 1991 году [Линусом Торвальдсом](https://ru.wikipedia.org/wiki/Торвальдс,_Линус) во время его обучения в Хельсинкском университете. Линус решал чисто практическую проблему: в то время персональные компьютеры не имели полноценной Unix-совместимой ОС. В университете студенты выполняли учебные задания на мини-компьютере MicroVAX под управлением Unix, но дома у них не было оборудования, подходящего для её запуска. Единственной альтернативой Unix была ОС [Minix](https://ru.wikipedia.org/wiki/Minix), разработанная Эндрю Таненбаумом в 1987 году для персональных компьютеров IBM с процессорами Intel 80268. Но эта ОС создавалась для учебных целей, и поэтому Эндрю отказывался вносить в неё изменения для поддержки более современных компьютеров. Эти изменения неизбежно привели бы к усложнению системы и сделали бы её непригодной для обучения студентов.

Линус задался целью написать Unix-совместимую ОС для своего нового компьютера IBM с процессором Intel 80386. Её прототипом стала учебная ОС Minix. Как и у создателей Unix, у него не было коммерческих интересов, связанных с продажей результата своего труда. Он разрабатывал систему для собственных нужд. Поэтому его ОС стала бесплатной и свободно распространялась с исходным кодом через интернет.

На самом деле Linux — это не более чем ядро ОС, предоставляющее функции для работы с памятью, файловой системой, периферийными устройствами, а также управлением процессорным временем. Большинство функций системы доступны через свободные [пользовательские компоненты GNU](https://ru.wikipedia.org/wiki/Проект_GNU), которые Линус включил в [дистрибутив](https://ru.wikipedia.org/wiki/Дистрибутив_Linux) своей ОС.

Изначально у Linux, как у и Unix, не было графической подсистемы. Все приложения пользователь запускал из командной строки. Только некоторые сложные приложения имели текстовый интерфейс. Со временем в Linux появилась оконная система [X Window System](https://ru.wikipedia.org/wiki/X_Window_System), а вместе с ней и приложения с графическим интерфейсом, более привычные пользователям Windows.

Условия в которых возникла и развивалась ОС Unix (а позднее и Linux), во многом определили культуру написания приложений. В этой культуре предпочтение отдаётся узкоспециализированным утилитам командной строки, которые выполняют только одну конкретную задачу, но делают это максимально эффективно. Эти утилиты выводят свои результаты в открытом формате данных (как правило [текстовом](https://ru.wikipedia.org/wiki/Текстовые_данные)), а их исходный код всегда доступен для изучения и модификации.

Культура разработки приложений в Linux значительно отличается от стандартов, принятых в Windows. В Windows каждое приложение монолитно и самостоятельно выполняет все свои задачи. Оно не полагается на сторонние утилиты, которые могут оказаться платными или недоступными для пользователя по какой-то причине. Разработчик должен рассчитывать только на себя. Он не в праве требовать от пользователя купить что-то дополнительное для работы своего приложения. В Linux же подавляющее большинство утилит бесплатны, взаимозаменяемы и легко доступны через интернет. Поэтому вполне естественно, что какое-то приложение потребует загрузить и установить недостающие ему системные компоненты или другое приложение.

Даже монолитные графические приложения в Linux обычно предоставляют дополнительный интерфейс командной строки. Таким образом они органично вписываются в экосистему и легко интегрируются с другими утилитами и приложениями.

Когда сложный вычислительный процесс строится на сочетании нескольких узкоспециализированных приложений, возникает задача составления алгоритма их совместной работы. Именно для этой задачи была создана [командная оболочка](https://ru.wikipedia.org/wiki/Командная_оболочка_Unix) [Bourne shell](https://ru.wikipedia.org/wiki/Bourne_shell) и её потомок [Bash](https://ru.wikipedia.org/wiki/Bash). В этой книге мы будем работать только с Bash, который полностью вытеснил Bourne shell на современных Linux-системах.

Стоит признать, что нельзя отдать однозначное предпочтение культуре Linux перед Windows. Их сравнение давно служит поводом для бесконечных споров. Каждая из культур имеет свои достоинства и недостатки. Например, широко распространённые в Windows монолитные приложения лучше справляются с задачами, требующими интенсивных расчётов. При комбинации узкоспециализированных Linux-утилит в этом случае возникают накладные расходы, связанные с их запуском и передачей данных между ними. В результате задача выполняется дольше.

Сегодня можно наблюдать синтез культур Windows и Linux. Всё больше коммерческих приложений портируются на Linux: браузеры, инструменты для разработки программ, игры, мессенджеры и т.д. При этом их разработчики часто не готовы вносить изменения, продиктованные Linux-культурой. Такие изменения требуют времени и сил. Кроме того они усложняют сопровождение продукта. Вместо одного приложения получается несколько: под каждую платформу разная версия. Намного проще портировать приложение в том же виде, в каком оно разрабатывалось под Windows. В результате под Linux всё чаще встречаются приложения выполненные в типичном Windows-стиле. О плюсах и минусах этого процесса можно спорить. Но одно очевидно: чем больше приложений запускается на ОС, тем популярнее она становится благодаря сетевому эффекту.

I> Подробнее о культуре разработки в Unix и Linux вы можете узнать из книги [Эрика Реймонда "Искусство программирования в Unix"](https://ru.wikipedia.org/wiki/Философия_Unix#Реймонд:_Искусство_программирования_в_Unix).
