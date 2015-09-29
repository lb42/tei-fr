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

<!--<xsl:strip-space elements="*"/>-->

<xsl:param name="directory"/>
<xsl:param name="filename"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="/">
<xsl:variable name="sansExt" select="substring-before($filename,'.')"/>
		<xsl:result-document href="{concat($directory,'/EPUB/',$sansExt,'_linksToImages.txt')}" method="text">
		<xsl:choose>
		<xsl:when test="//tei:graphic">
			<xsl:for-each select="//tei:graphic">
			<xsl:value-of select="concat('../',@url)"/>
				<xsl:text>
</xsl:text>
			</xsl:for-each>
		</xsl:when>
		<xsl:when test="not(//tei:graphic)">
				<xsl:value-of><xsl:text>../../../icono/cover.jpg</xsl:text></xsl:value-of>
				<xsl:text>
</xsl:text>
		</xsl:when>
		</xsl:choose>
		</xsl:result-document>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="//tei:graphic">
<xsl:variable name="imgName">
	<xsl:value-of select="substring-after(substring-after(@url,'../icono/'),'/')"/>
</xsl:variable>
	<graphic>
		<xsl:attribute name="url"><xsl:value-of select="concat('../Images/',$imgName)"/></xsl:attribute>
	</graphic>
</xsl:template>

<xsl:template match="tei:floatingText">
	<xsl:variable name="ref" select="descendant::xi:include/./@href"/>
	<xsl:variable name="floatingSubtype" select="@subtype"/>
	<xsl:variable name="floatInclude">
		<xsl:apply-templates select="document($ref)//tei:text/*"/>
	</xsl:variable>
		<floatingText>
			<xsl:attribute name="type" select="concat('enc_',$floatingSubtype)"/>
			<xsl:apply-templates select="$floatInclude"/>
		</floatingText>
</xsl:template> 

<xsl:template match="//tei:floatingText//*[@aid:pstyle]">
	<xsl:copy>
    	<xsl:copy-of select="@*"/>
	 		<xsl:variable name="style">
	    		<xsl:value-of select="ancestor::tei:floatingText/@type"/>
	    	</xsl:variable>
	    	<xsl:attribute name="aid:pstyle">
                <xsl:value-of select="concat($style,'_', @aid:pstyle)"/>
            </xsl:attribute>
	    	<xsl:attribute name="rend" select="concat($style,'_', @aid:pstyle)"/>
            <xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

<xsl:template match="tei:div[@xml:id='mainDiv']">
<!--	<head>
		<xsl:value-of select="../../tei:front/descendant::tei:titlePart[@type='main']"/>
	</head>
	<byline>
		<xsl:value-of select="../../tei:front/descendant::tei:docAuthor"/>
	</byline> -->
	<div>
	<!--	<head>
		<xsl:value-of select="../../tei:front/descendant::tei:titlePart[@type='main']"/>
	</head>-->
		<byline>
		<xsl:value-of select="../../tei:front/descendant::tei:docAuthor"/>
	</byline>
		<xsl:apply-templates select="../../tei:front/tei:titlePage/following-sibling::*"/>
		<xsl:apply-templates select="tei:*"/>
		<xsl:apply-templates select="../../tei:back/tei:*"/>
	</div>

</xsl:template>

<xsl:template match="tei:front"/>
<xsl:template match="tei:back"/>

</xsl:stylesheet>
