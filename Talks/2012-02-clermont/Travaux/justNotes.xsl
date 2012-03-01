<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:t="http://www.tei-c.org/ns/1.0"
   
    version="2.0"
    >
    <xsl:output method="xml" indent="yes"/>
   
    
    <xsl:template match="/">
        <xsl:apply-templates select="//t:hi[@rend='footnote_reference']/t:note"/>
   </xsl:template>         
        
    
    
    <xsl:template match="*|@*|processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
</xsl:stylesheet>

