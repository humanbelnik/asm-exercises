//! Using Intel synatax.
//! Compile: gcc -masm=intel main.c
 
#include <stdio.h>
#include <string.h>


size_t getlen(const char* str_prt);

// Implemented in my_strcpy.s 
void  my_strcpy(char *dest, const char *src, const size_t len);

int main(void)
{
    char s[] = "Calculate my length!";
    size_t len = getlen(s);
    printf(
        "String surrounded by []:\n"
        "[%s]\n\n"
        "String's length:\n"
        "stdlib strlen(): %zu\n"
        "assembly: %zu\n",
        s ,strlen(s), len 
    );

    // Cannot use char* s_dst cause string literal is a constant
    char s_dst[]  = "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$";
    printf(
        "Before copy surrounded by []\n"
        "[%s]\n\n", s_dst
    );

    my_strcpy(s, s+1, 5);
    printf(
        "Afters copy surrounded by []\n"
        "[%s]\n", s
    );

    return 0;
}

size_t getlen(const char* str_ptr)
{
    size_t l = 0;

    // AL - target byte
    // RDI -  byte to compare with target
    // RCX - amount of compare iterations to perform (AMAP)
    // Iterative scan until bytes are equal (ECX being substracted on each iter)
    // neg - 2 => 0000 -> 0001 -> 1111 -> 1110 (single char) -> 1100 -> 0011 (-2) --> 0001
    // Write result to RCX 

    __asm__(
        "xor al, al\n"
        "mov rdi, %1\n"
        "mov rcx, -1\n"
        "repne scasb\n" 
        "neg rcx\n"
        "sub rcx, 2\n"
        "mov %0, rcx\n"
        : "=r"(l)  
        : "r"(str_ptr)
        : "rcx", "rdi", "al"
    );

    return l;
}

