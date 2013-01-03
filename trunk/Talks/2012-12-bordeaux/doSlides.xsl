<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
   xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"
   xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    version="2.0">


  <xsl:output cdata-section-elements="eg" indent="yes" method="xml"
	      encoding="utf-8" omit-xml-declaration="yes"     

/>

<xsl:template match="/">
<div>
  <xsl:apply-templates/>
</div>
</xsl:template>

<xsl:template match="a:p">
<item><xsl:apply-templates/></item>
</xsl:template>
</xsl:stylesheet>