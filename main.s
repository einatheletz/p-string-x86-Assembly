#311230163  einat heletz
.section	.rodata	            
	.text	                   
str_scanf_digit:
    .string " %d"
str_scanf_string:
    .string " %s"

.globl	main	                
	.type	main, @function	    
main:	                        
	pushq %rbp		               #save the old frame pointer
	movq  %rsp, %rbp	           #create the new frame pointer
    pushq %r15                     #keep the value of calle regster
    pushq %r14                     #keep the value of calle regster
    pushq %r12                     #keep the value of calle regster
    pushq %r13                     #keep the value of calle regster

    subq $4, %rsp                  #memory allocation of 4 byte for the length of the first pstring
    movl $0, (%rsp)             
    movq %rsp, %rsi                #%rsi point to the place in the stack that scanf need to use
    movq $str_scanf_digit, %rdi     
	movq $0, %rax 
	call scanf
    movq $0, %r12
    movb  (%rsp), %r12b            #keep the input in %r12b
    addq $4, %rsp                  #free the memory  that we allocte on the stack
    addq $2, %r12                  #add the 2 byte that thar we wants to allocte  for '\0', and the length
    subq %r12, %rsp                #memory allocation of the first pstring 
    subq $2, %r12                  #return the orgial value of the length
    movb $0,(%rsp)                 #input zero to rsp 
    movb %r12b, (%rsp)             #put length one in the stake
    movq %rsp, %rsi                #%rsi pointer to the length 
    addq $1, %rsi                  #point on the free placese that allocte to the string
    movq $str_scanf_string, %rdi   
    movq $0, %rax
    call scanf                     #get the first string
    movq $0, %r13
    movq  %rsp, %r13               #keep pointer to the start of the first pstring in the stack
   

    subq $4, %rsp                  #memory allocation of 4 byte for the length of the second pstring
    movl $0, (%rsp)                
    movq %rsp, %rsi                #%rsi point to the place in the stack that scanf need to use 
    movq $str_scanf_digit, %rdi
    movq $0, %rax  
    call scanf                    #get the length of the second pstring
    movq $0, %r14
    movb (%rsp), %r14b            #save the input in %r14b
    addq $4, %rsp                 #free the memory  that we allocte on the stack
    addq $2 ,%r14                 #add the 2 byte that thar we wants to allocte  for '\0', and the length
    subq %r14, %rsp               #memory allocation of the second pstring 
    subq $2, %r14                 #return the orgial value of the length
    movb $0,(%rsp)                #input zero to rsp 
    movb %r14b, (%rsp)            #put length of the second pstringin the stake
    movq %rsp, %rsi               #%rsi pointer to the length 
    addq $1, %rsi                 #point on the free placese that allocte to the string
    movq $str_scanf_string, %rdi  
    movq $0, %rax
    call scanf                    #get the second string
    movq  %rsp, %r15              #keep pointer to the start of the second pstring in the stack

    subq $0x4, %rsp               #memory allocation of 4 byte for the case number 
    movl $0,(%rsp)                #input zero to rsp   
    movq %rsp, %rsi               #%rsi point to the empty memory that allcate for the case number
    movq $str_scanf_digit, %rdi
    movq $0, %rax
    call scanf                    #get the cuse number
    movzbq (%rsp), %rdi           #keep the input value i %rdi
    movq  %r13 , %rsi             #pointer to the first pstring in %rsi
    movq  %r15, %rdx              #pointer to the second pstring in %rdx
    call run_func

    addq %r12, %rsp               #free the memory of the fisrt pstring
    addq %r14, %rsp               #free the memory of the second pstring
    addq $4, %rsp                 #free the memory that we add for the length and '/0' in each pstring
    popq %r13                     #retunr the value of %r13
    popq %r12                     #retunr the value of %r12
    popq %r14                     #retunr the value of %r14
    popq %r15                     #retunr the value of %r15

    movq %rbp, %rsp    #restore the old stack pointer - release all used memory.
    popq %rbp        #restore old frame pointer (the caller function frame)
    ret         #return to caller function (OS)




























