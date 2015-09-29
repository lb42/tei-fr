<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT indd2tei
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

<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
		xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"		
		xmlns:xi="http://www.w3.org/2001/XInclude"
		exclude-result-prefixes="tei xhtml xsi">
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<!-- <xsl:strip-space elements="*"/> -->

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:sourceDesc">
	<sourceDesc>
		<p>Version des outils : 0.9 vers 0.9+ (struct)</p>
		<p>Written by OpenOffice</p>
	</sourceDesc>
</xsl:template>

<xsl:template match="tei:text">
<text xml:id="text">
<front>
	<titlePage>
		<docTitle>
			<titlePart type="main" aid:pstyle="T_3_Article">
				<xsl:copy-of select="//tei:head[@aid:pstyle='T_3_Article']/node()|text()|//tei:titlePart[@aid:pstyle='T_3_Article']/node()|text()"/>
			</titlePart>
			<xsl:if test="//tei:head[@aid:pstyle='T_0_Article_UK']">
				<titlePart type="alt" aid:pstyle="T_0_Article_UK">
					<xsl:value-of select="//tei:head[@aid:pstyle='T_0_Article_UK']"/>
				</titlePart>
			</xsl:if>
		</docTitle>
		<xsl:if test="../descendant::tei:author">
			<byline>
			<xsl:for-each select="../descendant::tei:author/tei:name">
				<docAuthor aid:pstyle="txt_auteur">
					<xsl:value-of select="."/>
				</docAuthor>
				<xsl:if test="following-sibling::tei:affiliation">
					<affiliation>
						<xsl:value-of select="following-sibling::tei:affiliation"/>
					</affiliation>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="//tei:p[@aid:pstyle='auteur_Institution']">
				<affiliation aid:pstyle="auteur_Institution">
					<xsl:value-of select="//tei:p[@aid:pstyle='auteur_Institution']"/>
				</affiliation>
			</xsl:if>
			<xsl:if test="//tei:p[@aid:pstyle='auteur_Courriel']">
				<email aid:pstyle="auteur_Courriel">
					<xsl:value-of select="//tei:p[@aid:pstyle='auteur_Courriel']"/>
				</email>
			</xsl:if>
			</byline>
		</xsl:if>
	</titlePage>
	<xsl:if test="//tei:p[@aid:pstyle='txt_Resume']">
		<div type="resume_motscles">
			<xsl:copy-of select="//tei:p[@aid:pstyle='txt_Resume']"/>
			<xsl:if test="//tei:p[@aid:pstyle='txt_Resume_italique']">
				<xsl:copy-of select="//tei:p[@aid:pstyle='txt_Resume_italique']"/>
			</xsl:if>
			<xsl:if test="//tei:p[@aid:pstyle='txt_Motclef']">
				<xsl:copy-of select="//tei:p[@aid:pstyle='txt_Motclef']"/>
			</xsl:if>
			<xsl:if test="//tei:p[@aid:pstyle='txt_Keywords']">
				<xsl:copy-of select="//tei:p[@aid:pstyle='txt_Keywords']"/>
			</xsl:if>
		</div>
	</xsl:if>
	<xsl:if test="//tei:p[@aid:pstyle='txt_remerciements']">
		<div type="prelim">
			<xsl:apply-templates select="//tei:p[@aid:pstyle='txt_remerciements']"/>
		</div>
	</xsl:if>
</front>
<body>
		<!--xsl:apply-templates select="//tei:div[@type='section1']/preceding-sibling::tei:p[@aid:pstyle='txt_Normal']"/>
		<xsl:apply-templates select="//tei:div[@type='section1']/preceding-sibling::tei:quote[@aid:pstyle='txt_Citation']"/-->
		<xsl:apply-templates select="//tei:div[@type='chapitre']"/>
</body>
<back>
	<xsl:if test="//tei:div[@subtype='annexe']">
		<xsl:copy-of select="//tei:div[@subtype='annexe']"/>
	</xsl:if>
	<xsl:if test="//tei:div[@subtype='bibliographie']">
		<div type="bibliographie"><listBibl><xsl:copy-of select="//tei:div[@subtype='bibliographie']/node()"/></listBibl></div>
	</xsl:if>
	<xsl:if test="//tei:div[@type='bibliographie']">
		<div type="bibliographie"><listBibl><xsl:copy-of select="//tei:div[@type='bibliographie']/node()"/></listBibl></div>
	</xsl:if>
</back>
</text>
</xsl:template>

<xsl:template match="//tei:div[@subtype='annexe']"/>
<xsl:template match="//tei:div[@type='bibliographie']"/>
<xsl:template match="//tei:div[@subtype='bibliographie']"/>
<xsl:template match="//tei:head[@aid:pstyle='T_3_Article']"/>
<xsl:template match="//tei:p[@aid:pstyle='auteur']"/>
<xsl:template match="//tei:p[@aid:pstyle='auteur_Institution']"/>
<xsl:template match="//tei:p[@aid:pstyle='auteur_Courriel']"/>
<xsl:template match="//tei:p[@aid:pstyle='txt_Resume']"/>
<xsl:template match="//tei:p[@aid:pstyle='txt_Resume_italique']"/>
<!--<xsl:template match="//tei:p[@aid:pstyle='txt_Motclef']"/>
<xsl:template match="//tei:p[@aid:pstyle='txt_Keywords']"/>-->

<!--xsl:template match="//tei:div[@type='chapitre']"/>
<xsl:template match="//tei:p[@aid:pstyle]"/>
<xsl:template match="//tei:quote[@aid:pstyle]"/-->


</xsl:stylesheet>
