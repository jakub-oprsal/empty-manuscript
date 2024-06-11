SECTIONS = content.tex

.PHONY : FORCE default clean
.PRECIOUS : %.bbl %.tex

default : main.pdf

macro.tex :
	true

main.tex : meta.yaml recipe.yaml | $(SECTIONS)
	thead -c amsart --cname snkart --opts noheader $< -o $@

%.tex : %.md
	tmarko $< >$@

%.aux : %.tex macro.tex $(SECTIONS)
	pdflatex -draftmode -interaction=nonstopmode -halt-on-error $*

%.pdf : FORCE %.tex $(SECTIONS)
	latexrun $*

%.bbl : %.aux *.bib
	bibtex -terse $*
	pdflatex -draftmode -interaction=batchmode $*

clean :
	@echo Cleaning up...
	@[ -d latex.out ] && echo ./latex.out && rm -r latex.out
	@for aux in "*.aux" "*.blg" "*.log" "*.out" "*.toc" "*.vtc" "*~" \
		"*.cut" "*.bbl" "*.thm" "*.fls" ; do \
		find . -type f -name "$$aux"; \
		find . -type f -name "$$aux" -delete; \
		done
