<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT 
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
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"	
		xmlns:xinclude="http://www.w3.org/2001/XInclude"
		xmlns:xlink="http://www.w3.org/1999/xlink"
		xmlns:mets="http://www.loc.gov/METS/" 
   		xmlns:marcrel="http://www.loc.gov/loc.terms/relators"
   		xmlns:mods="http://www.loc.gov/mods/v3"
		exclude-result-prefixes="tei xhtml"
>

<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:param name="fileUrl"/>
<xsl:variable name="md5Place" select="string(concat($fileUrl,'/md5.xml'))"/>
<xsl:variable name="md5list" select="document($md5Place)//files"/>
<xsl:strip-space elements="*"/>

<xsl:variable name="filename" select="substring-before((tokenize(base-uri(.),'/')[last()]),'.')"/>
<xsl:variable name="nbOfBody">
	<xsl:number count="tei:body" format="1" from="/" level="any"/>
</xsl:variable>

<xsl:variable name="volType" select="//tei:text[@xml:id='book']/@type"/>

<xsl:template match="/">
<mets:mets>
	<xsl:call-template name="dmdSecbook"/>
	<xsl:call-template name="dmdSecpart"/>
	<xsl:call-template name="fileSecTEI"/>
	<xsl:call-template name="structMap"/>
</mets:mets>
</xsl:template>

<xsl:template name="dmdSecbook" match="tei:teiHeader/tei:fileDesc">
	<mets:dmdSec ADMID="amdbook">
	<xsl:attribute name="ID">
		<xsl:value-of select="$filename"/>
	</xsl:attribute>
		<mets:mdWrap MDTYPE="MODS" MIMETYPE="text/xml">
			<mets:xmlData>
        		<mods:titleInfo>
          			<mods:title>
          				<xsl:value-of select="//tei:titleStmt/tei:title[@type='main']"/>
          			</mods:title>
          				<xsl:if test="//tei:titleStmt/tei:title[@type!='main']">
          					<mods:subTitle>
          						<xsl:value-of select="//tei:titleStmt/tei:title[@type!='main']"/>
          					</mods:subTitle>
          				</xsl:if>
          		</mods:titleInfo>
          		<xsl:if test="//tei:publicationStmt/tei:ab/tei:idno[@type='ISBN-10']">
          		<mods:identifier type="isbn">
          			<xsl:value-of select="//tei:publicationStmt/tei:ab/tei:idno[@type='ISBN-10']"/>
          		</mods:identifier>
          		</xsl:if>
          		<xsl:if test="//tei:publicationStmt/tei:ab/tei:idno[@type='ISBN-13']">
          		<mods:identifier type="isbn">
          			<xsl:value-of select="//tei:publicationStmt/tei:ab/tei:idno[@type='ISBN-13']"/>
          		</mods:identifier>
          		</xsl:if>
          		<mods:originInfo>
          			<mods:publisher>
          				<xsl:value-of select="//tei:editionStmt/tei:editor/tei:name"/>
          			</mods:publisher>
          			<mods:dateIssued encoding="w3cdtf">
          				<xsl:value-of select="substring-before(//tei:editionStmt/tei:edition/tei:date,'-')"/>
          			</mods:dateIssued>
          		</mods:originInfo>
          		<xsl:for-each select="//tei:author">
          		<mods:name type="personal">
          			<xsl:call-template name="author"/>
          			<mods:role>
          				<mods:roleTerm authority="marcrelator" type="text">
          				<!--xsl:value-of select="//tei:titleStmt/tei:author/@role"/-->
          					<xsl:text>author</xsl:text>
          				</mods:roleTerm>
          			</mods:role>
          		</mods:name>
          		</xsl:for-each>
          		<!--xsl:if test="//tei:publicationStmt/tei:ab[@type='papier']/tei:bibl/tei:biblScope[@type='pp'] != ''"-->
          		<!--xsl:if test="//tei:titleStmt/tei:title[@type='collection']/@n != ''"-->
          		<mods:part>
          			<xsl:if test="//tei:publicationStmt/tei:ab[@type='papier']/tei:bibl/tei:biblScope[@type='pp'] != ''">
          			<mods:extent>
          				<mods:total>
          					<xsl:value-of select="//tei:publicationStmt/tei:ab[@type='papier']/tei:bibl/tei:biblScope[@type='pp']"/>
          				</mods:total>
          			</mods:extent>
          			</xsl:if>
          			<xsl:if test="//tei:titleStmt/tei:title[@type='collection']/@n != ''">
          			<mods:detail>
          				<mods:number>
          					<xsl:value-of select="//tei:titleStmt/tei:title[@type='collection']/@n"/>
          				</mods:number>
          			</mods:detail>
          			</xsl:if>
          		</mods:part>
          		<!--/xsl:if-->
          		<mods:abstract xml:lang="fr">
          			<xsl:value-of select="//tei:profileDesc/tei:abstract[@rend='4e-couv']"/>
          		</mods:abstract>
          		<!--mods:abstract>
          			<xsl:attribute name="xml:lang" select="//tei:profileDesc/tei:abstract[@rend='abstract']/@xml:lang"/>
          			<xsl:value-of select="//tei:profileDesc/tei:abstract[@rend='abstract']"/>
          		</mods:abstract-->
          		<xsl:if test="//tei:publicationStmt/tei:availability/tei:licence">
          		<mods:accessCondition>
          			<xsl:value-of select="//tei:publicationStmt/tei:availability/tei:licence"/>         		
          		</mods:accessCondition>
          		</xsl:if>
