ECHO=

TALKS= \
	tei-history.xml \
	cartes-roma-1.xml \
	cartes-roma-2.xml \
	xslt-intro.xml 


DOCS= \
	exercices
 
default: pdfslides
slides: pdfslides 

pdfslides:  
	for i in $(TALKS) ; do \
		saxon -o:`basename $$i .xml`.tex `basename $$i .xml`.xml slides.xsl \
		 latexLogo=../Graphics/logo \
                 attsOnSameLine=6 \
                 reencode=false ; \
		$(ECHO) xelatex `basename $$i .xml`.tex ;\
		$(ECHO) xelatex `basename $$i .xml`.tex ;\
	done


docs:	
	for i in $(DOCS) ; do \
		saxon  -o:$$i.tex $$i.xml  \
	       	/usr/share/xml/tei/stylesheet/latex/tei.xsl \
		reencode=false ; \
		xelatex $$i.tex ; \
		xelatex $$i.tex ; \
	done
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
	-for i in $(TALKS) ; do onvdl teitalks.nvdl Talks/`basename $$i .xml`.xml \
	 | grep -v ': error: unfinished element$$' \
	 | grep -v ': error: unfinished element .* required to finish the element$$'; done

zip:
	(cd Travaux ; 	zip travaux.zip $(ZIP) )
