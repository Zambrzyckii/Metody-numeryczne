TEXINPUTS := ../common:
export TEXINPUTS

PDFLATEX = pdflatex -interaction=nonstopmode -halt-on-error

all: main.pdf

main.pdf: $(wildcard *.tex) ../common/mnstyle.sty
	$(PDFLATEX) main.tex
	$(PDFLATEX) main.tex

clean:
	rm -f main.aux main.log main.nav main.out main.snm main.toc main.vrb main.pdf

.PHONY: all clean
