<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"  xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:dbk="http://docbook.org/ns/docbook"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:html="http://www.w3.org/1999/xhtml"

                
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="a fo dbk xlink xhtml rng tei teix"
                version="2.0">
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p> TEI stylesheet dealing with elements from the textcrit
      module, making HTML output. </p>
         <p>This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.
</p>
         <p>Author: See AUTHORS</p>
         <p>Id: $Id$</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>

   <xsl:template name="appReading">
     <xsl:param name="lemma"/>
     <xsl:param name="lemmawitness"/>
     <xsl:param name="readings"/>
     <!--<xsl:message>App: <xsl:value-of select="($lemma,$lemmawitness,$readings)" separator="|"/></xsl:message>-->
     <xsl:value-of select="$lemma"/>
      <xsl:variable name="identifier">
         <xsl:text>App</xsl:text>
         <xsl:choose>
	   <xsl:when test="@xml:id">
	     <xsl:value-of select="@xml:id"/>
	   </xsl:when>
	   <xsl:otherwise>
	     <xsl:number count="tei:app" level="any"/>
	   </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:choose>
       <xsl:when test="$footnoteFile='true'">
	 <a class="notelink" href="{$masterFile}-notes.html#{$identifier}">
	   <sup>
	     <xsl:call-template name="appN"/>
	   </sup>
	 </a>
       </xsl:when>
       <xsl:otherwise>
	 <a class="notelink" href="#{$identifier}">
	   <sup>
	     <xsl:call-template name="appN"/>
	   </sup>
	 </a>
       </xsl:otherwise>
      </xsl:choose>

  </xsl:template>


   <xsl:template name="appN">
      <xsl:choose>
         <xsl:when test="@n">
            <xsl:value-of select="@n"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:number from="tei:text" level="any"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="tei:app" mode="printnotes">
      <xsl:variable name="identifier">
         <xsl:text>App</xsl:text>
         <xsl:choose>
            <xsl:when test="@xml:id">
	      <xsl:value-of select="@xml:id"/>
            </xsl:when>
            <xsl:otherwise>
	      <xsl:number count="tei:app" level="any"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <div class="app">
         <xsl:call-template name="makeAnchor">
            <xsl:with-param name="name" select="$identifier"/>
         </xsl:call-template>
	 <span class="lemma">
	   <xsl:choose>
	     <xsl:when test="tei:lem">
	       <xsl:apply-templates select="tei:lem"/>
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:apply-templates select="tei:rdg[1]"/>
	     </xsl:otherwise>
	   </xsl:choose>
	 </span>
	 <xsl:text>] </xsl:text>
	 <span class="lemmawitness">
	   <xsl:choose>
	     <xsl:when test="tei:lem">
	       <xsl:value-of select="tei:getWitness(tei:lem/@wit)"/>
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:value-of select="tei:getWitness(tei:rdg[1]/@wit)"/>
	     </xsl:otherwise>
	   </xsl:choose>
	 </span>
	<xsl:variable name="start" select="if (not(../tei:lem)) then 1 else 0"/>
	<xsl:for-each select="tei:rdg[position() &gt; $start]">
	   <xsl:text>; </xsl:text>
	   <xsl:apply-templates/>
	   <xsl:if test="@cause='omission'">[]</xsl:if>
	   <xsl:text> (</xsl:text>
	   <xsl:value-of select="tei:getWitness(@wit)"/>
	   <xsl:text>)</xsl:text>
	   <xsl:if test="not(following-sibling::tei:rdg)">.</xsl:if>
	 </xsl:for-each>
     </div>
     
   </xsl:template>

</xsl:stylesheet>