#311230163	einat heletz	
	.section	.rodata
str_inv:
	.string	"invalid input!\n"
	.text

	.globl	pstrlen
	.globl	replaceChar
	.globl	swapCase
	.globl	pstrijcpy
	.globl	pstrijcmp

	.type	pstrlen, @function
pstrlen:
	pushq %rbp		         #save the old frame pointer
	movq  %rsp, %rbp	     #create the new frame pointer
	movzbq (%rdi), %rax      #rax = *rdi , get the length og 
	movq %rbp, %rsp	         #restore the old stack pointer - release all used memory.
	popq %rbp		         #restore old frame pointer (the caller function frame)
	ret			             #return to caller function (OS)


	.type	replaceChar, @function
replaceChar:
	pushq %rbp				#save the old frame pointer
	movq  %rsp, %rbp		#create the new frame pointer
	movzbq (%rdi), %rcx     # get the lrngth of the pstring 
	movq  $-1, %r9			#r9 counter
	addq  $1, %rdi 		    #point of the first char in the pstring

strat_loop_replaceChar:
	addq $1, %r9                      #add one to the counter %r9
	cmpq %r9, %rcx                    #compare the counter to the lengh of the pstring
	jle     end_replaceChar           #will the counter is smeller then the length keep doning the loog
	leaq (%rdi,%r9), %r8		      #keep the pointer to char  in %r8
	movzbq (%r8), %r11		          #keep the value of the char in %r11
	cmpq %r11, %rsi                   #check if the char we standing on is equla to the old char
	jne     strat_loop_replaceChar    #if not strat over the loog if yes keep going
	movb %dl, 	(%r8)                 #chang the char that equla to the oldchar to the new char
    jmp     strat_loop_replaceChar    #start over the loog

end_replaceChar:
	movq 	%rdi , 	%rax               	#insert the return value to rax
	movq	%rbp,	%rsp				#restore the old stack pointer - release all used memory.
	popq	%rbp						#restore old frame pointer (the caller function frame)
	ret		                          	#return to caller function (OS)

	.type	swapCase, @function
swapCase:

	pushq %rbp				#save the old frame pointer
	movq  %rsp,	%rbp		#create the new frame pointer
	movzbq  (%rdi), %rcx    #rcx equls to the length of the pstring
	movq $-1, %rdx          # rdx is the counter  = 0
	addq  $1,  %rdi         #rdi point to the first char in the pstring

strat_loop_swapCase:
	addq  $1, %rdx             #add one to counter in %rdx
	cmpq  %rdx, %rcx           #check if we move on all the chars in the pstring
	jle  end_swapCase          #if we  move on all the chers end the function if not keep going
	leaq (%rdi,%rdx),%r8       #keep pointer to the char we stand on in %r8
	movzbq (%r8), %r9          #keep the value of the char in %r9
	cmpq $65, %r9              #check if the char is in A-Z biggrer then 65
	setg %al                   #keep the answer flg
	cmpq $90, %r9              #check if the char is in A-Z smeller then 90
	setle %r10b                #keep the anwer flg
	testb %r10b, %al           #check if the number is between 63<x<91 
	jz  loop_swapCase          #if bl & al = 
	addl   $32,		(%r8)      #if yes chang the char to lower-case letter
	jmp   strat_loop_swapCase  #get to the next char - start the loog again

loop_swapCase:  
	cmpq $96, %r9              #check if there char is in A-Z biggrer then 95
	setg %al                   #keep the answer in flg
	cmpq $122, %r9             #check if there char is in A-Z smeller then 122
	setle %r10b                #keep the answer in flg
	testb %r10b,%al            #check if the number is between 96<x<122
	jz  strat_loop_swapCase    #if bl & al = false do the loop agian
	subl $32,(%r8)             # chang the chat to gibber letter
	jmp strat_loop_swapCase    #start the loog again


end_swapCase:
	movq %rdi, %rax       #insert the return value to rax
	movq %rbp, %rsp	   #restore the old stack pointer - release all used memory.
	popq %rbp		       #restore old frame pointer (the caller function frame)
	ret			               #return to caller function (OS)
          

	.type	pstrijcpy, @function
