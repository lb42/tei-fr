<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all"
    version="2.0">
    <!-- generate default templates for the meta element -->
    <xsl:template match="LivrESC">
        <!--<xsl:for-each-group select="item/categories/category/subcategory[node()]" group-by="@type">
                <xsl:sort select="current-grouping-key()"/>
           -->
        <xsl:for-each-group select="item/categories/category" group-by="@type">
            <xsl:sort select="current-grouping-key()"/>
            <xsl:text> 
</xsl:text>
            <xsl:variable name="grpName">
                <xsl:value-of select="replace(current-grouping-key(), '[^a-zA-Zéàè]', '_')"/>
            </xsl:variable>
            <xsl:variable name="keepGrp">
                <xsl:value-of select="current-grouping-key()"/>
            </xsl:variable>

            <xsl:element name="{$grpName}">
                <xsl:for-each-group select="//subcategory[parent::category/@type = $keepGrp]"
                    group-by="@type">
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:text> 
       </xsl:text>
                    <xsl:variable name="subGrpName">
                        <xsl:value-of select="replace(current-grouping-key(), '[^a-zA-Zéàè]', '_')"
                        />
                    </xsl:variable>

                    <xsl:element name="{$subGrpName}"/>
                    <xsl:comment>
                    <xsl:value-of select="count(current-group())"/>
                </xsl:comment>
                </xsl:for-each-group>
            </xsl:element>
        </xsl:for-each-group>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
