Documentation : 
	mkdir TempForDoc;
	cp ../src/Mini/MiniParser.c ./TempForDoc/MiniParser.c 
	cp ../src/Mini/MiniParser.h ./TempForDoc/MiniParser.h 
	cp ../src/Mini/MiniLexer.c  ./TempForDoc/MiniLexer.c
	cp ../src/Mini/MiniLexer.h  ./TempForDoc/MiniLexer.h
	cp ../src/Translate/Translator.h ./TempForDoc/Translator.h
	cp ../src/Translate/GraphAdapter.h ./TempForDoc/GraphAdapter.h	
	cp ../src/Main/main.c ./TempForDoc/Main.c 
	cp ../src/Graph/GRAPH.h ./TempForDoc/GRAPH.h
	cp ../src/Graph/graphZ.h ./TempForDoc/graphZ.h
	cd TempForDoc; doxygen -g; doxygen doxyfile;
	mv TempForDoc/html ./html;
	mv TempForDoc/latex ./latex;
	rm -r TempForDoc
	@echo Documentation Generated !
