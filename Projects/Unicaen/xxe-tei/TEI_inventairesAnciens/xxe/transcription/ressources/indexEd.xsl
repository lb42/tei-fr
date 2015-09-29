<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
		xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"	
		exclude-result-prefixes="tei"
>
		<!--xmlns:xxe="http://www.unicaen.fr/mrsh/pddn/xxe/1.0"	-->		
<xsl:output method="text" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>

<xsl:param name="typeIndex" />


<xsl:template match="/">
<xsl:text>(-- Nouvelle entrée --)</xsl:text><xsl:text>
</xsl:text>?<xsl:text>
</xsl:text>

<xsl:choose>
	<xsl:when test="$typeIndex='Resp'">
		<xsl:for-each select="//tei:editor">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Ed'">
			<xsl:for-each select="//tei:msDesc">
				<xsl:apply-templates select="."/>
			</xsl:for-each>
			<xsl:for-each select="//tei:biblStruct">
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</xsl:when>	
</xsl:choose>
</xsl:template>

	

	
	<xsl:template match="tei:biblStruct">
<xsl:value-of select="tei:biblStruct"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="tei:msDesc">
<xsl:value-of select="tei:msIdentifier/tei:settlement"/><xsl:text> </xsl:text><xsl:value-of select="tei:msIdentifier/tei:repository"/> • <xsl:value-of select="tei:msIdentifier/tei:idno"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>	
	
	
	
	
	

</xsl:stylesheet>