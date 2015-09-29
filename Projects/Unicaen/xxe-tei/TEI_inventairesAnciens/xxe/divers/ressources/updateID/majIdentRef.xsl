<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT majIdentRef.xsl
*
*  Copyright (c) 2009-2014 
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


<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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

<xsl:template match="//*[@target] | //*[@ref]">
	<xsl:element name="{name()}">
		<xsl:for-each select="@*">
			<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
			<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
		</xsl:for-each>
		<xsl:call-template name="verifIdent">
			<xsl:with-param name="oldIdent" select="if (@target) then (substring-after(@target,'#')) else (substring-after(@ref,'#'))" />
		</xsl:call-template>
		<xsl:apply-templates/>	
	</xsl:element>	
</xsl:template>

<xsl:template match="//tei:handNote">
	<handNote>
		<xsl:for-each select="@*">
			<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
			<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
		</xsl:for-each>
		<xsl:call-template name="verifIdent">
			<xsl:with-param name="oldIdent" select="@xml:id" />
		</xsl:call-template>
		<xsl:apply-templates/>
	
	</handNote>
</xsl:template>

<xsl:template name="verifIdent">
	<xsl:param name="oldIdent" />
	<xsl:choose>
	<xsl:when test="//*/@synch = $oldIdent">
		<xsl:if test="@target">
			<xsl:attribute name="target"><xsl:value-of select="concat('#',//*[@synch = $oldIdent]/@xml:id)" /></xsl:attribute>
		</xsl:if>
		<xsl:if test="@ref">
		<xsl:attribute name="ref"><xsl:value-of select="concat('#',//*[@synch = $oldIdent]/@xml:id)" /></xsl:attribute>
		</xsl:if>
		<xsl:if test="@xml:id">
		<xsl:attribute name="xml:id"><xsl:value-of select="//*[@synch = $oldIdent]/@xml:id" /></xsl:attribute>
		</xsl:if>
	</xsl:when>
	<xsl:otherwise>
		<xsl:if test="@target">
			<xsl:attribute name="target"><xsl:value-of select="concat('#',$oldIdent)" /></xsl:attribute>
		</xsl:if>
		<xsl:if test="@ref">
			<xsl:attribute name="ref"><xsl:value-of select="concat('#',$oldIdent)" /></xsl:attribute>
		</xsl:if>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- on supprime l'attribut synch qui servait à stocker l'ancien identifiant -->
<xsl:template match="//*[@synch]">
	<xsl:element name="{name()}">
		<xsl:for-each select="@*">
			<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
			<xsl:choose>
				<xsl:when test="$attrName = 'synch'">
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		
		<xsl:apply-templates/>	
	</xsl:element>	
</xsl:template>










</xsl:stylesheet>