# Builds the preliminary deck. Plain pdflatex, run twice for \inserttotalframenumber.
# mnstyle.sty is resolved from slides/common/ via TEXINPUTS.

TEXINPUTS := ../common:
export TEXINPUTS

PDFLATEX = pdflatex -interaction=nonstopmode -halt-on-error

all: main.pdf

main.pdf: main.tex ../common/mnstyle.sty
	$(PDFLATEX) main.tex
	$(PDFLATEX) main.tex

clean:
	rm -f main.aux main.log main.nav main.out main.snm main.toc main.vrb

.PHONY: all clean
