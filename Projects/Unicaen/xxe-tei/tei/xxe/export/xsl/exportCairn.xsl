<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT exportCairn
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
*
*  Cairn DTD propriétaire.
*/
-->

<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xhtml="http://www.w3.org/TR/xhtml/strict"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
		xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		exclude-result-prefixes="tei aid aid5 xlink xhtml xsi"
		xmlns:xlink="http://www.w3.org/1999/xlink">
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<!-- <xsl:strip-space elements="*"/> -->

<xsl:param name="directory"/>
<xsl:param name="filename"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="/">
<xsl:variable name="sansExt" select="substring-before($filename,'.')"/>
		<xsl:result-document href="{concat($directory,'/CAIRN/',$sansExt,'/linksToImages.txt')}" method="text">
			<xsl:for-each select="//tei:graphic">
			<xsl:value-of select="concat('../../',@url)"/>
				<xsl:text>
</xsl:text>
			</xsl:for-each>
		</xsl:result-document>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:TEI">
   	<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE article SYSTEM "dtd/eruditarticle_cairn_v2.dtd"&gt;</xsl:text>
<article lang="fr" idproprio="tele_038" traitement="artr">
  <admin>
    <infoarticle>
      <idpublic norme="doi">????</idpublic>

      <pagination>
        <ppage>??</ppage>

        <dpage>??</dpage>
      </pagination>

      <nbpage>??</nbpage>

      <nbpara>??</nbpara>

      <nbmot>??</nbmot>

      <nbfig>??</nbfig>

      <nbtabl>??</nbtabl>

      <nbimage>??</nbimage>

      <nbaudio>??</nbaudio>

      <nbvideo>??</nbvideo>

      <nbrefbiblio>??</nbrefbiblio>

      <nbnote>??</nbnote>
    </infoarticle>

    <revue id="##">
      <titrerev>??</titrerev>

      <titrerevabr>Titre abbr</titrerevabr>

      <idissn></idissn>

      <idissnnum>ISSN Numérique</idissnnum>
    </revue>

    <numero id="##">
      <volume></volume>

      <nonumero></nonumero>

      <pub>
        <annee></annee>
      </pub>

      <pubnum>
        <date></date>
      </pubnum>

      <theme>??</theme>

      <idisbn></idisbn>
    </numero>

    <editeur id="##">
      <nomorg></nomorg>
    </editeur>

    <prodnum id="CairnP">
      <nomorg>Cairn/Softwin</nomorg>
    </prodnum>

    <diffnum id="CairnD">
      <nomorg>Cairn</nomorg>
    </diffnum>

    <dtd nom="Erudit Article" version="vCairn 2.0" />

    <droitsauteur>© <nomorg></nomorg>, 201#</droitsauteur>
  </admin>

	<liminaire>
	<grtitre>
		<titre><xsl:value-of select="//tei:div[@type='chapitre']/tei:head"/></titre>
	</grtitre>
	<grauteur>
		<xsl:for-each select="descendant::tei:p[@aid:pstyle='auteur']">
			<xsl:call-template name="auteur"/>
		</xsl:for-each>
	</grauteur>
	<xsl:for-each select="descendant::tei:p">
		<xsl:call-template name="resume"/>
	</xsl:for-each>
	</liminaire>
	<xsl:apply-templates/>
	<partiesann>
	<xsl:choose>
	<xsl:when test="descendant::tei:bibl">
	<biblio>
		<xsl:for-each select="descendant::tei:bibl">
			  <xsl:call-template name="biblio"/>
		</xsl:for-each>
	</biblio>
	</xsl:when>
	<xsl:otherwise>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
	<xsl:when test="descendant::tei:note">
	<grnote>
	<xsl:for-each select="descendant::tei:note">
	  <xsl:call-template name="noteFin"/>
	</xsl:for-each>
	</grnote>
	</xsl:when>
	<xsl:otherwise>
	</xsl:otherwise>
	</xsl:choose>
	</partiesann>
</article>
</xsl:template>

<!-- Header -->
<xsl:template match="tei:teiHeader">

</xsl:template>

<!-- Notes en fin de fichier -->
<xsl:template name="noteFin">
<xsl:variable name="nbNote"><xsl:value-of select="count(preceding::tei:note)+1"/></xsl:variable>
<note><xsl:attribute name="id">no<xsl:value-of select="$nbNote"/></xsl:attribute><no><xsl:value-of select="$nbNote"/></no><alinea><xsl:apply-templates/></alinea></note>
</xsl:template>

