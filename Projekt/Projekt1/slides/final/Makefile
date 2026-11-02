# Builds the final deck. Plain pdflatex, run twice for \inserttotalframenumber.
# mnstyle.sty is resolved from slides/common/ via TEXINPUTS. Charts and result
# macros are read from ../../charts and ../../results by relative paths.

TEXINPUTS := ../common:
export TEXINPUTS

PDFLATEX = pdflatex -interaction=nonstopmode -halt-on-error

all: main.pdf

main.pdf: $(wildcard *.tex) ../common/mnstyle.sty $(wildcard ../../charts/*.pdf) $(wildcard ../../results/*.tex)
	$(PDFLATEX) main.tex
	$(PDFLATEX) main.tex

clean:
	rm -f main.aux main.log main.nav main.out main.snm main.toc main.vrb

.PHONY: all clean