<xsl:call-template name="langNsubject"/>          		
			</mets:xmlData>
		</mets:mdWrap>
	</mets:dmdSec>
</xsl:template>

<xsl:template name="author">
	<mods:namePart type="given">
		<xsl:value-of select="substring-before(.,' ')"/>
	</mods:namePart> 
	<mods:namePart type="family">
		<xsl:value-of select="substring-after(.,' ')"/>
	</mods:namePart> 
</xsl:template>

<xsl:template name="langNsubject" match="tei:teiHeader/tei:profileDesc">
	<mods:language usage="primary">
		<mods:languageTerm type="code" authority="iso639-2b">
			<xsl:value-of select="//tei:langUsage/tei:language"/>
		</mods:languageTerm>
	</mods:language>
<xsl:if test="//tei:keywords[@xml:lang!='fr']">
	<mods:language>
		<mods:languageTerm type="code" authority="iso639-2b">
			<xsl:value-of select="//tei:keywords[2]/@xml:lang"/>
		</mods:languageTerm>
	</mods:language>
</xsl:if>
<xsl:for-each select="//tei:textClass/tei:keywords">
<!--xsl:variable name="schemKeyw" select="@scheme"/-->
	<mods:subject authority="motsclesfr" xml:lang="fr">
		<!--xsl:attribute name="authority" select="$schemKeyw"/-->
		<!--xsl:for-each select="//tei:textClass/tei:keywords[@scheme=$schemKeyw]/tei:list/tei:item"-->
		<xsl:for-each select="//tei:textClass/tei:keywords[@xml:lang='fr']/tei:list/tei:item">
			<mods:topic>
				<xsl:apply-templates/>
			</mods:topic>
		</xsl:for-each>
	</mods:subject>
</xsl:for-each>
</xsl:template>

<xsl:template name="dmdSecpart" match="tei:text">
	<xsl:if test="//tei:div[starts-with(@xml:id,'limin')]">
		<mets:dmdSec>
			<xsl:attribute name="ID" select="concat($filename,'-prelim_',$filename)"/>
		</mets:dmdSec>
	</xsl:if>
	<xsl:if test="//tei:body">
		<xsl:for-each select="//tei:body">
<xsl:variable name="prelimpartnum">
	<xsl:number count="tei:body" format="1" from="/" level="any"/>
