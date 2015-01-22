<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive" xmlns:bk="utc.fr:ics/book"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs sc sp bk tei" version="2.0">

    <xsl:template match="bk:book">
        <TEI>
            <teiHeader>
            <xsl:apply-templates select="bk:bookMeta"/>
            <revisionDesc>
                <xsl:apply-templates select="sp:foreword"/>
            </revisionDesc>
            </teiHeader>
                <text>
                <front>
                    <xsl:apply-templates select="sp:generalIntro"/>
                </front>
                <body>
                    <xsl:apply-templates select="sp:chapter"/>
                </body>
                <back>
                    <xsl:apply-templates select="sp:appendix"/>
                </back>
            </text>
        </TEI>
    </xsl:template>

    <xsl:template match="sp:foreword">
        <xsl:apply-templates select="bk:foreword/sp:forewordDiv/bk:textR/sc:itemizedList"/>
    </xsl:template>
    

    <xsl:template match="sp:generalintro">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="sp:chapter">
   <xsl:variable name="SRC">
           <xsl:value-of select="substring-after(@sc:refUri,'Renaissance/')"/>
       </xsl:variable>
      <xsl:apply-templates select="doc($SRC)"/> 
       </xsl:template>
    
    <xsl:template match="sp:appendix">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="bk:bookMeta">
            <fileDesc>
                <titleStmt>
                    <title>
                        <xsl:value-of select="sp:title"/>
                    </title>
                    <xsl:apply-templates select="sp:authors"/>
                </titleStmt>
                <publicationStmt>
                  <publisher>
                      <xsl:apply-templates select="sp:editorialInfo/bk:textS/sc:para"/>
                  </publisher> 
                    <availability>
                        <p>
                            <xsl:apply-templates select="sp:legalInfo"/>
                        </p>
                    </availability>
                </publicationStmt>
                <sourceDesc><p>Converted from cendari source</p></sourceDesc>
            </fileDesc>
           

    </xsl:template>

    <xsl:template match="sp:authors">
        <xsl:for-each select="sp:author">
            <author>
                <!--<xsl:value-of select='substring-after(@sc:refUri, "Renaissance/")'/>
               --> <xsl:variable name="SRC">
                    <xsl:value-of select="substring-after(@sc:refUri,'Renaissance/')"/>
                </xsl:variable>            
                    <xsl:apply-templates select="doc($SRC)"/>
             </author>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="sp:firstName">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="bk:chapter|bk:subChap">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="sc:para">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="sc:orderedList">
        <list rend="ordered">
            <xsl:apply-templates/>
        </list>
    </xsl:template>

    <xsl:template match="sc:itemizedList|sc:simpleList">
        <list>
            <xsl:apply-templates/>
        </list>
    </xsl:template>
    <xsl:template match="sc:listItem/sc:para|sc:simpleList/sc:member">
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>


    <xsl:template match="sp:title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    
    <xsl:template match="sp:remark//sp:title">
        <p rend="head">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="sp:warning//sp:title">
        <p rend="head">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="sp:complement//sp:title">
        <p rend="head">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="sp:example">
        <egXML xmlns="http://www.tei-c.org/ns/Examples">
            <xsl:apply-templates/>
        </egXML>
    </xsl:template>
    <xsl:template match="sp:example/bk:textR/sc:para">
        <xsl:apply-templates/>
    </xsl:template>

<xsl:template match="sp:remark">
    <note type="remark">
    <xsl:apply-templates/>
    </note>
    </xsl:template>
    
    <xsl:template match="sp:warning">
        <note type="warning">
            <xsl:apply-templates/>
        </note>       
    </xsl:template>
    
    <xsl:template match="sp:complement">
        <note type="complement">
            <xsl:apply-templates/>
        </note>       
    </xsl:template>
    <xsl:template match="sc:extBlock">
        <figure>
            <graphic url="{@sc:refUri}"/>
        </figure>
    </xsl:template>

    <xsl:template match="sc:inlineStyle[@role='foreign']">
        <soCalled>
            <xsl:apply-templates/>
        </soCalled>
    </xsl:template>
    
    <xsl:template match="sc:uLink[@role='note']">
        <xsl:variable name="SRC">
            <xsl:value-of select="substring-after(@sc:refUri,'Renaissance/')"/>
        </xsl:variable>
  
        <note target="{$SRC}">
            <xsl:apply-templates select="doc($SRC)//sc:para"/>
        </note>
    </xsl:template>

</xsl:stylesheet>
       
