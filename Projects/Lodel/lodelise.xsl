<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:teix="http://www.tei-c.org/ns/Examples"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <!-- import verbatim handling from TEI stylesheets-->
    <xsl:import href="/usr/share/xml/tei/stylesheet/common/verbatim.xsl"/>
    <xsl:param name="attsOnSameLine">2</xsl:param>
    <xsl:param name="attLength">35</xsl:param>
    <xsl:param name="spaceCharacter">&#160;</xsl:param>
    <xsl:param name="simple">false</xsl:param>
    <xsl:param name="highlight"/>
    
    <xsl:output indent="yes"/>
    
    <xsl:template match="/">
    
    <TEI>

<teiHeader>
    <xsl:apply-templates select="TEI/teiHeader"/>
</teiHeader>
<text>
    <xsl:if test='TEI/text/front'>
        <front>
            <xsl:for-each select="TEI/text/front/div">
                <xsl:variable name="part">
                    <xsl:number count="front/div"/>
                </xsl:variable>
                <xsl:variable name="filename" select="concat('whatIs-intro-',$part,'.xml')"/>
                <xsl:message><xsl:value-of select="$filename"/>
                </xsl:message>
                
                
                <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
                    <xsl:attribute name="href"><xsl:value-of select="$filename"/></xsl:attribute>
                </xsl:element>
                
                <xsl:for-each select=".//graphic">
                    <xsl:message>      <xsl:value-of select="@url"/></xsl:message>
                </xsl:for-each>
                
                <xsl:result-document href="{$filename}" >
                    <div xml:id="{concat('div-',$part)}"  >
                        <xsl:apply-templates/>
                    </div>
                </xsl:result-document>
            </xsl:for-each>
        </front>
    </xsl:if>
        
        
<body>
        <xsl:for-each select="TEI/text/body/div">
            <xsl:variable name="part">
                <xsl:number/>
            </xsl:variable>
            <xsl:variable name="filename" select="concat('whatIs-',$part,'.xml')"/>
            <xsl:message><xsl:value-of select="$filename"/>
            </xsl:message>


            <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
                    <xsl:attribute name="href"><xsl:value-of select="$filename"/></xsl:attribute>
                </xsl:element>
            
            <xsl:for-each select=".//graphic">
            <xsl:message>       <xsl:value-of select="@url"/></xsl:message>
            </xsl:for-each>
            
            <xsl:result-document href="{$filename}" >
                <div xml:id="{concat('div-',$part)}"  >
                    <xsl:apply-templates/>
                </div>
            </xsl:result-document>
        </xsl:for-each>-->
    
</body>
    
    <xsl:if test='TEI/text/back'>
        <back>
            <xsl:for-each select="TEI/text/back/div">
                <xsl:variable name="part">
                    <xsl:number count="back/div"/>
                </xsl:variable>
                <xsl:variable name="filename" select="concat('whatIs-biblio-',$part,'.xml')"/>
                <xsl:message><xsl:value-of select="$filename"/>
                </xsl:message>
                
                <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
                    <xsl:attribute name="href"><xsl:value-of select="$filename"/></xsl:attribute>
                </xsl:element>
               
                <xsl:for-each select=".//graphic">
                    <xsl:message>      <xsl:value-of select="@url"/></xsl:message>
                </xsl:for-each>
                
                <xsl:result-document href="{$filename}" >
                    <div xml:id="{concat('div-',$part)}"  >
                        <xsl:apply-templates/>
                    </div>
                </xsl:result-document>
            </xsl:for-each>
        </back>
    </xsl:if>
