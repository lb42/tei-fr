<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:t="http://www.tei-c.org/ns/1.0"
   
    version="2.0"
    >

    <xsl:output method="text" encoding="utf-8"/>
   
    
<xsl:template match="t:teiHeader"/>
<xsl:template match="t:div[@type='recto']"/>

<xsl:template match="t:div[@type='verso']">
<xsl:text>----------------------CARTE VERSO---------------------------</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="t:div[@type='message']">
<xsl:text>Message </xsl:text><xsl:number level="any"/><xsl:text> : </xsl:text>
<xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template match="t:div[@type='destination']">
<xsl:text>Destination </xsl:text><xsl:number level="any"/><xsl:text> : </xsl:text>
<xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<!--    <xsl:text>  -->
    
</xsl:stylesheet>

