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
		xsi:schemaLocation="http://ns.editeur.org/onix/3.0/reference"
	   	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="tei xhtml xsi">

<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<!--xsl:link type="text/css" rel="stylesheet" href="css/onix_form.css"/-->
	<!--xsl:processing-instruction name="xml-stylesheet">
		<xsl:text>type="text/css"</xsl:text>
		<xsl:text>href="XSD/onix.css"</xsl:text>
	</xsl:processing-instruction-->
	<ONIXMessage>
		<!--xsl:attribute name="release">
			<xsl:text>3.0</xsl:text>
		</xsl:attribute-->
		<xsl:attribute name="xsi:schemaLocation">
			<xsl:text>http://ns.editeur.org/onix/3.0/reference http://www.unicaen.fr/mrsh/pddn/schemas/onix_opentools/XSD/ONIX_BookProduct_3.0_reference.xsd</xsl:text>
		</xsl:attribute>
		<xsl:call-template name="Header"/>
		<xsl:for-each select="//tei:ab">
			<xsl:call-template name="Product"/>
		</xsl:for-each>
	</ONIXMessage>
</xsl:template>

<xsl:template name="Header">
	<Header>
		<Sender>
			<SenderName>
				<xsl:value-of select="//tei:editor/tei:name"/>	
			</SenderName>
			<EmailAddress></EmailAddress>
		</Sender>
		<SentDateTime>
			<xsl:value-of select="format-date(current-date(),'[Y0001][M01][D01]')"/>	
		</SentDateTime>
	</Header>
</xsl:template>

<xsl:template name="Product">
	<Product>
		<RecordReference>
		</RecordReference>
		<NotificationType>
		</NotificationType>
		<ProductIdentifier>
		</ProductIdentifier>
		<DescriptiveDetail>
			<!-- ProductComposition, ProductForm, ProductFormDetail, PrimaryContentType, (ProductPart, Collection), (EpubTechnicalProtection, EpubUsageConstraint) -->
			<xsl:call-template name="TitleDetail"/>
			<xsl:call-template name="Contributor"/>
			<xsl:call-template name="Language"/>
			<xsl:call-template name="Extent"/>
			<xsl:call-template name="Subject"/>
			<xsl:call-template name="Audience"/>
		</DescriptiveDetail>
		<PublishingDetail>
		</PublishingDetail>
		<ProductSupply>
			<xsl:call-template name="SupplyDetail"/>
		</ProductSupply>
	</Product>
</xsl:template>

<xsl:template name="SupplyDetail">
	<SupplyDetail>
		<Supplier>
			<SupplierRole><xsl:value-of select="tei:name[starts-with(@type,'di')]/@type"/>	</SupplierRole>
			<SupplierName><xsl:value-of select="tei:name[starts-with(@type,'di')]"/>	</SupplierName>
		</Supplier>
		<ProductAvailability>
		</ProductAvailability>
		<Price>
			<PriceType></PriceType>
			<PriceAmount>
				<xsl:value-of select="tei:idno[@type='price']"/>
			</PriceAmount>
			<CurrencyCode>EUR</CurrencyCode>
		</Price>
	</SupplyDetail>
</xsl:template>

