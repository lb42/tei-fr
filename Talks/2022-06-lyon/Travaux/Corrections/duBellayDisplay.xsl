<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="2.0">
 
  <xsl:template match="TEI">
  <html>
   <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
     <title><xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/></title>
   </head>
      <body>
        <xsl:apply-templates select="text"/>
      </body>
  </html>
</xsl:template> 
  
  <xsl:template match="l|lb">
    <xsl:apply-templates/><br/>
  </xsl:template>
  
  <xsl:template match="head">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>
  
  <xsl:template match="lg">
    <p class="lg-number"><xsl:number/></p>
    <p><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:param name="modernisation">oui</xsl:param>

  <xsl:template match="choice">
    <xsl:choose>
      <xsl:when test="$modernisation='oui'">
        <xsl:apply-templates select="reg|corr|expan"/>
      </xsl:when>
      <xsl:when test="$modernisation='non'">
        <xsl:apply-templates select="orig|sic|abbr"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:comment>Valeur du paramètre "modernisation" non reconnue (<xsl:value-of select="$modernisation"/>).</xsl:comment>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="pb"><p><img src="duBellay.png" height="400em" style="float:right"></img></p></xsl:template>
  
</xsl:stylesheet>