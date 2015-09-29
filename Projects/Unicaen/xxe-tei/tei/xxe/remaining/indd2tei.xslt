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
		exclude-result-prefixes="tei xhtml"
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:param name="notesfin" select="notesfin"/>
<xsl:param name="figures" select="figures"/>

<xsl:strip-space elements="*"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:body">
	<body>
		<xsl:apply-templates/>
	</body>
</xsl:template>


<xsl:template match="//tei:num_index">
	<xsl:variable name="idIndex" select="@ref"/>
	<index>
		<xsl:attribute name="indexName"><xsl:value-of select="//tei:content_index[@xml:id=$idIndex]/@indexName"/></xsl:attribute>
		<xsl:copy-of select="//tei:content_index[@xml:id=$idIndex]/*|//tei:content_index[@xml:id=$idIndex]/text()"/>
		<!--<xsl:copy-of select="//tei:content_index[@xml:id=$idIndex]/*"/>-->
	</index>
</xsl:template>

<xsl:template match="//tei:num_note">
	<xsl:variable name="idNote" select="@ref"/> 
	<note>
        <xsl:attribute name="aid:pstyle">txt_Note</xsl:attribute>	
        <xsl:attribute name="xml:id"><xsl:value-of select="$idNote"/></xsl:attribute>
        <xsl:apply-templates select="//tei:content_note[@xml:id=$idNote]/*|//tei:content_note[@xml:id=$idNote]/text()"/>
    </note>
</xsl:template>


<xsl:template match="tei:hi[@aid:cstyle]">
   <hi rend="{@rend}" aid:cstyle="{@aid:cstyle}">
    <xsl:apply-templates/>
  </hi>
</xsl:template>



<xsl:template match="//tei:back_xslt"></xsl:template>
<xsl:template match="//tei:p[@aid:pstyle='txt_NotesFin']"></xsl:template>
<xsl:template match="//tei:hi[@aid:cstyle='appel_Note']"></xsl:template>
<xsl:template match="//tei:hi[.='']"></xsl:template>

</xsl:stylesheet>