<xsl:template name="TitleDetail">
	<TitleDetail>
		<TitleType><xsl:text>01</xsl:text></TitleType>
		<TitleElement>
			<TitleElementLevel><xsl:text>01</xsl:text></TitleElementLevel>
			<TitleText>
				<xsl:value-of select="//tei:title[@type='main']"/>
			</TitleText>
		</TitleElement>
	<!-- sous-titre -->
	<xsl:if test="//tei:title[@type='sub']">
		<TitleElement>
			<TitleElementLevel><xsl:text>01</xsl:text></TitleElementLevel>
			<TitleText>
				<xsl:value-of select="//tei:title[@type='sub']"/>
			</TitleText>
		</TitleElement>
	</xsl:if>
	<!-- complément du titre -->
	<xsl:if test="//tei:title[@type='compl']">
		<TitleElement>
			<TitleElementLevel><xsl:text>01</xsl:text></TitleElementLevel>
			<TitleText>
				<xsl:value-of select="//tei:title[@type='compl']"/>
			</TitleText>
		</TitleElement>
	</xsl:if>
	</TitleDetail>
	<!-- titre en langue étrangère -->
	<xsl:if test="//tei:title[@type='alt']">
	<TitleDetail>
		<TitleType><xsl:text>06</xsl:text></TitleType>
		<TitleElement>
			<TitleElementLevel><xsl:text>01</xsl:text></TitleElementLevel>
			<TitleText>
				<xsl:value-of select="//tei:title[@type='alt']"/>
			</TitleText>
		</TitleElement>
	</TitleDetail>
	</xsl:if>
	<!-- titre en langue originale -->
	<xsl:if test="//tei:title[@type='orig']">
	<TitleDetail>
		<TitleType><xsl:text>03</xsl:text></TitleType>
		<TitleElement>
			<TitleElementLevel><xsl:text>01</xsl:text></TitleElementLevel>
			<TitleText>
				<xsl:value-of select="//tei:title[@type='orig']"/>
			</TitleText>
		</TitleElement>
	</TitleDetail>
	</xsl:if>	
 	<!-- titre de la collection -->
	<xsl:if test="//tei:title[@type='collection']">
	<TitleDetail>
		<TitleType><xsl:text>??</xsl:text></TitleType>
		<TitleElement>
			<TitleElementLevel><xsl:text>02</xsl:text></TitleElementLevel>
			<TitleText>
				<xsl:value-of select="//tei:title[@type='collection']"/>
			</TitleText>
		</TitleElement>
	</TitleDetail>
	</xsl:if>
</xsl:template>

<xsl:template name="Contributor">
	<xsl:for-each select="//tei:author">
<xsl:variable name="firstName" select="substring-before(.,' ')"/>
<xsl:variable name="lastName" select="substring-after(.,' ')"/>
	<Contributor>
		<SequenceNumber>
			<xsl:value-of select="@n"/>
		</SequenceNumber>
		<ContributorRole>A01</ContributorRole>
		<PersonName>
			<xsl:value-of select="."/>
		</PersonName>
		<PersonNameInverted>
			<xsl:value-of select="concat($lastName,', ',$firstName)"/>
		</PersonNameInverted>
		<NamesBeforeKey>
			<xsl:value-of select="$firstName"/>
		</NamesBeforeKey>
		<KeyNames>
			<xsl:value-of select="$lastName"/>
		</KeyNames>
	</Contributor>
	</xsl:for-each>
</xsl:template>

<xsl:template name="Language">
	<Language>
		<LanguageRole><xsl:text>01</xsl:text></LanguageRole>
		<LanguageCode>
			<xsl:if test="//tei:language='fr'">
				<xsl:text>fre</xsl:text>
			</xsl:if>
			<xsl:if test="//tei:language!='fr'">
				<xsl:text>??</xsl:text>
			</xsl:if>
		</LanguageCode>
	</Language>
</xsl:template>

<xsl:template name="Extent">
	<Extent>
		<xsl:choose>
		<!--xsl:when test="tei:biblScope[@type='pp']">
			<ExtentType>08</ExtentType>
			<ExtentValue>
				<xsl:value-of select="tei:biblScope[@type='pp']"/>
			</ExtentValue>
			<ExtentUnit>
				<xsl:text>03</xsl:text>
			</ExtentUnit>
		</xsl:when-->
		<xsl:when test="tei:dimensions[@unit='kB']">
			<ExtentType>??</ExtentType>
			<ExtentValue>
				<xsl:value-of select="tei:dimensions[@unit='kB']"/>
			</ExtentValue>
			<ExtentUnit>
				<xsl:text>18</xsl:text>
			</ExtentUnit>
		</xsl:when>
		</xsl:choose>
	</Extent>
</xsl:template>

<xsl:template name="Subject">
	<Subject>
		<SubjectSchemeIdentifier>
			<xsl:text>20</xsl:text>
		</SubjectSchemeIdentifier>
		<xsl:for-each select="//tei:list[1]">
		<SubjectHeadingText>
		<xsl:for-each select="tei:item">
   			<xsl:value-of select="."/>
   			<xsl:if test="position() != last()">
    			<xsl:text>, </xsl:text>
   			</xsl:if>
   		</xsl:for-each>
		</SubjectHeadingText>
		</xsl:for-each>
	</Subject>
</xsl:template>

<xsl:template name="Audience">
	<Audience>
		<AudienceCodeType>
			<xsl:text>01</xsl:text>
		</AudienceCodeType>
		<AudienceCodeValue>
			<xsl:text>05</xsl:text>
		</AudienceCodeValue>
	</Audience>
</xsl:template>

</xsl:stylesheet>
