ECHO=
SCHEMA=/home/lou/Public/tei-fr/trunk/Projects/Difdepo/out/difdepo.rng
CORPUS=/home/lou/Public/tei-fr/trunk/Projects/Difdepo/2015-10-samples
STYLES=/home/lou/Public/tei-fr/trunk/Projects/Difdepo/norm2ou.xsl
XSLHOME=/usr/share/xml/tei/stylesheet/profiles/oulipo/
CORPUSHDR=/home/lou/Public/tei-fr/trunk/Projects/Difdepo/corpHeaderStart.txt
CURRENT=`pwd`

convert:
	cd $(CORPUS); for f in *.docx ; do \
		echo $$f; \
		docxtotei $$f tmp/$$f.xml ; \
		saxon tmp/$$f.xml $(STYLES) >$$f.xml; done; cd $(CURRENT);

check:
	cd $(CORPUS); for f in *.xml ; do \
		echo $$f; \
		jing  $(SCHEMA) \
		$$f ; done; cd $(CURRENT);

corpus:
	cd $(CORPUS); cp $(CORPUSHDR) driver.xml;\
 		for f in 1*.xml ; do \
		echo "<include xmlns='http://www.w3.org/2001/XInclude' href='$$f'/>" >> driver.xml; \
	done; echo "</teiCorpus>" >> driver.xml; cd $(CURRENT);

schema: 
	teitorelaxng --odd difdepo.odd
updateXSL:
	cp from_common.xsl $(XSLHOME)

clean:
	cd $(CORPUS); rm *.xml
