<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT listIcono
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
* This stylesheet is inspired from the work of Sebastian Rahtz / University of
* Oxford (copyright 2005)
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
		exclude-result-prefixes="tei"
>

<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:param name="dir"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="/">
		<xsl:result-document href="{concat($dir,'/linksToImages.txt')}" method="text">
			<xsl:for-each select="//tei:graphic">
		<!--		<xsl:value-of select="substring-after(@url,'br/')"/> -->
			<xsl:value-of select="@url"/>
				<xsl:text>
</xsl:text>
			</xsl:for-each>
		</xsl:result-document>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="@aid:pstyle|@style">
	<xsl:choose>
		<xsl:when test="ancestor::tei:floatingText">
			<xsl:variable name="floatType"><xsl:value-of select="ancestor::tei:floatingText/@type"/></xsl:variable>
			<xsl:attribute name="rend">
				<xsl:value-of select="concat($floatType,'_',.)"/>
			</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="rend">
				<xsl:value-of select="."/>
			</xsl:attribute>
		</xsl:otherwise>
	</xsl:choose>
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:floatingText/tei:body">
	<body>	
		<div type="front"><xsl:apply-templates select="preceding-sibling::tei:front/*"/></div>
		<xsl:apply-templates/>
	</body>
</xsl:template>

<xsl:template match="tei:floatingText/tei:front"/>

<xsl:template match="tei:ref">
	<xsl:choose>
	<xsl:when test="contains(@target,'.xml')">
		<ref type="crossref">
			<xsl:attribute name="target">
				<xsl:value-of select="replace(@target,'.xml','.html')"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</ref>
	</xsl:when>
	<xsl:otherwise>
		<ref type="crossref">
			<xsl:attribute name="target" select="@target"/>
			<xsl:apply-templates/>
		</ref>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="tei:anchor">
	<hi rend="anchor">*</hi>
	<anchor type="crossref">
		<xsl:attribute name="xml:id" select="@xml:id"/>
	<xsl:apply-templates/>
	</anchor>
</xsl:template>

<!--<xsl:template match="tei:group[@type='book']//tei:text">
	<xsl:choose>
		<xsl:when test="parent::tei:body//tei:text">
			<div rend="encadre"><xsl:apply-templates select="parent::tei:body//tei:text/*"/></div>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy>
   				<xsl:apply-templates select="@*|node()"/>
 			</xsl:copy>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>-->

<!--<xsl:template match="tei:head[@subtype='level1'][parent::tei:group]">
	<text>
   		<head><xsl:apply-templates select="@*|node()"/></head>
 	</text>
</xsl:template>-->

<xsl:template match="tei:graphic">
	<graphic>
	<xsl:attribute name="url">
		<xsl:value-of select="substring-after(@url,'../')"/>
	</xsl:attribute>
	</graphic>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:front[ancestor::tei:group]"/>
<xsl:template match="tei:back[parent::tei:text]"/>

</xsl:stylesheet>