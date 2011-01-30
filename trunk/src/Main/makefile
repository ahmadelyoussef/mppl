mvObj :libmain.a
	mv main.o ../../.Objs/main.o
	mv libmain.a ../../lib/libmain.a

libmain.a : main.o
	ar rcs libmain.a main.o

main.o : main.c ../Mini/MiniLexer.h ../Translate/Translator.h ../Mini/MiniParser.h ../../input/input.txt ../check/test_module.h
	g++ -c  main.c -I. -I ../check -I ../Visual -I ../Graph -I../Translate -I ../Mini -I ../../lib/libantlr3c-3.2 -I ../../lib/libantlr3c-3.2/include 
