<?xml version="1.0" encoding="UTF-8"?>

<!-- output specDescs for all included elements that don't already have one -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:key match="//tei:specDesc" use="@key" name="SPEX"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//tei:moduleRef"/>
    </xsl:template>
    <xsl:variable name="here" select="/"/>
    <xsl:template match="tei:moduleRef">
        <xsl:comment> From module <xsl:value-of select="@key"/></xsl:comment>
        <xsl:for-each select="tokenize(@include, ' ')">
            <xsl:variable name="this">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <xsl:if test="string-length($this) > 1">
                <xsl:if test="not(key('SPEX', $this, $here))">
                    <xsl:element name="specDesc">
                        <xsl:attribute name="key">
                            <xsl:value-of select="$this"/>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:text>
</xsl:text>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
