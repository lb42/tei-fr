ECHO=
SCHEMA=/home/lou/Public/tei-fr/trunk/Projects/Unicaen/out/teiPucc.rng
CORPUS=/home/lou/Public/tei-fr/trunk/Projects/Unicaen/doNotAddMe
CORPUSHDR=/home/lou/Public/tei-fr/trunk/Projects/Unicaen/corpHeaderStart.txt
CURRENT=`pwd`

check:
	cd $(CORPUS); for f in *.xml ; do \
		echo $$f; \
		jing  $(SCHEMA) \
		$$f ; done; cd $(CURRENT);

corpus:
	cd $(CORPUS); cp $(CORPUSHDR) driver.xml;\
 		for f in *.xml ; do \
		echo "<include xmlns='http://www.w3.org/2001/XInclude' href='$$f'/>" >> driver.xml; \
	done; echo "</teiCorpus>" >> driver.xml; cd $(CURRENT);

schema: 
	teitorelaxng --odd teiPucc.odd

