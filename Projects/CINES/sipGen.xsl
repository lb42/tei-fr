<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    
    <xsl:template match="/">
        <xsl:apply-templates select="//teiHeader"/>
    </xsl:template>
    
    <xsl:template match="teiHeader">
        
        <pac xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="sip.xsd"
            xmlns="http://www.cines.fr/pac/sip"
          >
            <DocDC>
                <xsl:for-each select ="fileDesc/titleStmt/title">
                    
                <title language="fra">
                    <xsl:value-of select="."/>
                </title>
                </xsl:for-each>
                <xsl:for-each select ="fileDesc/titleStmt/author">
                <creator>
                    <xsl:apply-templates select="."/>
                </creator></xsl:for-each>
                <xsl:for-each select ="fileDesc/titleStmt/respStmt">
                    <creator>
                        <xsl:apply-templates select="."/>
                    </creator></xsl:for-each>
           
                <subject language="fra">
                    <xsl:choose><xsl:when test="profileDesc/textClass/keywords/term">  
                        <xsl:apply-templates select="profileDesc/textClass/keywords/term"/>
                    </xsl:when>
                    <xsl:otherwise>Aucune déscription trouvée</xsl:otherwise></xsl:choose>
                </subject>
                <description language="eng">A TEI encoded full text resource.
               <xsl:apply-templates select="encodingDesc/projectDesc"/> 
                    <xsl:apply-templates select="encodingDesc/editorialDesc"/>         
                </description>
                <publisher>
                    <xsl:apply-templates select="fileDesc/publicationStmt"/> 
                </publisher>
                <date>  <xsl:choose><xsl:when test="fileDesc/publicationStmt/date"> 
                    <xsl:value-of select="fileDesc/publicationStmt/date"/>
                </xsl:when>
                    <xsl:otherwise>Aucune date trouvée</xsl:otherwise></xsl:choose>
                </date>
                <type language="fra">text</type>
                <format language="eng">TEI XML Resource</format>
                <xsl:choose>
                    <xsl:when test="profileDesc/langUsage/language/@ident">
                        <language><xsl:value-of select="profileDesc/langUsage/language/@ident"/></language>
                    </xsl:when>    
               <xsl:otherwise><language>fra</language></xsl:otherwise>
                </xsl:choose>
                <rights language="fra">
                    <xsl:apply-templates select="fileDesc/publicationStmt/availability"/>
                </rights>
            </DocDC>
            <DocMeta>
                <identifiantDocProducteur>
                    <xsl:choose><xsl:when test='fileDesc/publicationStmt/idno'><xsl:value-of
                    select="fileDesc/publicationStmt/idno[1]"/></xsl:when>
                        <xsl:otherwise>Aucun identifiant fourni</xsl:otherwise>
                   </xsl:choose> 
                </identifiantDocProducteur>
                <serviceVersant> 
                    <xsl:value-of select="fileDesc/publicationStmt/distributor"/>
                </serviceVersant>
            </DocMeta>
          
               <!-- <formatFichier>XML</formatFichier>
                <nomFichier>wibble.xml</nomFichier>
                <empreinteOri type="MD5">empreinte numérique (fonction de hachage) du fichier calculée avec les algorithmes MD5, SHA-1 ou SHA-256 et fournie par le service versant</empreinteOri> -->
                <xsl:comment>Insert output from doSIP here</xsl:comment>
            
        </pac>    
    </xsl:template>
    
    <xsl:template match="availability">
        <xsl:apply-templates/>
        <xsl:if test='licence'>
            URI du licence: <xsl:value-of select="licence/@target"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="respStmt">
        <xsl:value-of select="resp"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates select="name"/>
        <xsl:text>
            
        </xsl:text>
    </xsl:template>
    
    <xsl:template match="publicationStmt">
        <xsl:for-each select="child::*">
          
         <xsl:choose>
           <xsl:when test="name(.) = 'availability'"><xsl:message>ignoring it</xsl:message></xsl:when>         
           <xsl:when test="name(.) = 'distributor'"><xsl:text>Distributed by </xsl:text>
           <xsl:apply-templates select="."/></xsl:when>
             <xsl:when test="name(.) = 'authority'"><xsl:text>Release authority :  </xsl:text> <xsl:apply-templates select="."/></xsl:when>
             <xsl:when test="name(.) = 'publisher'"><xsl:text>Published by  </xsl:text> <xsl:apply-templates select="."/></xsl:when>
             <xsl:when test="name(.) = 'idno'"/>
             <xsl:when test="name(.) = 'date'"/>
             <xsl:otherwise>
         <xsl:apply-templates select="."/>
        </xsl:otherwise>
         </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="term">
        <xsl:apply-templates/><xsl:text>;
            
        </xsl:text>
    </xsl:template>
    
    
</xsl:stylesheet>