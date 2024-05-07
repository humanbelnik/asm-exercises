run: main.exe
	./main.exe

main.exe : main.o my_strcpy.o
	gcc main.o my_strcpy.o -o main.exe

my_strcpy.o: my_strcpy.s
	nasm -f macho64 my_strcpy.s -o my_strcpy.o

main.o : main.c
	gcc -masm=intel -O0 main.c -c -o main.o

disasm: main.c
	gcc -O0 -S -masm=intel main.c 

clean:
	rm *.o *.exe
