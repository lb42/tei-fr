<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:template match="/">      
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Bibliographie complète des Bibliothèques Virtuels Humanistes</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Fourni avec l'Epistemon</p>        
                    </publicationStmt>
                    <sourceDesc>
                        <p>Cet oeuvre dérive des travaux originels de plusieurs chercheurs du Centre de la Renaissance de l'Université de Tours</p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <p>Description détaillée du bibliographie à compléter </p>
                 <listBibl>
                     <xsl:for-each select="//tei:bibl">
                         <xsl:sort />
                         <xsl:if test='count(child::*) gt 1'>
                         <xsl:if test="ancestor::tei:teiHeader">
                         <xsl:copy>
                             
                             <xsl:if test='not(@xml:id)'>
                                 <xsl:attribute name="xml:id">
                                     <xsl:text>BIB_</xsl:text>
                                     <xsl:number format="001" level="any"/>                             
                                 </xsl:attribute>
                             </xsl:if>
                             <xsl:apply-templates select="@*"/>
                             <xsl:apply-templates 
                                 select="*|comment()|processing-instruction()|text()"/>
                         </xsl:copy>
                         </xsl:if></xsl:if>
                     </xsl:for-each>
                 </listBibl>   
                </body>
            </text>
        </TEI>
    </xsl:template>
    
   <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates 
                select="*|comment()|processing-instruction()|text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*|processing-instruction()|text()">
        <xsl:copy/>
    </xsl:template>
    
    <xsl:template match="comment()">
        <xsl:copy/>
    </xsl:template>
</xsl:stylesheet>