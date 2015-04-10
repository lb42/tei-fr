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
   indent="yes"
   cdata-section-elements="tei:eg teix:egXML"
   omit-xml-declaration="yes"/>

<!-- first we try to get rid of duplicate xml:id values -->

<!-- change xml:id on name to @key -->
<xsl:template match="tei:name/@xml:id">
<xsl:attribute name="key">
<xsl:value-of select="."/>
</xsl:attribute>
</xsl:template>

<!-- add prefix to make div xml:ids unique -->
<xsl:template match="tei:div/@xml:id">
<xsl:attribute name="xml:id">
<xsl:value-of select="concat(substring-before(ancestor::tei:TEI/@xml:id,'tei'), .)"/>
</xsl:attribute>
</xsl:template>

<!-- remove xml:id on bibl for consistency -->
<xsl:template match="tei:bibl/@xml:id"/>

<!-- remove redundant xml:id on milestone -->
<xsl:template match="tei:milestone/@xml:id"/>

<!-- remove xml:id on handnote since there are no handshifts -->
<xsl:template match="tei:handNote/@xml:id"/>

<!-- remove xml:id on zone pending clarification of its use -->
<xsl:template match="tei:zone/@xml:id"/>


<!-- copy everything else -->

 <xsl:template match="*">
 <xsl:copy>
  <xsl:apply-templates select="@*"/>
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