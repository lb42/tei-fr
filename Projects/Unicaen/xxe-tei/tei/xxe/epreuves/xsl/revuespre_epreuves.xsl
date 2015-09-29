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
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<!--<xsl:strip-space elements="*"/>-->

<xsl:param name="directory"/>
<xsl:param name="filename"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="/">
<xsl:variable name="sansExt" select="substring-before($filename,'.')"/>
		<xsl:result-document href="{concat($directory,'/OE/',$sansExt,'/linksToImages.txt')}" method="text">
			<xsl:for-each select="//tei:graphic">
			<xsl:value-of select="concat('../../',@url)"/>
				<xsl:text>
</xsl:text>
			</xsl:for-each>
		</xsl:result-document>
	<xsl:apply-templates/>
</xsl:template>

<xsl:variable name="lang_alt" select="//tei:head[@aid:pstyle='T_0_Article_UK']/@xml:lang"/>
<xsl:variable name="edit_role" select="//tei:editor/@role"/>

<xsl:template match="tei:titleStmt">
	<titleStmt>
		<title type="main">
				<xsl:apply-templates select="//tei:titlePart[@type='main']/node()"/>
		</title>
		<xsl:if test="//tei:titlePart[@type='alt']">
			<xsl:for-each select="//tei:titlePart[@type='alt']">
				<title type="alt">
					<xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
    				<xsl:apply-templates/>
				</title>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="//tei:titlePart[@type='sub']">
		<title type="sub">
    		<xsl:value-of select="//tei:titlePart[@type='sub']"/>
		</title>
		</xsl:if>
		<xsl:if test="//tei:titlePart[@rend='rtl']">
		<title type="sub" rendition="#rtl">
    		<xsl:value-of select="//tei:titlePart[@rend='rtl']"/>
		</title>
		</xsl:if>
		<xsl:if test="//descendant::tei:author">
			<xsl:for-each select="tei:author">
			<author>
				<xsl:apply-templates/>
			</author>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="//tei:editor">
			<xsl:for-each select="tei:editor">
			<editor>
				<xsl:attribute name="role"><xsl:value-of select="$edit_role"/></xsl:attribute>
				<xsl:apply-templates/>
			</editor>
			</xsl:for-each>
		</xsl:if>
	</titleStmt>
</xsl:template>

<xsl:template match="tei:hi[@rend='line-through']">
	<hi rendition="#T1"><xsl:apply-templates/></hi>
</xsl:template>

<xsl:template match="tei:encodingDesc">
<encodingDesc>
	<tagsDecl>
		<rendition scheme="css" xml:id="T1">
			<xsl:text>text-decoration:line-through</xsl:text>
		</rendition>
		<rendition scheme="css" xml:id="rtl">
			<xsl:text>direction:rtl</xsl:text>
		</rendition>
	</tagsDecl>
</encodingDesc>
</xsl:template>

<xsl:template match="tei:titlePage"/>

<xsl:template match="tei:front">
<front>
	<xsl:if test="descendant::tei:p[@aid:pstyle='txt_Resume']">
		<div type="abstract">
			<xsl:attribute name="xml:lang">
				<xsl:value-of select="descendant::tei:p[@aid:pstyle='txt_Resume']/@xml:lang"/>
			</xsl:attribute>
			<xsl:copy-of select="descendant::tei:p[@aid:pstyle='txt_Resume']"/>
		</div>
	</xsl:if>
	<xsl:if test="descendant::tei:p[@aid:pstyle='txt_Resume_italique']">
	<xsl:for-each select="descendant::tei:p[@aid:pstyle='txt_Resume_italique']">
		<div type="abstract">
			<xsl:attribute name="xml:lang">
				<xsl:value-of select="@xml:lang"/>
			</xsl:attribute>
			<xsl:copy-of select="."/>
		</div>
	</xsl:for-each>
	</xsl:if>
	<xsl:if test="descendant::tei:p[@aid:pstyle='txt_resume_inv']">
		<div type="abstract" xml:lang="ar">
		<!--xsl:attribute name="xml:lang">
			<xsl:value-of select="@xml:lang"/>
		</xsl:attribute-->
		<p rendition="#rtl"><xsl:value-of select="descendant::tei:p[@aid:pstyle='txt_resume_inv']"/></p>
		</div>
	</xsl:if>
	<xsl:if test="descendant::tei:div[@type='review']">
			<xsl:copy-of select="descendant::tei:div[@type='review']"/>
	</xsl:if>
	<xsl:if test="../descendant::tei:p[@aid:pstyle='adlocalnoteredaction']">
			<note resp="author"><xsl:copy-of select="../descendant::tei:p[@aid:pstyle='adlocalnoteredaction']"/></note>
	</xsl:if>
	<xsl:if test="../../descendant::tei:note[@type='noteediteur']">
			<note resp="editor"><p><xsl:copy-of select="../../descendant::tei:note[@type='noteediteur']/text()"/></p></note>
	</xsl:if>
	<xsl:if test="../../descendant::tei:note[@type='noteredaction']">
			<note resp="author"><p><xsl:copy-of select="../../descendant::tei:note[@type='noteredaction']/text()"/></p></note>
	</xsl:if>
