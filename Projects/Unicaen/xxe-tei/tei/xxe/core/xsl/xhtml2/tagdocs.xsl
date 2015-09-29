<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:s="http://www.ascc.net/xml/schematron" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:html="http://www.w3.org/1999/xhtml"

                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#default s html a fo rng tei teix"
                version="2.0">

  <xsl:param name="cssFile"/>
  <xsl:param name="cssSecondaryFile"/>
  <xsl:param name="summaryDoc">false</xsl:param>
  <xsl:include href="../common2/tagdocs.xsl"/>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p> TEI stylesheet dealing with elements from the tagdocs module,
      making HTML output. </p>
         <p> This library is free software; you can redistribute it and/or
      modify it under the terms of the GNU Lesser General Public License as
      published by the Free Software Foundation; either version 2.1 of the
      License, or (at your option) any later version. This library is
      distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
      without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
      PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
      details. You should have received a copy of the GNU Lesser General Public
      License along with this library; if not, write to the Free Software
      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA </p>
         <p>Author: See AUTHORS</p>
         <p>Id: $Id: tagdocs.xsl 7859 2010-07-19 08:44:49Z rahtz $</p>
         <p>Copyright: 2008, TEI Consortium</p>
      </desc>
   </doc>


  <xsl:param name="xrefName">a</xsl:param>
  <xsl:param name="urlName">href</xsl:param>
  <xsl:param name="ulName">ul</xsl:param>
  <xsl:param name="dlName">dl</xsl:param>
  <xsl:param name="codeName">span</xsl:param>
  <xsl:param name="colspan">colspan</xsl:param>
  <xsl:param name="ddName">dd</xsl:param>
  <xsl:param name="dtName">dt</xsl:param>
  <xsl:param name="hiName">span</xsl:param>
  <xsl:param name="itemName">li</xsl:param>
  <xsl:param name="labelName">dt</xsl:param>
  <xsl:param name="rendName">class</xsl:param>
  <xsl:param name="rowName">tr</xsl:param>
  <xsl:param name="tableName">table</xsl:param>
  <xsl:param name="cellName">td</xsl:param>
  <xsl:param name="divName">div</xsl:param>
  <xsl:param name="sectionName">div</xsl:param>
  <xsl:param name="segName">span</xsl:param>
  <xsl:param name="outputNS">http://www.w3.org/1999/xhtml</xsl:param>

  <xsl:template name="identifyElement">
      <xsl:param name="id"/>
      <xsl:attribute name="id">
         <xsl:value-of select="$id"/>
      </xsl:attribute>
  </xsl:template>

  <xsl:template name="verbatim-lineBreak">
      <xsl:param name="id"/>
      <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:key match="tei:moduleSpec[@ident]" name="FILES" use="@ident"/>

  <xsl:variable name="top" select="/"/>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[odds] Document an element, macro, or class</desc>
   </doc>
  <xsl:template name="refdoc">
      <xsl:if test="$verbose='true'">
         <xsl:message> refdoc for <xsl:value-of select="name(.)"/> - <xsl:value-of select="@ident"/>
         </xsl:message>
      </xsl:if>
      <xsl:variable name="objectname">
         <xsl:choose>
            <xsl:when test="tei:altIdent">
               <xsl:value-of select="tei:altIdent"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="@ident"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="name">
         <xsl:value-of select="$objectname"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="self::tei:classSpec and not(@ident='att.global') and         count(key('CLASSMEMBERS',@ident))=0">
            <xsl:if test="$verbose='true'">
               <xsl:message> class <xsl:value-of select="@ident"/> omitted as it has no members
      </xsl:message>
            </xsl:if>

         </xsl:when>
         <xsl:when test="number($splitLevel)=-1 or $STDOUT='true'">
	           <xsl:apply-templates mode="weavebody" select="."/>
         </xsl:when>
         <xsl:otherwise> 
	           <xsl:variable name="BaseFile">
               <xsl:value-of select="$masterFile"/>
               <xsl:if test="ancestor::tei:teiCorpus">
                  <xsl:text>-</xsl:text>
                  <xsl:choose>
                     <xsl:when test="@xml:id">
                        <xsl:value-of select="@xml:id"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:number/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:if>
            </xsl:variable>

	
	           <xsl:variable name="outName">
	              <xsl:call-template name="outputChunkName">
	                 <xsl:with-param name="ident">
	                    <xsl:text>ref-</xsl:text>
	                    <xsl:value-of select="@ident"/>
	                 </xsl:with-param>
	              </xsl:call-template>
	           </xsl:variable>
	
	           <xsl:if test="$verbose='true'">
	              <xsl:message>Opening file <xsl:value-of select="$outName"/>
               </xsl:message>
	           </xsl:if>
	           <xsl:variable name="documentationLanguage">
	              <xsl:call-template name="generateDoc"/>
	           </xsl:variable>
	           <xsl:variable name="langs">
	              <xsl:value-of select="concat(normalize-space($documentationLanguage),' ')"/>
	           </xsl:variable>

	           <xsl:result-document doctype-public="{$doctypePublic}" doctype-system="{$doctypeSystem}"
                                 encoding="{$outputEncoding}"
                                 href="{$outName}"
                                 method="{$outputMethod}">
	              <html>
	                 <xsl:call-template name="addLangAtt"/>
	                 <xsl:comment>THIS IS A GENERATED FILE. DO NOT EDIT (7) </xsl:comment>
	                 <head>
	                    <title>
		                      <xsl:text>TEI </xsl:text>
		                      <xsl:value-of select="substring-before(local-name(),'Spec')"/>
		                      <xsl:text> </xsl:text>
		                      <xsl:value-of select="$name"/>
		                      <xsl:text> </xsl:text>
		                      <xsl:call-template name="makeGloss">
		                         <xsl:with-param name="langs" select="$langs"/>
		                      </xsl:call-template>
	                    </title>
	                    <xsl:choose>
		                      <xsl:when test="$cssFile = ''"/>
		                      <xsl:otherwise>
		                         <link href="{$cssFile}" rel="stylesheet" type="text/css"/>
		                      </xsl:otherwise>
	                    </xsl:choose>
	                    <xsl:if test="not($cssSecondaryFile = '')">
		                      <link href="{$cssSecondaryFile}" rel="stylesheet" type="text/css"/>
	                    </xsl:if>
	                    <xsl:call-template name="generateLocalCSS"/>
	                    <xsl:call-template name="metaHTML">
		                      <xsl:with-param name="title">
		                         <xsl:value-of select="substring-before(local-name(),'Spec')"/>
		                         <xsl:text> </xsl:text>
		                         <xsl:value-of select="@ident"/>
		                         <xsl:text> </xsl:text>
		                         <xsl:call-template name="makeGloss">
		                            <xsl:with-param name="langs" select="$langs"/>
		                         </xsl:call-template>
		                         <xsl:text> - </xsl:text>
		                         <xsl:call-template name="generateTitle"/>
		                      </xsl:with-param>
	                    </xsl:call-template>
	                    <xsl:call-template name="includeJavascript"/>
	                    <xsl:call-template name="javascriptHook"/>
	                 </head>
	                 <body id="TOP">
	                    <xsl:call-template name="bodyHook"/>
	                    <xsl:call-template name="teiTOP">
		                      <xsl:with-param name="name">
		                         <xsl:value-of select="$name"/>
		                      </xsl:with-param>
	                    </xsl:call-template>
	                    <div class="main-content">
		                      <xsl:call-template name="startDivHook"/>
		                      <xsl:apply-templates mode="weavebody" select="."/>
	                    </div>
	                    <xsl:call-template name="stdfooter">
		                      <xsl:with-param name="file">
		                         <xsl:text>ref-</xsl:text>
		                         <xsl:value-of select="@ident"/>
		                      </xsl:with-param>
	                    </xsl:call-template>
	                    <xsl:call-template name="bodyEndHook"/>
	                 </body>
	              </html>
	           </xsl:result-document>
	           <xsl:if test="$verbose='true'">
	              <xsl:message>Closing file <xsl:value-of select="$outName"/>
               </xsl:message>
	           </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[html] make a link<param name="class">class</param>
         <param name="id">id</param>
         <param name="name">name</param>
         <param name="text">text</param>
      </desc>
   </doc>
  <xsl:template name="makeLink">
      <xsl:param name="class"/>
      <xsl:param name="name"/>
      <xsl:param name="text"/>
      <a class="{$class}">
         <xsl:attribute name="href">
            <xsl:choose>
               <xsl:when test="number($splitLevel)=-1">
                  <xsl:text>#</xsl:text>
                  <xsl:value-of select="$name"/>
               </xsl:when>
	              <xsl:when test="$STDOUT='true'">
	                 <xsl:for-each select="key('IDENTS',$name)">
	                    <xsl:call-template name="getSpecURL">
		                      <xsl:with-param name="name">
		                         <xsl:value-of select="$name"/>
		                      </xsl:with-param>
		                      <xsl:with-param name="type">
		                         <xsl:value-of select="substring-before(local-name(),'Spec')"/>
		                      </xsl:with-param>
	                    </xsl:call-template>
	                 </xsl:for-each>
	              </xsl:when>
               <xsl:otherwise>
                  <xsl:text>ref-</xsl:text>
                  <xsl:value-of select="$name"/>
	                 <xsl:value-of select="$outputSuffix"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:attribute>
         <xsl:copy-of select="$text"/>
      </a>
  </xsl:template>
   <xsl:template name="teiTOP">
      <xsl:param name="name"/>
      <div id="hdr">
	<xsl:call-template name="stdheader">
	  <xsl:with-param name="title">
	    <xsl:value-of select="$name"/>
	  </xsl:with-param>
	</xsl:call-template>
      </div>
   </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[html] Provide a footer for each reference document</desc>
   </doc>

  <xsl:template name="refdocFooter">
      <xsl:call-template name="preAddressHook"/>
      <div style="margin: 20pt; font-weight: bold;">
         <a href="{$refDocFooterURL}">
	           <xsl:value-of select="$refDocFooterText"/>
         </a>
      </div>
  </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[html] <param name="text">text</param>
      </desc>
   </doc>
  <xsl:template name="typewriter">
      <xsl:param name="text"/>
      <tt>
         <xsl:copy-of select="$text"/>
      </tt>
  </xsl:template>


  <xsl:template name="showRNC">
      <xsl:param name="style"/>
      <xsl:param name="contents"/>
      <span class="{$style}">
	<xsl:choose>
	  <xsl:when test="string-length($contents)&lt;50">
	    <xsl:value-of select="$contents"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:call-template name="verbatim-reformatText">
	      <xsl:with-param name="sofar">0</xsl:with-param>
	      <xsl:with-param name="indent">
		<xsl:text> </xsl:text>
	      </xsl:with-param>
	      <xsl:with-param name="text">
		<xsl:value-of select="$contents"/>
	      </xsl:with-param>
	    </xsl:call-template>
	  </xsl:otherwise>
	</xsl:choose>
      </span>
  </xsl:template>

  <xsl:template name="emptySlash">
      <xsl:param name="name"/>
      <span class="emptySlash">
	        <xsl:value-of select="$name"/>
      </span>
  </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Process elements teix:egXML</desc>
   </doc>
  <xsl:template match="teix:egXML">
      <xsl:param name="simple">false</xsl:param>
      <xsl:param name="highlight"/>
      <div>
         <xsl:attribute name="id">
	           <xsl:apply-templates mode="ident" select="."/>
         </xsl:attribute>
         <xsl:attribute name="class">
	           <xsl:text>pre</xsl:text>
	           <xsl:if test="not(*)">
	              <xsl:text> cdata</xsl:text>
	           </xsl:if>
         </xsl:attribute>
         <xsl:choose>
	           <xsl:when test="$simple='true'">
	              <xsl:apply-templates mode="verbatim">
	                 <xsl:with-param name="highlight">
	                    <xsl:value-of select="$highlight"/>
	                 </xsl:with-param>
	              </xsl:apply-templates>
	           </xsl:when>
	           <xsl:otherwise>
	              <xsl:call-template name="egXMLStartHook"/>
	              <xsl:apply-templates mode="verbatim">
	                 <xsl:with-param name="highlight">
	                    <xsl:value-of select="$highlight"/>
	                 </xsl:with-param>
	              </xsl:apply-templates>
	              <xsl:call-template name="egXMLEndHook"/>
	           </xsl:otherwise>
         </xsl:choose>
      </div>
  </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[html] <param name="grammar">grammar</param>
         <param name="content">content</param>
         <param name="element">element</param>
      </desc>
   </doc>

  <xsl:template name="bitOut">
      <xsl:param name="grammar"/>
      <xsl:param name="content"/>
      <xsl:param name="element">pre</xsl:param>
      <xsl:choose>
         <xsl:when test="$displayMode='both'">
	           <div class="displayRelax">
	              <button class="displayRelaxButton">
	                 <span class="RNG_Compact">
	                    <xsl:call-template name="i18n">
	                       <xsl:with-param name="word">Compact to XML format</xsl:with-param>
	                    </xsl:call-template>
	                 </span>
	                 <span class="RNG_XML">
	                    <xsl:call-template name="i18n">
	                       <xsl:with-param name="word">XML format to compact</xsl:with-param>
	                    </xsl:call-template>
	                 </span>
	              </button>
	              <pre class="RNG_XML">
	                 <xsl:apply-templates mode="verbatim" select="$content/*/*"/>
	              </pre>
	              <pre class="RNG_Compact">
	                 <xsl:call-template name="make-body-from-r-t-f">
	                    <xsl:with-param name="schema">
	                       <xsl:for-each select="$content/*">
		                         <xsl:call-template name="make-compact-schema"/>
	                       </xsl:for-each>
	                    </xsl:with-param>
	                 </xsl:call-template>
	              </pre>
	           </div>
         </xsl:when>
         <xsl:when test="$displayMode='rng'">
	           <xsl:element name="{$element}">
	              <xsl:attribute name="class">eg</xsl:attribute>
	              <xsl:apply-templates mode="verbatim" select="$content/*/*"/>
	           </xsl:element>
         </xsl:when>
         <xsl:when test="$displayMode='rnc'">
	           <xsl:element name="{$element}">
	              <xsl:attribute name="class">eg</xsl:attribute>
	              <xsl:call-template name="make-body-from-r-t-f">
	                 <xsl:with-param name="schema">
	                    <xsl:for-each select="$content/*">
		                      <xsl:call-template name="make-compact-schema"/>
	                    </xsl:for-each>
	                 </xsl:with-param>
	              </xsl:call-template>
	           </xsl:element>
         </xsl:when>
         <xsl:otherwise>
	           <xsl:element name="{$element}">
	              <xsl:attribute name="class">eg</xsl:attribute>
	              <xsl:for-each select="$content/*">
	                 <xsl:apply-templates mode="literal"/>
	              </xsl:for-each>
	           </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:template name="showSpace">
      <xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template name="showSpaceBetweenItems">
      <xsl:text> </xsl:text>
  </xsl:template>


  <xsl:template match="tei:schemaSpec">
    
      <xsl:choose>
         <xsl:when test="tei:specGrpRef">
	           <xsl:variable name="SPECS">
	              <tei:schemaSpec>
	                 <xsl:copy-of select="@*"/>
	                 <xsl:apply-templates mode="expandSpecs"/>
	              </tei:schemaSpec>
	           </xsl:variable>
	           <xsl:for-each select="$SPECS/tei:schemaSpec">
	              <xsl:call-template name="schemaSpecWeave"/>
	           </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
	           <xsl:call-template name="schemaSpecWeave"/>
         </xsl:otherwise>
      </xsl:choose>

  </xsl:template>

  <xsl:template name="schemaSpecWeave">
      <xsl:if test="$verbose='true'">
         <xsl:message>Processing schemaSpec <xsl:value-of select="@ident"/>, summaryDoc=<xsl:value-of select="$summaryDoc"/>
         </xsl:message>
      </xsl:if>

      <xsl:choose>
         <xsl:when test="$summaryDoc='true'">
	   <h2>Schema <xsl:value-of select="@ident"/>: changed components</h2>
	   <xsl:for-each select="tei:classSpec[@mode or @rend='change']  
				 | tei:macroSpec[(@mode or @rend='change')]  
				 | tei:elementSpec[(@mode or @rend='change')]">
	     <xsl:sort select="@ident"/>
	     <xsl:apply-templates mode="weave" select="."/>
	   </xsl:for-each>
	   <h2>Schema <xsl:value-of select="@ident"/>:  unchanged  components</h2>
	   <table>
	     <xsl:for-each select="tei:classSpec[not(@mode or @rend)]  
				   | tei:macroSpec[not(@mode or  @rend)]  
				   | tei:elementSpec[not(@mode or @rend)]">
	       <xsl:sort select="@ident"/>
	       <tr>
		 <td id="{@ident}">
		   <a href="http://www.tei-c.org/release/doc/tei-p5-doc/{$documentationLanguage}/html/ref-{@ident}.html">
		     <xsl:value-of select="@ident"/>
		     </a>:
		     <xsl:call-template name="makeDescription"/>
		 </td>
	       </tr>
	     </xsl:for-each>
	   </table>
	 </xsl:when>
         <xsl:otherwise>
	           <xsl:if test="tei:classSpec[@type='model']">
	              <h2>Schema <xsl:value-of select="@ident"/>: Model classes</h2>
	              <xsl:apply-templates mode="weave" select="tei:classSpec[@type='model']">
	                 <xsl:sort select="@ident"/>
	              </xsl:apply-templates>
	           </xsl:if>
	
	
	           <xsl:if test="tei:classSpec[@type='atts']">
	              <h2>Schema <xsl:value-of select="@ident"/>: Attribute classes</h2>
	              <xsl:apply-templates mode="weave" select="tei:classSpec[@type='atts']">
	                 <xsl:sort select="@ident"/>
	              </xsl:apply-templates>
	           </xsl:if>
	
	           <xsl:if test="tei:macroSpec">
	              <h2>Schema <xsl:value-of select="@ident"/>: Macros</h2>
	              <xsl:apply-templates mode="weave" select="tei:macroSpec">
	                 <xsl:sort select="@ident"/>
	              </xsl:apply-templates>
	  
	           </xsl:if>
	           <h2>Schema <xsl:value-of select="@ident"/>: Elements</h2>
	           <xsl:apply-templates mode="weave" select="tei:elementSpec">
	              <xsl:sort select="@ident"/>
	           </xsl:apply-templates>
         </xsl:otherwise>
      </xsl:choose>	
  </xsl:template>


  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[odds] make a link<param name="name">name</param>
         <param name="id">id</param>
      </desc>
   </doc>

  <xsl:template name="makeSectionHead">
      <xsl:param name="name"/>
      <xsl:param name="id"/>
      <h3 class="oddSpec">
         <xsl:call-template name="makeAnchor">
            <xsl:with-param name="name">
               <xsl:value-of select="$id"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:value-of select="$name"/>
         <xsl:if test="@ns">
	[<xsl:value-of select="@ns"/>]
      </xsl:if>
      </h3>
  </xsl:template>

  <xsl:template name="specHook">
      <xsl:param name="name"/>
  </xsl:template>


</xsl:stylesheet>