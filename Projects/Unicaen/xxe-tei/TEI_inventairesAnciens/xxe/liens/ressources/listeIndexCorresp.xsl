<?xml version="1.0" encoding="UTF-8"?>
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

<xsl:param name="typeIndex" />


<xsl:template match="/">
<xsl:text>(-- Nouvelle entrée --)</xsl:text><xsl:text>
</xsl:text>?<xsl:text>
</xsl:text>
<xsl:choose>
<!-- appel du template en fonction du paramètre passé pour créer la liste dans un fichier txt -->
	<xsl:when test="$typeIndex='Auteur'">
		<xsl:for-each select="//tei:bibl/tei:name[@role='auteur']">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Titre'">
		<xsl:for-each select="//tei:bibl/tei:title">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Resp'">
		<xsl:for-each select="//tei:editor">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='PbEd'">
		<xsl:for-each select="//tei:msDesc[@type='source']">
			<xsl:value-of select="."/><xsl:text> - </xsl:text><xsl:apply-templates select="//tei:biblStruct"/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='MsEd'">
		<xsl:for-each select="//tei:msDesc[@type='source_ms_edition']">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Langue'">
		<xsl:for-each select="document('../personne_titre_date/indexLangues.xml')//tei:listNym/tei:nym[@type='langue']">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Item'">
		<xsl:for-each select="//tei:item">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='HandNote'">
		<xsl:for-each select="//tei:handNote">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='EntreeIndex'">
		<xsl:for-each select="//tei:item">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Witness'">
		<xsl:for-each select="//tei:witness">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Resp_ancien'">
		<xsl:for-each select="//tei:author">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Add'">
		<xsl:for-each select="//tei:add">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	
	<xsl:when test="$typeIndex='Mod'">
		<xsl:for-each select="//tei:mod">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Del'">
		<xsl:for-each select="//tei:del">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
	<xsl:when test="$typeIndex='Date'">
		<xsl:for-each select="//tei:date">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:when>
</xsl:choose>
</xsl:template>

	
	<xsl:template match="tei:bibl/tei:name[@type='personne']">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:bibl/tei:title">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:editor">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:msDesc[@type='source']">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="tei:biblStruct">
<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:msDesc[@type='source_ms_edition']">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="tei:language">
		<xsl:value-of select="."/> • <xsl:value-of select="@ident"/><xsl:text>
</xsl:text><xsl:value-of select="@ident"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:item">
		<xsl:value-of select="substring(.,1,30)"/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:handNote">
<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="tei:witness">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:author">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:add">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="tei:mod">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:del">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	<xsl:template match="tei:date">
		<xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
	</xsl:template>
	
<xsl:template match="tei:nym[@type='langue']">
	<xsl:for-each select="tei:nym"><xsl:value-of select="."/> • <xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>
</xsl:text>
</xsl:for-each>
	</xsl:template>

	<xsl:template match="tei:msIdentifier">
	<xsl:for-each select="node()">	
	<xsl:apply-templates /><xsl:text> </xsl:text>
	</xsl:for-each>• <xsl:value-of select="parent::tei:msDesc/@xml:id"/><xsl:text>
</xsl:text><xsl:value-of select="parent::tei:msDesc/@xml:id"/>
	</xsl:template>
	
</xsl:stylesheet>