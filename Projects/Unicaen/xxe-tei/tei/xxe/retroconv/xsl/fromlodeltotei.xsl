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
		exclude-result-prefixes="tei xhtml xsi"
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<!--<xsl:template match="tei:front">
<front>
	<titlePage>
		<titlePart type="main" aid:pstyle="T_3_Article">
			<xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']"/>
		</titlePart>
		<xsl:choose>
			<xsl:when test="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type!='main']">
			<xsl:variable name="titleType" select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type!='main']/@type"/>
				<titlePart>
					<xsl:attribute name="type" select="$titleType"/>
					<xsl:apply-templates select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type!='main']/node()"/>
				</titlePart>
			</xsl:when>
		</xsl:choose>
		<byline>
			<docAuthor aid:pstyle="auteur">
				<xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblFull/tei:titleStmt/tei:respStmt/tei:name"/>
			</docAuthor>
		</byline>
	</titlePage>
	<xsl:apply-templates/>
</front>
</xsl:template>-->

<xsl:template match="tei:front">
<front>
		<head type="main" aid:pstyle="T_3_Article">
			<xsl:apply-templates select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']/node()"/>
		</head>
		<xsl:choose>
			<xsl:when test="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type!='main']">
			<xsl:variable name="titleType" select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type!='main']/@type"/>
				<titlePart>
					<xsl:attribute name="type" select="$titleType"/>
					<xsl:apply-templates select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type!='main']/node()"/>
				</titlePart>
			</xsl:when>
		</xsl:choose>
	<titlePage>
		<byline>
			<docAuthor aid:pstyle="auteur">
				<xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblFull/tei:titleStmt/tei:respStmt/tei:name"/>
			</docAuthor>
		</byline>
		<byline aid:pstyle="auteur_Institution">
			<xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:affiliation/tei:s"/>
		</byline>
	</titlePage>
	<xsl:apply-templates/>
</front>
</xsl:template>

<xsl:template match="tei:p[not(@rend)]">
<p>
	<xsl:attribute name="aid:pstyle">txt_Normal</xsl:attribute>
 <xsl:apply-templates />
</p>
</xsl:template>

<xsl:template match="tei:p[@rend='noindent']">
<p>
	<xsl:attribute name="aid:pstyle">txt_annexe</xsl:attribute>
 <xsl:apply-templates />
</p>
</xsl:template>


<xsl:template match="tei:q[@rend='quotation']">
<xsl:variable name="rendQ" select="@rend"/>
<q>
	<xsl:attribute name="aid:pstyle" select="$rendQ"/>
 <xsl:apply-templates />
</q>
</xsl:template>

<xsl:template match="tei:div[@type='abstract'][1]">
	<p aid:pstyle="txt_Resume">
		<xsl:value-of select="."/>
	</p>
	<xsl:call-template name="motcle"/>
</xsl:template>

<xsl:template name="motcle">
	<p aid:pstyle="txt_Motclef">
		<xsl:call-template name="join">
			<xsl:with-param name="list" select="//tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords[not(@xml:lang='it')]/tei:list/tei:item"/>
			 <xsl:with-param name="separator" select="', '" />
		</xsl:call-template>
	</p>
</xsl:template>

<xsl:template name="join">
	<xsl:param name="list" />
	<xsl:param name="separator"/>
		<xsl:for-each select="$list">
			<xsl:value-of select="." />
			<xsl:if test="position() != last()">
				<xsl:value-of select="$separator" />
			</xsl:if>
		</xsl:for-each>
</xsl:template>

<xsl:template match="tei:div[@type='abstract'][2]">
	<p aid:pstyle="txt_Resume_italique">
		<xsl:value-of select="."/>
	</p>
	<xsl:call-template name="keyword"/>
</xsl:template>

<xsl:template name="keyword">
	<p aid:pstyle="txt_Keywords">
		<xsl:call-template name="join">
			<xsl:with-param name="list" select="//tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords[@xml:lang='it']/tei:list/tei:item"/>
			 <xsl:with-param name="separator" select="', '" />
		</xsl:call-template>
	</p>
</xsl:template>

<xsl:template match="tei:head[@subtype='level1']">
	<head>
	<xsl:attribute name="aid:pstyle">T_a</xsl:attribute>
 		<xsl:apply-templates />
	</head>
</xsl:template>

<xsl:template match="tei:head[@subtype='level2']">
	<head>
	<xsl:attribute name="aid:pstyle">T_b</xsl:attribute>
 		<xsl:apply-templates />
	</head>
</xsl:template>

<xsl:template match="tei:head[@subtype='level3']">
	<head>
	<xsl:attribute name="aid:pstyle">T_c</xsl:attribute>
 		<xsl:apply-templates />
	</head>
</xsl:template>

<xsl:template match="tei:bibl">
<bibl>
	<xsl:attribute name="aid:pstyle">txt_Bibliographie</xsl:attribute>
 <xsl:apply-templates />
</bibl>
</xsl:template>

