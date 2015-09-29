<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT TEI to ONIX
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
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://ns.editeur.org/onix/3.0/reference"
		xmlns:xi="http://www.w3.org/2001/XInclude"
		xsi:schemaLocation="http://ns.editeur.org/onix/3.0/reference"
	   	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="tei xhtml xsi">

<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<TEI xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/" xmlns:aid5="http://ns.adobe.com/AdobeInDesign/5.0/" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns="http://www.tei-c.org/ns/1.0">
			<teiHeader>
				<fileDesc>
					<titleStmt>
						<xsl:call-template name="titre"/>
						<xsl:call-template name="editeurs"/>
						<xsl:call-template name="auteurs"/>
					</titleStmt>
					<editionStmt>
						<xsl:call-template name="editeurMat"/>
					</editionStmt>
					<publicationStmt>
						<xsl:call-template name="publicationStmt"/>
					</publicationStmt>
					<sourceDesc>
						<xsl:call-template name="source"/>
					</sourceDesc>
				</fileDesc>
				<profileDesc>
					<xsl:call-template name="langue"/>
					<xsl:call-template name="motscles"/>
					<xsl:call-template name="resumes"/>
				</profileDesc>
			</teiHeader>
			<text>
				<front>
				</front>
				<group>
					<xsl:call-template name="tdm"/>
				</group>
				<back>
				</back>
			</text>
	</TEI>
</xsl:template>

<xsl:template name="titre">
	<tei:title type="main">
		<xsl:value-of select="//TitleText"/>
	</tei:title>
	<xsl:if test="//Subtitle">
		<tei:title type="sub">
			<xsl:value-of select="//Subtitle"/>
		</tei:title>
	</xsl:if>
	<xsl:if test="//Collection/descendant::TitleText">
		<tei:title type="collection">
			<xsl:value-of select="//Collection/descendant::TitleText"/>
		</tei:title>
	</xsl:if>
</xsl:template>

<xsl:template name="editeurs">
	<xsl:for-each select="//Contributor[child::ContributorRole='B01']">
		<tei:editor>
			<xsl:attribute name="n" select="SequenceNumber"/>
			<tei:name>
				<xsl:value-of select="NamesBeforeKey"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="KeyNames"/>
			</tei:name>
			<xsl:if test="BiographicalNote">
				<tei:note>
					<xsl:value-of select="BiographicalNote/p"/>
				</tei:note>
			</xsl:if>
		</tei:editor>
	</xsl:for-each>
</xsl:template>

<xsl:template name="auteurs">
	<xsl:for-each select="//Contributor[child::ContributorRole='A02']">
		<tei:author>
			<xsl:attribute name="n" select="SequenceNumber"/>
			<tei:name>
				<xsl:value-of select="NamesBeforeKey"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="KeyNames"/>
			</tei:name>
			<xsl:if test="BiographicalNote">
				<tei:note>
					<xsl:value-of select="BiographicalNote/p"/>
				</tei:note>
			</xsl:if>
		</tei:author>
	</xsl:for-each>
</xsl:template>

<xsl:template name="editeurMat">
	<tei:editor>
		<tei:name>
			<xsl:value-of select="//SenderName"/>
		</tei:name>
	</tei:editor>
</xsl:template>

<xsl:template name="source">
	<tei:p>
		<xsl:text>création du book à partir d'une fiche onix (éditeur)</xsl:text>
	</tei:p>
	<tei:p>
		<xsl:text>Date fiche Onix : </xsl:text><xsl:value-of select="//SentDateTime"/>
	</tei:p>
</xsl:template>

<xsl:template name="langue">
	<tei:langUsage>
		<tei:language ident="##">
			<xsl:value-of select="substring(//DefaultLanguageOfText,1,2)"/>
		</tei:language>
	</tei:langUsage>
</xsl:template>

<xsl:template name="publicationStmt">
	<tei:ab type="papier">
		<tei:bibl>
			<tei:biblScope type="pp">
				<xsl:value-of select="//Extent[child::ExtentUnit='03']/ExtentValue"/>
			</tei:biblScope>
		</tei:bibl>
		<tei:idno type="ISBN-13">
			<xsl:value-of select="//ProductIdentifier[child::ProductIDType='15']/IDValue"/>
		</tei:idno>
		<tei:idno type="EAN">
			<xsl:value-of select="//ProductIdentifier[child::ProductIDType='03']/IDValue"/>
		</tei:idno>
		<tei:dimensions>
			<tei:width></tei:width>
			<tei:height></tei:height>
			<tei:depth></tei:depth>
		</tei:dimensions>
		<tei:date type="publication">
			<xsl:value-of select="//PublishingDate[child::PublishingDateRole='01']/Date"/>
		</tei:date>
		<tei:idno type="price">
			<xsl:value-of select="//PriceAmount"/><xsl:value-of select="//CurrencyCode"/>
		</tei:idno>
		<tei:name type="diffuseur">
			<xsl:value-of select="//SupplierName"/>
		</tei:name>
		<tei:name type="distributeur">
			<xsl:value-of select="//SupplierName[parent::Supplier[child::SupplierRole='06']]"/>
		</tei:name>
	</tei:ab>
	<tei:ab type="pdf">
		<tei:dimensions>
			<xsl:if test="//Extent[child::ExtentUnit='18']">
				<xsl:attribute name="unit"><xsl:text>Kbytes</xsl:text></xsl:attribute>
			</xsl:if>
			<xsl:value-of select="//Extent[child::ExtentUnit='18']/ExtentValue"/>
		</tei:dimensions>
	</tei:ab>
	<tei:ab type="epub">
	</tei:ab>
</xsl:template>

<xsl:template name="motscles">
	<tei:textClass>
		<tei:keywords scheme="keywords">
			<tei:list>
				<xsl:for-each select="//SubjectHeadingText">
					<tei:item>
						<xsl:value-of select="."/>
					</tei:item>
				</xsl:for-each>
			</tei:list>
		</tei:keywords>
	</tei:textClass>
</xsl:template>

<xsl:template name="resumes">
	<tei:abstract>
		<tei:p>
			<xsl:value-of select="//Text[parent::TextContent[child::TextType='03']]"/>
		</tei:p>
	</tei:abstract>
</xsl:template>

<xsl:template name="tdm">
	<xsl:for-each select="//TextContent[child::TextType='04']//p">
		<tei:group>
			<xi:include xpointer="text" href="??">
			</xi:include>
			<tei:byline>
				<xsl:value-of select="strong"/>
			</tei:byline>
		</tei:group>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
