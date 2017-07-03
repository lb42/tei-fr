<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:t="http://www.tei-c.org/ns/1.0"  exclude-result-prefixes="t" version="2.0">
    <xsl:key name="NAMES" match="t:persName" use="1"/>
   <xsl:template match="/">
        <listPerson>
       <xsl:for-each select="key('NAMES',1)">
           <xsl:sort/>
           <person>
               <xsl:attribute name="xml:id">
                   <xsl:text>P</xsl:text>
                   <xsl:number format="1111"
                       level="any"/>
               </xsl:attribute>
               <persName>
                   <xsl:choose>
                       <xsl:when test="t:surname"> <xsl:value-of
                           select="normalize-space(t:forename)"/><xsl:text> </xsl:text>
                           <xsl:value-of select="normalize-space(t:surname)"/></xsl:when>
                       <xsl:when test="t:choice">
                           <xsl:value-of select="normalize-space(t:choice/t:expan)"/>
                           
                       </xsl:when>
                       <xsl:otherwise>
                 <!--          <xsl:value-of select="normalize-space(.)"/>
                 -->          <xsl:value-of select="."/>
                           
                       </xsl:otherwise>
                   </xsl:choose>
               </persName>
               <ref>
                   <xsl:attribute name="target">#<xsl:value-of select="ancestor::*/@xml:id[1]"/></xsl:attribute>
               </ref>
           </person>
       </xsl:for-each>
            
        </listPerson>
    </xsl:template>
   
</xsl:stylesheet>
