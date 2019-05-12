#311230163	einat heletz
	.section	.rodata         
str_twolen:
	.string	"first pstring length: %d, second pstring length: %d\n"
str_outres:
	.string	"length: %d, string: %s\n"
str_replceChar:
	.string "old char: %c, new char: %c, first string: %s, second string: %s\n"
str_scanf_char:
	.string	" %c"
str_scanf_digit:
	.string	" %d"
str_cmpres:
	.string	"compare result: %d\n"
str_inval:
	.string	"invalid option!\n"

jump_table:
	.quad	case_50
	.quad	case_51
	.quad	case_52
	.quad	case_53
	.quad	case_54

	.text                       # the beginning of the code
	.globl	run_func            # global symbol name
	.type	run_func, @function # label run_func, representing the beginning of a function

run_func:
	pushq %rbp				#save the old frame pointer
	movq  %rsp,	%rbp		#create the new frame pointer
	pushq %r15              #keep the value of calle regster
    pushq %r14              #keep the value of calle regster
    pushq %r13              #keep the value of calle regster
    pushq %r12              #keep the value of calle regster
    pushq %rbx              #keep the value of calle regster

  	movq %rdx, %r15        #move the pointer of the second pstring calle regster
	movq %rsi, %r14        #move the pointer of the frist pstring calle regster
	movq $0, %rdx
	movq $0, %rsi     
	subq $50,%rdi     #substract 50 from the number of case
	cmpq $4, %rdi     #check if it defult case
	ja 		defult_case      #defult_case
	jmp 	*jump_table(,%rdi,8)  #go to the right line according to the jump table
	
case_50:
	movq %r14,%rdi             #move the pointer to the first pstring to %rdi
	movq $0, %rdx	
	call pstrlen               #call pstrlen
	movq %r15, %rdi            #move the pointer to the second pstring to %rdi
	movq %rax, %r13            #keep the value  in %r13 cllee regster
	call pstrlen               #call pstrlen
	movq %rax, %rdx            #keep the input in %rdx
	movq $str_twolen, %rdi     #put the output string in %rdi
	movq %r13, %rsi            #save the length of the first pstring in %rsi
	movq $0, %rax            
	call printf               #print
	jmp 	exit

case_51:
    subq $2, %rsp               #memory allocation of 2 byte for the input char
    leaq -1(%rbp),%rsi           #save in %rsi the pointer to the free place on the stack to the first char 
    movq $str_scanf_char, %rdi   
    movq $0, %rax
    call scanf                     #get the first char
    movzbq -1(%rbp), %r12        #keep the first char in %r12 
    leaq  -2(%rbp), %rsi        #save in %rsi the pointer to the free place on the stack to the second char  
    movq $str_scanf_char, %rdi 
    movq $0, %rax
    call scanf                     #get the secomd char
    movzbq -2(%rbp),	%r13       #keep the first char in %r13
    movq %r13, %rdx                #save the second char in %rdx  
    movq %r14, %rdi                #save the first pstring in %rdi
    movq %r12, %rsi                #save the first char in %rsi
	call replaceChar               #call function replaceChar
	movq %rax, %rbx                #save the pointer to the first pstring in %rdx
	movq %r15, %rdi                #save the pointer to the second pstring in %rdi
	movq %r13, %rdx                #save the second char in %rdx
	movq %r12,%rsi                 #save the first char in $rsi
	call replaceChar               #call function replaceChar
	movq %rax, %r8                 #save the pointer to the second pstring in %rdx
	movq %rbx, %rcx                #save the pointer to the first pstring
	movq %r12, %rsi                #save the first char in %rsi
	movq %r13, %rdx                #save thr second char in $rdx
	movq $str_replceChar, %rdi     #save the output string in %rsi
    movq $0, %rax
    call printf                    #print
    addq $2, %rsp                 #free the memory that allcate to the chars
    jmp exit


