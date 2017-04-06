<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     exclude-result-prefixes="#all"
     version="2.0">
    
    
    
    <xsl:template match="LivrESC">
        <xsl:for-each-group select="item/fr_meta/meta[node()]" group-by="@type">
            <xsl:sort select="current-grouping-key()"/>
          
            <xsl:text>
            </xsl:text>
            
            <template> 
                <xsl:attribute name="match">
                  <xsl:text>meta[@type='</xsl:text>  
                   <xsl:value-of select="current-grouping-key()"/>
                <xsl:text>'</xsl:text></xsl:attribute>
            </template>
            <xsl:comment><xsl:value-of select="count(current-group())"/></xsl:comment>
            
            
            </xsl:for-each-group>
        </xsl:template>
    
    <xsl:template match="text()"/>
    
</xsl:stylesheet>