<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:teix="http://www.tei-c.org/ns/Examples"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    version="2.0">

    <xsl:template match="@* | text() | comment() | processing-instruction()">
        <xsl:copy/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:element name="{name()}">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="bibl">
        <bibl>
            <xsl:for-each select="author">
                <xsl:apply-templates select="."/>
                <xsl:text>, </xsl:text>
            </xsl:for-each>
            
            <xsl:for-each select="editor">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            
            <xsl:if test="date"><xsl:value-of select="date"/>
            <xsl:text>, </xsl:text></xsl:if>
            
            <xsl:apply-templates select="title"/>
            <xsl:text>, </xsl:text>
            <xsl:if test="pubPlace">
                <xsl:apply-templates select="pubPlace"/>
            </xsl:if>
            <xsl:if test="publisher">
                <xsl:apply-templates select="publisher"/>
            </xsl:if>
            <xsl:apply-templates select="biblScope"/>
            <xsl:apply-templates select="ref"/>
            <xsl:apply-templates select="ptr"/>

            <xsl:apply-templates select="note"/>
        </bibl>
        <xsl:text>
            
        </xsl:text>
    </xsl:template>


    <xsl:template match="pubPlace"> 
        <xsl:apply-templates/><xsl:text>, </xsl:text>
    </xsl:template>
    <xsl:template match="publisher">
        <xsl:apply-templates/><xsl:text>, </xsl:text>
    </xsl:template>

    <xsl:template match="title[@level='a']">
        <xsl:text> «</xsl:text>
        <xsl:apply-templates/>
      
        
        <xsl:text>» </xsl:text>
    </xsl:template>


    <xsl:template match="title[@level='m']">
     <xsl:variable name="lang">
         <xsl:choose>
    <xsl:when test='@xml:lang'>
             <xsl:value-of select="@xml:lang"/>
         </xsl:when>
             <xsl:otherwise>en</xsl:otherwise>
         </xsl:choose>
     </xsl:variable>
        
        <hi rend="it" xml:lang="{$lang}">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>

    <xsl:template match="title[@level='j']">
        <hi rend="it">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>

    <xsl:template match="author">
        <hi rend="sc">
            <xsl:value-of select="surname"/>
        </hi>
        <xsl:text> </xsl:text>
        <xsl:value-of select="forename"/>
    </xsl:template>

    <xsl:template match="editor">
        <xsl:variable name="roleTag">
            <xsl:choose>
                <xsl:when test='@role="trans"'> trans., </xsl:when>
                <xsl:otherwise> éd., </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <hi rend="sc">
            <xsl:value-of select="surname"/>
        </hi>
        <xsl:text> </xsl:text>
        <xsl:value-of select="forename"/>
       <xsl:choose>
           <xsl:when test="following-sibling::editor[1]"> et </xsl:when>
           <xsl:otherwise><xsl:value-of select="$roleTag"/></xsl:otherwise>
       </xsl:choose>
    </xsl:template>

    <xsl:template match="biblScope">
        <xsl:choose>
            <xsl:when test="@type='vol'">
                <xsl:text>vol. </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="@type='issue'">
                <xsl:text>no. </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test='@type="pp"'>
                <xsl:text>p. </xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="bibl/ref|bibl/ptr">
        <xsl:text> [URL : </xsl:text>
        <xsl:value-of select="@target"/>
        <xsl:text>] Consulté le 2 dec 2013. </xsl:text>
    </xsl:template>

    <xsl:template match="bibl/note">
        <xsl:text> (</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>)</xsl:text>
    </xsl:template>

</xsl:stylesheet>
