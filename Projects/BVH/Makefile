ECHO=
CURRENT=`pwd`
ROOT=/Users/Travail/Desktop/SynchroSVN/SVNLouMain/BVH
CORPUS=$(ROOT)/testBed
NEWCORPUS=$(ROOT)/Corpus
CLEANCORPUS=$(ROOT)/cleanCorpus
BVHRNG=$(ROOT)/out/bvh.rng
CLEANUP=$(ROOT)/cleanup.xsl
IDENTITY=$(ROOT)/identity.xsl
SCHEMA=/home/lou/Public/TEI-SF/P5/Exemplars/tei_all.rng
OBE=/home/lou/Public/Stylesheets.git/trunk/tools/oddbyexample.xsl



FILES= \
	B330636101_D55869_tei.xml \
	B360446201_B343_1_tei.xml \
	B360446201_B343_2_tei.xml \
	B360446201_THIA63_1_tei.xml \
	B372615206_1263_tei.xml \
	B372615206_3436_tei.xml \
	B372615206_4023_tei.xml \
	B372615206_4040_tei.xml \
	B372615206_11923_tei.xml \
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
	B751062305_LES_0697_tei.xml \
	B751131010_FR3370_suppl_tei.xml \
	B751131011_PYE868_tei.xml \
	B751131011_RES_P_Y2_1349_tei.xml \
	B751131011_RES_Y2_2125_tei.xml \
	B751131011_RES_Y2_2169_tei.xml \
	B751131011_RES_YD_1184_tei.xml \
	B751131011_Y2_251_tei.xml \
	B751131011_Y2_2126_tei.xml \
	B751131011_Y2_2146_tei.xml \
	B751131011_Y22789_tei.xml \
	B751131011_YE645_tei.xml \
	B751131011_YE4769_tei.xml \
	B751131015_PYC612_tei.xml \
	B751131015_X1888_tei.xml \
	B751131015_YE1457_1460_tei.xml \
	B751131015_YE1735_tei.xml \
	B751131015_YE11562_tei.xml \
	B751131015_Z1918_tei.xml \
	B759999999_Y2_2162_tei.xml \
	B759999999_Y2_2164_tei.xml \
	B861946101_DP1139_tei.xml \
	FRAD0330635101_1B252_179_tei.xml \
	FRAD0330635101_1B257_084_tei.xml \
	FRAD0330635101_1B258_149_tei.xml \
	FRAD0330635101_1B258_221_tei.xml \
	FRAD0330635101_1B259_105_tei.xml \
	FRAD0330635101_1B260_218_tei.xml \
	FRAD0330635101_1B260_273_tei.xml \
	FRAD0330635101_1B262_102_tei.xml \
	FRAD0330635101_1B264_223_tei.xml \
	FRAD0330635101_1B267_021_tei.xml \
	FRAD0330635101_1B268_305_tei.xml \
	FRAD0330635101_1B269_163_tei.xml \
	FRAD0330635101_1B269_182_tei.xml \
	FRAD0330635101_1B269_245_tei.xml \
	FRAD0330635101_1B271_227_tei.xml \
	FRAD0330635101_1B272_030_tei.xml \
	FRAD0330635101_1B274_185_tei.xml \
	FRAD0330635101_1B274_186_tei.xml \
	FRAD0330635101_1B278_074_tei.xml \
	FRAD0330635101_1B279_005_tei.xml \
	FRAD0330635101_1B279_008_tei.xml \
	FRAD0330635101_1B279_212_tei.xml \
	FRAD0330635101_1B280_118_tei.xml \
	FRAD0330635101_1B280_167_tei.xml \
	FRAD0330635101_1B280_168_tei.xml \
	FRAD0330635101_1B283_003_tei.xml \
	FRAD0330635101_1B284_168_tei.xml \
	FRAD0330635101_1B284_189_tei.xml \
	FRAD0330635101_1B284_190_tei.xml \
	FRAD0330635101_1B291_130_tei.xml \
	FRAD0330635101_1B291_161_tei.xml \
	FRAD0330635101_1B292_210_tei.xml \
	FRAD0330635101_1B292_239_tei.xml \
	FRAD0330635101_1B292_351_tei.xml \
	FRAD0330635101_1B294_101_tei.xml \
	FRAD0330635101_1B294_393_tei.xml \
	FRAD0330635101_1B295_087_tei.xml \
	FRAD0330635101_1B295_193_tei.xml \
	FRAD0330635101_1B295_237_tei.xml \
	FRAD0330635101_1B295_267_tei.xml \
	FRAD0330635101_1B295_331_tei.xml \
	FRAD0330635101_1B298_104_tei.xml \
	FRAD0330635101_1B298_188_tei.xml \
	FRAD0330635101_1B305_069_tei.xml \
	FRAD0330635101_1B305_083_tei.xml \
	FRAD0330635101_1B305_101_tei.xml \
	FRAD0330635101_1B305_228_tei.xml \
	XUVA_Gordon1543_B53_tei.xml \
	XUVA_Gordon1543_K43_tei.xml \
	XUVA_Gordon1563_R65b_2_tei.xml \
	XUVA_Gordon1563_R66_tei.xml \
	XUVA_Gordon1563_R67b_tei.xml \
	XUVA_Gordon1563_R656_tei.xml \
	XUVA_Gordon1563_R656b_tei.xml \
	XUVA_Gordon1564_R65_tei.xml \
	XUVA_Gordon1578_L47_tei.xml \

check:
	cd $(CORPUS); for f in $(FILES) ; do \
		echo $$f; \
		jing  $(SCHEMA) \
		$$f ; done; cd $(CURRENT);
generate:
		java -Xmx2G -jar /Applications/Saxon/saxon9he.jar -it:main -o:generated.odd \
	$(OBE) \
	corpus=$(CORPUS) ; \
	teitorelaxng generated.odd 
# generated.odd needs handediting to produce bvh.odd 

copy:
	echo Running identity transform ...
	cd $(CORPUS); 	for f in $(FILES) ; do \
		echo $$f; \
		java -Xmx2G -jar /Applications/Saxon/saxon9he.jar \
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
		java -Xmx2G -jar /Applications/Saxon/saxon9he.jar  \
		$$f $(CLEANUP) > $(CLEANCORPUS)/$$f; done; cd $(CURRENT);


checkClean:
	echo Validate cleaned corpus  against BVH schema
	cd $(CLEANCORPUS); 	for f in $(FILES) ; do \
		echo $$f; \
		jing $(BVHRNG) \
		$$f ; done; cd $(CURRENT);
checkLinks:
	/Applications/Saxon/saxon9he.jar -xi $(CLEANCORPUS)/driver.xml checkSharps.xsl | grep ERROR | sort | uniq > failedLinks.txt
