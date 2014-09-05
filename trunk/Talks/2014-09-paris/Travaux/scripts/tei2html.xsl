<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:template match="TEI">
        <html>
            <head>
                <title><xsl:value-of select=".//titleStmt/title"/></title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="teiHeader"/>
    <xsl:template match="p | trailer">
        <p>
            <xsl:if test="@rend = 'indent'">
                <xsl:attribute name="style">text-indent:15px</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    <xsl:template match="del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    <xsl:template match="head">
        <h3><xsl:apply-templates/></h3>
    </xsl:template>
    <xsl:template match="add">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>
    <xsl:template match="unclear">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    <xsl:template match="pb">
        <xsl:variable name="facs" select="substring-after(@facs, '#')"/>
        <div style="float:left">
            <img src="{//surface[@xml:id =$facs]/graphic/@url}" alt=""/>
        </div>
    </xsl:template>
    <xsl:template match="signed">
        <p style="text-align:right"><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="app">
        <xsl:apply-templates select="lem"/> <span style="color:gray">{<xsl:value-of select="rdg"/>}</span>
        
    </xsl:template>
</xsl:stylesheet>