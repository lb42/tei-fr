<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT updateNotesIds
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


<xsl:stylesheet version="1.0"
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

<xsl:strip-space elements="*"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:note">
<xsl:variable name="numNote">
	<xsl:number count="tei:note" level="any" format="1"/>
</xsl:variable>
<xsl:variable name="styleNote">
	<xsl:value-of select="@aid:pstyle"/>
</xsl:variable>
<xsl:variable name="attrName">
	<xsl:value-of select="name()"/>
</xsl:variable>
<note>
<xsl:for-each select="@*">
<!--xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute-->
</xsl:for-each>
<xsl:attribute name="xml:id">ftn<xsl:value-of select="$numNote"/></xsl:attribute>
<xsl:attribute name="n"><xsl:value-of select="$numNote"/></xsl:attribute>
<xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
<xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute>
<xsl:attribute name="aid:pstyle"><xsl:value-of select="$styleNote"/></xsl:attribute>
<xsl:apply-templates/>
</note>
</xsl:template>

</xsl:stylesheet>