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
			<xsl:if test="//xi:include">
				<xsl:variable name="ref" select="//descendant::xi:include/@href"/>
				<xsl:variable name="pathtoRef" select="concat($directory,'/',$ref)"/>
				 	<xsl:if test="document($pathtoRef)//tei:graphic">
				 		<xsl:for-each select="document($pathtoRef)//tei:graphic">
				 			<xsl:value-of select="concat('../../',@url)"/>
				<xsl:text>
</xsl:text>
				 		</xsl:for-each>
				 	</xsl:if>
			</xsl:if>
		</xsl:result-document>
	<xsl:apply-templates/>
</xsl:template>

<xsl:variable name="lang_alt" select="//tei:head[@style='T_0_Article_UK']/@xml:lang|//tei:head[@aid:pstyle='T_0_Article_UK']/@xml:lang"/>
<xsl:variable name="edit_role" select="//tei:editor/@role"/>
<xsl:variable name="firstNote"><xsl:value-of select="//tei:note[1]/@type"/></xsl:variable>

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
			<xsl:for-each select="//tei:titlePart[@type='sub']">
		<title type="sub">
    		<!--<xsl:value-of select="//tei:titlePart[@type='sub']"/>--> <xsl:apply-templates/>
		</title>
			</xsl:for-each>
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

<!--xsl:template match="tei:hi[@rend='line-through']">
	<hi rendition="#T1"><xsl:apply-templates/></hi>
</xsl:template-->

<xsl:template match="tei:encodingDesc">
<encodingDesc>
	<tagsDecl>
		<!--rendition scheme="css" xml:id="T1">
			<xsl:text>text-decoration:line-through</xsl:text>
		</rendition-->
		<rendition scheme="css" xml:id="rtl">
			<xsl:text>direction:rtl</xsl:text>
		</rendition>
	</tagsDecl>
</encodingDesc>
</xsl:template>

<xsl:template match="tei:titlePage"/>

<xsl:template match="tei:front">
<front>
	<xsl:if test="descendant::tei:p[@style='txt_Resume']|descendant::tei:p[@aid:pstyle='txt_Resume']">
		<div type="abstract">
			<xsl:attribute name="xml:lang">
				<xsl:value-of select="descendant::tei:p[@style='txt_Resume']/@xml:lang|descendant::tei:p[@aid:pstyle='txt_Resume']/@xml:lang"/>
			</xsl:attribute>
			<xsl:copy-of select="descendant::tei:p[@style='txt_Resume']|descendant::tei:p[@aid:pstyle='txt_Resume']"/>
		</div>
	</xsl:if>
	<xsl:if test="descendant::tei:p[@style='txt_Resume_italique']|descendant::tei:p[@aid:pstyle='txt_Resume_italique']">
	<xsl:for-each select="descendant::tei:p[@style='txt_Resume_italique']|descendant::tei:p[@aid:pstyle='txt_Resume_italique']">
		<div type="abstract">
			<xsl:attribute name="xml:lang">
				<xsl:value-of select="@xml:lang"/>
			</xsl:attribute>
			<xsl:copy-of select="."/>
		</div>
	</xsl:for-each>
	</xsl:if>
	<xsl:if test="descendant::tei:p[@style='txt_resume_inv']|descendant::tei:p[@aid:pstyle='txt_resume_inv']">
		<div type="abstract" xml:lang="ar">
		<!--xsl:attribute name="xml:lang">
			<xsl:value-of select="@xml:lang"/>
		</xsl:attribute-->
		<p rendition="#rtl"><xsl:value-of select="descendant::tei:p[@style='txt_resume_inv']|descendant::tei:p[@aid:pstyle='txt_resume_inv']"/></p>
		</div>
	</xsl:if>
	<xsl:if test="descendant::tei:div[@type='prelim']/tei:p[@aid:pstyle='txt_remerciements']|descendant::tei:div[@type='prelim']/tei:p[@style='txt_remerciements']">
		<div type="ack">
			<xsl:copy-of select="descendant::tei:div[@type='prelim']/tei:p[@aid:pstyle='txt_remerciements']|descendant::tei:div[@type='prelim']/tei:p[@style='txt_remerciements']"/>
		</div>
	</xsl:if>
	<xsl:if test="descendant::tei:div[@type='review']">
			<xsl:copy-of select="descendant::tei:div[@type='review']"/>
	</xsl:if>
	<xsl:if test="descendant::tei:div[@type='recension']">
		<div type="review">
			<p rend="review-title"><xsl:value-of select="descendant::tei:title"/></p>
			<xsl:for-each select="descendant::tei:author">
			<p rend="review-author"><xsl:value-of select="."/></p>
			</xsl:for-each>
			<p rend="review-bibliography"><xsl:copy-of select="descendant::tei:bibl/node()"/></p>
			<p rend="review-date"><xsl:value-of select="descendant::tei:date"/></p>
		</div>
	</xsl:if>
