<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:rng="http://relaxng.org/ns/structure/1.0"
    version="2.0">

<xsl:template match="text()"/>

<xsl:template match="tei:elementSpec">
<xsl:value-of select="@ident"/>  
<xsl:text>   </xsl:text>
<xsl:value-of select="@module"/><xsl:text>
</xsl:text>

</xsl:template>

</xsl:stylesheet>