</text>      
        
    </TEI>
    </xsl:template>   
    
    <xsl:template match="div" mode="splitting">
        <xsl:variable name="part">
            <xsl:number  level="any"/>
        </xsl:variable>
        <xsl:variable name="filename" select="concat('whatIs-',$part,'.xml')"/>
        <xsl:message><xsl:value-of select="$filename"/>
        </xsl:message>
        
        <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
            <xsl:attribute name="href"><xsl:value-of select="$filename"/></xsl:attribute>
        </xsl:element>
        
        <xsl:for-each select=".//graphic">
            <xsl:message>      <xsl:value-of select="@url"/></xsl:message>
        </xsl:for-each>
        
        <xsl:result-document href="{$filename}" >
            <div xml:id="{concat('div-',$part)}"  >
                <xsl:apply-templates/>
            </div>
        </xsl:result-document>
    </xsl:template>
    
    
    <xsl:template match="teix:egXML|eg">
     
        <p rend="noindent">      <code lang="xml">
            <xsl:apply-templates mode="verbatim">
                <xsl:with-param name="highlight">
                    <xsl:value-of select="$highlight"/>
                </xsl:with-param>
            </xsl:apply-templates>
        </code></p>
    </xsl:template>
    

  <xsl:template match="@* | text() | comment() | processing-instruction()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:element name="{name()}" >
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>
    
    
<xsl:template match="TEI">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       >     <xsl:apply-templates/> 
        </TEI>
    </xsl:template>


<xsl:template match="revisionDesc"/>
    <!-- suppress revisionDesc :-( -->

    
    <xsl:template match="body//title">
        <hi rendition="#title"><xsl:apply-templates/></hi>
    </xsl:template>

<xsl:template match="label"/>
  
    <xsl:template match="list[@type='gloss']">
   <list rendition="#gloss"><xsl:apply-templates/></list>
    </xsl:template>
      
    <xsl:template match="list[@type='gloss']/item">
        <item><hi rendition="#label"><xsl:value-of select="preceding-sibling::label[1]"/></hi>
    <xsl:text>  </xsl:text><xsl:apply-templates/></item>
    </xsl:template>
        
        <xsl:template match="listBibl">           
                <xsl:apply-templates/>
        </xsl:template>
    
    
    <xsl:template match="biblStruct|bibl">
       <p><bibl>
            <xsl:apply-templates/>
        </bibl></p>
    </xsl:template>
    
    <xsl:template match="idno">
        <hi rendition="#idno"><xsl:apply-templates/></hi>
    </xsl:template>
    
    <xsl:template match="analytic|monogr|imprint">
        <xsl:apply-templates/>
        
    </xsl:template>
    
    <xsl:template match="biblScope">
        <biblScope><xsl:value-of select="@type"/> <xsl:value-of select="."/></biblScope> 
    </xsl:template>
    
    <xsl:template match="emph">
        <hi rendition="#emph"><xsl:apply-templates/></hi>
    </xsl:template>
    
    <xsl:template match="foreign">
        <hi rendition="#foreign" xml:lang="{@xml:lang}"><xsl:apply-templates/></hi>
    </xsl:template>
    
    <xsl:template match="q">
        <hi rendition="#q"><xsl:apply-templates/></hi>
    </xsl:template>
    
    <xsl:template match="quote[@rend='block']">
        <p rendition="#quoteBlock"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="term">
        <hi rendition="#term"><xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="gi">
        &lt;<xsl:apply-templates/>&gt;
    </xsl:template>
    
    <xsl:template match="tag">
        &lt;<xsl:apply-templates/>&gt;
    </xsl:template>
   
    <xsl:template match="att">
        @<xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="ident">
        <hi rendition="#ident"><xsl:apply-templates/></hi>
    </xsl:template>
    
    
    <xsl:template match="soCalled|mentioned">
        `<xsl:apply-templates/>'
    </xsl:template>
    
    <xsl:template match="title">
        <title rendition='#title'><xsl:apply-templates/></title>
    </xsl:template>
    
    <xsl:template match="val">
        <hi rendition="#val"><xsl:apply-templates/></hi>
    </xsl:template>
    
    

<xsl:template match="figure/head">
    <!-- not allowed -->
</xsl:template>
    
    <xsl:template match="graphic/@width">
        <!-- not allowed -->
    </xsl:template>
    
</xsl:stylesheet>