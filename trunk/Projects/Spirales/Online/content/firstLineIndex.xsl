<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:template match="/">
        <xsl:for-each select="//tei:div">
        <xsl:sort select="descendant::tei:l[1]"/>
           
            <xsl:variable name="divno">
               
                <xsl:number format="01"/>
            </xsl:variable>
         <xsl:variable name="firstLine">   
             <xsl:apply-templates select="descendant::tei:l[1]"/>
        </xsl:variable>
      <xsl:value-of select="$firstLine"/>
            (<xsl:apply-templates select="tei:head"/>) p. <xsl:apply-templates 
                select="tei:pb[1]"/> : <xsl:value-of select="concat('Sp',$divno)"/><xsl:text>            
        </xsl:text>      
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <xsl:value-of select="substring-before(substring-after(@facs, 'IV_1_'),'.jpg')"/>
    </xsl:template>
    
    <xsl:template match="tei:head">
          <xsl:apply-templates/>
        <xsl:if test="following-sibling::tei:head"> : </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:space">
        <xsl:text>     </xsl:text>
    </xsl:template>
</xsl:stylesheet>