</xsl:variable>	
		<mets:dmdSec>
			<xsl:attribute name="ID" select="concat($filename,'-prelim_part_',$prelimpartnum)"/>
		</mets:dmdSec>
		</xsl:for-each>
	</xsl:if> 
	<xsl:for-each select="//xinclude:include">
		<mets:dmdSec>
			<xsl:attribute name="ID" select="concat($filename,'-',substring-before(@href,'.'))"/>
		</mets:dmdSec>
	</xsl:for-each>
	<xsl:for-each select="//tei:group[@type='section1']">
	<xsl:variable name="section1count">
		<xsl:number count="//tei:group[@type='section1']"/>
	</xsl:variable>
		<mets:dmdSec>
			<xsl:attribute name="ID" select="concat($filename,'-section',$section1count)"/>
			<mets:mdWrap MDTYPE="MODS" MIMETYPE="text/xml">
				<mets:xmlData>
					<mods:titleInfo>
						<mods:title>
							<xsl:value-of select="tei:head"/>
						</mods:title>
					</mods:titleInfo>					
				</mets:xmlData>				
			</mets:mdWrap>
		</mets:dmdSec>
	</xsl:for-each>
	<xsl:choose>
	<xsl:when test="$volType = 'livre'">
	<mets:dmdSec>
		<xsl:attribute name="ID" select="concat($filename,'_imgcouv01')"/>
		<mets:mdWrap MDTYPE="MODS" MIMETYPE="text/xml">
			<mets:xmlData>
				<mods:titleInfo>
					<mods:title>Image de couverture</mods:title>
				</mods:titleInfo>
			</mets:xmlData>
		</mets:mdWrap>
	</mets:dmdSec>
	</xsl:when>
	<xsl:otherwise>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="fileSecTEI" match="xinclude:include">
	<mets:fileSec>
      <mets:fileGrp ID="tei_files">
      <xsl:if test="//tei:div[starts-with(@xml:id,'limin')]">
      			<mets:file MIMETYPE="text/xml">
					<xsl:attribute name="GROUPID">
						<xsl:value-of select="concat($filename,'-prelim_',$filename)"/>
					</xsl:attribute>
					<xsl:attribute name="ID">
						<xsl:value-of select="concat($filename,'-teiprelim_',$filename)"/>
					</xsl:attribute>
          			<mets:FLocat LOCTYPE="URL">
          				<xsl:attribute name="xlink:href">
          					<xsl:value-of select="concat('sources/prelim_',$filename,'.xml')"/>
          				</xsl:attribute>
          			</mets:FLocat>
       			 </mets:file>
      	</xsl:if>
      <xsl:if test="//tei:body">
		<xsl:for-each select="//tei:body">
<xsl:variable name="prelimpartnum">
	<xsl:number count="tei:body" format="1" from="/" level="any"/>
</xsl:variable>	
			<mets:file MIMETYPE="text/xml">
			<xsl:attribute name="GROUPID">
				<xsl:value-of select="concat($filename,'-prelim_part_',$prelimpartnum)"/>
			</xsl:attribute>
			<xsl:attribute name="ID">
				<xsl:value-of select="concat($filename,'-teiprelim_part_',$prelimpartnum)"/>
			</xsl:attribute>
          		<mets:FLocat LOCTYPE="URL">
          			<xsl:attribute name="xlink:href">
          				<xsl:value-of select="concat('sources/prelim_part_',$prelimpartnum,'.xml')"/>
          			</xsl:attribute>
          		</mets:FLocat>
       		</mets:file>
		</xsl:for-each>
		</xsl:if> 
      	<xsl:for-each select="//xinclude:include">
      	<xsl:variable name="includeHref" select="@href"/>
      			 <mets:file MIMETYPE="text/xml">
      			 	<!--xsl:attribute name="CHECKSUM">
      					<xsl:for-each select="$md5list/file"-->
      				<!--	grou = <xsl:value-of select="substring-after(@name,'sources/')"/> plop= <xsl:value-of select="$includeHref"/>-->
      						<!--xsl:if test="substring-after(@name,'sources/') = $includeHref"><xsl:value-of select="."/></xsl:if>
      			 		</xsl:for-each>
      			 	</xsl:attribute-->
					<xsl:attribute name="GROUPID">
						<xsl:value-of select="concat($filename,'-',substring-before(@href,'.'))"/>
					</xsl:attribute>
					<xsl:attribute name="ID">
						<xsl:value-of select="concat($filename,'-tei',substring-before(@href,'.'))"/>
					</xsl:attribute>
          			<mets:FLocat LOCTYPE="URL">
          				<xsl:attribute name="xlink:href">
          					<xsl:value-of select="concat('sources/',@href)"/>
          				</xsl:attribute>
          			</mets:FLocat>
       			 </mets:file>
      		</xsl:for-each>
      	<!--	<xsl:if test="//tei:body">
      			<xsl:for-each select="//tei:body">
      				<mets:file MIMETYPE="text/xml">
					<xsl:attribute name="GROUPID">
						<xsl:value-of select="concat('prelimPart_1_',$filename)"/>
					</xsl:attribute>
					<xsl:attribute name="ID">
						<xsl:value-of select="concat('teiprelimPart1_',$filename)"/>
					</xsl:attribute>
          			<mets:FLocat LOCTYPE="URL">
          				<xsl:attribute name="xlink:href">
          					<xsl:value-of select="concat('sources/','prelim_',$filename,'.xml')"/>
          				</xsl:attribute>
          			</mets:FLocat>
       			 </mets:file>
      			</xsl:for-each>
      		</xsl:if>-->
      </mets:fileGrp>
      <xsl:call-template name="imgGroup"/>
      <!--xsl:call-template name="fileSecPDF"/-->      
    </mets:fileSec>
