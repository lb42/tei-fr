ECHO=

TALKS= \
	talk-01 \
	talk-tei \
	comment \
	teiheader \
	carteTEI \
	talk-names \
	talk-mss \
	talk-msdesc \
	talk-cartes \
	outillage-tei \
	xslt-intro 

EXERCISES= \
	exercice-oxygen-1 \
	exercice-initiale \
	exercice-header \
	exercice-roma \
	exercice-semantique \
	exercice-diffusion \
	exercices-xslt

default: pdfslides

exercises:
	for i in $(EXERCISES) ; do \
		teitopdf $$i.xml; \
	done

slides: pdfslides 

pdfslides:  
	for i in $(TALKS) ; do \
		teitoslides --profile=tei $$i.xml; \
		mv $$i.xml.slides $$i.pdf; \
	done


clean:
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
	-rm booklet.pdf

all:
	xmllint --xinclude talks.xml > mutecxsl.xml
	teitoepub --profile=oucs --odd mutecxsl.xml
	teitodocx --profile=oucs mutecxsl.xml
	rm -f Work.zip
	zip -r Work `find Work -type f | grep -v .svn`

handout: 
	cat booklet-top.txt > booklet-xi.xml
	echo '<?tex \\newpage ?><div><head>Exercises</head>' >> booklet-xi.xml
	for i in $(EXERCISES); do \
		echo "<div>" >> booklet-xi.xml; \
		grep "<title>" $$i.xml | head -1 | sed 's/title>/head>/g' >> booklet-xi.xml; \
		echo "<xi:include href=\"$$i.xml#xmlns(t=http://www.tei-c.org/ns/1.0)xpointer(/t:TEI/t:text/t:body/t:*)\"/>" >> booklet-xi.xml; \
		echo "</div>" >> booklet-xi.xml; \
		echo '<?tex \\newpage ?>'>> booklet-xi.xml ; \
	done
	echo "</div>" >> booklet-xi.xml
	echo '<?tex \\newpage ?>'>> booklet-xi.xml
	cat booklet-end.txt >> booklet-xi.xml
	xmllint --xinclude booklet-xi.xml > booklet.xml
	saxon booklet.xml booklet.xsl > booklet.tex
	perl -p -i -e 's+.color{red}++g' booklet.tex
	echo perl -p -i -e 's+\\maketitle++g' booklet.tex
	pdflatex booklet
	pdflatex booklet
	pdflatex booklet

validate:
	-for i in $(TALKS) ; do onvdl ../teitalks.nvdl `basename $$i .xml`.xml \
	 | grep -v ': error: unfinished element$$' \
	 | grep -v ': error: unfinished element .* required to finish the element$$'; done

demo:
	xmllint --xinclude demo.odd > x.odd; roma2 --docpdf --nodtd --dochtml --isoschematron x.odd .
	roma --nodtd --noxsd --schema=demosimple x.odd .
	saxon demo.isosch http://www.tei-c.org/release/xml/tei/odd/Utilities/iso_schematron_message_xslt2.xsl > demo.isosch.xsl

test:
	jing demo.rng demo.xml
	rnv demo.rnc demo.xml
	saxon demo.xml demo.isosch.xsl 
	jing demo.xsd demo.xml

foo:
	curl -s  -F upload=@RomaResults/demo.odd.compiled  -o test.html http://localhost:8080/ege-webservice/Conversions/ODDC%3Atext%3Axml/xhtml%3Aapplication%3Axhtml%2Bxml/