</front>
</xsl:template>

<xsl:template match="tei:p[@aid:pstyle='txt_Resume']"/>
<xsl:template match="//tei:p[@aid:pstyle='txt_Resume_italique']"/>
<xsl:template match="//tei:p[@aid:pstyle='txt_resume_inv']"/>
<xsl:template match="//tei:div[@type='review']"/>

<xsl:template match="tei:body">
  <body>
  	<xsl:if test="preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']">
		<div>
		<p rend="epigraph">
			<xsl:choose>
				<xsl:when test="preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:lb" >
					<xsl:apply-templates select="preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/text()|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/text()"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:note">
				<note>
				<xsl:attribute name="place"><xsl:value-of select="preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:note/@place"/></xsl:attribute>
				<xsl:attribute name="n"><xsl:value-of select="preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:note/@n"/></xsl:attribute>
				<p><xsl:apply-templates select="preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:note/text()"/></p></note>
			</xsl:if>
		</p>
		</div>
	</xsl:if>
    <xsl:apply-templates/>
  </body>
  <back>
    <!--xsl:apply-templates select="//tei:back/*"/-->
    <xsl:call-template name="bibliographie"/>
    <xsl:call-template name="appendice"/>
  </back>
</xsl:template>

<xsl:template match="tei:quote[@rend='rtl']">
	<q rend="quotation2" rendition="#rtl" xml:lang="ar">
		<xsl:apply-templates/>		
	</q>
</xsl:template>

<xsl:template match="tei:p[@rend='rtl']">
	<p rendition="#rtl">
		<xsl:apply-templates/>		
	</p>
</xsl:template>

<xsl:template match="tei:note">
  <xsl:variable name="numNote"><xsl:number count="tei:note" level="any" format="1"/></xsl:variable>
  <note>
    <xsl:for-each select="@*">
      <xsl:variable name="attrName"><xsl:value-of select="name()"/></xsl:variable>
      <xsl:attribute name="{$attrName}"><xsl:value-of select="."/></xsl:attribute>
    </xsl:for-each>
    <xsl:attribute name="xml:id">note<xsl:value-of select="$numNote"/></xsl:attribute>
    <p rend="footnote">
      <xsl:apply-templates/>
    </p>
  </note>
</xsl:template>

<xsl:template match="tei:note[@type='NDLE']"/>
<xsl:template match="tei:note[@type='NDLA']"/>
<xsl:template match="tei:p[@aid:pstyle='txt_remerciements']"/>
<xsl:template match="tei:p[@aid:pstyle='txt_Motclef']"/>
<xsl:template match="tei:p[@aid:pstyle='txt_Keywords']"/>
<xsl:template match="tei:p[@aid:pstyle='txt_motscles_inv']"/>

<xsl:template match="tei:quote[@aid:pstyle='txt_Citation']">
  <q rend="quotation"><xsl:apply-templates/></q>
</xsl:template>
<xsl:template match="tei:quote[@aid:pstyle='txt_Citation_italique']">
  <q rend="quotation2"><xsl:apply-templates/></q>
</xsl:template>
<!--xsl:template match="tei:quote[@aid:pstyle='txt_Citation_inv']">
  <q rend="quotation2">
	<xsl:attribute name="xml:lang">
		<xsl:value-of select="@xml:lang"/>
	</xsl:attribute>
 	<xsl:apply-templates/>
  </q>