<!-- bibliographie -->
<xsl:template name="biblio">
<refbiblio><xsl:attribute name="id">rb<xsl:value-of select="count(preceding::tei:bibl)"/></xsl:attribute><alinea><xsl:apply-templates/></alinea></refbiblio>
</xsl:template>

<!-- le text du TEI -->
<xsl:template match="tei:text">
<xsl:apply-templates/>
</xsl:template>

<!-- le front du TEI -->
<xsl:template match="tei:front">
</xsl:template>

<!-- le back du TEI -->
<xsl:template match="tei:back">
</xsl:template>

<!-- Le template pour le grpauteur -->
<xsl:template name="auteur">
	<auteur>
		<xsl:attribute name="id">au<xsl:value-of select="count(preceding::tei:p[@aid:pstyle='auteur'])"/></xsl:attribute>
	<nompers><prenom><xsl:value-of select="."/></prenom><nomfamille></nomfamille></nompers>
	<affiliation><alinea><xsl:value-of select="following::tei:p[@aid:pstyle='auteur_Institution']"/></alinea></affiliation>
	</auteur>
</xsl:template>

<!-- le corps du document -->
<xsl:template match="tei:body">
<corps><xsl:apply-templates/></corps>
</xsl:template>

<xsl:template match="tei:div[@type='chapitre']">
  <xsl:choose>
    <xsl:when test="tei:p">
      <section1>
        <xsl:attribute name="id">s1n0a</xsl:attribute>
        <xsl:apply-templates select="tei:p|tei:quote" mode="topPara"/>
      </section1>
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <section1>
        <xsl:attribute name="id">s1n0a</xsl:attribute>
        <xsl:apply-templates/>
      </section1>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:p|tei:quote" mode="topPara">
  <xsl:choose>
  	<xsl:when test="@aid:pstyle='txt_Resume'"></xsl:when>
  	<xsl:when test="@aid:pstyle='txt_Resume_italique'"></xsl:when>
  	<xsl:when test="@aid:pstyle='auteur'"></xsl:when>
  	<xsl:when test="@aid:pstyle='auteur_Institution'"></xsl:when>
  	<xsl:when test="@aid:pstyle='txt_Keywords'"></xsl:when>
    <xsl:when test="local-name()='p'">
      <para>
        <xsl:attribute name="id">pa<xsl:value-of select="count(preceding::tei:p|preceding::tei:quote|preceding::tei:list)"/></xsl:attribute>
        <xsl:choose>
          <xsl:when test="@aid:pstyle='txt_Normal'">
            <alinea><xsl:apply-templates/></alinea>
          </xsl:when>
          <xsl:otherwise>
            <alinea><xsl:apply-templates/></alinea>
          </xsl:otherwise>
        </xsl:choose>
      </para>
    </xsl:when>
    <xsl:when test="local-name()='quote' and @aid:pstyle='txt_Citation'">
      <para>
        <xsl:attribute name="id">pa<xsl:value-of select="count(preceding::tei:p|preceding::tei:quote|preceding::tei:list)"/></xsl:attribute>
        <bloccitation>
          <xsl:choose>
            <xsl:when test="child::tei:lb">
              <verbatim typeverb="forme">
                <bloc>
                  <xsl:text disable-output-escaping="yes">&lt;</xsl:text>ligne<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
                  <xsl:apply-templates/>
                  <xsl:text disable-output-escaping="yes">&lt;</xsl:text>/ligne<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
                </bloc>
              </verbatim>
            </xsl:when>
            <xsl:otherwise>
              <alinea><xsl:apply-templates/></alinea>
            </xsl:otherwise>
          </xsl:choose>
        </bloccitation>
      </para>      
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:div[@type='section1']|tei:div[@type='section2']|tei:div[@type='section3']|tei:div[@type='section4']">
  <xsl:variable name="level">
    <xsl:choose>
      <xsl:when test="//tei:div[@type='chapitre']/tei:p">
        <xsl:value-of select="number(substring-after(@type,'section'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="number(substring-after(@type,'section'))+1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="currentType">
    <xsl:value-of select="@type"/>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="child::tei:bibl">

    </xsl:when>
    <xsl:otherwise>
      <xsl:text disable-output-escaping="yes">&lt;</xsl:text>section<xsl:value-of select="$level"/> id=&quot;s<xsl:value-of select="$level"/>n<xsl:value-of select="count(preceding::tei:div[@type=$currentType])"/>&quot;<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
      <xsl:apply-templates/>
      <xsl:text disable-output-escaping="yes">&lt;</xsl:text>/section<xsl:value-of select="$level"/><xsl:text disable-output-escaping="yes">&gt;</xsl:text>      
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--A REVOIR -->
<xsl:template match="tei:head">
<xsl:choose>
<xsl:when test="parent::tei:div[@type='chapitre']">
</xsl:when>
<xsl:when test="local-name(parent::node())='tei:div'">
</xsl:when>
<xsl:otherwise>
<titre><xsl:apply-templates/></titre>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- Figures -->
<xsl:template match="tei:figure">
  <!--<figure><xsl:attribute name="id">fi<xsl:value-of select="count(preceding::tei:figure)+1"/></xsl:attribute>
