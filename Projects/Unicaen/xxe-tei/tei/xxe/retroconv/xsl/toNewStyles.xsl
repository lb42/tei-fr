<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT indd2tei
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

<xsl:strip-space elements="*"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:sourceDesc">
	<sourceDesc>
		<p>Version des outils : vers 1.0 (styles)</p>
		<p>Written by OpenOffice</p>
	</sourceDesc>
</xsl:template>

<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Normal']">
  <xsl:attribute name="aid:pstyle">Txt_Standard</xsl:attribute>
</xsl:template>
<xsl:template match="tei:head/@aid:pstyle[. =  'T_3_Article']">
  <xsl:attribute name="aid:pstyle">UnEdit_Titre</xsl:attribute>
</xsl:template>
<xsl:template match="tei:head/@aid:pstyle[. =  'T_1']">
  <xsl:attribute name="aid:pstyle">UnEdit_Subd_Titre_niv1</xsl:attribute>
</xsl:template>
<xsl:template match="tei:head/@aid:pstyle[. =  'T_2']">
  <xsl:attribute name="aid:pstyle">UnEdit_Subd_Titre_niv2</xsl:attribute>
</xsl:template>
<xsl:template match="tei:head/@aid:pstyle[. =  'T_3']">
  <xsl:attribute name="aid:pstyle">UnEdit_Subd_Titre_niv3</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'auteur']">
  <xsl:attribute name="aid:pstyle">Auteur</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Resume']">
  <xsl:attribute name="aid:pstyle">Resume</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Resume_italique']">
  <xsl:attribute name="aid:pstyle">Resume_langdif</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Motclef']">
  <xsl:attribute name="aid:pstyle">Motclef</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Keywords']">
  <xsl:attribute name="aid:pstyle">Motclef_langdif</xsl:attribute>
</xsl:template>
<xsl:template match="tei:head/@aid:pstyle[. =  'T_SousTitre']">
  <xsl:attribute name="aid:pstyle">UnEdit_Ss_Titre</xsl:attribute>
</xsl:template>
<xsl:template match="tei:head/@aid:pstyle[. =  'T_0_Article_UK']">
  <xsl:attribute name="aid:pstyle">UnEdit_Titre_trad</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'auteur_Institution']">
  <xsl:attribute name="aid:pstyle">Auteur_Institution</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'auteur_adresse']">
  <xsl:attribute name="aid:pstyle">Auteur_Adresse</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'auteur_Courriel']">
  <xsl:attribute name="aid:pstyle">Auteur_Courriel</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_remerciements']">
  <xsl:attribute name="aid:pstyle">Txt_Remerciements</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Epigraphe']">
  <xsl:attribute name="aid:pstyle">Txt_Epigraphe</xsl:attribute>
</xsl:template>
<xsl:template match="tei:quote/@aid:pstyle[. =  'txt_Citation']">
  <xsl:attribute name="aid:pstyle">Txt_Cit</xsl:attribute>
</xsl:template>
<xsl:template match="tei:quote/@aid:pstyle[. =  'txt_Citation_italique']">
  <xsl:attribute name="aid:pstyle">Txt_Cit_langdif</xsl:attribute>
</xsl:template>
<xsl:template match="tei:head/@aid:pstyle[. =  'titre_figure']">
  <xsl:attribute name="aid:pstyle">Fig_Titre</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Legende']">
  <xsl:attribute name="aid:pstyle">Fig_Legende</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_question']">
  <xsl:attribute name="aid:pstyle">Txt_Question</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_reponse']">
  <xsl:attribute name="aid:pstyle">Txt_Reponse</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_code']">
  <xsl:attribute name="aid:pstyle">Txt_Code_inf</xsl:attribute>
</xsl:template>
<xsl:template match="tei:quote/@aid:pstyle[. =  'txt_Exemple']">
  <xsl:attribute name="aid:pstyle">Txt_Exemple</xsl:attribute>
</xsl:template>
<xsl:template match="tei:bibl/@aid:pstyle[. =  'txt_Biblio']">
  <xsl:attribute name="aid:pstyle">Txt_Ref_Bibl</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Normal_inv']">
  <xsl:attribute name="aid:pstyle">Txt_Standard_inv</xsl:attribute>
</xsl:template>
<xsl:template match="tei:note/@aid:pstyle[. =  'txt_Citation_inv']">
  <xsl:attribute name="aid:pstyle">Txt_Cit_inv</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Note_inv']">
  <xsl:attribute name="aid:pstyle">Txt_Note_inv</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_Legende_tableau']">
  <xsl:attribute name="aid:pstyle">Fig_Legende</xsl:attribute>
</xsl:template>
<xsl:template match="tei:note/@aid:pstyle[. =  'txt_Note']">
  <xsl:attribute name="aid:pstyle">Txt_Note</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'txt_separateur']">
  <xsl:attribute name="aid:pstyle">Txt_Separateur</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'review-title']">
  <xsl:attribute name="aid:pstyle">Recension_Titre</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'review-author']">
  <xsl:attribute name="aid:pstyle">Recension_auteur</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'review-bibliography']">
  <xsl:attribute name="aid:pstyle">Recension_ref_Bibl</xsl:attribute>
</xsl:template>
<xsl:template match="tei:p/@aid:pstyle[. =  'review-date']">
  <xsl:attribute name="aid:pstyle">Recension_Date</xsl:attribute>
</xsl:template>


</xsl:stylesheet>
