<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:template match="//tei:*[@xml:lang='en']"/>
    
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text(
                )"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="text()|comment()|@*|processing-instruction()">
        <xsl:copy/>
    </xsl:template>
    
</xsl:stylesheet>