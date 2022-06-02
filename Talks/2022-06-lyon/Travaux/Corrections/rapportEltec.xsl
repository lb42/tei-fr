<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="/"> 
        Rapport sur "<xsl:value-of
            select="substring-before(/TEI/teiHeader/fileDesc/titleStmt/title, ':')"/>
        <xsl:text>" de </xsl:text>
        <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/author"/> 
        
        Ce roman contient <xsl:value-of
            select="count(//div[@type = 'chapter'])"/> chapitres, <xsl:value-of 
            select="TEI/teiHeader/fileDesc/extent/measure[@unit='words']"/> mots, et <xsl:value-of
            select="count(//p)"/> paragraphes, soit en moyen <xsl:value-of select="TEI/teiHeader/fileDesc/extent/measure[@unit='words'] div count(//p)"/> mots par paragraphe.
        
        Voici une liste des chapitres, avec la location de son debut, et le contenu de son dernier paragraphe:
        <xsl:for-each
            select="//div[@type = 'chapter']">
            <xsl:value-of select="head"/>
            <xsl:choose>
                <xsl:when test="preceding::pb">
                    <xsl:text>...a la page </xsl:text> <xsl:value-of
                    select="preceding::pb[1]/@n"/></xsl:when>
                <xsl:otherwise>
                    <xsl:text>... au paragraphe </xsl:text> <xsl:value-of select="count(preceding::p)"/></xsl:otherwise>
            </xsl:choose><xsl:text>
Para final: </xsl:text>
            <xsl:value-of select="p[position() = last()]"/>
            <xsl:text>
</xsl:text>
                <xsl:if test="count(l) &gt; 0">
                    ... ce roman contient aussi <xsl:value-of select="count(l)"/> vers!
                </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
