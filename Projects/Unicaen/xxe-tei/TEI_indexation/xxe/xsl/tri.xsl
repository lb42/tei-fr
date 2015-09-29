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
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns="http://www.tei-c.org/ns/1.0"
        exclude-result-prefixes=""
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>


<xsl:template match="/">
	<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyzÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßáàâãäåæçèéêëìíîïðñòóôõöøùúûýýþÿŔŕ'"/>
	<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZAAAAAAACEEEEIIIIDNOOOOOOUUUUYBSAAAAAAACEEEEIIIIDNOOOOOOUUUYYBYRR'"/>

<TEI
xxe:env="indexation"
xmlns="http://www.tei-c.org/ns/1.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:xinclude="http://www.w3.org/2001/XInclude"
xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
xmlns:ns="http://www.tei-c.org/ns/1.0"
xmlns:hfp="http://www.w3.org/2001/XMLSchema-hasFacetAndProperty"
xmlns:xxe="http://www.unicaen.fr/mrsh/pddn/xxe/1.0/"
>
<teiHeader><fileDesc><titleStmt><title><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></title><author><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/></author></titleStmt><publicationStmt><publisher><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/></publisher><authority><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:authority"/></authority><pubPlace><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:pubPlace"/></pubPlace></publicationStmt><sourceDesc><p><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p"/> </p></sourceDesc></fileDesc><profileDesc><creation><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation"/></creation></profileDesc><revisionDesc><change><xsl:attribute name="when"><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:revisionDesc/tei:change/@when"/></xsl:attribute><xsl:attribute name="who"><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:revisionDesc/tei:change/@who"/></xsl:attribute><xsl:value-of select="//tei:TEI/tei:teiHeader/tei:revisionDesc/tei:change"/></change></revisionDesc></teiHeader>
      <text>
      	<body>
      	<xsl:choose>
      	<xsl:when test="//tei:place">
      	<listPlace>
			<!-- traitement pour avoir les lettres accentuées dans le tri -->
			<xsl:for-each select="//tei:place">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
		</listPlace>
		</xsl:when>
		<xsl:when test="//tei:person">
		<listPerson>
			<xsl:for-each select="//tei:person">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
			<xsl:apply-templates select="//tei:relation"/>
		</listPerson>
		</xsl:when>
		<xsl:when test="//tei:entry">
		<div>
			<xsl:for-each select="//tei:entry">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
		</div>
		</xsl:when>
		<xsl:when test="//tei:biblStruct">
		<listBibl>
			<xsl:for-each select="//tei:biblStruct">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
		</listBibl>
		</xsl:when>
		<xsl:when test="//tei:bibl">
		<listBibl>
			<xsl:for-each select="//tei:bibl">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
		</listBibl>
		</xsl:when>
		</xsl:choose>
		</body>
	 </text>
</TEI>
</xsl:template>


<xsl:template match="tei:place">
	<!-- pour ne pas qu'il copie une deuxième fois la balise place qui se trouve au deuxième niveau :
	on ne fait une copie du noeud que si on est au premier niveau -->
	<xsl:if test="local-name(parent::node()) != 'place'" >
  	<xsl:copy-of select="." />
	</xsl:if>
</xsl:template>

<xsl:template match="tei:person">
  	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="tei:entry">
  	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="tei:relation">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="tei:biblStruct">
  	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="tei:bibl">
  	<xsl:copy-of select="." />
</xsl:template>

</xsl:stylesheet>