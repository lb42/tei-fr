<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    
    
    <xsl:variable name="identifier">
        <xsl:value-of select="substring-before(tokenize(document-uri(.),'/')[last()],'.xml')"/>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:apply-templates select="tei:TEI/tei:text"/>
    </xsl:template>
  
    <xsl:template match="tei:text">
        <xsl:variable name="text">
            <xsl:apply-templates/>
        </xsl:variable>
<row>
    <cell><ref target="{$identifier}.xml">
        <xsl:value-of select="//tei:titleStmt/tei:title"/></ref></cell>
    <cell><xsl:value-of select="substring($text,1,60)"/><xsl:text>...</xsl:text></cell>
</row>  
        
    </xsl:template>
    
    <xsl:template match="tei:p">
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>
</xsl:stylesheet>