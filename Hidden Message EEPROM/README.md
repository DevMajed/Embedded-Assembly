# Encrypted messages in EEPROM
In this project, there was an encrypted message in the EEPROM of my 328PB board, and the task was to decrypt the message using the decryption algorithm given below, and then transfer the message to RAM, and then examine the RAM in the debugger of Atmell Studii to read the unencrypted message.\ 
Before explaning the project details, here are some general info about EEPROM in AVR Architecture. 


# General information about EEPROM in AVR Architecture 
ATMega 328PB It has 1kB EEPROM, which is non volatile memory, it can mentain the information it has even when power is off.\
EEPROM can store small amount of date and it allow data to be read, writen, earased at byte level.\
in AVR Arch internal EEPROM is not maped to the addressable memory space, it can be acccesed as an external peripheral device using its own regester with read and wririte instruction. That makes EEPROM acesss slower than data and programn memory.\

Program modes:
* Erase & Write (Atomic opretion) takes 3.3ms
* Erase only takes 1.8 ms
* Write only takes 1.8 ms.\
Note that 1.8 ms = 136,000 cycles at 16Mhz\


CPU halt:
* 4 cycels for read
* 2 cycles for write

AVR CPU uses three I\O Regeistor to interact with EEPROM:

1. EEPROM Adress regestor high & low [EEARH and EEARL]
Contains EEPROM address to which data is read/written EEARH and EEARL are high order bits and low order bits respectively. Atmega 328pB has one 1KB of that EEPROM memeory, the lower 10 bits are used for adressing, The rest of the bits, 11 to 15 are unused. the initial value of the regestors are undefind a

<img width="898" alt="Screen Shot 2020-06-03 at 2 10 12 AM" src="https://user-images.githubusercontent.com/57555013/83601842-67219c00-a53f-11ea-965c-dd67e2e837a4.png">


2. EEPROM Data Regestor [EEDR]:
Contains data to be read/written.in Write operation, the EEDR will get the data from EEAR to be writen in EEPROM. in  read operation EEDR contain the data read out from the EEPROM at the adress given by EEAR.\
<img width="921" alt="Screen Shot 2020-06-03 at 2 54 04 AM" src="https://user-images.githubusercontent.com/57555013/83605202-802d4b80-a545-11ea-8556-209c63247e4e.png">


3. EEPROM Control Register [EECR]
used to specify the operation to be preformed on the EEPROM memory.\
Bits 5 and 4 controls the programming mode. 0 – Erase and write, 1 – Erase only, 2 – Write only, 3 - unused. Bit 3 Ready Interrupt Enable
1 – Enable Ready interrupt, 0 – Disables. Bit 2 Master Write Enable and must be set to one to write and will be reset after 4 clock cycles. Bit 1is  Write Enable, When set to one, writes the content of EEDR at EEPROM address EEAR, and here EEMPE must be set to one. bit 0 Read Enable. When set to one, trigger the Read operation, Reads the data at address EEAR and store to EEDR.




<img width="929" alt="Screen Shot 2020-06-03 at 2 22 20 AM" src="https://user-images.githubusercontent.com/57555013/83603387-5888b400-a542-11ea-9b2b-9a343b36c8dc.png">





# Encryption Algorithm & Project info
This was part of a lab in an embedded systems course durring my study for electrical engineering.\ 
Before doing the lab, i needed to test my ability to read from EEPROM to make sure everything is write, and that was the point of the lab, acessing the EEPROM and playing with it.\

Testing:\

The first charictar of the string "ECE 263 Spring 2020" can be found in location 1 of EEPROM,\
The length of the string, 19 in decimal, will be in location 0 of the EEPROM.\
First, We will examine these locations to see if we are reading the EEPROM correctly.\

Within the EEPROM there are several encrypted strings.\
Based on our bench number in the lab we ha , our bench was 1, we had to decrypt the string beginning at hex location:\
Bench#:   1  2 3  4  5  6  7  8   9    10  11 12\
Hex Loc: 20 40 60 80 A0 C0 E0 100 120 140 160 180\

The length of the encrypted string is in the first byte (hex 20, 40, 60, etc).\
The length is not encrypted. The encrypted string begins at the next byte.
We have to decrypt the string and store it in RAM starting at location 0x300 then we  should terminate the string in RAM by a null (0) byte.\
To decrypt each byte of the string, we will Exclusive OR 0xC3 with the byte, before writing it into SRAM.
The code bellow states indicating which IO Registers are used to access the EEPROM and yo show how to write to the EEPROM.\


<img width="523" alt="Screen Shot 2020-06-02 at 8 39 32 PM" src="https://user-images.githubusercontent.com/57555013/83583032-3cb8ea00-a511-11ea-8704-a58f61015ef2.png">

The figure above taken from the lab handout provided by our proffisor for the embedded systems course in UMASS Dartmouth.

# Result



<img width="668" alt="Screen Shot 2020-06-03 at 5 04 03 AM" src="https://user-images.githubusercontent.com/57555013/83617890-ba074d80-a557-11ea-8cba-a11e1f4bbb99.png">


Note that the figures above are from a handout that our proffisor gave to us, for that reason i archeaved this repo becuase he does not want his work to be open source. The code and the sulotions are all mine and anyone welcome to use them


