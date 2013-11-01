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

<xsl:template match="eg:egXML">
<p rend="noindent">
    <code lang="xml">
<xsl:text>some text</xsl:text>
<xsl:apply-templates/>

    </code>
</p>
    </xsl:template>


    <xsl:template match="tei:emph">
        <tei:hi rend="emph"><xsl:apply-templates/>
        </tei:hi>
    </xsl:template>
    
    <xsl:template match="tei:q">
        <hi rend="q"><xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="tei:term">
        <hi rend="it"><xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="tei:gi">
        &lt;<xsl:apply-templates/>
        &gt;
    </xsl:template>
    
    <xsl:template match="tei:tag">
        &lt;<xsl:apply-templates/>
            &gt;
    </xsl:template>
    
    <xsl:template match="tei:soCalled">
        <hi>`<xsl:apply-templates/>
            '</hi>
    </xsl:template>
    
    <xsl:template match="tei:title">
        <hi><xsl:apply-templates/>
            </hi>
    </xsl:template>
    

    <xsl:template match="tei:p/tei:list">
    <!-- not allowed -->
    </xsl:template>

<xsl:template match="tei:figure/tei:head">
    <!-- not allowed -->
</xsl:template>
    
    <xsl:template match="graphic/@width">
        <!-- not allowed -->
    </xsl:template>
    
</xsl:stylesheet>