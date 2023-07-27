SECTIONS = 1_introduction.tex

.PHONY : default clean install-thead

.PRECIOUS : %.bbl %.tex

default : main.pdf

macro.tex :
	true

main.tex : meta.yaml recipe.yaml
	python3 -m thead -c amsart --recipe recipe.yaml $< -o $@

%.tex : %.md
	python3 -m tmarko $< >$@

%.aux : %.tex macro.tex $(SECTIONS)
	pdflatex -draftmode -interaction=nonstopmode -halt-on-error $*

%.pdf : %.tex %.bbl %.aux macro.tex $(SECTIONS)
	pdflatex -interaction=batchmode $*

%.bbl : %.aux *.bib
	bibtex -terse $*
	pdflatex -draftmode -interaction=batchmode $*

arxiv.tgz : main.tex snkart.cls $(FIGURES)
	tar -cvf $@ $^

restart :
	git remote remove origin
	git commit --amend -m "empty manuscript" --date="$(date)"

bibtool : consistency.bib
	mv consistency.bib temp.bi~
	bibtool temp.bi~ >consistency.bib

clean :
	@echo Cleaning up...
	@for aux in "*.aux" "*.blg" "*.log" "*.out" "*.toc" "*.vtc" "*~" \
		"*.cut" "*.bbl" "*.thm" "*.fls" ; do \
		find . -name "$$aux"; \
		find . -name "$$aux" -delete; \
		done
