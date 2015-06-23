<xsl:stylesheet 
 xmlns:teix="http://www.tei-c.org/ns/Examples"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:rng="http://relaxng.org/ns/structure/1.0"
 extension-element-prefixes="exsl"
 exclude-result-prefixes="exsl teix rng tei"
 xmlns:exsl="http://exslt.org/common"
 version="2.0">

<xsl:output 
   method="xml"
   encoding="utf-8"
   indent="no"
   cdata-section-elements="tei:eg teix:egXML"
   omit-xml-declaration="yes"/>

<xsl:strip-space elements="*"/>
  
  
 <xsl:template match="*">
 <xsl:copy>
  <xsl:apply-templates select="@*">
    <xsl:sort select="name()"/>
    <!-- we do this so that subsequent rules which turn some attributes into elements wont fail -->
  </xsl:apply-templates>
  <xsl:apply-templates 
      select="*|comment()|processing-instruction()|text()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="@*|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

<xsl:template match="comment()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>