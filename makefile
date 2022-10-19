SECTIONS = 1_introduction.tex

.PHONY : default clean install-thead

.PRECIOUS : %.bbl %.tex

default : main.pdf

macro.tex :
	true

main.tex : meta.yaml macro.tex makefile | $(SECTIONS)
	python3 -m thead -c amsart meta.yaml -o $@

%.aux : %.tex $(SECTIONS)
	pdflatex -interaction=nonstopmode -halt-on-error $*

%.pdf : %.tex %.bbl %.aux $(SECTIONS)
	pdflatex -interaction=batchmode $*

%.bbl : %.aux *.bib
	bibtex -terse $*
	pdflatex -draftmode -interaction=batchmode $*

install-thead :
	python3 -m pip install git+https://github.com/jakub-oprsal/thead

clean :
	rm *.aux *.blg *.log *.out *.toc *.vtc *.bi~ *.cut | true