</xsl:template>

<xsl:template name="imgGroup">
	<mets:fileGrp ID="img_files">
		<mets:file MIMETYPE="image/jpg">
			<xsl:attribute name="GROUPID">
				<xsl:value-of select="concat($filename,'-img01.jpg')"/>
			</xsl:attribute>
			<xsl:attribute name="ID">
				<xsl:value-of select="concat($filename,'-img01')"/>
			</xsl:attribute>
          	<mets:FLocat LOCTYPE="URL">
          		<xsl:attribute name="xlink:href">
          			<xsl:value-of select="concat('files/','cover.jpg')"/>
          		</xsl:attribute>
          	</mets:FLocat>
		</mets:file>
	</mets:fileGrp>
</xsl:template>

<!--xsl:template name="fileSecPDF" match="xinclude:include">
	<mets:fileGrp ID="pdf_files">
		<xsl:for-each select="//xinclude:include">
			<mets:file MIMETYPE="application/pdf" CHECKSUMTYPE="MD5">
				<xsl:attribute name="CHECKSUM">
				</xsl:attribute>
				<xsl:attribute name="GROUPID">
						<xsl:value-of select="concat($filename,'-',substring-before(@href,'.'))"/>
				</xsl:attribute>
				<xsl:attribute name="ID">
					<xsl:value-of select="concat($filename,'-pdf',substring-before(@href,'.'))"/>
				</xsl:attribute>
				<mets:FLocat LOCTYPE="URL">
					<xsl:attribute name="xlink:href">
						<xsl:value-of select="concat('sources/',substring-before(@href,'.'),'.pdf')"/>
					</xsl:attribute>
				</mets:FLocat>
			</mets:file>
		</xsl:for-each>
	</mets:fileGrp>
</xsl:template-->

