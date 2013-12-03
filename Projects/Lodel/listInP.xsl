<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:teix="http://www.tei-c.org/ns/Examples"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    
    <xsl:template match="@* | text() | comment() | processing-instruction()">
        <xsl:copy/>
    </xsl:template>
    
    <xsl:template match="*">
        <xsl:element name="{name()}" >
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="div">
  <xsl:copy>
            <xsl:apply-templates select="@*" />
      <xsl:apply-templates/>
  </xsl:copy>
        
    </xsl:template>
    
    <xsl:template match="list">
        <xsl:if test="parent::p">
            <xsl:message>list inside p! panic!</xsl:message>
        </xsl:if>
    </xsl:template>
    <xsl:template match="figure/head">
        <xsl:message>panic! head not allowed inside figure</xsl:message>
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:variable name="level">
            <xsl:value-of select="count(ancestor-or-self::div)"/>
        </xsl:variable>
        <xsl:message>head level <xsl:value-of select="$level"/></xsl:message>
       <xsl:element name="head">
           <xsl:attribute name="subtype">
               <xsl:value-of select="concat('level',$level)"/>
           </xsl:attribute>
           <xsl:apply-templates/>
       </xsl:element> 
    </xsl:template>
    
</xsl:stylesheet>