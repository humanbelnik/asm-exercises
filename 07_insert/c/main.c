#include <stdio.h>
#include <string.h>
#include <assert.h>

// Implemented in my_strcpy.s 
void my_strcpy(char *dest, const char *src, const size_t len);
size_t my_strlen(const char* str_prt);

typedef struct {
    char *description;
    char *str;
    size_t expected;
    size_t actual;
} strlen_test_t;

void strlen_test() 
{
    strlen_test_t tt[] = {
        {
            .description = "Length is equal to zero",
            .str = "",
            .expected = strlen(""),
        },
        {
            .description = "Length is not zero",
            .str = "get my length!",
            .expected = strlen("get my length!")
        }
    };

    size_t len = sizeof(tt)/sizeof(tt[0]);
    for (size_t i = 0; i < len; i++) {
        printf("test %zu : %s\n", i + 1, tt[i].description);
        tt[i].actual = my_strlen(tt[i].str);
        assert(tt[i].actual == tt[i].expected);
        printf("ok\n");
    }
}

typedef struct {
    char *description;   
    char *expected;
    size_t src_offset;
    size_t dst_offset;
    size_t len;
} strcpy_test_t;

void strcpy_test()
{
    // pool = aaabbbccc\0
    char pool[9 + 1] = { 0 };
    memset(pool, 'a', 3);
    memset(pool+3, 'b', 3);
    memset(pool+6, 'c', 3);

    strcpy_test_t tt[] = {
        {
            .description = "Uncovered: front to back",
            .expected = "aaabbbaaa",
            .src_offset = 0,
            .dst_offset = 6,
            .len = 3
        },
        {
            .description = "Uncovered: back to front",
            .expected = "cccbbbccc",
            .src_offset = 6,
            .dst_offset = 0,
            .len = 3
        },
        {   
            .description = "Covered: front to back",
            .expected = "aaaabbbcc",
            .src_offset = 2,
            .dst_offset = 3,
            .len = 4
        },
        {
            .description = "Covered: back to front",
            .expected = "aabbbbccc",
            .src_offset = 3,
            .dst_offset = 2,
            .len = 3
        },
        {
            .description = "Covered: back to front, copied chars not equal",
            .expected = "aabbbbccc",
            .src_offset = 1,
            .dst_offset = 0,
            .len = 3
        }

    };

    size_t n = sizeof(tt)/sizeof(tt[0]);
    char tpool[20] = { 0 };
    for (size_t i = 0; i < n; ++i) {
        printf("test %zu : %s\n", i + 1, tt[i].description);
        strcpy(tpool, pool);
        my_strcpy(tpool + tt[i].dst_offset, tpool + tt[i].src_offset, tt[i].len);
        assert(strcmp(tt[i].expected, tpool) == 0);
        printf("ok\n");
    }


  
}

int main(void)
{
    strlen_test();
    strcpy_test();
    return 0;
}

size_t my_strlen(const char* str_ptr)
{
    size_t l = 0;

    // C-type string is a 0-terminated byte array
    // Idea is to go through array and compare current byte with 0 
    
    // Array traverse being performed with repne scasb instruction:
    //      1. Store 'compare with' 0 byte in AL
    //      2. Store string address in RDI
    //      3. Load amount of iterations in RCX (We don't know them yet so let's load AMAP)
    //      4. Perform some magic conversion in order to get the len right:
    //          "qwe" --> RCX = -1 = 0001 = 1110 = 1111 --> (-4): 1110 1101 1100 1011 --> (neg): 1010 0101 --> (sub 2): 0100 0011 OK!

    __asm__(
        "xor al, al\n"
        "mov rdi, %1\n"
        "mov rcx, -1\n"
        "repne scasb\n" 
        "neg rcx\n"
        "sub rcx, 2\n"
        "mov %0, rcx\n"
        : "=r"(l)               // output parameter placed in some general register
        : "r"(str_ptr)          // input parameter placed in some general register
        : "rcx", "rdi", "al"    // registers that will be used in assembly insertion -> pushed onto the stack
    );

    return l;
}
