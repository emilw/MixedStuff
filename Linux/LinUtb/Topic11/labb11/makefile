all: programGTK

programGTK:
	gcc -Wall -o electrotestgtk maingtk.c electrolibui.c `pkg-config --cflags --libs gtk+-3.0` -lresistance -lpower -lcomponent

docs: programGTK
	doxygen
	make -C docs/latex
	cp docs/latex/refman.pdf docs/documentation.pdf