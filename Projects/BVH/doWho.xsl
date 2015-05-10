<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:teix="http://www.tei-c.org/ns/Examples"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rng="http://relaxng.org/ns/structure/1.0" exclude-result-prefixes="tei" version="2.0">

    <xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>

    <xsl:key name="Peeps1" match="tei:sp/@who" use="1"/>
    <xsl:key name="Peeps2" match="tei:said/@who" use="1"/>

    <xsl:key name="IDS" match="*[@xml:id]" use="@xml:id"/>


    <xsl:template match="tei:profileDesc">
        <xsl:copy>
            <xsl:apply-templates/>
            <xsl:element name="particDesc" xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:for-each-group select="key('Peeps1', 1)" group-by=".">
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:variable name="pid" select="current-grouping-key()"/>
                    <xsl:element name="person" xmlns="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="xml:id">
                            <xsl:choose>
                                <xsl:when test="starts-with($pid, '#')">
                                    <xsl:value-of select="substring-after($pid, '#')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$pid"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each-group>
                <xsl:for-each-group select="key('Peeps2', 1)" group-by=".">
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:variable name="pid" select="current-grouping-key()"/>
                    <xsl:element name="person" xmlns="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="xml:id">
                            <xsl:choose>
                                <xsl:when test="starts-with($pid, '#')">
                                    <xsl:value-of select="substring-after($pid, '#')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$pid"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each-group>
            </xsl:element>
        </xsl:copy>
    </xsl:template>

    <!-- copy everything else -->

    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="* | comment() | processing-instruction() | text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@* | processing-instruction() | text()">
        <xsl:copy/>
    </xsl:template>

    <xsl:template match="comment()">
        <xsl:copy/>
    </xsl:template>


</xsl:stylesheet>
