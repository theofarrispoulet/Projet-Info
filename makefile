all: exe

code_ABR.o: code_ABR.c header_ABR.h
	gcc -c code_ABR.c -o code_ABR.o

code_AVL.o: code_AVL.c header_AVL.h
	gcc -c code_AVL.c -o code_AVL.o

code_Tab.o: code_Tab.c header_Tab.h
	gcc -c code_Tab.c -o code_Tab.o

main.o: main.c main.h
	gcc -c main.c -o main.o
    
exe: code_ABR.o code_AVL.o code_Tab.o
	gcc code_ABR.o code_AVL.o code_Tab.o main.o -o exe
	
clean:
	rm -f *.o
