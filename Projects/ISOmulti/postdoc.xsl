<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    

<xsl:output method="xml" indent="yes"
    cdata-section-elements="code"
    exclude-result-prefixes="tei eg"/>

  <xsl:template match="@* | text() | comment() | processing-instruction()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:element name="{name()}" >
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

<!-- XML examples are always in a table cell for some reason -->

<xsl:template match="//tei:table">
<xsl:apply-templates select="tei:row/tei:cell"/>
</xsl:template>

<xsl:template match="tei:cell">
<egXML ns="http://www.tei-c.org/example/1.0">
<xsl:apply-templates/>
</egXML>
</xsl:template>

<xsl:template match="//tei:cell/tei:p">
<xsl:value-of select="."/><xsl:text>
</xsl:text>
</xsl:template>

<!-- other unwarranted assumptions: if a p contains a bold string it's
a bibl -->

<xsl:template match="tei:p">
<xsl:if test="tei:hi[@rend='bold']">
<bibl>
<xsl:apply-templates />
</bibl>
</xsl:if>
</xsl:template>    
</xsl:stylesheet>