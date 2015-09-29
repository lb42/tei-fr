<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT torevuesdotorg
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


<xsl:import href="torevuesdotorg.xsl"/>

<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<!--<xsl:strip-space elements="*"/>-->

<!--xsl:template match="/">
<xsl:variable name="sansExt" select="substring-before($filename,'.')"/>
		<xsl:result-document href="{concat($directory,'/OE/',$sansExt,'/linksToImages.txt')}" method="text">
			<xsl:for-each select="//tei:graphic">
			<xsl:value-of select="concat('../../',@url)"/>
				<xsl:text>
</xsl:text>
			</xsl:for-each>
		</xsl:result-document>
	<xsl:apply-templates/>
</xsl:template-->

<!-- correction des liens vers les images pour pointer vers le même dossier -->
<xsl:template match="tei:graphic">
  <xsl:variable name="imageLink">
    <xsl:choose>
      <xsl:when test="contains(@url,'br')">
        <xsl:value-of select="substring-after(@url,'br/')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-after(@url,'hr/')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <graphic>
  	<xsl:attribute name="url">
  		<xsl:value-of select="concat('../files/',$imageLink)"/>
  	</xsl:attribute>
  </graphic>
</xsl:template>

</xsl:stylesheet>
