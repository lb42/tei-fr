<?xml version="1.0" encoding="utf-8"?>

<!--
/**
*  XSLT changegraphicurls pour epub
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

<xsl:stylesheet xmlns:dc="http://purl.org/dc/elements/1.1/"
		xmlns:iso="http://www.iso.org/ns/1.0"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
		version="2.0" exclude-result-prefixes="iso tei dc html ncx">

  <!-- Modification du dossier icono, pour une archive epub correctemenT rangée -->
  <xsl:template match="//tei:graphic">
    <graphic>
      <xsl:attribute name="url"><xsl:value-of select="substring-after(@url,'../')"/></xsl:attribute>
    </graphic>
  </xsl:template>

</xsl:stylesheet>
