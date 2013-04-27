<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    version="1.0">
    
    <xsl:template match="tei:emph">
        <hi><xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="tei:q">
        <hi><xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="tei:term">
        <hi><xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="tei:gi">
        <hi>&lt;<xsl:apply-templates/>
        &gt;</hi>
    </xsl:template>
    
    <xsl:template match="tei:tag">
        <hi>&lt;<xsl:apply-templates/>
            &gt;</hi>
    </xsl:template>
    
    <xsl:template match="tei:soCalled">
        <hi>`<xsl:apply-templates/>
            '</hi>
    </xsl:template>
    
    <xsl:template match="tei:title">
        <hi><xsl:apply-templates/>
            </hi>
    </xsl:template>
    
    <xsl:template match="eg:egXML">
        <!-- ??? -->
        
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