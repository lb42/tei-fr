<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

  <xsl:template match="TEI">
    <html>
      <head>
        <title>
          <xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/>
        </title>
      </head>
      <body>
        <xsl:apply-templates select="text"/>
      </body>
    </html>
  </xsl:template>

<xsl:variable name="modernisation">oui</xsl:variable>
  
  <xsl:template match="l">
    <xsl:apply-templates/><br/>
  </xsl:template>
    
  <xsl:template match="head">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>  
  
  <xsl:template match="lg">
    <xsl:number/>
    <p><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="choice">
<xsl:choose>
<xsl:when test='$modernisation="oui"'>
<xsl:value-of select="reg"/>
</xsl:when>
<xsl:when test='$modernisation="non"'>
<xsl:value-of select="orig"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates/>
</xsl:otherwise>
</xsl:choose>

</xsl:template>
  
</xsl:stylesheet>
