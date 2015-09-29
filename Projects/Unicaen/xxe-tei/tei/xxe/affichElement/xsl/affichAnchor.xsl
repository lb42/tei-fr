<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
		xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"		
		exclude-result-prefixes="tei xhtml"
>
<xsl:output method="text" encoding="UTF-8" indent="yes"/>

<xsl:strip-space elements="*"/>

<xsl:template match="/"><xsl:text>
</xsl:text>
	<xsl:for-each select="//tei:anchor">
		<xsl:apply-templates select="@xml:id"/><xsl:text>
</xsl:text>
    </xsl:for-each>
</xsl:template>

<!-- <xsl:template match="/"><xsl:text>
</xsl:text>
	<xsl:for-each select="//tei:anchor">
	<xsl:copy>
		<xsl:value-of select="@xml:id"/>
    </xsl:copy><xsl:text>
</xsl:text>
	</xsl:for-each>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:header"/>
<xsl:template match="tei:p"/> -->

</xsl:stylesheet>