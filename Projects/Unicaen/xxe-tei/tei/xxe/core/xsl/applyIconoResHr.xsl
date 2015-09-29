<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT switchIconoRes
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

<xsl:param name="dir" select="dir"/>

<xsl:strip-space elements="*"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:graphic">
	<graphic>
		<xsl:variable name="imgNameInFile"><xsl:value-of select="@url"/></xsl:variable>
		<xsl:variable name="imgNameInFile2"><xsl:value-of select="concat(substring-before(substring-after($imgNameInFile,'icono/'),'.'),'.')"/></xsl:variable>
		<xsl:variable name="imgNameInFile3"><xsl:value-of select="substring-after($imgNameInFile2,'/')"/></xsl:variable>
		<xsl:variable name="imgNameInList"><xsl:value-of select="document('imgList.xml')//*:figure/*:graphic"/></xsl:variable>
		<xsl:for-each select="@*">
			<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
			<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
		</xsl:for-each>
			<xsl:if test="contains($imgNameInList,$imgNameInFile3)">
			<xsl:variable name="goodImgExt">
				<xsl:value-of select="document('imgList.xml')//*:figure/*:graphic[contains(text(),$imgNameInFile3)]"/>
			</xsl:variable>
				<xsl:choose>
					<xsl:when test="contains($goodImgExt, '.tif')">
						<xsl:attribute name="url"><xsl:text>../icono/</xsl:text><xsl:value-of select="$dir"/><xsl:text>/</xsl:text><xsl:copy-of select="document('imgList.xml')//*:figure/*:graphic[contains(text(),$imgNameInFile3)]"/></xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($goodImgExt, '.jpg')">
						<xsl:attribute name="url"><xsl:text>../icono/</xsl:text><xsl:value-of select="$dir"/><xsl:text>/</xsl:text><xsl:copy-of select="document('imgList.xml')//*:figure/*:graphic[contains(text(),$imgNameInFile3)]"/></xsl:attribute>
					</xsl:when>
					<xsl:when test="contains($goodImgExt, '.eps')">
						<xsl:attribute name="url"><xsl:text>../icono/</xsl:text><xsl:value-of select="$dir"/><xsl:text>/</xsl:text><xsl:copy-of select="document('imgList.xml')//*:figure/*:graphic[contains(text(),$imgNameInFile3)]"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="url"><xsl:text>##</xsl:text><xsl:copy-of select="document('imgList.xml')//*:figure/*:graphic[contains(text(),$imgNameInFile3)]"/><xsl:text>##</xsl:text></xsl:attribute>
						<desc><xsl:text>format d'images non autorisé pour la définition choisie</xsl:text></desc>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
	</graphic>
</xsl:template>

</xsl:stylesheet>