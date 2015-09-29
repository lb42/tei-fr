<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT xinclude résolution des inclusions avant export epub depuis le container
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

<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
		xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"	
		xmlns:xi="http://www.w3.org/2001/XInclude"
		exclude-result-prefixes="tei xhtml"
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:group[@type='book']">
	<body><xsl:apply-templates/></body>
</xsl:template>

<xsl:template match="tei:group[@type='section1']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:group[@subtype|@rend]">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:floatingText">
	<xsl:variable name="ref" select="descendant::xi:include/./@href"/>
	<xsl:variable name="floatingSubtype" select="@subtype"/>
	<xsl:variable name="floatInclude">
		<xsl:apply-templates select="document($ref)//tei:text/*"/>
	</xsl:variable>
		<floatingText>
			<xsl:attribute name="type" select="concat('enc_',$floatingSubtype)"/>
			<xsl:apply-templates select="$floatInclude"/>
		</floatingText>
</xsl:template> 

<xsl:template match="//tei:floatingText//*[@aid:pstyle]|//tei:floatingText//*[@style]">
	<xsl:copy>
    	<xsl:copy-of select="@*"/>
	 		<xsl:variable name="style">
	    		<xsl:value-of select="ancestor::tei:floatingText/@type"/>
	    	</xsl:variable>
	    	<xsl:attribute name="aid:pstyle">
                <xsl:value-of select="concat($style,'_', @style)"/>
            </xsl:attribute>
	    	<xsl:attribute name="rend" select="concat($style,'_', @style)"/>
            <xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

<xsl:template match="xi:include[@xpointer='text']">
     <xsl:variable name="ref" select="./@href"/>
     <div><xsl:attribute name="xml:id"><!--<xsl:value-of select="generate-id(.)"/>--><xsl:value-of select="substring-before($ref,'.xml')"/></xsl:attribute>
     <head><xsl:value-of select="document($ref)//tei:text/tei:front//tei:titlePart[@type='main']"/></head>
     <!--front-->
     <xsl:apply-templates select="document($ref)//tei:text/tei:front/*"/><!--/div-->
     <!--mainDiv-->
     <xsl:apply-templates select="document($ref)//tei:text/tei:body/tei:div[@xml:id='mainDiv']/*"/>
     <!--back-->
     <xsl:if test="document($ref)//tei:text/tei:back">
     	<xsl:apply-templates select="document($ref)//tei:text/tei:back/*"/>
     </xsl:if>	
     </div>
</xsl:template>

<xsl:template match="tei:div[@type='liminaires']">
  <xsl:copy>
  	<xsl:copy-of select="@*"/>
	<head><xsl:value-of select="substring-after(descendant::tei:p/@aid:pstyle,'Vol_')"/></head>
    <xsl:apply-templates/>
  </xsl:copy>
  <xsl:if test="following-sibling::tei:div[@type='liminaires']">
  	<plop></plop>
</xsl:template>

<xsl:template match="tei:head[@subtype='level1'][parent::tei:group]">
	<div>
	<xsl:attribute name="xml:id"><xsl:text>Titre</xsl:text><xsl:value-of select="generate-id(.)"/></xsl:attribute>
		<head><xsl:apply-templates select="@*|node()"/></head>
		<xsl:value-of select="node()"/>
	</div>
</xsl:template>

<xsl:template match="tei:text[ancestor::tei:group]">
	<div>
		<xsl:attribute name="xml:id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<head><xsl:text>txt</xsl:text></head>
			<xsl:apply-templates select="@*|node()"/>
	</div> 
<!--  <xsl:copy>
  	<xsl:copy-of select="@*"/>
  	<xsl:attribute name="xml:id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
    <head><xsl:text>txt</xsl:text></head>
    <xsl:apply-templates/>
  </xsl:copy>-->
</xsl:template>

<!--<xsl:template match="tei:div[@type='chapitre']">-->
	<!--xsl:attribute name="xml:id">
		<xsl:value-of select=""/>
	</xsl:attribute-->
<!--<div type="section0">
	<head><xsl:copy-of select="../preceding-sibling::tei:front/tei:titlePage//tei:titlePart[@type='main']"/></head>
	<xsl:copy-of select="../preceding-sibling::tei:front/tei:titlePage/tei:*"/>
	<xsl:apply-templates/>-->
	<!-- rappatrier les back dans le body -->
	<!--<xsl:copy-of select="../following-sibling::tei:back/tei:*"/>	
</div>
</xsl:template>-->



<!-- encadré dans un book pour l'epub
<xsl:template match="tei:floatingText">
	<xsl:variable name="ref" select="descendant::xi:include/./@href"/>
	<xsl:variable name="floatingSubtype" select="@subtype"/>
	<xsl:variable name="floatInclude">
		<xsl:apply-templates select="document($ref)//tei:text/*"/>
	</xsl:variable>
		<floatingText>
			<xsl:attribute name="type" select="concat('enc_',$floatingSubtype)"/>
			<xsl:apply-templates select="$floatInclude"/>
		</floatingText>
</xsl:template> 

<xsl:template match="//tei:floatingText//*[@aid:pstyle]">
	<xsl:copy>
    	<xsl:copy-of select="@*"/>
	 		<xsl:variable name="style">
	    		<xsl:value-of select="ancestor::tei:floatingText/@type"/>
	    	</xsl:variable>
	    	<xsl:attribute name="aid:pstyle">
                <xsl:value-of select="concat($style,'_', @aid:pstyle)"/>
            </xsl:attribute>
	    	<xsl:attribute name="rend" select="concat($style,'_', @aid:pstyle)"/>
            <xsl:apply-templates/>
	</xsl:copy>
</xsl:template>
-->

</xsl:stylesheet>