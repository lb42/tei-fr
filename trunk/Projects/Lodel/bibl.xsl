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
    
    
    <xsl:template match="title[@level='m']">
        <hi rend="it"><xsl:apply-templates/></hi>
    </xsl:template>
    
    <xsl:template match="author">
        <hi rend="sc"><xsl:value-of select="surname"/></hi><xsl:text>, </xsl:text>
        <xsl:value-of select="forename"/>
    </xsl:template>
    
    <xsl:template match="editor">
        <hi rend="sc"><xsl:value-of select="surname"/></hi><xsl:text>, </xsl:text>
        <xsl:value-of select="forename"/><xsl:text>, éd.</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>