case_52:
	movq $0, %rdi 
	subq $8,	%rsp             #memory allocation of 8 byte for the input digit 
    leaq -4(%rbp), %rsi        #save in %rsi the pointer to the free place on the stack to the first char 
    movq $str_scanf_digit, %rdi 
    movq $0, %rax
    call scanf                    #get the first digit           
    movzbq -4(%rbp), %r12       #keep the first digit in %r12 
    leaq -8(%rbp), %rsi        #save in %rsi the pointer to the free place on the stack to the second digit 
    movq $str_scanf_digit, %rdi 
    movq $0, %rax
    call scanf                    #get the second digit
    movzbq -8(%rbp),	%r13      #keep the second digit in %r13
    movq %r13, %rcx               #move the second digit to %rcx
    movq %r12, %rdx			      #move the first digit to %rdx
	movq %r15, %rsi 			  #move the second string to %rsi
	movq %r14, %rdi               #move the first string to %rdi
	call  pstrijcpy               #call pstrijcpy
	#movq %rax, %rbx              #pointer to the first pstring in %rbx
	movq %r14, %rdi		          #put pointer to first pstring in rdi
	call pstrlen                  #call pstrlen
	movq %rax, %rsi               #length of pstring1
	addq $1, %r14                 #%r14 point to the string og the first pstring         
	movq %r14, %rdx               #put pointer to the first string in %rdx 
	movq $str_outres, %rdi        #put the output string in %rdi
	movq $0, %rax
	call printf                   #print the first line
	subq $1, %r14                 #return the orignal value %r14
	movq %r15, %rdi               #put the second pstring in %rdi
	call pstrlen                  #get the length of the second pstring
	movq %rax, %rsi               #keep the length of the second pstring %rsi
	movq %r15, %rdx               #put pointer to the second pstring in %rdx
	addq $1, %rdx                 #%rdx point to the string of the second pstring
	movq $str_outres, %rdi        #put the output string in %rdi
	movq $0, %rax
	call printf                   #print
	addq $8, %rsp                #free the memory that allcate to the digit
	jmp exit


case_53:
	movq %r14, %rdi			#put the pointer of first pstring in %rdi
	call pstrlen            #get the length of the first pstring
	movq %rax, %r13         #keep the length in the %r13
	movq %r14, %rdi			#put the pointer of first pstring in %rdi
	call swapCase           #call swapCase
	movq %rax, %rdx         #keep the pointer to the first pstring in %rdx
	movq %r13, %rsi         #put the length of the first pstring in %rsi
	movq $str_outres, %rdi  #put the out put string in %rdi
	movq $0, %rax 
	call printf             #print
	movq %r15, %rdi         #put the pointer of the second pstring in %rdi
	call pstrlen            #get the length of the second pstring
	movq %rax, %r13         #keep the length in %r13
	call swapCase           #call swapCase
	movq %rax, %rdx         #keep the pointer to the second pstring
	movq %r13, %rsi         #put the length of the second pstring in %rsi
	movq $str_outres, %rdi  #put the out put string in %rdi
	movq $0, %rax
	call printf             #print
	jmp exit                

case_54: 
	subq $8, %rsp            #memory allocation of 8 byte for the input digit  
    leaq -4(%rbp),%rsi        #save in %rsi the pointer to the free place on the stack to the first digit 
    movq $str_scanf_digit, %rdi 
    movq $0, %rax 
    call scanf                  #get the first digit
    movzbq -4(%rbp), %r12     #keep the first digit in r12 
    leaq -8(%rbp), %rsi      #save in %rsi the pointer to the free place on the stack to the second digit
    movq $str_scanf_digit, %rdi 
    movq $0, %rax
    call scanf                  #get the second digit
    movzbq -8(%rbp), %r13    #keep the second digit in r13	
	movq %r13, %rcx             #move the second digit to %rce
    movq %r12, %rdx			    #move the first digit to %rdx
	movq %r15, %rsi 			#move the second string to %rsi
	movq %r14, %rdi             #move the first string to %rdi
	call pstrijcmp              #call the function pstrijcmp
	movq %rax, %rsi             #keep the return value in %rsi
	movq $str_cmpres, %rdi      #put the out put string in %rdi  
	movq $0, %rax
	call printf                 #print
	addq $8, %rsp              #free the memory that allcate to the digits
	jmp exit


defult_case:
	movq $str_inval, %rdi    #print error
	movq $0, %rax
	call printf
	jmp 	exit 

exit:
	popq %rdx     #retunr the value of %rdx
    popq %r12     #retunr the value of %r12
    popq %r13     #retunr the value of %r13
    popq %r14     #retunr the value of %r14
    popq %r15     #retunr the value of %r15

	movq %rbp, %rsp	 #restore the old stack pointer - release all used memory.
	popq %rbp		 #restore old frame pointer (the caller function frame)
	ret			     #return to caller function (OS)

	



