<!--	<xsl:if test="../descendant::tei:p[@style='adlocalnoteredaction']">
			<note resp="author"><xsl:copy-of select="../descendant::tei:p[@style='adlocalnoteredaction']"/></note>
	</xsl:if>-->
	<xsl:if test="../../descendant::tei:note[@type='noteediteur']">
			<note resp="editor"><p><xsl:copy-of select="../../descendant::tei:note[@type='noteediteur']/node()"/></p></note>
	</xsl:if>
	<xsl:if test="../../descendant::tei:note[@type='noteredaction']">
			<note resp="author"><p><xsl:copy-of select="../../descendant::tei:note[@type='noteredaction']/node()"/></p></note>
	</xsl:if>
</front>
</xsl:template>

<xsl:template match="tei:p[@style='txt_Resume']|tei:p[@aid:pstyle='txt_Resume']"/>
<xsl:template match="//tei:p[@style='txt_Resume_italique']|//tei:p[@aid:pstyle='txt_Resume_italique']"/>
<xsl:template match="//tei:p[@style='txt_resume_inv']|//tei:p[@aid:pstyle='txt_resume_inv']"/>
<xsl:template match="//tei:div[@type='review']"/>
<xsl:template match="//tei:p[@aid:pstyle='txt_Exergue']"/>

<xsl:template match="tei:body">
  <body>
<!-- exergue dans le body… -->
	<xsl:if test="descendant::tei:p[@aid:pstyle='txt_Exergue']">
			<p rend="epigraph">
				<xsl:copy-of select="descendant::tei:p[@aid:pstyle='txt_Exergue']/node()"/>
			</p>
	</xsl:if>
  	<xsl:if test="preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']|preceding-sibling::tei:front//tei:quote[@aid:pstyle='epigraphe']">
		<div>
		<p rend="epigraph">
			<xsl:choose>
				<xsl:when test="preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']/tei:lb|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:lb" >
					<xsl:apply-templates select="preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']/text()|preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']/node()|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/text()|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/node()"/>
				</xsl:when>
				<xsl:when test="preceding-sibling::tei:front//tei:quote[@aid:pstyle='epigraphe']/tei:lb">
					<xsl:apply-templates select="preceding-sibling::tei:front//tei:quote[@aid:pstyle='epigraphe']/text()|preceding-sibling::tei:front//tei:quote[@aid:pstyle='epigraphe']/node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']/text()|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/text()"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']/tei:note|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:note">
				<note>
				<xsl:attribute name="place"><xsl:value-of select="preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']/tei:note/@place|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:note/@place"/></xsl:attribute>
				<xsl:attribute name="n"><xsl:value-of select="preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']/tei:note/@n|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:note/@n"/></xsl:attribute>
				<p><xsl:apply-templates select="preceding-sibling::tei:front//tei:quote[@style='txt_Epigraphe']/tei:note/text()|preceding-sibling::tei:front//tei:quote[@aid:pstyle='txt_Epigraphe']/tei:note/text()"/></p></note>
			</xsl:if>
		</p>
		</div>
	</xsl:if>
    <xsl:apply-templates/>
  </body>
  <back>
    <!--xsl:apply-templates select="//tei:back/*"/-->
    <xsl:if test="../tei:back/tei:div[@type='bibliographie']">
    	<xsl:call-template name="bibliographie"/>
    </xsl:if>
    <xsl:if test="../tei:back/tei:div[@type='annexe']">
    	<xsl:call-template name="annexe"/>
    </xsl:if>
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
	<xsl:choose>
		<xsl:when test="$firstNote != 'standard'">
			<note>
				<xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute>
				<xsl:attribute name="n"><xsl:value-of select="@n -1"/></xsl:attribute>
				<p>
					<xsl:apply-templates/>
				</p>
			</note>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="descendant::tei:p">
					<note>
						<xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute>
						<xsl:attribute name="n"><xsl:value-of select="@n"/></xsl:attribute>
							<xsl:apply-templates/>
					</note>
				</xsl:when>
				<xsl:otherwise>
					<note>
						<xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute>
						<xsl:attribute name="n"><xsl:value-of select="@n"/></xsl:attribute>
						<p>
							<xsl:apply-templates/>
						</p>
					</note>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="tei:note[@type='NDLE']"/>