pstrijcpy:
	pushq	%rbp		         #save the old frame pointer
	movq	%rsp,	%rbp	     #create the new frame pointer
	cmpq 	%rdx, 	%rcx         #check if j>i
	jl 	bad_exit_pstrijcpy       #if not end end the function
	movzbq	(%rdi), %r11         #get lengh of the first pstring
	cmpq 	%rcx,  %r11          #check if j smeller or equal then the length of the first pstring
	jle  	bad_exit_pstrijcpy   #if j is bigger then the length of the first pstring end the function
	movzbq	(%rsi), %r11         #get the length of he second pstring 
	cmpq 	%rcx,  	%r11         #check if  i is smeller or equals the second pstring
	jle  	bad_exit_pstrijcpy   #if i is bigger end the function
	cmpq 	$0,		%rdx         #check i>0
	jl 		bad_exit_pstrijcpy   #if not end the progem
	addq   $1,	%rdi             #point on the first char in the first pstring 
	addq   $1,	%rsi			 #piont on the second char in the second pstring
	movq   $0,  %r11          

loop_pstrijcpy:
	leaq (%rsi,%rdx), %r8       #get pointer of char in the rage of pstring1
	leaq (%rdi,%rdx), %r9       #get  pointer of  char in the rage of pstring2
	movzbq (%r8),%r11           #keep the value of the char in %r11
	movb %r11b,	(%r9)           #keep the value of the char in %r12
	addq $1, %rdx               # i++ 
	cmpq %rdx, 	%rcx            #check if we still in the rage
	jge  	loop_pstrijcpy      #if the i<=j return on the action

exit_pstrijcpy:
	movq	%rdi, 	%rax    #insert the return value to rax
	movq	%rbp,	%rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		    #restore old frame pointer (the caller function frame)
	ret			            #return to caller function (OS)

bad_exit_pstrijcpy:
	movq	%rdi, 	%r8       #keep the value in %rdi, in %r8
	movq 	$str_inv,	%rdi  
	movq	$0,		%rax
	call	printf           #peint error
	movq	%r8, 	%rdi     #return bake the value
	jmp 	exit_pstrijcpy   #exit



	.type	pstrijcmp, @function
pstrijcmp:

	pushq	%rbp		       #save the old frame pointer
	movq	%rsp,	%rbp	   #create the new frame pointer
	cmpq 	%rdx, 	%rcx       #check if j>i
	jl 	inv_exit_pstijcmp      #if not end end the function
	movzbq	(%rdi), %r11       #get lengh of the first pstring
	cmpq 	%rcx,  %r11        #check if j smeller or equal then the length of the first pstring
	jle  	inv_exit_pstijcmp  #if j is bigger then the length of the first pstring end the function
	movzbq	(%rsi), %r11       #get the length of he second pstring
	cmpq 	%rcx, %r11       #check if  i is smeller or equals the second pstring
	jle  	inv_exit_pstijcmp  #if i is bigger end the function
	cmpq 	$0,	%rdx       #check i>0
	jl 	inv_exit_pstijcmp      #if not end the progem
	addq   $1, %rdi           #point on the first char in the first pstring 
	addq   $1, %rsi		   #piont on the second char in the second pstring
	movq   $0, %r11

loop_start_pstijcmp:
	leaq (%rsi,%rdx), %r8      #get pointer of  char in the rage of pstring1
	leaq (%rdi,%rdx),  %r9     #get  pointer of  char in the rage of pstring2
	movzbq (%r8), %r11         #keep the value of the char of pstring 1 in %r11
	movzbq (%r9), %r10         #keep the value of the char of pstring2in %r10      
	cmpq %r11, %r10            #copmpar betwwen the values
	jl 		src_bigger         #if dst[i:j] < src[i:j]
	jg 		dst_bigger         #if dst[i:j] > src[i:j]
	addq $1, %rdx              #the vlues are equal move to the next char
	cmpq %rdx, %rcx            #check if we still on the rang
	jg 	loop_start_pstijcmp    #if yes start the loog again
	movq $0, %rax              #if i>j then dst[i:j] = src[i:j] 
	jmp 	exit_pstijcmp      #exit

inv_exit_pstijcmp :           #the input value are not corrcat
	movq	$str_inv,%rdi	 
	movq $0, %rax
	call	printf            #prinf error
	##return               
	movq $0, %rax          
	movq $-2, %rax            #put -2 in the return valse
	jmp 	exit_pstijcmp

src_bigger:                   #if dst[i:j] > src[i:j] return value is 1
	movq $-1, %rax              
	jmp  	exit_pstijcmp

dst_bigger :                  #if dst[i:j] < src[i:j] return value is -1
	movq $1, %rax
	jmp 	exit_pstijcmp

exit_pstijcmp:             #exit
	movq %rbp, %rsp	       #restore the old stack pointer - release all used memory.
	popq %rbp		       #restore old frame pointer (the caller function frame)
	ret	


