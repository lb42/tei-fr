<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT identifiantsDiv.xsl
*
*  Copyright (c) 2009-2014 
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
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"
		exclude-result-prefixes="tei"
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>


<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>



<xsl:template match="tei:div[@type='section1']">
	<xsl:variable name="numDiv"><xsl:value-of select="count(preceding-sibling::tei:div[@type='section1'])+1"/></xsl:variable>
	<div>
		<xsl:for-each select="@*">
			<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
			<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
		</xsl:for-each>
		<xsl:if test="not(@type='livre')" >
			<xsl:variable name="newId"><xsl:value-of select="parent::tei:div/@xml:id" /><xsl:text>.</xsl:text>
				<xsl:value-of select="$numDiv"/>
			</xsl:variable>
			<xsl:attribute name="xml:id"><xsl:value-of select="$newId"/>
			</xsl:attribute>
			<xsl:if test="@xml:id != $newId">
				<xsl:attribute name="synch">
				<xsl:value-of select="@xml:id" />
			</xsl:attribute>
			</xsl:if>
		</xsl:if>
		<xsl:apply-templates/>
	</div>
</xsl:template>


</xsl:stylesheet>