<xsl:template match="tei:note[@type='NDLA']"/>
<xsl:template match="tei:p[@style='txt_remerciements']|tei:p[@aid:pstyle='txt_remerciements']"/>
<xsl:template match="tei:p[@style='txt_Keywords']|tei:p[@aid:pstyle='txt_Keywords']"/>
<xsl:template match="tei:p[@style='txt_motscles_inv']|tei:p[@aid:pstyle='txt_motscles_inv']"/>

<xsl:template match="tei:quote[@style='txt_Citation']|tei:quote[@aid:pstyle='txt_Citation']">
  <q rend="quotation"><xsl:apply-templates/></q>
</xsl:template>
<xsl:template match="tei:quote[@style='txt_Citation_italique']|tei:quote[@aid:pstyle='txt_Citation_italique']">
  <q rend="quotation2"><xsl:apply-templates/></q>
</xsl:template>
<!--xsl:template match="tei:quote[@style='txt_Citation_inv']">
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

<!--xsl:template match="tei:l">
	<xsl:choose>
		<xsl:when test="tei:lb">
			<xsl:for-each select="tei:lb[1]/preceding-sibling::*|tei:lb[1]/preceding-sibling::text()|node()">
				<p rend="noindent"><xsl:value-of select="@n"/><xsl:text>&#160;&#160;&#160;</xsl:text><xsl:apply-templates select="."/></p>
				</xsl:for-each>
			<xsl:for-each select="tei:lb[1]/following-sibling::*|tei:lb[1]/following-sibling::text()">
				<p rend="noindent"><xsl:copy-of select="."/></p>
			</xsl:for-each>	
		</xsl:when>
		<xsl:otherwise>
			<p rend="noindent"><xsl:value-of select="@n"/><xsl:text>&#160;&#160;&#160;</xsl:text><xsl:apply-templates/></p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template-->

<!--xsl:template match="xi:include">
	<p rend="box">
		<xsl:variable name="ref" select="./@href"/>
     <xsl:apply-templates select="document($ref)//tei:text/*"/>
	</p>
</xsl:template-->

<xsl:template match="tei:figure">
<xsl:if test="descendant::tei:head">
	<p rend="figure-title">
		<xsl:apply-templates select="tei:head/node()"/>
	</p>
</xsl:if>
	<p><figure>
		<xsl:apply-templates select="tei:graphic"/>
	</figure></p>
	<xsl:if test="following-sibling::tei:p[1][@style='txt_Legende']|following-sibling::tei:p[1][@aid:pstyle='txt_Legende']|descendant::tei:p[1][@style='txt_Legende']|descendant::tei:p[1][@aid:pstyle='txt_Legende']">
		<p rend="figure-legend">
			<xsl:apply-templates select="following-sibling::tei:p[1][@style='txt_Legende']/node()|following-sibling::tei:p[1][@aid:pstyle='txt_Legende']/node()|descendant::tei:p[1][@style='txt_Legende']/node()|descendant::tei:p[1][@aid:pstyle='txt_Legende']/node()"/>
		</p>
	</xsl:if>
	<xsl:if test="descendant::tei:p[@style='txt_credits']">
		<p rend="figure-license">
			<xsl:apply-templates select="descendant::tei:p[@style='txt_credits']/node()"/>
		</p>
	</xsl:if>
