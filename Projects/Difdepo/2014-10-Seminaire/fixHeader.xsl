<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">


    <xsl:template match="/">
        <xsl:variable name="identifier">
            <xsl:value-of select="substring-before(tokenize(document-uri(.),'/')[last()],'.xml')"/>
        </xsl:variable>
        <xsl:text>
            <?xml-stylesheet type="text/xsl" href="http://localhost/teibp/content/teibp.xsl"?>
        </xsl:text>
        <TEI xmlns="http://www.tei-c.org/ns/1.0"><teiHeader>
            <fileDesc><titleStmt><title>
               Document <xsl:value-of select="$identifier"/> from the OULIPO Archive: TEI version
            </title></titleStmt>
                <publicationStmt>
                    <p>Unpublished resource created by DifDePo Project</p>
                </publicationStmt>
                <sourceDesc>
                    <p>Transcribed from <xsl:value-of select="$identifier"/>  by <xsl:value-of select="//tei:author"/> </p>
                </sourceDesc>
            </fileDesc>
            <xsl:copy-of select="//tei:revisionDesc"/>
        </teiHeader>
        <xsl:copy-of select='/tei:TEI/tei:text'/></TEI>
    </xsl:template>
</xsl:stylesheet>