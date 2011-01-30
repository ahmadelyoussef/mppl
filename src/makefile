All : ../bin/Final
	../bin/Final
	dot -Tjpg ./Visual/graph.dot -o ./Visual/graph.jpg

../bin/Final : ../.Objs/MiniLexer.o ../.Objs/MiniParser.o ../.Objs/main.o ./Translate/Translator.h
	g++ -o ../bin/Final ../.Objs/MiniLexer.o ../.Objs/MiniParser.o ../.Objs/main.o -L../lib/libantlr3c-3.2/.libs/ -lantlr3c

../.Objs/main.o : ./Main/main.c ../input/input.txt ../.Objs/MiniParser.o ../.Objs/MiniLexer.o ./Translate/Translator.h
	cd Main; $(MAKE);

../.Objs/MiniParser.o ../.Objs/MiniLexer.o : ./Mini/Mini.g ./Graph/WovenGraph.h ./Mini/MiniParser.h ./Mini/MiniLexer.h ./Mini/MiniLexer.c ./Mini/MiniParser.c
	cd Mini; $(MAKE);

./Graph/WovenGraph.h ./Mini/MiniParser.h ./Mini/MiniLexer.h ./Mini/MiniLexer.c ./Mini/MiniParser.c: ./Graph/aspect.ah ./Graph/GRAPH.h 
	cd Graph; $(MAKE); 


