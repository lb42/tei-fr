ECHO=
SCHEMA=/home/lou/Public/TEI-SF/P5/Exemplars/tei_all.rng
CORPUS=/home/lou/Public/tei-fr/trunk/Projects/BVH/testBed
NEWCORPUS=/home/lou/Public/tei-fr/trunk/Projects/BVH/Corpus
CLEANCORPUS=/home/lou/Public/tei-fr/trunk/Projects/BVH/cleanCorpus
OBE=/home/lou/Public/Stylesheets.git/trunk/tools/oddbyexample.xsl
BVHRNG=/home/lou/Public/tei-fr/trunk/Projects/BVH/out/bvh.rng
CLEANUP=/home/lou/Public/tei-fr/trunk/Projects/BVH/cleanup.xsl
IDENTITY=/home/lou/Public/tei-fr/trunk/Projects/BVH/identity.xsl
CURRENT=`pwd`
#	M0275_01_tei.xml \
#	M0275_02_tei.xml \

FILES= \
	B330636101_D55869_tei.xml \
	B330636101_S1238_encodage_EG_LivreI.xml \
	B360446201_B343_1_tei.xml \
	B360446201_B343_2_tei.xml \
	B360446201_THIA63_1_tei.xml \
	B372615206_11923_tei.xml \
	B372615206_1263_tei.xml \
	B372615206_3436_tei.xml \
	B372615206_4023_tei.xml \
	B372615206_4040_tei.xml \
	B372616101_2950_tei.xml \
	B372616101_3536_tei.xml \
	B372616101_3537_tei.xml \
	B410186201_I65_tei.xml \
	B410186201_LI139_tei.xml \
	B452346101_D1497_3_tei.xml \
	B452346101_H6513_tei.xml \
	B452346101_Ms629_tei.xml \
	B693836101_346632_tei.xml \
	B693836101_355925_tei.xml \
	B693836101_A489170_tei.xml \
	B751041006_FR_1513_tei.xml \
	B751131010_FR3370_suppl_tei.xml \
	B751131011_PYE868_tei.xml \
	B751131011_RES_P_Y2_1349_tei.xml \
	B751131011_RES_Y2_2125_tei.xml \
	B751131011_RES_Y2_2169_tei.xml \
	B751131011_RES_YD_1184_tei.xml \
	B751131011_Y2_2146_tei.xml \
	B751131011_Y2_251_tei.xml \
	B751131011_Y22789_tei.xml \
	B751131011_YE4769_tei.xml \
	B751131011_YE645_tei.xml \
	B751131015_PYC612_tei.xml \
	B751131015_X1888_tei.xml \
	B751131015_YE11562_tei.xml \
	B751131015_YE1457_1460_tei.xml \
	B751131015_YE1735_tei.xml \
	B751131015_Z1918_tei.xml \
	B759999999_Y2_2162_tei.xml \
	B759999999_Y2_2164_tei.xml \
	B861946101_DP1139_tei.xml \
	XUVA_Gordon1543_B53_tei.xml \
	XUVA_Gordon1543_K43_tei.xml \
	XUVA_Gordon1563_R656b_tei.xml \
	XUVA_Gordon1563_R656_tei.xml \
	XUVA_Gordon1563_R65b_2_tei.xml \
	XUVA_Gordon1563_R66_tei.xml \
	XUVA_Gordon1563_R67b_tei.xml \
	XUVA_Gordon1564_R65_tei.xml \
	XUVA_Gordon1578_L47_tei.xml 

check:
	cd $(CORPUS); for f in $(FILES) ; do \
		echo $$f; \
		jing  $(SCHEMA) \
		$$f ; done; cd $(CURRENT);
generate:
		saxon -it:main -o:generated.odd \
	$(OBE) \
	corpus=$(CORPUS) ; \
	teitorelaxng generated.odd 
# generated.odd needs handediting to produce bvh.odd 

copy:
	echo Running identity transform ...
	cd $(CORPUS); 	for f in $(FILES) ; do \
		echo $$f; \
		saxon \
		$$f $(IDENTITY) >$(NEWCORPUS)/$$f; done; cd $(CURRENT);

checkSpec:
	echo Validate  against BVH schema
	cd $(NEWCORPUS); 	for f in $(FILES) ; do \
		echo $$f; \
		jing $(BVHRNG) \
		$$f ; done; cd $(CURRENT);

cleanup:
	echo Do cleanup 
	cd $(NEWCORPUS); 	for f in $(FILES) ; do \
		echo $$f; \
		saxon  \
		$$f $(CLEANUP) > $(CLEANCORPUS)/$$f; done; cd $(CURRENT);


checkClean:
	echo Validate cleaned corpus  against BVH schema
	cd $(CLEANCORPUS); 	for f in $(FILES) ; do \
		echo $$f; \
		jing $(BVHRNG) \
		$$f ; done; cd $(CURRENT);
