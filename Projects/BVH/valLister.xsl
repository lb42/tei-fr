<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="elementSpec/attList/attDef/valList">
        <table>
            <row><cell><xsl:value-of select="../../../@ident"/></cell>
                <cell><xsl:value-of select="../../../@ident"/></cell><cell/></row>
       <xsl:for-each select="valItem"><row><cell/><cell/><cell><xsl:value-of select="@ident"/></cell></row>
        </xsl:for-each>
        </table></xsl:template>
  
</xsl:stylesheet>