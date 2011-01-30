mvObj : libMiniLexer.a libMiniParser.a
	mv MiniLexer.o ../../.Objs/MiniLexer.o
	mv MiniParser.o ../../.Objs/MiniParser.o
	mv libMiniLexer.a ../../lib/Mini/libMiniLexer.a
	mv libMiniParser.a ../../lib/Mini/libMiniParser.a

libMiniLexer.a libMiniParser.a : MiniLexer.o MiniParser.o
	ar rcs libMiniLexer.a MiniLexer.o
	ar rcs libMiniParser.a MiniParser.o

MiniLexer.o MiniParser.o: MiniLexer.c MiniParser.c MiniLexer.h MiniParser.h
	g++  -c MiniLexer.c -I. -I ../Graph -I ../../lib/libantlr3c-3.2 -I ../../lib/libantlr3c-3.2/include
	@echo MiniLexer Compiled !
	g++ -c MiniParser.c -I. -I ../Graph -I ../Translate -I ../../lib/libantlr3c-3.2 -I ../../lib/libantlr3c-3.2/include
	@echo MiniParser Compiled !
	@echo Cleaning up . . .
MiniLexer.c MiniParser.c MiniLexer.h MiniParser.h: Mini.g
	java -jar ../../bin/antlr-3.2.jar Mini.g
	@echo Antlr Grammar Generated !

