ECHO=

TALKS= \
	talk-01-intro.xml \
#	talk-tei.xml \
#	talk-guidelines.xml \
#	talk-editing.xml \
#	talk-customizing.xml \
#	talk-xslt.xml \
#	talk-hdr.xml \



DOCS= \
	tp-1 \
#	tp-oxygen \
#	tp-styling \
#	tp-editing 


default: pdfslides
slides: pdfslides 

pdfslides:  
	for i in $(TALKS) ; do \
		saxon -o:`basename $$i .xml`.tex `basename $$i .xml`.xml slides.xsl \
                 attsOnSameLine=6 \
                 reencode=false ; \
		$(ECHO) xelatex `basename $$i .xml`.tex ;\
		$(ECHO) xelatex `basename $$i .xml`.tex ;\
	done

pdfslides-handout:  
	for i in $(TALKS); do \
		saxon -o:`basename $$i .xml`-handout-slides.tex Talks/`basename $$i .xml`.xml slides.xsl \
		latexLogo="" \
		startAttribute="{" \
		startAttributeValue="{" \
		startElement="{" \
		startElementName="{" \
                 attsOnSameLine=6 \
		 beamerClass=boxes \
                 reencode=false \
                 pause=false ; \
		$(ECHO) xelatex `basename $$i .xml`-handout-slides.tex ;\
		$(ECHO) xelatex `basename $$i .xml`-handout-slides.tex ;\
	done

handout:  pdfslides-handout
	cat booklet-top.txt > booklet.xml
	echo '<?tex \\newpage ?><div><head>Presentations</head>' >> booklet.xml
	for i in $(TALKS) ; do \
	echo "<ptr n=\"`basename $$i .xml`\" target=\"`basename $$i .xml`-handout-slides.pdf\" rend=\"pdfslidesinclude\"/>" >> booklet.xml; \
	done
	echo "</div>" >> booklet.xml
	echo '<?tex \\newpage ?><div><head>Exercises</head>' >> booklet.xml
	for i in $(EXERCISES); do \
	echo "<div>" >> booklet.xml; \
	grep "<title>" $$i.xml | head -1 | sed 's/title>/head>/g' >> booklet.xml; \
	echo "<xi:include href=\"$$i.xml#xmlns(t=http://www.tei-c.org/ns/1.0)xpointer(/t:TEI/t:text/t:body/t:*)\"/>" >> booklet.xml; \
	echo "</div>" >> booklet.xml; \
	done
	echo "</div>" >> booklet.xml
docs:	
	for i in $(DOCS) ; do \
		saxon  -o:$$i.tex $$i.xml  \
	       	/usr/share/xml/tei/stylesheet/latex/tei.xsl \
		reencode=false ; \
		xelatex $$i.tex ; \
		xelatex $$i.tex ; \
	echo "<ptr n=\"$$i\" target=\"$$i.pdf\" rend=\"pdfinclude\"/>" >> booklet.xml; \
	done
	cat booklet-end.txt >> booklet.xml
	xmllint --xinclude booklet.xml > booklet-xi.xml
	saxon booklet-xi.xml booklet.xsl > booklet.tex
	rm booklet-xi.xml
	perl -p -i -e 's+.color{red}++g' booklet.tex
	echo perl -p -i -e 's+\\maketitle++g' booklet.tex
	pdflatex booklet
	pdflatex booklet
	pdflatex booklet

schema:
	roma2 --localsource=../../../TEI-SF/P5/Source/Guidelines/en/guidelines-en.xml --doclang=fr Travaux/Schemas/tei_mut.odd Travaux/Schemas

clean:
	-for i in $(TALKS) ; do rm -f $$i.pdf $$i-handout.* $$i-handout-slides.*; done
	-rm -f *.aux
	-rm -f *.log
	-rm -f *.nav
	-rm -f *.out
	-rm -f *.snm
	-rm -f *.tex
	-rm -f *.toc
	-rm -f *.vrb
	-rm -f *.eps *.dvi
	-rm -f *.xhtml
	-rm -f *~

validate:
	-for i in $(TALKS) ; do onvdl ../teitalks.nvdl Talks/`basename $$i .xml`.xml \
	 | grep -v ': error: unfinished element$$' \
	 | grep -v ': error: unfinished element .* required to finish the element$$'; done

zip:
	(cd Travaux ; 	zip travaux.zip $(ZIP) )
