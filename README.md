# p-string-x86-Assembly
## Description
Implementation of p-string in x86 Assembly. p-string is a struct which is defined as follows:
* char size - reprensts the length of a string
* char string[255] - the string itself

The following functions are implemented:
* char pstrlen(Pstring* pstr)
* Pstring* replaceChar(Pstring* pstr, char oldChar, char newChar)
* Pstring* pstrijcpy(Pstring* dst, Pstring* src, char i, char j)
* Pstring* swapCase(Pstring* pstr)
* int pstrijcmp(Pstring* pstr1, Pstring* pstr2, char i, char j)

## Implementation Details
I used a jump table which is actually a switch-case in Assembly, for jumping to the code of the requested function.
