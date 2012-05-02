<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:t="http://www.tei-c.org/ns/1.0"
   
    version="2.0"
    >
    <xsl:output method="text" encoding="utf-8"/>
   
    
    <xsl:template match="/">
        <xsl:apply-templates select="t:TEI/t:text"/>
   </xsl:template>         
        
    <xsl:template match="t:note"/>
  <xsl:template match="t:p[@rend]"/>
    <xsl:template match="t:hi[@rend]"/>
    
<xsl:template match="t:p/text()">
<xsl:value-of select="ancestor::t:div/@n"/><xsl:text>_</xsl:text><xsl:number level="any"/><xsl:text>  </xsl:text>
    <xsl:value-of select="normalize-space(.)"/><xsl:text>  
    </xsl:text>
 <!--       <xsl:for-each select="tokenize(normalize-space(.), ' ')">
            <xsl:value-of select="."/>
            <xsl:text>|
            </xsl:text>
        </xsl:for-each>      
   --> </xsl:template>

   <!-- <xsl:template match="*|@*|processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
        </xsl:copy>
    </xsl:template>
    -->
    <xsl:template match="text()"/>
    
</xsl:stylesheet>

