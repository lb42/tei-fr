<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet xmlns="http://www.tei-c.org/ns/1.0"
        xmlns:teix="http://www.tei-c.org/ns/Examples"
        xmlns:s="http://www.ascc.net/xml/schematron" 
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:tei="http://www.tei-c.org/ns/1.0"
        xmlns:t="http://www.thaiopensource.com/ns/annotations"
        xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
        xmlns:rng="http://relaxng.org/ns/structure/1.0"
        exclude-result-prefixes="tei t a rng s teix" 
        version="2.0">
      <xsl:template match="tei:TEI">
          <TEI>
          <xsl:apply-templates/>
          </TEI>
      </xsl:template>  
        <xsl:template match="tei:teiHeader|tei:pb">
            <xsl:copy-of select="."/>
        </xsl:template>
    <xsl:template match="tei:l/tei:hi">
        <xsl:variable name="indentCount">
            <xsl:value-of select="count(tei:space[not(preceding-sibling::text())])"/>
        </xsl:variable>
  
        <l>
<xsl:if test="$indentCount > 0"><xsl:attribute name="rendition">#indent-<xsl:value-of select="$indentCount"/>
</xsl:attribute></xsl:if>        
        <xsl:apply-templates/>
        </l>
    </xsl:template>
    <xsl:template match="tei:l/tei:hi/tei:space[preceding-sibling::text()][1]">
        <xsl:copy/>
    </xsl:template>
    <xsl:template match="tei:div">
        <div>
        <xsl:attribute name="n">
            <xsl:value-of select="position()"/>
        </xsl:attribute>
        <xsl:apply-templates/>
        </div>
    </xsl:template>
        <xsl:template match="tei:head">
            <head>
                <xsl:attribute name="rendition">
                    <xsl:value-of select="@rendition"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </head> 
        </xsl:template>
        <xsl:template match="tei:lg">
            <lg><xsl:apply-templates/></lg> 
        </xsl:template>
    <xsl:template match="tei:text">
        <text><body><xsl:apply-templates/></body></text>
    </xsl:template>
</xsl:stylesheet>