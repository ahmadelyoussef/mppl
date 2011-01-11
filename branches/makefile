final : MiniLexer.o MiniParser.o main.o
	ag++ -o final MiniLexer.o MiniParser.o main.o  -L libantlr3c-3.2/.libs -l antlr3c

main.o : main.c MiniLexer.h MiniParser.h input.txt
	ag++ -c main.c -I. -I libantlr3c-3.2 -I libantlr3c-3.2/include

MiniLexer.o MiniParser.o : MiniLexer.c MiniParser.c MiniLexer.h MiniParser.h
	ag++ -c MiniLexer.c MiniParser.c -I. -I libantlr3c-3.2 -I libantlr3c-3.2/include

MiniLexer.c MiniParser.c MiniLexer.h MiniParser.h: Mini.g
	java -jar antlr-3.2.jar Mini.g

