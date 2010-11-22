Final : MiniLexer.o MiniParser.o main.o 
	g++ -o Final MiniLexer.o MiniParser.o main.o  -L. -l antlr3c 

main.o : main.c MiniLexer.h MiniParser.h input.txt
	g++ -c main.c -I. -I libantlr3c-3.2-win -I libantlr3c-3.2-win/include

MiniLexer.o MiniParser.o : MiniLexer.c MiniParser.c MiniLexer.h MiniParser.h 
	g++ -c MiniLexer.c MiniParser.c -I. -I libantlr3c-3.2-win -I libantlr3c-3.2-win/include

MiniLexer.c MiniParser.c MiniLexer.h MiniParser.h: Mini.g
	java -jar antlr-3.2.jar Mini.g