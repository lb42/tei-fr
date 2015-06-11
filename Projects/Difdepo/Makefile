ECHO=
SCHEMA=/home/lou/Public/tei-fr/trunk/Projects/Difdepo/out/difdepo.rng
CORPUS=/home/lou/Public/tei-fr/trunk/Projects/Difdepo/testFiles
XSLHOME=/usr/share/xml/tei/stylesheet/profiles/oulipo/

CURRENT=`pwd`

FILES= \
	10010009-1961-06-CR-V2 \
	10010179-1975-11-CV-V2 \
	10010179-1975-12-CR-V2 \
	1001079-75-11 \
	test_v9	
convert:
	cd $(CORPUS); for f in $(FILES) ; do \
		echo $$f; \
		docxtotei --profile=oulipo \
		$$f.docx ; done; cd $(CURRENT);

check:
	cd $(CORPUS); for f in $(FILES) ; do \
		echo $$f; \
		jing  $(SCHEMA) \
		$$f.xml ; done; cd $(CURRENT);
updateXSL:
	cp from_common.xsl $(XSLHOME)
