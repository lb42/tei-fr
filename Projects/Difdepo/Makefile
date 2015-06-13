ECHO=
SCHEMA=/home/lou/Public/tei-fr/trunk/Projects/Difdepo/out/difdepo.rng
CORPUS=/home/lou/Public/tei-fr/trunk/Projects/Difdepo/testFiles
XSLHOME=/usr/share/xml/tei/stylesheet/profiles/oulipo/

CURRENT=`pwd`

FILES= \
	10010009-1961-06-CR \
	10010009-1961-06-CR-V2 \
	10010010-1961-08-CR \
	10010011-1961-09-CR \
	10010011-CR-1961-11 \
	10010179-1975-11-CV \
	10010179-1975-11-CV-V2 \
	10010179-1975-12-CR \
	10010179-1975-12-CR-V2 \
	10010200-1977-11-CR \
	10010200-1977-11-CV \
	100102242-1981-07-CV \
	100102242-1981-07-CV-V2 \
	10010241-1981-07-CR-simple \
	10010241-1981-07-CV-simple \
	10010241-1981-07-OJ-simple \
	10010242-1981-07-CV-simple \
	10010242-1981-08-CR \
	10010242-1981-08-CR-simple \
	10010242-1981-08-CR-V2 \
	10010242-1981-08-OJ \
	10010242-1981-08-OJ-simple \
	10010242-1981-08-OJ-V2 \
	10010243-1981-10-CR-simple \
	10010243-1981-10-OJ-simple \
	10010244-1981-11-CR-simple \
	10010308-1987-09-CV-simple \
	1001079-75-11 \
	1977-11-03-Convoc 

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