</xsl:template>

<!--titre, tableau, legende-->
<xsl:template match="tei:table">
	<p rend="figure-title">
		<xsl:apply-templates select="tei:head/node()"/>
	</p>
	<table>
		<xsl:apply-templates/>
	</table>
</xsl:template>

<xsl:template match="tei:cell">
	<xsl:choose>
		<xsl:when test="ancestor::tei:table[@rendition='none']">
			<cell>
				<xsl:copy-of select="@*"/>
				<xsl:attribute name="rendition">
					<xsl:text>border:none;</xsl:text>
				</xsl:attribute>
				<xsl:apply-templates/>
			</cell>
		</xsl:when>
		<xsl:otherwise>
			<cell>
				<xsl:copy-of select="@*"/>
				<xsl:apply-templates/>
			</cell>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="tei:p[@style='txt_Legende']|tei:p[@aid:pstyle='txt_Legende']">
	<xsl:choose>
		<xsl:when test="preceding-sibling::tei:table[1]">
			<p rend="figure-legend">
				<xsl:apply-templates/>
			</p>
		</xsl:when>
		<xsl:otherwise>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

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
			<xsl:if test="descendant::tei:head[@style='T_2']|descendant::tei:head[@aid:pstyle='T_2']">
				<head subtype='level1'><xsl:value-of select="descendant::tei:head[@style='T_2']|descendant::tei:head[@aid:pstyle='T_2']"/></head>
			</xsl:if>
			<xsl:apply-templates/>
		</listBibl>
	</xsl:for-each>
  <!--xsl:copy-of select="//tei:div[@type='bibliographie']/descendant::tei:bibl|//tei:div[@type='bibliographie']/descendant::tei:head[@style='T_2']"/-->
</div>
</xsl:template>

<xsl:template match="//tei:div[@type='bibliographie']/descendant::tei:listBibl/tei:head[@style='T_1']|//tei:div[@type='bibliographie']/descendant::tei:listBibl/tei:head[@aid:pstyle='T_1']"/>

<xsl:template match="//tei:div[@type='bibliographie']/descendant::tei:listBibl/tei:head[@style='T_2']|//tei:div[@type='bibliographie']/descendant::tei:listBibl/tei:head[@aid:pstyle='T_2']"/>

<xsl:template match="//tei:div[@type='annexe']/descendant::tei:head[@style='T_1']"/>

<xsl:template name="annexe" match="//tei:div[@type='annexe']">
	<div type="appendix">
		<xsl:for-each select="//descendant::tei:floatingText[@type='annexe']">
			<xsl:variable name="ref" select="//descendant::xi:include/@href"/>
			<xsl:variable name="pathtoRef" select="concat($directory,'/',$ref)"/>
			<div type="div1">
			<head subtype="level1"><xsl:apply-templates select="document($pathtoRef)//tei:titlePart[@type='main']/text()"/></head>
			<xsl:apply-templates select="document($pathtoRef)//tei:div[@type='chapitre']/*"/>
			</div>
		</xsl:for-each>
	</div>
</xsl:template>

<xsl:template match="tei:floatingText">
	<xsl:for-each select="descendant::tei:p|descendant::tei:head">
		<p rend="box"><xsl:value-of select="."/></p>
	</xsl:for-each>
</xsl:template>

<xsl:template match="tei:note[@type='noteediteur']">
<xsl:text>*</xsl:text>
</xsl:template>

<xsl:template match="tei:note[@type='noteredaction']">
<xsl:text>*</xsl:text>
</xsl:template>

<xsl:template match="tei:div[@type='bibliographie']"/>

<xsl:template match="tei:div[@type='annexe']"/>

<xsl:template match="//tei:index">
</xsl:template>

<xsl:template match="tei:back">
</xsl:template>

</xsl:stylesheet>
