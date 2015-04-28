<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:meta="thankYouBobDuCharme"
    exclude-result-prefixes="xs" version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    <xsl:namespace-alias result-prefix="xsl"
        stylesheet-prefix="meta"/>
   

    <xsl:key name="divTypes" match="tei:*/@rend" use="1"/>
    <xsl:template match="/">
        <xsl:variable name="Q">'</xsl:variable>
        
    
        <meta:template>
        <xsl:attribute name="match">
        <xsl:text>tei:*/@type</xsl:text>
        </xsl:attribute>
           <meta:attribute>
               <xsl:attribute name="name">rend</xsl:attribute>
           
               <meta:choose>
                
            <xsl:for-each-group select="key('divTypes',1)" group-by=".">
                <xsl:sort select="current-grouping-key()"/>
                <xsl:variable name="ident" select="current-grouping-key()"/>
                
                <meta:when>
                    <xsl:attribute name="test">
                    <xsl:value-of select="concat('.=',$Q,$ident,$Q)"/></xsl:attribute> 
                        <xsl:value-of select="$ident"/><xsl:comment>
                            <xsl:value-of select="count(current-group())"/></xsl:comment>
                </meta:when>
            </xsl:for-each-group>
                <meta:otherwise>
                    <meta:value-of>
                        <xsl:attribute name="select">.</xsl:attribute>
                    </meta:value-of>
                </meta:otherwise>
        </meta:choose></meta:attribute>
       
        
        </meta:template>  

    </xsl:template>
</xsl:stylesheet>
