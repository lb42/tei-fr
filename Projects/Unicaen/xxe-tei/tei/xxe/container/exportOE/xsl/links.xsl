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
	<xsl:result-document href="{concat($directory,'/OE/',$sansExt,'/linksToCover.txt')}" method="text">
		<xsl:choose>
			<xsl:when test="//tei:graphic">
				<xsl:for-each select="//tei:graphic">
					<xsl:value-of select="concat('../../',@url)"/>
				<xsl:text>
</xsl:text>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>../../../icono/cover.jpg</xsl:text><xsl:text>
</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:result-document>
	<xsl:result-document href="{concat($directory,'/OE/',$sansExt,'/linksToXML.txt')}" method="text">
		<xsl:for-each select="//xi:include">
			<xsl:value-of select="concat('../../',@href)"/>
				<xsl:text>
</xsl:text>
		</xsl:for-each>
	</xsl:result-document>
	<xsl:result-document href="{concat($directory,'/OE/',$sansExt,'/linksToAllImages.txt')}" method="text">
	<xsl:for-each select="//xi:include">
		<xsl:variable name="ref" select="@href"/>
		<xsl:for-each select="document(concat($directory,'/',$ref))//tei:graphic">
			<xsl:value-of select="concat('../../',@url)"/>
				<xsl:text>
</xsl:text>
		</xsl:for-each>
	</xsl:for-each>
	</xsl:result-document>
	<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>