<no><marquage typemarq="gras"><marquage typemarq="italique">Figure <xsl:value-of select="count(preceding::tei:figure)+1"/></marquage></marquage></no>
<legende lang="fr"><xsl:apply-templates/></legende> -->
<objetmedia flot="bloc">
<image>
<xsl:attribute name="id">im<xsl:value-of select="count(preceding::tei:figure)+1"/></xsl:attribute>
<xsl:attribute name="typeimage">figure</xsl:attribute>
<xsl:attribute name="typemime">image:jpeg</xsl:attribute>
<xsl:attribute name="xlink:actuate">onLoad</xsl:attribute>
<xsl:attribute name="xlink:href"><xsl:value-of select="tei:graphic/@url"/></xsl:attribute>
<xsl:attribute name="xlink:show">embed</xsl:attribute>
<xsl:attribute name="xlink:title"><xsl:value-of select="tei:head"/></xsl:attribute>
<xsl:attribute name="xlink:type">simple</xsl:attribute>
</image>
</objetmedia>
<!-- </figure> -->
</xsl:template>

<xsl:template match="tei:graphic">
</xsl:template>

<!-- Tableaux -->

<xsl:template match="tei:table">
<tableau>
<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
<legende lang="fr"><xsl:apply-templates select="tei:head"/></legende>
<table>
<tgroup>
<xsl:attribute name="cols"><xsl:value-of select="@aid:tcols"/></xsl:attribute>
<tbody>
<xsl:apply-templates select="tei:row"/>
</tbody>
</tgroup>
</table>
</tableau>
</xsl:template>

<xsl:template match="tei:row">
<row><xsl:apply-templates/></row>
</xsl:template>

<xsl:template match="tei:cell">
<entry><xsl:apply-templates/></entry>
</xsl:template>

<xsl:template match="tei:p">
<xsl:choose>
<xsl:when test="local-name(parent::node())='tei:cell'">
<xsl:apply-templates/>
</xsl:when>
<xsl:when test="parent::tei:div[@type='chapitre']">
</xsl:when>
<xsl:when test="@aid:pstyle='auteur'">
</xsl:when>
<xsl:when test="@aid:pstyle='auteur_Institution'">
</xsl:when>
<xsl:when test="@aid:pstyle='T_2_Partie'">
</xsl:when>
<xsl:otherwise>
<para>
  <xsl:attribute name="id">pa<xsl:value-of select="count(preceding::tei:p|preceding::tei:quote|preceding::tei:list)"/></xsl:attribute>
<xsl:choose>
	<xsl:when test="@aid:pstyle='txt_Normal'">
		<alinea><xsl:apply-templates/></alinea>
	</xsl:when>
	<xsl:otherwise>
		<alinea><xsl:apply-templates/></alinea>
	</xsl:otherwise>
</xsl:choose>
</para>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:bibl">
</xsl:template>

<xsl:template match="tei:list">
<xsl:choose>
<xsl:when test="local-name(parent::node())='tei:cell'">
	<xsl:apply-templates/>
</xsl:when>
<xsl:otherwise>
<para>
<xsl:attribute name="id">pa<xsl:value-of select="count(preceding::tei:p|preceding::tei:quote|preceding::tei:list)"/></xsl:attribute>
<listenonord>
	<xsl:apply-templates/>
