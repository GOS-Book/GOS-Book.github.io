.PHONY: book chapter clean distclean check-env
MAINSRC = _main.tex

define delete
	find . -depth -path "./.git/*" -prune -o -iregex $1 -type f -delete
endef

book: $(MAINSRC)
	latexmk -pdf -pdflatex="pdflatex -halt-on-error" $(MAINSRC)

chapter: check-env
	pdflatex "\newcommand{\n}{$(CH)}\input{chapter}"

softclean:
	$(call delete, '.*\.\(bbl\|bcf\|blg\|aux\|log\|lof\|loc\|lot\|loa\|out\|toc\|dvi\|fdb_latexmk\|run\.xml\|htm\|fls\)$$')

clean: softclean
	$(call delete, '.*\.\(synctex\|idx\|ilg\|ind\)$$')
	
distclean: clean
	$(call delete, '.*\.\(pdf\)$$')

readme:
	pandoc --email-obfuscation=none --normalize -s -S \
		--from markdown_github --to html README.md > README.htm

check-env:
ifndef CH
	$(error You must provide a number of chapter: `make chapter CH=N')
endif
