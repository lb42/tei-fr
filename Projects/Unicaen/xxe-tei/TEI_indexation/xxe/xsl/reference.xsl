<?xml version="1.0" encoding="UTF-8"?>
<!--/**
*  Feuilles de transformation XSL pour la gestion des autorités et des index
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

<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:tei="http://www.tei-c.org/ns/1.0"
xmlns="http://www.tei-c.org/ns/1.0"		
exclude-result-prefixes="tei"
>
<xsl:output method="text" encoding="UTF-8" indent="yes"/>

<xsl:strip-space elements="*"/>

<xsl:param name="typeAutorite"/>

<xsl:template match="/">
<xsl:for-each-group select="//tei:roleName[@ref]" group-by="@ref">
      <xsl:sort select="." order="ascending"/>

      <xsl:apply-templates select="@ref"/><xsl:text>
</xsl:text>
    </xsl:for-each-group>
</xsl:template>
</xsl:stylesheet>