</listenonord>
</para>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:item">
<xsl:choose>
<xsl:when test="ancestor::tei:cell">
<xsl:apply-templates/>
</xsl:when>
<xsl:otherwise>
<elemliste><alinea><xsl:apply-templates/></alinea></elemliste>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:quote">
  <xsl:if test="not(parent::tei:div[@type='chapitre'])">
    <para><xsl:attribute name="id">pa<xsl:value-of select="count(preceding::tei:p|preceding::tei:quote|preceding::tei:list)"/></xsl:attribute>
    <bloccitation>
      <xsl:choose>
        <xsl:when test="child::tei:lb">
          <verbatim typeverb="forme">
            <bloc>
              <xsl:text disable-output-escaping="yes">&lt;</xsl:text>ligne<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
              <xsl:apply-templates/>
              <xsl:text disable-output-escaping="yes">&lt;</xsl:text>/ligne<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
            </bloc>
          </verbatim>
        </xsl:when>
        <xsl:otherwise>
          <alinea><xsl:apply-templates/></alinea>
        </xsl:otherwise>
      </xsl:choose>
    </bloccitation></para>      
  </xsl:if>
</xsl:template>

<xsl:template match="tei:p[@aid:pstyle='txt_Resume']">
</xsl:template>

<xsl:template match="tei:p[@aid:pstyle='txt_Resume_italique']">
</xsl:template>

<xsl:template name="resume">
<xsl:if test="@aid:pstyle='txt_Resume'">
	<resume lang="fr"><titre>Résumé</titre><alinea><xsl:apply-templates/></alinea></resume>
</xsl:if>
<xsl:if test="@aid:pstyle='txt_Resume_italique'">
	<resume lang="en"><titre>Abstract</titre><alinea><xsl:apply-templates/></alinea></resume>
</xsl:if>
</xsl:template>

<xsl:template match="tei:quote[@aid:pstyle='txt_Exemple']">
<exemple><xsl:attribute name="id">se<xsl:value-of select="count(preceding::tei:p|preceding::tei:quote|preceding::tei:list)"/></xsl:attribute><alinea><xsl:apply-templates/></alinea></exemple>
</xsl:template>

<xsl:template match="tei:note">
<xsl:variable name="nbNote"><xsl:value-of select="count(preceding::tei:note)+1"/></xsl:variable>
<renvoi><xsl:attribute name="id">re<xsl:value-of select="$nbNote"/>no<xsl:value-of select="$nbNote"/></xsl:attribute>
<xsl:attribute name="idref">no<xsl:value-of select="$nbNote"/></xsl:attribute>
<xsl:attribute name="typeref">note</xsl:attribute><xsl:value-of select="$nbNote"/></renvoi>
</xsl:template>

<xsl:template match="tei:hi[@rend='italic']">
<marquage typemarq="italique"><xsl:apply-templates/></marquage>
</xsl:template>

<xsl:template match="tei:hi[@aid:cstyle='typo_Exposant']">
<xsl:choose>
<xsl:when test="descendant::tei:note">
<xsl:apply-templates/>
</xsl:when>
<xsl:otherwise>
<exposant><xsl:apply-templates/></exposant>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:hi[@aid:cstyle='typo_Indice']">
<xsl:choose>
<xsl:when test="descendant::tei:note">
<xsl:apply-templates/>
</xsl:when>
<xsl:otherwise>
<indice><xsl:apply-templates/></indice>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:hi[@aid:cstyle='typo_Exposant_Italic']">
<xsl:choose>
<xsl:when test="descendant::tei:note">
<xsl:apply-templates/>
</xsl:when>
<xsl:otherwise>
<exposant><xsl:apply-templates/></exposant>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:hi[@aid:cstyle='typo_gras']">
<marquage typemarq="gras"><xsl:apply-templates/></marquage>
</xsl:template>

<xsl:template match="tei:hi[@aid:cstyle='typo_gras_italic']">
<marquage typemarq="gras"><marquage typemarq="italique"><xsl:apply-templates/></marquage></marquage>
</xsl:template>

<xsl:template match="tei:hi[@aid:cstyle='typo_Majuscule']">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:hi[@aid:cstyle='typo_SC']">
<marquage typemarq="petitecap"><xsl:apply-templates/></marquage>
</xsl:template>

<xsl:template match="tei:lb">
  <xsl:choose>
    <xsl:when test="../@aid:pstyle='txt_Citation'">
      <xsl:text disable-output-escaping="yes">&lt;</xsl:text>/ligne<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
      <xsl:text disable-output-escaping="yes">&lt;</xsl:text>ligne<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
