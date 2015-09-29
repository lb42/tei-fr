<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT identifiantsParag.xsl
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

<xsl:template match="tei:body//tei:p">
	<xsl:variable name="numParag"><xsl:value-of select="count(preceding-sibling::tei:p)+1"/></xsl:variable>
	<xsl:variable name="oldIdent" select="@xml:id" />
	<p>
		<xsl:for-each select="@*">
			<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
			<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
		</xsl:for-each>
			<xsl:variable name="newId"><xsl:value-of select="ancestor::tei:div[1]/@xml:id" />
				<xsl:text>.</xsl:text><xsl:value-of select="name()"/><xsl:value-of select="$numParag"/>
			</xsl:variable>
			<xsl:attribute name="xml:id"><xsl:value-of select="$newId"/>
			</xsl:attribute>
			<xsl:if test="($oldIdent != '') and  ($oldIdent != $newId)">
				<xsl:attribute name="synch">
				<xsl:value-of select="$oldIdent" />
			</xsl:attribute>
			</xsl:if>
		<xsl:apply-templates/>
	</p>
</xsl:template>

<xsl:template match="tei:body//tei:list">	
	<list>
		<xsl:for-each select="@*">
			<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
			<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
		</xsl:for-each>	
		<xsl:for-each select="tei:item">
		<xsl:variable name="numItem"><xsl:value-of select="count(preceding-sibling::tei:item)+1"/></xsl:variable>
			<item>
				<xsl:for-each select="@*">
					<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
					<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
				</xsl:for-each>	
				<xsl:variable name="newId">
					<xsl:value-of select="ancestor::tei:div[1]/@xml:id" />
					<xsl:for-each select="ancestor::tei:item">
					<!-- pour l'identifiant on ne prend que la première lettre du nom de l'élément -->
						<xsl:text>.</xsl:text><xsl:value-of select="substring(name(),1,1)"/><xsl:value-of select="count(preceding-sibling::tei:item)+1"/>
					</xsl:for-each>
					<xsl:text>.</xsl:text><xsl:value-of select="substring(name(),1,1)"/><xsl:value-of select="$numItem"/>
					<!--<xsl:text>_</xsl:text><xsl:value-of select="name()"/><xsl:text>.</xsl:text><xsl:value-of select="$numItem"/> -->
				</xsl:variable>	
				<xsl:attribute name="xml:id">
					<xsl:value-of select="$newId"/>
				</xsl:attribute>
				<xsl:call-template name="item">					
					<xsl:with-param name="newId">
						<xsl:value-of select="$newId"/>
					</xsl:with-param>	
					<xsl:with-param name="oldId">
						<xsl:value-of select="@xml:id"/>	
					</xsl:with-param>				
				</xsl:call-template>				
			</item>
		</xsl:for-each>
	</list>		
	
</xsl:template>

<xsl:template name="item">
	<xsl:param name="newId" />
	<xsl:param name="oldId" />	
	<xsl:choose>
		<xsl:when test="$oldId != $newId">
			<xsl:attribute name="synch">
				<xsl:value-of select="@xml:id" />
			</xsl:attribute>
		</xsl:when>
	</xsl:choose>
		
	<xsl:apply-templates />
</xsl:template>



<xsl:template match="tei:body//tei:note">
<xsl:variable name="numNote"><xsl:number count="tei:note" level="any" format="1"/></xsl:variable>
	<!--<xsl:variable name="numNote"><xsl:value-of select="count(preceding::tei:note)+1"/></xsl:variable>-->	
	<note>
		<xsl:for-each select="@*">
			<xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
			<xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
		</xsl:for-each>
		<xsl:variable name="newId"><xsl:value-of select="ancestor::tei:div[1]/@xml:id" />
				<xsl:text>.</xsl:text><xsl:value-of select="name()"/><xsl:text>.</xsl:text><xsl:value-of select="$numNote"/>
			</xsl:variable>
			<xsl:attribute name="xml:id">
				<xsl:value-of select="$newId"/>
			</xsl:attribute>
			<xsl:if test="(@xml:id != '') and  (@xml:id != $newId)">
			<xsl:attribute name="synch">
				<xsl:value-of select="@xml:id" />
			</xsl:attribute>
			</xsl:if>
		<xsl:apply-templates/>
	</note>
</xsl:template>



</xsl:stylesheet>