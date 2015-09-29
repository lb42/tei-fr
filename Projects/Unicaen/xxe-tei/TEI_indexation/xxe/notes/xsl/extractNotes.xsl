<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT extractNotes
*
*  Copyright (c) 2009-2013 
*  Pôle Document Numérique
*  Maison de la Recherche en Sciences Humaines
*  Université de Caen Basse-Normandie
*  Esplanade de la Paix
*  Campus 1
*  14032 Caen Cedex
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*  <http://www.gnu.org/licenses/>
*
*  See http://www.unicaen.fr/recherche/mrsh/document_numerique/equipe
*      for a list of contributors
*/
-->

<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
		xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"		
		exclude-result-prefixes="tei xhtml"
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>

<xsl:param name="directory"/>
<xsl:param name="fileName"/>

<xsl:template match="/">
  <xsl:for-each select="//tei:note">
    <xsl:variable name="localType">
    	<xsl:if test="@type!='standard'">
    	  <xsl:value-of select="@type"/>
		</xsl:if>
    </xsl:variable>
    <xsl:variable name="nbNotes">
      <xsl:number count="tei:note[@type=$localType]" from="/" level="any"/>
    </xsl:variable>
    <xsl:if test="$nbNotes!='' and $nbNotes=1">
      <xsl:call-template name="docNotes">
        <xsl:with-param name="typeNotes">
        	<xsl:value-of select="$localType"/>
        </xsl:with-param>
      </xsl:call-template>        
    </xsl:if>
  </xsl:for-each>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:note">
  <xsl:variable name="currentType">
  	  <xsl:if test="@type!='standard'">
    	<xsl:value-of select="@type"/>
      </xsl:if>
  </xsl:variable>
  <xsl:variable name="currentN">
    <xsl:value-of select="@n"/>
  </xsl:variable>
  <xsl:variable name="currentId">
  	<xsl:value-of select="@xml:id"/>
  </xsl:variable>
  <xsl:variable name="placeNote">
  	<xsl:value-of select="@place"/>
  </xsl:variable>
  <xsl:variable name="nbNotes">
    <xsl:choose>
      <xsl:when test="$currentType='apparat'">
        <xsl:number format="A" count="tei:note[@type=$currentType]" from="//tei:div[@type='chapitre']" level="any"/>
      </xsl:when>
      <xsl:when test="$currentType='sources'">
        <xsl:number format="a" count="tei:note[@type=$currentType]" from="//tei:div[@type='chapitre']" level="any"/>
      </xsl:when>
      <xsl:when test="$currentType='philologie'">
        <xsl:number format="1" count="tei:note[@type=$currentType]" from="/" level="any"/>
      </xsl:when>
    </xsl:choose>
  </xsl:variable>
  <xsl:if test="@type='standard'">
  	<xsl:copy>
  		<xsl:attribute name="aid:pstyle">txt_Note</xsl:attribute>
  		<xsl:attribute name="type">standard</xsl:attribute>
  		<xsl:attribute name="place"><xsl:value-of select="$placeNote"/></xsl:attribute>
  		<xsl:attribute name="xml:id"><xsl:value-of select="$currentId"/></xsl:attribute>
  		<xsl:attribute name="n"><xsl:value-of select="$currentN"/></xsl:attribute>
  		<xsl:apply-templates/>
  	</xsl:copy>
  </xsl:if>
  <xsl:if test="@type!='standard'">
  <hi rend="sup" type="{$currentType}" aid:cstyle="typo_Exposant" n="{$currentN}"><xsl:value-of select="$nbNotes"/></hi>
  </xsl:if>
</xsl:template>

<xsl:template name="docNotes">
  <xsl:param name="typeNotes"/>
  <xsl:variable name="prefix">
    <xsl:value-of select="substring-before($fileName,'.xml')"/>
  </xsl:variable>
  <xsl:result-document method="xml" href="{concat($directory,'/',$prefix,'_notes_',$typeNotes,'.xml')}">
    <TEI 
      xmlns="http://www.tei-c.org/ns/1.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      xmlns:xinclude="http://www.w3.org/2001/XInclude"
      xmlns:ns="http://www.tei-c.org/ns/1.0"
      xmlns:hfp="http://www.w3.org/2001/XMLSchema-hasFacetAndProperty"
      xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
      xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/">
      <teiHeader>
        <fileDesc>
          <titleStmt>
            <title><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></title>
            <author>XMLMind XML Editor</author>
          </titleStmt>
          <publicationStmt>
            <p>Fichier de notes "<xsl:value-of select="$typeNotes"/>"</p>
          </publicationStmt>
          <sourceDesc>
            <bibl>Référence bibliographique à la source</bibl>
          </sourceDesc>
        </fileDesc>
        <encodingDesc>
          <projectDesc>
            <p>Informations sur l'encodage.</p>
          </projectDesc>
        </encodingDesc>
        <revisionDesc>
          <change when="2010" who="réviseur">Nature de l'intervention</change>
        </revisionDesc>
      </teiHeader>
      <text>
        <front>
        </front>
        <body>
          <div>
            <xsl:for-each select="//tei:div[@type='chapitre']">
              <p aid:pstyle="txt_Note_{$typeNotes}" n="{@xml:id}">
                <xsl:for-each select="descendant::tei:note">
                  <xsl:if test="@type=$typeNotes">
                    <xsl:variable name="nbNotes">
                      <xsl:choose>
                        <xsl:when test="$typeNotes='apparat'">
                          <xsl:number format="A" count="tei:note[@type=$typeNotes]" from="//tei:div[@type='chapitre']" level="any"/>
                        </xsl:when>
                        <xsl:when test="$typeNotes='sources'">
                          <xsl:number format="a" count="tei:note[@type=$typeNotes]" from="//tei:div[@type='chapitre']" level="any"/>
                        </xsl:when>
                        <xsl:when test="$typeNotes='philologie'">
                          <xsl:number format="1" count="tei:note[@type=$typeNotes]" from="/" level="any"/>
                        </xsl:when>
                      </xsl:choose>
                      <!--                  <xsl:number count="tei:note[@type=$typeNotes]" from="/" level="any"/> -->
                    </xsl:variable>
                    <note aid:pstyle="txt_Note_{$typeNotes}" n="{@n}" xml:id="{@xml:id}" type="{$typeNotes}">
                      <xsl:choose>
                        <xsl:when test="@type='apparat'">
                          <xsl:text>&#160;|&#160;</xsl:text><c aid:cstyle="typo_Gras"><xsl:value-of select="$nbNotes"/></c><xsl:text>&#0009;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>&#0009;</xsl:text><xsl:value-of select="$nbNotes"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>&#160;</xsl:text><xsl:apply-templates/></note>
                  </xsl:if>
                </xsl:for-each>
              </p>
            </xsl:for-each>
          </div>
        </body>
      </text>
    </TEI>
  </xsl:result-document>
</xsl:template>

<xsl:template match="tei:index">
  <xsl:if test="not(ancestor::tei:note)">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:if>
</xsl:template>

<xsl:template match="tei:bibl">
  <!--  [<xsl:apply-templates/>] -->
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:hi">
  <xsl:choose>
    <xsl:when test="@rend='italic'">
      <hi rend="italic" aid:cstyle="typo_italic"><xsl:apply-templates/></hi>
    </xsl:when>
    <xsl:when test="@rend='small-caps'">
      <hi aid:cstyle="typo_SC"><xsl:apply-templates/></hi>
    </xsl:when>
    <xsl:otherwise>
      <hi><xsl:apply-templates/></hi>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


</xsl:stylesheet>