<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="2.0">
 
 <xsl:output method="text"/>
  <xsl:template match="TEI">
  <xsl:apply-templates select="text"/>
</xsl:template> 
  
  <xsl:template match="text">
    <xsl:variable name="context" select="."/>
    <xsl:variable name="textString">
      <xsl:apply-templates/>
    </xsl:variable>
    <xsl:for-each select="distinct-values(tokenize(normalize-space(replace($textString,'[.,-:]',
      ' ')),' '))">
      <xsl:sort/>
      <xsl:variable name="type"><xsl:value-of select="."/></xsl:variable>
      <xsl:value-of select="."/>
      <xsl:text>   </xsl:text>
      <xsl:value-of select="count($context//*[contains(.,$type)])"/>
      <xsl:text>       
      </xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="reg|corr|head|quote"/>
    
</xsl:stylesheet>