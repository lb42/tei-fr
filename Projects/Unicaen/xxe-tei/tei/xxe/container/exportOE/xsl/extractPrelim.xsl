<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT extractNotes
*
*  Copyright (c) 2009-2015 
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
		xmlns:xinclude="http://www.w3.org/2001/XInclude"
		xmlns:xi="http://www.w3.org/2001/XInclude"
		xmlns="http://www.tei-c.org/ns/1.0"		
		exclude-result-prefixes="tei xhtml"
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>

<xsl:param name="directory"/>
<xsl:param name="fileName"/>

<xsl:variable name="sansExt" select="substring-before($fileName,'.')"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="/">

<xsl:if test="descendant::tei:div[@type='liminaires']">
	<xsl:result-document href="{concat($directory,'/OE/',$sansExt,'/presources/prelim_',$fileName)}" method="xml">
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
            <title>Préliminaires du volume</title>
          </titleStmt>
          <publicationStmt>
            <p></p>
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
          <change when="2015" who="réviseur">Nature de l'intervention</change>
        </revisionDesc>
      </teiHeader>
      <text xml:id="text">
      	<front>
      		<titlePage>
      			<titlePart type="main">
      				<xsl:text>Préliminaires du volume</xsl:text>
      			</titlePart>
      		</titlePage>
      	</front>
        <body>
        	<xsl:for-each select="//tei:div[@type='liminaires']">
          		<div>
                   	<xsl:copy-of select="*"/>
                </div>
            </xsl:for-each>
            <xsl:if test="//tei:epigraph">
               <xsl:copy-of select="//tei:epigraph"/>
            </xsl:if>
        </body>
      </text>
    </TEI>
  </xsl:result-document>
</xsl:if>
	<xsl:for-each select="//tei:body">
		<xsl:call-template name="docBody"/>
	</xsl:for-each>
  
	<xsl:apply-templates/>
</xsl:template>

<xsl:template name="docBody">
<xsl:variable name="prelimpartnum">
	<xsl:number count="tei:body" format="1" from="/" level="any"/>
</xsl:variable>
<xsl:result-document href="{concat($directory,'/OE/',$sansExt,'/presources/prelim_part_',$prelimpartnum,'.xml')}" method="xml">
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
            <title>Préliminaires des parties du volume</title>
          </titleStmt>
          <publicationStmt>
            <p></p>
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
          <change when="2015" who="réviseur">Nature de l'intervention</change>
        </revisionDesc>
      </teiHeader>
      <text xml:id="text">
      	<front>
      		<titlePage>
      			<titlePart type="main">
      				<xsl:text>Préliminaires des parties du volume</xsl:text>
      			</titlePart>
      		</titlePage>
      	</front>
        <body>
      		<div>
      			<xsl:copy-of select="./descendant::tei:*"/>
	        </div>
        </body>
      </text>
    </TEI>
</xsl:result-document>
</xsl:template>

</xsl:stylesheet>