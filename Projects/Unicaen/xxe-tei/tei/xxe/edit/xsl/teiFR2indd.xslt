<?xml version="1.0" encoding="UTF-8"?>

<!--
/**
*  XSLT tei2indd
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
		exclude-result-prefixes="tei"
>
<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:param name="notesfin" select="notesfin"/>
<xsl:param name="figures" select="figures"/>
<xsl:param name="figMode" select="figMode"/>

<!--xsl:template match="/">
<xsl:value-of select="$figMode"/>
</xsl:template-->

<xsl:strip-space elements="*"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:text">
  <text>
    <xsl:apply-templates/>
      <xsl:for-each select="descendant::tei:note[@place='end']">
        <xsl:call-template name="notesDiv"/>
      </xsl:for-each>
  </text>
</xsl:template>

<xsl:template match="@aid:pstyle">
	<xsl:attribute name="aid:pstyle">
		<xsl:value-of select="concat('orig-',.)"/>
	</xsl:attribute>
</xsl:template>

<xsl:template match="@aid:cstyle">
	<xsl:attribute name="aid:cstyle">
		<xsl:value-of select="concat('orig-',.)"/>
	</xsl:attribute>
</xsl:template>

<xsl:template match="@xml:id">
  <xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template name="notesDiv">
	<xsl:text>
</xsl:text>
<p aid:pstyle="txt_NotesFin"><hi aid:cstyle="debut_Note"><xsl:value-of select="./@n"/>.&#00009;</hi><anchor type="crossref" id="ref{./@xml:id}"/><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="*[@aid:pstyle and not(self::table) and not(self::cell) and not(self::*:quote)]">
<xsl:choose>
<!--  <xsl:when test="local-name()='note' and $notesfin='oui'">
    <xsl:variable name="numNote">
      <xsl:number count="tei:note" level="any" from="//tei:TEI" format="1"/>
    </xsl:variable>
    <hi aid:cstyle="appel_Note"><xsl:value-of select="$numNote"/></hi>
  </xsl:when>-->
  <xsl:when test="local-name()='note' and ./@place='end'">
  	<ref type="crossref" target="#ref{./@xml:id}"><xsl:value-of select="./@n"/></ref>
  </xsl:when>
	<xsl:when test="local-name()='note' and ./@place='foot'">
	<xsl:text>
</xsl:text>
		<xsl:copy>
			<xsl:apply-templates select="./@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	<xsl:text>
</xsl:text>
	</xsl:when>
	<xsl:when test="local-name()='p'">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="local-name(preceding-sibling::node()[1])='head' and @aid:pstyle='txt_Normal'">
					<xsl:attribute name="aid:pstyle">orig-txt_Normal_sa</xsl:attribute>
				</xsl:when>
				<xsl:when test="local-name(preceding-sibling::node()[1])='head' and @aid:pstyle='Txt_Standard'">
					<xsl:attribute name="aid:pstyle">orig-Txt_Standard_sa</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="./@*"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
		</xsl:copy>
	<xsl:text>
</xsl:text>
	</xsl:when>
	<xsl:when test="local-name()='head'">
		<xsl:element name="head">
			<xsl:choose>
				<xsl:when test="@aid:pstyle='T_1'">
					<xsl:attribute name="aid:pstyle">orig-T_a</xsl:attribute>
				</xsl:when>
				<xsl:when test="@aid:pstyle='T_2'">
					<xsl:attribute name="aid:pstyle">orig-T_b</xsl:attribute>
				</xsl:when>
				<xsl:when test="@aid:pstyle='T_3'">
					<xsl:attribute name="aid:pstyle">orig-T_c</xsl:attribute>
				</xsl:when>
				<xsl:when test="@aid:pstyle='T_4'">
					<xsl:attribute name="aid:pstyle">orig-T_d</xsl:attribute>
				</xsl:when>
				<xsl:when test="@aid:pstyle='T_5'">
					<xsl:attribute name="aid:pstyle">orig-T_e</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="./@*"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
		</xsl:element>
		<xsl:choose>
			<xsl:when test="local-name(parent::node())='figure'">
			</xsl:when>
			<xsl:otherwise>
			<xsl:text>
</xsl:text>			
			</xsl:otherwise>
		</xsl:choose>
	</xsl:when>
        <xsl:when test="local-name()='item'">
          <xsl:choose>
            <xsl:when test="tei:lb">
              <xsl:text disable-output-escaping="yes">&lt;item aid:pstyle="</xsl:text><xsl:value-of select="@aid:pstyle"/><xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
              <xsl:apply-templates/>
              <xsl:text disable-output-escaping="yes">&lt;/p&gt;</xsl:text>
	<xsl:text>
</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
              </xsl:copy>
	<xsl:text>
</xsl:text>
            </xsl:otherwise>
          </xsl:choose>          
        </xsl:when>
	<xsl:otherwise>
		<xsl:copy>
			<xsl:apply-templates select="./@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	<xsl:text>
</xsl:text>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- <xsl:template match="tei:lb">
	<xsl:text>
</xsl:text>
</xsl:template> -->

<xsl:template match="tei:emph">
	<hi rend="italic"><xsl:apply-templates/></hi>
</xsl:template>

<xsl:template match="tei:table[not(ancestor::tei:table)]">
<!--	<xsl:element name="p">
		<xsl:element name="p">
			<xsl:apply-templates select="./tei:head/*|./tei:head/text()"/>
		</xsl:element> -->
		<xsl:element name="Tableau">
					<!--xsl:choose>
                    <xsl:when test="@aid5:tablestyle">
                      <xsl:attribute name="aid5:tablestyle"><xsl:value-of select="@aid5:tablestyle"/></xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="aid5:tablestyle">tableau-simple</xsl:attribute>
                    </xsl:otherwise>
            </xsl:choose-->
			<xsl:attribute name="aid:table">table</xsl:attribute>
			<xsl:attribute name="aid:tcols"><xsl:value-of select="@aid:tcols"/></xsl:attribute>			
                        <xsl:attribute name="aid:trows">
							<xsl:variable name="nbRows">
			                  	<xsl:value-of select="count(./tei:row)"/>                        		
							</xsl:variable>
                        	<xsl:choose>
                        		<xsl:when test="child::tei:head">
                        			<xsl:value-of select="$nbRows + 1"/>
                        		</xsl:when>
                        		<xsl:otherwise>
									<xsl:value-of select="$nbRows"/>
                        		</xsl:otherwise>
                        	</xsl:choose>
                        </xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	<!--</xsl:element> -->
	<xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="tei:table">
<!--		<xsl:element name="p">
			<xsl:apply-templates select="./tei:head/*|./tei:head/text()"/>
		</xsl:element> -->
		<xsl:element name="Tableau">
			<xsl:attribute name="aid:table">table</xsl:attribute>
			<xsl:choose>
                          <xsl:when test="./parent::tei:cell">
                            <xsl:attribute name="aid5:tablestyle">
                              <xsl:text>tableau-enchasse</xsl:text>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="aid5:tablestyle">
                              <xsl:text>tableau-principal</xsl:text>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                        <xsl:attribute name="aid:trows"><xsl:value-of select="count(./tei:row)"/></xsl:attribute>
			<xsl:attribute name="aid:tcols"><xsl:value-of select="@aid:tcols"/></xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="tei:row">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:cell">
	<xsl:element name="Cellule">
		<xsl:attribute name="aid:table">cell</xsl:attribute>
		<xsl:choose>
			<xsl:when test="./tei:table">
				<xsl:attribute name="aid5:cellstyle">
					<xsl:text>cellule-table</xsl:text>
				</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="aid5:cellstyle">
					<xsl:text>cellule-standard</xsl:text>
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:attribute name="aid:pstyle">Cellule</xsl:attribute>
		<xsl:choose>
			<xsl:when test="./*[1][self::tei:hi[@rend='bold']]">
				<xsl:attribute name="aid:pstyle">tetiere</xsl:attribute>
			</xsl:when>
			<xsl:when test="./*[1][self::tei:hi[@rend='tetiere']]">
				<xsl:attribute name="aid:pstyle">tetiere</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="aid:pstyle">texte-tab</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:attribute name="aid:crows">
			<xsl:choose>
				<xsl:when test="./@rows"><xsl:value-of select="./@rows"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="aid:ccols">
			<xsl:choose>
				<xsl:when test="./@cols"><xsl:value-of select="./@cols"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:apply-templates/>
	</xsl:element>
</xsl:template>

<xsl:template match="tei:table/tei:head">
        <xsl:element name="Cellule">
                <xsl:attribute name="aid:table"><xsl:text>cell</xsl:text></xsl:attribute>
                <xsl:attribute name="aid5:cellstyle">
					<xsl:text>cellule-table</xsl:text>
				</xsl:attribute>
	            <xsl:attribute name="aid:pstyle"><xsl:text>titre_Tableau</xsl:text></xsl:attribute>
                <xsl:attribute name="aid:crows">1</xsl:attribute>
                <xsl:attribute name="aid:ccols"><xsl:value-of select="../@aid:tcols"/></xsl:attribute>
                <xsl:apply-templates/>
        </xsl:element>
</xsl:template>

<xsl:template match="tei:cell/tei:hi[@rend='bold']">
	<xsl:element name="emph">
		<xsl:attribute name="aid:cstyle">gras tableau</xsl:attribute>
		<xsl:apply-templates select="./*|text()"/>
	</xsl:element>
</xsl:template>

<xsl:template match="tei:cell/tei:hi[@rend='quae-tetiere']">
		<xsl:apply-templates select="./*|text()"/>
</xsl:template>

<xsl:template match="tei:cell/tei:emph">
	<xsl:element name="emph">
		<xsl:attribute name="aid:cstyle">italique tableau</xsl:attribute>
		<xsl:apply-templates select="./*|text()"/>
	</xsl:element>
</xsl:template>

<xsl:template match="tei:cell/tei:hi[@rend='bold']/tei:emph">
	<xsl:element name="emph">
		<xsl:attribute name="aid:cstyle">italique gras tableau</xsl:attribute>
		<xsl:apply-templates select="./*|text()"/>
	</xsl:element>
</xsl:template>


<!-- Gestion des images avec choix d'importation : en tableau ou en tas -->
<xsl:template match="tei:figure">
<xsl:choose>
<xsl:when test="$figMode='tab'">
  <Tableau aid:table="table">
    <xsl:choose>
      <xsl:when test="$figures='vert'">
        <xsl:attribute name="aid:tcols">1</xsl:attribute>
        <xsl:attribute name="aid:trows">2</xsl:attribute>
        <xsl:attribute name="aid5:tablestyle">tableau-figure</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="aid:tcols">2</xsl:attribute>
        <xsl:attribute name="aid:trows">1</xsl:attribute>
        <xsl:attribute name="aid5:tablestyle">tableau-figure</xsl:attribute>        
      </xsl:otherwise>
    </xsl:choose>
    <cell aid:table="cell">
      <graphic aid:pstyle="txt_Figure">
        <xsl:choose>
          <xsl:when test="tei:figDesc/tei:ref">
            <xsl:attribute name="href"><xsl:value-of select="tei:figDesc/tei:ref"/></xsl:attribute>
          </xsl:when>
          <xsl:when test="tei:graphic/@url">
            <xsl:attribute name="href">
              <xsl:value-of select="tei:graphic/@url"/>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </graphic>
    </cell>
    <cell aid:table="cell" aid5:cellstyle="cellule-titre-legende">
      <xsl:apply-templates select="tei:head"/><xsl:text>
</xsl:text>
<xsl:copy-of select="tei:p"/>
    </cell>
  </Tableau>
  <xsl:text>
</xsl:text>
</xsl:when>
<xsl:when test="$figMode='heap'">
	<graphic aid:pstyle="txt_Figure">
		<xsl:attribute name="href">
        	<xsl:value-of select="./tei:graphic/@url"/>
    	</xsl:attribute>
    </graphic>
    <xsl:apply-templates select="./tei:head"/>
    <xsl:apply-templates select="./tei:p[@aid:pstyle='txt_Legende']"/>
</xsl:when>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:graphic">
  <graphic href="{@url}"/>
</xsl:template>

<xsl:template match="tei:quote[@type='exemple']">
  <xsl:choose>
    <xsl:when test="tei:quote/tei:seg">
      <xsl:element name="Tableau">
        <xsl:attribute name="aid:table">table</xsl:attribute>
        <xsl:attribute name="aid5:tablestyle">
          <xsl:text>tableau-exemple</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="aid:trows"><xsl:value-of select="count(./tei:quote)+count(./tei:bibl)"/></xsl:attribute>
        <xsl:attribute name="aid:tcols"><xsl:value-of select="count(./tei:quote[1]/tei:seg)+count(./tei:quote[1]/tei:num)"/></xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element><xsl:text>
</xsl:text>
    </xsl:when>
    <!--<xsl:otherwise>
      <xsl:apply-templates/><xsl:text>
</xsl:text>
    </xsl:otherwise>-->
  </xsl:choose>

</xsl:template>

<xsl:template match="tei:quote[@type='exemple']/tei:quote|tei:quote[@type='exemple']/tei:bibl">
  <xsl:choose>
    <xsl:when test="@type='traduction' or local-name()='bibl'">
      <xsl:choose>
        <xsl:when test="preceding-sibling::tei:quote/tei:num">
          <xsl:element name="Cellule">
            <xsl:attribute name="aid:table">cell</xsl:attribute>
            <xsl:attribute name="aid5:cellstyle">
              <xsl:text>cellule-numExemple</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="aid:pstyle">Cellule-numExemple</xsl:attribute>
            <xsl:attribute name="aid:crows">1</xsl:attribute>
            <xsl:attribute name="aid:ccols">1</xsl:attribute>
            <xsl:text> </xsl:text>
          </xsl:element>
          <xsl:element name="Cellule">
            <xsl:attribute name="aid:table">cell</xsl:attribute>
            <xsl:attribute name="aid5:cellstyle">
              <xsl:text>cellule-standard</xsl:text>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="@type='traduction'">
                <xsl:attribute name="aid:pstyle">Cellule-traduction</xsl:attribute>                            
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="aid:pstyle">Cellule-biblio</xsl:attribute>              
              </xsl:otherwise>
            </xsl:choose>
            <xsl:attribute name="aid:crows">1</xsl:attribute>
            <xsl:attribute name="aid:ccols"><xsl:value-of select="count(preceding-sibling::tei:quote[1]/tei:seg)"/></xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>          
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="bibl">
            <xsl:attribute name="aid:pstyle">txt_Biblio</xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="@aid:pstyle='txt_Exemple'">
      <xsl:element name="quote">
        <xsl:attribute name="aid:pstyle">txt_Exemple</xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element><xsl:text>
</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:quote[@type='exemple']/tei:quote/tei:num">
  	<xsl:element name="Cellule">
          <xsl:attribute name="aid:table">cell</xsl:attribute>
          <xsl:attribute name="aid5:cellstyle">
            <xsl:text>cellule-numExemple</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="aid:pstyle">Cellule-numExemple</xsl:attribute>
          <xsl:attribute name="aid:crows">1</xsl:attribute>
          <xsl:attribute name="aid:ccols">1</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
</xsl:template>

<xsl:template match="tei:quote[@type='exemple']/tei:quote/tei:seg">
  <xsl:if test="parent::tei:quote/preceding-sibling::tei:quote[1]/tei:num and position()=1">
    <xsl:element name="Cellule">
      <xsl:attribute name="aid:table">cell</xsl:attribute>
      <xsl:attribute name="aid5:cellstyle">
        <xsl:text>cellule-numExemple</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="aid:pstyle">Cellule-numExemple</xsl:attribute>
      <xsl:attribute name="aid:crows">1</xsl:attribute>
      <xsl:attribute name="aid:ccols">1</xsl:attribute>
      <xsl:text> </xsl:text>
    </xsl:element>
  </xsl:if>
  <xsl:element name="Cellule">
    <xsl:attribute name="aid:table">cell</xsl:attribute>
    <xsl:attribute name="aid5:cellstyle">
      <xsl:text>cellule-segment</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="aid:pstyle">Cellule-segment</xsl:attribute>
    <xsl:attribute name="aid:crows">1</xsl:attribute>
    <xsl:attribute name="aid:ccols">1</xsl:attribute>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>
<!--
<xsl:template match="tei:term">
	<xsl:copy>
		<xsl:attribute name="aid:cstyle">txt_index</xsl:attribute>
		<xsl:apply-templates/>
	</xsl:copy>
</xsl:template>
-->

<xsl:template match="tei:lb">
  <xsl:variable name="listStyle"><xsl:value-of select="../@aid:pstyle"/></xsl:variable>

  <xsl:choose>
    <xsl:when test="local-name(parent::node()) != 'item'">
      <!--xsl:text>
</xsl:text-->
<xsl:text disable-output-escaping="yes">  </xsl:text>
    </xsl:when>
    <xsl:when test="not(preceding-sibling::tei:lb)">
      <xsl:text disable-output-escaping="yes">&lt;/item&gt;
</xsl:text>
      <xsl:text disable-output-escaping="yes">&lt;p aid:pstyle="</xsl:text><xsl:value-of select="$listStyle"/><xsl:text disable-output-escaping="yes">suite"&gt;</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text disable-output-escaping="yes">&lt;/p&gt;
</xsl:text>
      <xsl:text disable-output-escaping="yes">&lt;p aid:pstyle="</xsl:text><xsl:value-of select="$listStyle"/><xsl:text disable-output-escaping="yes">suite"&gt;</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:quote[@rend='quotation']">
<xsl:choose>
 <xsl:when test="tei:lb">
   <quote rend="quotation" aid:pstyle="txt_Citation_debut">
     <xsl:for-each select="tei:lb[1]/preceding-sibling::*|tei:lb[1]/preceding-sibling::text()">
       <xsl:apply-templates select="."/>
     </xsl:for-each>
   </quote><xsl:text>
</xsl:text>
   <xsl:variable name="finCitation">
     <xsl:for-each select="tei:lb[1]/following-sibling::*|tei:lb[1]/following-sibling::text()">
       <xsl:copy-of select="."/>
     </xsl:for-each>
   </xsl:variable>

   <xsl:call-template name="citationSuite">
     <xsl:with-param name="rest" select="$finCitation"/>
   </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
   <quote rend="quotation" aid:pstyle="txt_Citation">
     <xsl:apply-templates/>
   </quote><xsl:text>
</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="citationSuite">
  <xsl:param name="rest" select="rest"/>
  <xsl:choose>
    <xsl:when test="$rest/descendant::tei:lb">
      <quote rend="quotation" aid:pstyle="txt_Citation_suite">
        <xsl:for-each select="$rest/tei:lb[1]/preceding-sibling::*|$rest/tei:lb[1]/preceding-sibling::text()">
          <xsl:apply-templates select="."/>
        </xsl:for-each>
      </quote><xsl:text>
</xsl:text>
      <xsl:variable name="finCitation">
        <xsl:for-each select="$rest/tei:lb[1]/following-sibling::*|$rest/tei:lb[1]/following-sibling::text()">
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </xsl:variable>
      
      <xsl:call-template name="citationSuite">
        <xsl:with-param name="rest" select="$finCitation"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <quote rend="quotation" aid:pstyle="txt_Citation_fin">
        <xsl:apply-templates select="$rest"/>
      </quote><xsl:text>
</xsl:text>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:list">
  <list>
    <xsl:apply-templates/>
  </list>
</xsl:template>

<!--encadrés flottants-->
    <xsl:template match="xi:include">
        <xsl:variable name="ref" select="./@href"/>
        <!-- on englobe dans un anonymous bloc et on stocke le résultat dans la variable ab-->
        <xsl:variable name="ab">
            <ab type='encadre'>
<!--                <xsl:apply-templates select="document($ref)//tei:body/tei:div[@xml:id='mainDiv']"/> -->
              <xsl:apply-templates select="document($ref)//tei:body/*"/>
            </ab>
        </xsl:variable>
        <!-- on lance la transformation sur l'anonymous bloc -->     
        <xsl:apply-templates select="$ab"/>
        
    </xsl:template>

    <xsl:template match="//tei:ab//*[@aid:pstyle]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
	    <xsl:variable name="style">
	      <xsl:choose>
		<xsl:when test="not(@type)">
		  <xsl:value-of select="enc_flot_"/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="@type"/>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:variable>
            <xsl:attribute name="aid:pstyle">
                <!--xsl:value-of select="concat($style,'_', @aid:pstyle)"/-->
                <xsl:value-of select="concat('enc_flot_', @aid:pstyle)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="//tei:ab//*[@aid:cstyle]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
	    <xsl:variable name="style">
              <xsl:choose>
		<xsl:when test="not(@type)">
                  <xsl:value-of select="enc_flot_"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@type"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="aid:cstyle">
                <!--xsl:value-of select="concat($style,'_', @aid:cstyle)"/-->
                <xsl:value-of select="concat('enc_flot_', @aid:cstyle)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>  

</xsl:stylesheet>