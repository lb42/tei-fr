#for f in Transcriptions/*/*.docx; do echo $f; docxtotei --profile=oulipo $f; done
#mv Transcriptions/*/*.xml XML
cd XML
saxon -it:main -o:generated.odd ../oddbyexample.xsl corpus=.


