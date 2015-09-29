<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
		xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"		
		exclude-result-prefixes="tei xhtml aid xsi"
>

<xsl:output method="html" encoding="UTF-8"/>

<xsl:template match="/">
      <link rel="stylesheet" type="text/css" href="xxecss/sommaire.css"/>
       <html>
       <body>
       	<h1><xsl:value-of select="//tei:head[@xml:id='mainTitle']"/><xsl:text>
</xsl:text></h1>
       	<ul>
       		<xsl:for-each select="//tei:head[starts-with(@subtype, 'level')]">
<xsl:variable name="headLevel" select="@subtype"></xsl:variable>
       			<li><xsl:attribute name="class"><xsl:value-of select="$headLevel"/></xsl:attribute>
       				<xsl:text>
</xsl:text><xsl:apply-templates/>
       			</li>
       		</xsl:for-each>
       		<!--xsl:for-each select="//tei:head[@xml:id='mainTitle']">
       			<h1><xsl:value-of select="//tei:head[@xml:id='mainTitle']"/><xsl:text>
</xsl:text></h1>
			</xsl:for-each>
    		<xsl:for-each select="//tei:head[@subtype='level1']">
       			<h2><xsl:value-of select="."/><xsl:text>
</xsl:text></h2>
				<xsl:choose>
						<xsl:when test="//tei:head[@subtype='level2']"><h3><xsl:value-of select="."/><xsl:text>
</xsl:text></h3></xsl:when>
					</xsl:choose>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
       		</xsl:for-each>
    		<xsl:for-each select="//tei:head[@subtype='level2']">
       			<h3><xsl:value-of select="."/><xsl:text>
</xsl:text></h3>
       		</xsl:for-each-->
       	</ul>
       </body>
        </html>
</xsl:template>

<!--xsl:template match="//tei:head[@xml:id='mainTitle']"/>
<xsl:template match="//tei:head[@subtype='level1']"/>
<xsl:template match="//tei:head[@subtype='level2']"/-->

</xsl:stylesheet>