</xsl:template-->

<xsl:template match="tei:quote[@type='exemple']">
<xsl:variable name="numero"><xsl:value-of select="tei:quote/tei:num"/></xsl:variable>
<quote type="exemple" n="{$numero}">
	<xsl:apply-templates/>
</quote>
</xsl:template>

<xsl:template match="tei:num">
</xsl:template>

<xsl:template match="xi:include">
	<p rend="box">
		<xsl:variable name="ref" select="./@href"/>
     <xsl:apply-templates select="document($ref)//tei:text/*"/>
	</p>
</xsl:template>

<xsl:template match="tei:figure">
	<p rend="figure-title">
		<xsl:apply-templates select="tei:head/node()"/>
	</p>
	<p><figure>
		<xsl:apply-templates select="tei:graphic"/>
	</figure></p>
	<p rend="figure-legend">
		<xsl:apply-templates select="tei:p[@aid:pstyle='txt_Legende']/node()"/>
	</p>
</xsl:template>

<!--titre, tableau, legende-->
<xsl:template match="tei:table">
	<p rend="figure-title">
		<xsl:apply-templates select="tei:head/node()"/>
	</p>
	<table>
		<xsl:apply-templates/>
	</table>
<xsl:if test="following-sibling::tei:p[@aid:pstyle='txt_Legende'][1]">
	<p rend="figure-legend">
		<xsl:value-of select="following-sibling::tei:p[@aid:pstyle='txt_Legende'][1]"/>
	</p>	
</xsl:if>
</xsl:template>

<xsl:template match="tei:p[@aid:pstyle='txt_Legende']"/>
<xsl:template match="//tei:table/tei:head"/>

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
  <graphic url="{$imageLink}">
  </graphic>
</xsl:template>

<xsl:template name="bibliographie">
<div type="bibliography">
	<xsl:for-each select="//tei:div[@type='bibliographie']/descendant::tei:listBibl">
		<listBibl>
			<xsl:if test="descendant::tei:head[@aid:pstyle='T_2']">
				<head subtype='level1'><xsl:value-of select="descendant::tei:head[@aid:pstyle='T_2']"/></head>
			</xsl:if>
			<xsl:apply-templates/>
		</listBibl>
	</xsl:for-each>
  <!--xsl:copy-of select="//tei:div[@type='bibliographie']/descendant::tei:bibl|//tei:div[@type='bibliographie']/descendant::tei:head[@aid:pstyle='T_2']"/-->
</div>
</xsl:template>

<xsl:template match="//tei:div[@type='bibliographie']/descendant::tei:listBibl/tei:head[@aid:pstyle='T_2']"/>

<xsl:template name="appendice" match="//tei:div[@type='appendice']/*">
<div type="appendix">
	<xsl:copy-of select="//tei:div[@type='appendice']/*"/>
	<!--xsl:choose>
		<xsl:when test="//tei:figure[ancestor::tei:div[@type='appendice']]">
		  <xsl:for-each select="//tei:figure[ancestor::tei:div[@type='appendice']]">
			<p rend="figure-title">
				<xsl:apply-templates select="tei:head/node()"/>
			</p>
  				<xsl:variable name="imageLinkApp">
      			  <xsl:value-of select="tei:graphic/substring-after(@url,'br/')"/>
  				</xsl:variable>
  			<graphic url="{$imageLinkApp}"/>
			<p rend="figure-legend">
				<xsl:apply-templates select="./following-sibling::tei:p[@aid:pstyle='txt_Legende'][1]/node()"/>
			</p>
		  </xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="//tei:div[@type='appendice']/*"/>
		</xsl:otherwise>
	</xsl:choose-->
  <!--xsl:copy-of select="//tei:div[@type='appendice']/*"/-->
</div>
</xsl:template>

<xsl:template match="tei:note[@type='noteediteur']">
<xsl:text>*</xsl:text>
</xsl:template>

<xsl:template match="tei:note[@type='noteredaction']">
<xsl:text>*</xsl:text>
</xsl:template>

<xsl:template match="tei:div[@type='bibliographie']"/>

<xsl:template match="tei:div[@type='appendice']"/>

<xsl:template match="//tei:index">
</xsl:template>

<!--xsl:template match="tei:back">
  
</xsl:template-->

</xsl:stylesheet>
