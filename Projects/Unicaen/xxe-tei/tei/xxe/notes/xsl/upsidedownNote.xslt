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

<xsl:template match="tei:hi[child::tei:note]">
<xsl:variable name="attrNnote" select="./tei:note/@n"/>
<xsl:variable name="attrPlaceNote" select="./tei:note/@place"/>
<xsl:variable name="attrTypeNote" select="./tei:note/@type"/>
<xsl:variable name="attrStyleNote" select="./tei:note/@aid:pstyle"/>
	<note>
		<xsl:attribute name="place" select="$attrPlaceNote"/>
		<xsl:attribute name="n" select="$attrNnote"/>	
		<xsl:attribute name="type"><xsl:text>standard</xsl:text></xsl:attribute>
		<xsl:attribute name="aid:pstyle" select="$attrStyleNote"/>
		<xsl:attribute name="xml:id" select="concat($attrPlaceNote,$attrNnote)"/>
		<xsl:apply-templates select="./tei:note/node()"/>
	</note>
</xsl:template>

</xsl:stylesheet>