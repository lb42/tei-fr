<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT updatepIds
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
* This stylesheet is inspired from the work of Alain Pierrot
*
*  See http://www.unicaen.fr/recherche/mrsh/document_numerique/equipe
*      for a list of contributors
*/
-->

<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:rng="http://relaxng.org/ns/structure/1.0"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/html"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.w3.org/1999/xhtml"
	xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
	exclude-result-prefixes=" html a fo rng tei  " version="2.0">
	<!--================================ Appel des modules (paramètres et de servives) ===================================================-->
	

	<xsl:output encoding="UTF8" method="xml"/>
	
<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="*[name()='term']/text()" priority="99">
	<xsl:value-of select='translate(.,"í ¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“ ‘’◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛ˇ","&apos; ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ")'/>
</xsl:template>

<xsl:template match="@*[contains(name(),'indexName')]" priority="99">
	<xsl:attribute name="indexName">
	<xsl:value-of select='translate(.,"í ¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“ ‘’◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛ˇ","&apos; ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ")'/>
	</xsl:attribute>
</xsl:template>

<xsl:template match="*">
	<xsl:copy>
	<xsl:apply-templates select="@*"/>
	<xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

<xsl:template match="comment()|text()|@*">
	<xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