<xsl:template match="tei:q[@rend='quotation']">
<xsl:variable name="rendQ" select="@rend"/>
<q>
	<xsl:attribute name="aid:pstyle" select="$rendQ"/>
 <xsl:apply-templates />
</q>
</xsl:template>

<!--xsl:template match="tei:lb">
	<lb/>
</xsl:template-->

<xsl:template match="tei:graphic">
<xsl:variable name="filename">
	<xsl:value-of select="tokenize(base-uri(.),'/')[last()]"/>
</xsl:variable>
<xsl:variable name="graphurl">
	<xsl:value-of select="substring-after(@url,'docannexe/image/')"/>
</xsl:variable>
<xsl:variable name="figtitle" select="../../preceding-sibling::tei:p[@rend='figure-title'][1]"/>
<graphic>
	<xsl:attribute name="url">
		<xsl:value-of select="concat('../icono/br/',substring-before($filename,'.'),'-',substring-after($graphurl,'/'))"/>
	</xsl:attribute>
</graphic>
<head aid:pstyle="titre-figure">
	<xsl:value-of select="$figtitle"/>
</head>
</xsl:template>

<xsl:template match="tei:table">
<xsl:variable name="tabtitle" select="preceding-sibling::tei:p[@rend='figure-title'][1]"/>
<xsl:variable name="tabrows"><xsl:value-of select="count(tei:row)"/></xsl:variable>
<xsl:variable name="tabcols"><xsl:value-of select="count(tei:row[2]/tei:cell)"/></xsl:variable>
	<table aid:table="table">
		<xsl:attribute name="aid:trows"><xsl:value-of select="$tabrows"/></xsl:attribute>
		<xsl:attribute name="aid:tcols"><xsl:value-of select="$tabcols"/></xsl:attribute>
		<xsl:copy-of select="@*"/>
		<head>
			<xsl:value-of select="$tabtitle"/>
		</head>
<xsl:apply-templates/>
	</table>
</xsl:template>

<xsl:template match="tei:p[@rend='figure-license']">
<p>
	<xsl:attribute name="aid:pstyle">figure-credit</xsl:attribute>
<xsl:apply-templates />
</p>
</xsl:template>

<xsl:template match="tei:p[@rend='figure-legend']">
<p>
	<xsl:attribute name="aid:pstyle">figure-legend</xsl:attribute>
<xsl:apply-templates />
</p>
</xsl:template>

<xsl:template match="tei:p[@rend='epigraph']">
<epigraph>
	<xsl:attribute name="aid:pstyle">txt_Epigraphe</xsl:attribute>
<xsl:apply-templates />
</epigraph>
</xsl:template>

<xsl:template match="tei:ab[@subtype='level2']">
<head>
	<xsl:attribute name="aid:pstyle">T_annexe_1</xsl:attribute>
<xsl:apply-templates />
</head>
</xsl:template>

<xsl:template match="tei:ab[@subtype='level3']">
<head>
	<xsl:attribute name="aid:pstyle">T_annexe_2</xsl:attribute>
<xsl:apply-templates />
</head>
</xsl:template>

<xsl:template match="tei:note">
<note>
	<xsl:copy-of select="@*"/>
	<xsl:attribute name="aid:pstyle">txt_Note</xsl:attribute>
	<xsl:apply-templates/>
</note>
</xsl:template>

<xsl:template match="tei:back">
<back>
	<xsl:copy-of select="@*"/>
	<xsl:apply-templates/>
</back>
</xsl:template>

<xsl:template match="tei:hi[@rendition]">
	<xsl:variable name="hirend" select="substring-after(@rendition,'#')"/>
	<hi>
		<xsl:choose>
			<xsl:when test="$hirend = //tei:tagsDecl/tei:rendition/@xml:id">
				<xsl:variable name="histyle" select="//tei:tagsDecl/tei:rendition[@xml:id = $hirend]/substring-after(.,':')"/>
				<xsl:attribute name="rend"><xsl:value-of select="$histyle"/></xsl:attribute>
				<xsl:attribute name="aid:cstyle"><xsl:value-of select="$histyle"/></xsl:attribute>
			</xsl:when>
		</xsl:choose>
		<!--xsl:value-of select="."/-->
		<xsl:apply-templates/>
	</hi>
</xsl:template>

<xsl:template match="tei:hi[@xml:lang and not(@rendition)]">
		<xsl:apply-templates/>
</xsl:template>

<xsl:template match="@instant"/>
<xsl:template match="@full"/>
<xsl:template match="@rendition"/>
<xsl:template match="@rend"/>
<xsl:template match="@part"/>
<xsl:template match="@anchored"/>
<xsl:template match="@xml:lang"/>
<xsl:template match="@org"/>
<xsl:template match="@sample"/>
<xsl:template match="@xml:id[starts-with,'otx']"/>

<xsl:template match="tei:p[@rend='figure-title']"/>
<xsl:template match="tei:encodingDesc"/>
<xsl:template match="comment()"/>

</xsl:stylesheet>
