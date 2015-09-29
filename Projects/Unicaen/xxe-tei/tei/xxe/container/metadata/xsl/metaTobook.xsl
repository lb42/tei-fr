<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT xinclude résolution des inclusions avant export epub depuis le container
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
		xmlns="http://www.tei-c.org/ns/1.0"	
		xmlns:xi="http://www.w3.org/2001/XInclude"
		exclude-result-prefixes="tei xhtml"
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:titlePage[@type='pagedetitre']">
	<titlePage type="pagedetitre" xml:id="pdt1">
		<docTitle>
			<titlePart type="main" aid:pstyle="Vol_titre">
				<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='main']"/>
			</titlePart>
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='compl']">
				<titlePart type="compl" aid:pstyle="Vol_titre_compl">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='compl']"/>
				</titlePart>
			</xsl:if>
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='sub']">
				<titlePart type="sub" aid:pstyle="Vol_ss_titre">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='sub']"/>
				</titlePart>
			</xsl:if>
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='alt']">
				<titlePart type="alt" aid:pstyle="Vol_titre_trad">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='alt']"/>
				</titlePart>
			</xsl:if>
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='orig']">
				<titlePart type="orig" aid:pstyle="Vol_titre_orig">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='orig']"/>
				</titlePart>
			</xsl:if>
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='collection']">
				<titlePart type="collection" aid:pstyle="Vol_collection">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:title[@type='collection']"/>
				</titlePart>
			</xsl:if>
		</docTitle>
		<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:author">
		<byline>
			<xsl:for-each select="//preceding-sibling::tei:teiHeader/descendant::tei:author">
				<docAuthor aid:pstyle="Vol_auteur">
					<xsl:value-of select="."/>
				</docAuthor>
			</xsl:for-each>
		</byline>	
		</xsl:if>
		<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:respStmt">
		<byline>
			<xsl:for-each select="//preceding-sibling::tei:teiHeader/descendant::tei:respStmt">
				<docAuthor aid:pstyle="Vol_resp">
					<xsl:value-of select="."/>
				</docAuthor>
			</xsl:for-each>
		</byline>	
		</xsl:if>
		<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:respStmt/tei:name">
			<byline>
				<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:respStmt"/>
			</byline>
		</xsl:if>
	</titlePage>
	<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:editor or //preceding-sibling::tei:teiHeader/descendant::tei:sponsor or //preceding-sibling::tei:teiHeader/descendant::tei:desc[@type='licence'] or //preceding-sibling::tei:teiHeader/descendant::tei:bibl">
		<titlePage type="pagedecredits" xml:id="pdt2">
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:bibl">
				<byline aid:pstyle="Vol_biblio">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:bibl"/>
				</byline>
			</xsl:if>
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:desc[@type='licence']">
				<byline aid:pstyle="Vol_droits">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:desc[@type='licence'][1]"/>
				</byline>
			</xsl:if>
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:editor">
				<byline aid:pstyle="Vol_editeur">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:editor"/>
				</byline>
			</xsl:if>
			<xsl:if test="//preceding-sibling::tei:teiHeader/descendant::tei:sponsor">
				<byline aid:pstyle="Vol_sponsor">
					<xsl:value-of select="//preceding-sibling::tei:teiHeader/descendant::tei:sponsor"/>
				</byline>
			</xsl:if>
		</titlePage>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>