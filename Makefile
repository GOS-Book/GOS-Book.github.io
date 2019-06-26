.PHONY: book chapter clean distclean check-env		
MAINSRC = GOS-Book.tex

define delete
	find . -depth -path "./.git/*" -prune -o -iregex $1 -type f -delete
endef		

git: 
	git pull origin 

book: $(MAINSRC)
	git pull origin;\
	pdflatex -synctex=1 -interaction=nonstopmode -shell-escape $(MAINSRC);\
	xindy -L russian -C utf8 GOSBook.idx;\
	pdflatex -synctex=1 -interaction=nonstopmode -shell-escape $(MAINSRC);\
	#mv -f GOSBook.pdf GOSBook_Matan.pdf

chapter: check-env
	pdflatex "\newcommand{\n}{$(CH)}\input{chapter}"

softclean:
	$(call delete, '.*\.\(bbl\|bcf\|blg\|aux\|log\|lof\|loc\|lot\|loa\|out\|toc\|dvi\|fdb_latexmk\|run\.xml\|htm\|fls\)$$')

clean: softclean
	$(call delete, '.*\.\(synctex\|gz(busy)\|idx\|ilg\|ind\|maf\|ptc\|bak\)$$')
	-rm -f *.mtc*

distclean: clean
	$(call delete, '.*\.\(pdf\)$$')

readme:
	pandoc --email-obfuscation=none --normalize -s -S \
		--from markdown_github --to html README.md > README.htm

check-env:
ifndef CH
	$(error You must provide a number of chapter: `make chapter CH=N')
endif