<xsl:template name="structMap" match="tei:group">
<xsl:variable name="filename" select="substring-before((tokenize(base-uri(.),'/')[last()]),'.')"/>
	<mets:structMap>
		<mets:div>
			<xsl:attribute name="TYPE" select="$volType"/>
			<xsl:attribute name="DMDID" select="$filename"/>
			<xsl:if test="//tei:div[starts-with(@xml:id,'limin')]">
				<xsl:choose>
				<xsl:when test="$volType = 'numero' ">
					<mets:div>
						<!--xsl:attribute name="ORDER" select="$fileNum"/-->
						<xsl:attribute name="DMDID" select="concat($filename,'-prelim_',$filename)"/>
						<xsl:attribute name="TYPE"><xsl:text>editorial</xsl:text></xsl:attribute>	
						<xsl:attribute name="LABEL"><xsl:text>editorial</xsl:text></xsl:attribute>						
						<mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-teiprelim_',$filename)"/>
						</mets:fptr>
						<!--mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-pdf',substring-before(@href,'.'))"/>
						</mets:fptr-->
				</mets:div>
				</xsl:when>
				<xsl:otherwise>
				<mets:div>
						<!--xsl:attribute name="ORDER" select="$fileNum"/-->
						<xsl:attribute name="DMDID" select="concat($filename,'-prelim_',$filename)"/>
						<xsl:attribute name="TYPE"><xsl:text>pageliminaire</xsl:text></xsl:attribute>	
						<xsl:attribute name="LABEL"><xsl:text>Remerciements</xsl:text></xsl:attribute>						
						<mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-teiprelim_',$filename)"/>
						</mets:fptr>
						<!--mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-pdf',substring-before(@href,'.'))"/>
						</mets:fptr-->
				</mets:div>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="not(//tei:group[@type='section1'])">
				<xsl:for-each select=".//xinclude:include">
					<xsl:variable name="ref" select="./@href"/>	
					<xsl:variable name="fileNum"><xsl:number count="tei:group[@type='section1']//xinclude:include"/></xsl:variable>	
					<mets:div>
						<xsl:attribute name="DMDID" select="concat($filename,'-',substring-before(@href,'.'))"/>
						<xsl:attribute name="TYPE">
							<xsl:value-of select="../@rend"/>
						</xsl:attribute>	
						<xsl:attribute name="LABEL" select="document($ref)//tei:titleStmt/tei:title[@type='main']"/>						
						<mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-tei',substring-before(@href,'.'))"/>
						</mets:fptr>
					</mets:div>
				</xsl:for-each>
			</xsl:if>
			<xsl:for-each select="//tei:group[@type='section1']">
			<xsl:variable name="section1count">
				<xsl:number count="//tei:group[@type='section1']"/>
			</xsl:variable>
				<mets:div>
					<xsl:attribute name="DMDID"><xsl:value-of select="concat($filename,'-section',$section1count)"/></xsl:attribute>
					<xsl:attribute name="LABEL"><xsl:value-of select="tei:head"/></xsl:attribute>
					<xsl:attribute name="ORDER"><xsl:value-of select="$section1count"/></xsl:attribute>
					<xsl:attribute name="TYPE"><xsl:text>souspartie</xsl:text></xsl:attribute>
				<xsl:if test="descendant::tei:body">
					<xsl:choose>
					<xsl:when test="$volType = 'numero' ">
					<mets:div>
						<!--xsl:attribute name="ORDER" select="$fileNum"/-->
						<xsl:attribute name="DMDID" select="concat($filename,'-prelim_part_',$section1count)"/>
						<xsl:attribute name="TYPE"><xsl:text>editorial</xsl:text></xsl:attribute>	
						<xsl:attribute name="LABEL"><xsl:text>editorial</xsl:text></xsl:attribute>		
						<mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-teiprelim_part_',$section1count)"/>
						</mets:fptr>
						<!--mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-pdf',substring-before(@href,'.'))"/>
						</mets:fptr-->
					</mets:div>
					</xsl:when>
					<xsl:otherwise>
					<mets:div>
						<!--xsl:attribute name="ORDER" select="$fileNum"/-->
						<xsl:attribute name="DMDID" select="concat($filename,'-prelim_part_',$section1count)"/>
						<xsl:attribute name="TYPE"><xsl:text>pageliminaire</xsl:text></xsl:attribute>	
						<xsl:attribute name="LABEL"><xsl:text>Texte introductif</xsl:text></xsl:attribute>		
						<mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-teiprelim_part_',$section1count)"/>
						</mets:fptr>
						<!--mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-pdf',substring-before(@href,'.'))"/>
						</mets:fptr-->
					</mets:div>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:for-each select=".//xinclude:include">
					<xsl:variable name="ref" select="./@href"/>	
					<xsl:variable name="fileNum"><xsl:number count="tei:group[@type='section1']//xinclude:include"/></xsl:variable>	
					<mets:div>
						<!--xsl:attribute name="ORDER" select="$fileNum"/-->
						<xsl:attribute name="DMDID" select="concat($filename,'-',substring-before(@href,'.'))"/>
						<xsl:attribute name="TYPE">
							<xsl:value-of select="../@rend"/>
						</xsl:attribute>	
						<xsl:attribute name="LABEL" select="document($ref)//tei:titleStmt/tei:title[@type='main']"/>						
						<mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-tei',substring-before(@href,'.'))"/>
						</mets:fptr>
						<!--mets:fptr>
							<xsl:attribute name="FILEID" select="concat($filename,'-pdf',substring-before(@href,'.'))"/>
						</mets:fptr-->
					</mets:div>
				</xsl:for-each>
				</mets:div>
			</xsl:for-each>
			<xsl:choose>
			<xsl:when test="$volType = 'volume'">
			<mets:div LABEL="image de la 1ere de couverture" TYPE="couverture1">
				<xsl:attribute name="DMDID">
					<xsl:value-of select="concat($filename,'_imgcouv01')"/>
				</xsl:attribute>
				<!--xsl:attribute name="ORDER">
				</xsl:attribute-->
				<mets:fptr>
					<xsl:attribute name="FILEID">
						<xsl:value-of select="concat($filename,'-img01')"/>
					</xsl:attribute>
				</mets:fptr>
			</mets:div>
			</xsl:when>
			<xsl:otherwise>
				<mets:div LABEL="image de la 1ere de couverture" TYPE="imageaccroche">
				<xsl:attribute name="DMDID">
					<xsl:value-of select="concat($filename,'_imgcouv01')"/>
				</xsl:attribute>
				<!--xsl:attribute name="ORDER">
				</xsl:attribute-->
				<mets:fptr>
					<xsl:attribute name="FILEID">
						<xsl:value-of select="concat($filename,'-img01')"/>
					</xsl:attribute>
				</mets:fptr>
				</mets:div>
			</xsl:otherwise>
			</xsl:choose>
		</mets:div>
	</mets:structMap>
</xsl:template>

</xsl:stylesheet>
