.PHONY: clean

hello: hello.o
	ld -macosx_version_min 12.6.0 -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o app.exe hello.o 

hello.o:
	nasm -f macho64 hello.s -o hello.o

clean:
	rm *.o *.exe