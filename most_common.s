
.intel_syntax noprefix
.global _start


_start: 

# Set up the base of the stack as the current top

mov rbp, rsp 
sub rsp, 0x100 # Allocate 256 bytes onto the stack

# This value can be changed depending on how much variations of a byte you can have 
# This is based on the assumption that a byte will not be more then 0xFF 
# Index of the most common byte will get returned in rax (calling convention)

mov rcx, rbp # Move the base pointer into rdx 
sub rcx, 0x100 # rcx now points to the start of the counting buffer 


# Function takes two parameters: 
# Source of the address where the list of bytes is stored - rdi  
# Size of the list - rsi

.COUNT_BUFFER:

	xor r8, r8 
	xor rax, rax

	sub rsi, 1

	.COUNT_LOOP: 
	cmp r8, rsi
       	jg .FIND_MAX # If all the bytes in the list have been indexed jump to .FIND_MAX 
	mov al, byte ptr [rdi+r8]
	movzx rdx, al 

	mov rbx, rcx 
	add rbx, rdx
	inc byte ptr[rbx] # Increment the value at the specific counting address for the specific byte by 1
	
	inc r8 
	jmp .COUNT_LOOP


.FIND_MAX: 

	xor r8, r8 
	xor r9, r9 
	xor rax, rax 

	.FIND_MAX_LOOP: 
	cmp r8, 0xFF
	ja .DONE

	add rcx, r8  # add to rcx so that we iterate over each value in the counting list 
	cmp byte [rcx], r9b 
	jbe .NO_UPDATE # If the value is below or equal, jump to .NO_UPDATE and onto the next value on the list
	# We need to make sure that we iterate over all the values to find the biggest one which is the most common byte
	
	mov r9b, byte ptr[rcx]
	mov al, r8b # Move the index of the higest value into 'al', because rax is the return of this function 

	.NO_UPDATE:
	inc r8
	jmp .FIND_MAX_LOOP 

	.DONE:
	# Free the allocated space and restore the stack pointer
       	xor rbx, rbx # Restore function preserved register so that we won't alter the calling function
	add rsp, 0x100
	mov rsp, rbp
	ret






