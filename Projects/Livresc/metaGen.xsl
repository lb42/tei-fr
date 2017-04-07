<?xml version="1.0" encoding="UTF-8"?>
<xs:stylesheet xmlns:xs="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsl="http://www.w3.org/1999/XSL/fakeTransform" exclude-result-prefixes="#all"
    version="2.0">
    <!-- generate default templates for the meta element -->
    <xs:template match="LivrESC">
        <xsl:stylesheet>
            <xs:for-each-group select="item/fr_meta/meta[node()]" group-by="@type">
                <xs:sort select="current-grouping-key()"/>
                <xs:text> </xs:text>
                <xsl:template>
                    <xs:attribute name="match">
                        <xs:text>meta[@type='</xs:text>
                        <xs:value-of select="current-grouping-key()"/>
                        <xs:text>']</xs:text>
                    </xs:attribute>
                    <xsl:apply-templates/>
                </xsl:template>
                <xs:comment>
                    <xs:value-of select="count(current-group())"/>
                </xs:comment>
            </xs:for-each-group>
        </xsl:stylesheet>
    </xs:template>
    <xs:template match="text()"/>
</xs:stylesheet>
