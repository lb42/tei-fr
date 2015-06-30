<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    
    <!-- Déplacement des numérotations entre crochets vers les <pb/>
    Lauranne Bertrand, 04/06/2015 -->
    
    <xsl:output encoding="UTF-8" method="xml"/>
    
    <!-- copie de l'ensemble du fichier -->
    
    <xsl:template match="*|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- récupération du num entre crochets dans le <pb/> précédent -->
    
    <xsl:template match="tei:pb">
        <xsl:choose>
            <xsl:when test="following-sibling::tei:fw[@type='pageNum']">
                <pb>
                    <!-- xsl:copy-of select="@*[not(@n)]"/-->
                    <!-- The attribute axis starting at an attribute node will never select anything-->
                    <xsl:copy-of select="@*[not(local-name(.)='n')]"/>
                   
                    <xsl:attribute name="n">
                        <xsl:choose>
                            <xsl:when test="following-sibling::tei:fw[@type='pageNum'][1]/tei:choice">
                        <xsl:value-of select="following-sibling::tei:fw[@type='pageNum'][1]/tei:choice/tei:corr/text()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="following-sibling::tei:fw[@type='pageNum'][1]/text()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </pb>
            </xsl:when>
            <xsl:otherwise>
                <pb>
                    <xsl:copy-of select="@*"/>
                </pb>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- suppression des fw qui contiennent des num entre crochets -->
    
    <xsl:template match="tei:fw[@type='pageNum' and contains(., '[')]"/>
   
    
</xsl:stylesheet>