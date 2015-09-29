<?xml version="1.0" encoding="UTF-8"?>
<!--/**
*  Feuilles de transformation XSL pour la mise à jour des identifiants des notes
*
*  Copyright (c) 2009-2013 
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
*/-->

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
<xsl:variable name="numNote"><xsl:number count="tei:note" level="any" format="1"/></xsl:variable>
<note>
<xsl:for-each select="@*">
<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
</xsl:for-each>
<xsl:attribute name="xml:id">note<xsl:value-of select="$numNote"/></xsl:attribute>
<xsl:apply-templates/>
</note>
</xsl:template>

</xsl:stylesheet>