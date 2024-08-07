# most_common_byte 

Find the most common byte in a list. 
Assumptions for this program: 

A byte will not be more then 0xff, thus 256 variations of a given byte. 
The list that you provide it must have at least 1 element. 


## Compile

I used GCC to compile. 
Feel free to use whatever you like the best to compile the program.
<br>
<br>

### Compiling into an ELF-file: 
```sh
gcc -nostdlib -o most_common.o most_common.s
```

<i> (Exctract binary code from the ELF-file) </i> 
```sh
objcopy -O binary --only-section=.text most_common.o most_common.bin
```
<br>
<b> Feel free to use naming conventions of your choice </b>
