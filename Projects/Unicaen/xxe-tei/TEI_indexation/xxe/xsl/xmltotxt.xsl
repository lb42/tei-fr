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
        xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
		xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"	
		exclude-result-prefixes="tei"
>
		<!--xmlns:xxe="http://www.unicaen.fr/mrsh/pddn/xxe/1.0"	-->		
<xsl:output method="text" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>

<xsl:param name="typeIndex"/>

<xsl:template match="/">
<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyzÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞß
	áàâãäåæçèéêëìíîïðñòóôõöøùúûýýþÿŔŕ'"/>
	<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZAAAAAAACEEEEIIIIDNOOOOOOUUUUYBS
	AAAAAAACEEEEIIIIDNOOOOOOUUUYYBYRR'"/>
<xsl:text>(-- Nouvelle entrée --)</xsl:text><xsl:text>
</xsl:text>?<xsl:text>
</xsl:text>
<choose>
	<when test="$typeIndex='Personnes'">
    	<xsl:for-each select="//tei:person">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
	</when>
	<when test="$typeIndex='Biblios'">
			<xsl:for-each select="//tei:biblStruct">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
	</when>
		<when test="$typeIndex='Oeuvres'">
    	<xsl:for-each select="//tei:bibl">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
	</when>
	<otherwise>
		<!-- traitement pour avoir les lettres accentuées dans le tri -->
			<xsl:for-each select="//tei:place">
			<xsl:sort select="translate(.,$lower,$upper)" order="ascending" data-type="text" />
			<xsl:apply-templates select="."/>
			</xsl:for-each>
	</otherwise>
</choose>
</xsl:template>

<xsl:template match="tei:person">
<xsl:choose>
<xsl:when test="descendant::tei:occupation">
<xsl:for-each select="descendant::tei:occupation">
<xsl:choose>
<xsl:when test="../descendant::tei:persName[@xml:lang='fr']!=''">
<xsl:value-of select="../tei:persName[@xml:lang='fr'][1]"/><xsl:if test="../descendant::tei:persName[@xml:lang='la']!=''">, <xsl:value-of select="../descendant::tei:persName[@xml:lang='la'][1]"/></xsl:if></xsl:when>
<xsl:otherwise>
<xsl:value-of select="../descendant::tei:persName[@xml:lang='la'][1]"/>
</xsl:otherwise>
</xsl:choose> • <xsl:value-of select="."/>	<xsl:choose>
<xsl:when test="(@notBefore) or (@notAfter)"> [...<xsl:value-of select="@notBefore"/> / <xsl:value-of select="@notAfter"/>...]</xsl:when>
<xsl:when test="(@from) or (@to)"> [<xsl:value-of select="@from"/> / <xsl:value-of select="@to"/>]</xsl:when>
</xsl:choose><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="descendant::tei:persName[@xml:lang='fr']!=''">
<xsl:value-of select="descendant::tei:persName[@xml:lang='fr'][1]"/><xsl:if test="descendant::tei:persName[@xml:lang='la']!=''">, <xsl:value-of select="descendant::tei:persName[@xml:lang='la'][1]"/></xsl:if><xsl:if test="(descendant::tei:birth)"> (<xsl:value-of select="descendant::tei:birth"/>-<xsl:value-of select="descendant::tei:death"/>)</xsl:if><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="descendant::tei:persName[@xml:lang='la'][1]"/><xsl:if test="(descendant::tei:birth)"> (<xsl:value-of select="descendant::tei:birth"/>-<xsl:value-of select="descendant::tei:death"/>)</xsl:if><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:place">
<xsl:choose>
	<xsl:when test="parent::tei:place!=''">
	<xsl:value-of select="../tei:placeName[@xml:lang='fr'][1]"/> • <xsl:value-of select="tei:placeName[@xml:lang='fr'][1]"/> > <xsl:value-of select="@type"/><xsl:if test="tei:trait"> (<xsl:value-of select="tei:trait/tei:label"/> <xsl:text> </xsl:text><xsl:value-of select="tei:trait/tei:desc"/>)</xsl:if><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:when>
	<xsl:otherwise>
	<xsl:value-of select="tei:placeName[@xml:lang='fr'][1]"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:otherwise>
	</xsl:choose>

</xsl:template>


<xsl:template match="tei:biblStruct">
<xsl:choose>
<xsl:when test="(@type='ouvrage') or (@type='collectif') or (@type='these')" >
<xsl:choose>
<xsl:when test="count(tei:monogr/tei:author) > 1" ><xsl:for-each select="tei:monogr/tei:author"><xsl:value-of select="tei:surname"/><xsl:text>, </xsl:text></xsl:for-each></xsl:when>
<xsl:otherwise><xsl:value-of select="tei:monogr/tei:author/tei:surname"/></xsl:otherwise>
</xsl:choose> 
<xsl:text> • </xsl:text>
<xsl:value-of select="tei:monogr/tei:imprint/tei:date"/><xsl:text>
</xsl:text>
<xsl:value-of select="@xml:id"/>
<xsl:text>_</xsl:text>
<xsl:choose>
<xsl:when test="count(tei:monogr/tei:author) > 1" >
<xsl:for-each select="tei:monogr/tei:author">
<xsl:value-of select="tei:surname"/>
<xsl:text> &amp; </xsl:text>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="tei:monogr/tei:author/tei:surname"/>
</xsl:otherwise>
</xsl:choose>
<xsl:text>_</xsl:text>
<xsl:value-of select="tei:monogr/tei:imprint/tei:date"/><xsl:text>
</xsl:text>
</xsl:when>
<xsl:when test="(@type='article') or (@type='contribution')" >
<xsl:choose>
<xsl:when test="count(tei:analytic/tei:author) > 1" >
<xsl:for-each select="tei:analytic/tei:author">
<xsl:value-of select="tei:surname"/>
<xsl:text>, </xsl:text>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="tei:analytic/tei:author/tei:surname"/>
</xsl:otherwise>
</xsl:choose> 
<xsl:text> • </xsl:text>
<xsl:value-of select="tei:analytic/tei:imprint/tei:date"/><xsl:text>
</xsl:text>
<xsl:value-of select="@xml:id"/>
<xsl:text>_</xsl:text>
<xsl:choose>
<xsl:when test="count(tei:analytic/tei:author) > 1" >
<xsl:for-each select="tei:analytic/tei:author">
<xsl:value-of select="tei:surname"/>
<xsl:text> &amp; </xsl:text>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="tei:analytic/tei:author/tei:surname"/>
</xsl:otherwise>
</xsl:choose>
<xsl:text>_</xsl:text>
<xsl:value-of select="tei:analytic/tei:imprint/tei:date"/><xsl:text>
</xsl:text>
</xsl:when>
<xsl:otherwise>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template match="tei:bibl">
<xsl:choose>
	<xsl:when test="tei:author!=''" >
		<xsl:value-of select="tei:author"/> • <xsl:value-of select="tei:title"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:when>
	<xsl:otherwise>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>