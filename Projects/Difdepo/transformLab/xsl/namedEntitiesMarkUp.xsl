<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZŠšßŽžÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÑÒÓÔÕÖŒØÙÚÛÜÝÞàáâãäåæçèéêëìíîïðñòóôõöœøùúûýýþÿ.-?,;:!/’«»+%=();*  &amp;&gt;&lt;&quot;'"/>
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzssszzaaaaaaaceeeeiiiinoooooœouuuuybaaaaaaaceeeeiiiionooooooouuuyyby________________________'"/>
    <xsl:output method="xml" encoding="utf-8" indent="yes"/>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//tei:persName/node() | //tei:name[@type = 'manif']/node() | //tei:orgName/node() | //tei:text//tei:title/node() | //tei:term/node() | //tei:placeName/node()">
        <!--    [not (@ref)] if we don't want to overwriter existing @ref    -->
        <xsl:variable name="normalizednode">
            <xsl:value-of select="translate(translate(., $uppercase, $smallcase), '_', '')"/>
        </xsl:variable>
        <xsl:for-each select="document('../namedEntities/namedEntities.xml')//forme1 | document('../namedEntities/namedEntities.xml')//forme2 | document('../namedEntities/namedEntities.xml')//forme3 | document('../namedEntities/namedEntities.xml')//forme4 | document('../namedEntities/namedEntities.xml')//forme5 | document('../namedEntities/namedEntities.xml')//forme6 | document('../namedEntities/namedEntities.xml')//forme7 | document('../namedEntities/namedEntities.xml')//forme8">
            <xsl:variable name="normalizedform">
                <xsl:value-of select="translate(translate(., $uppercase, $smallcase), '_', '')"/>
            </xsl:variable>
            <xsl:if test="$normalizednode = $normalizedform">
                <xsl:variable name="id">
                    <xsl:value-of select="./preceding-sibling::id/node()"/>
                </xsl:variable>
                <xsl:attribute name="ref">#<xsl:value-of select="$id"/></xsl:attribute>
            </xsl:if>
        </xsl:for-each>
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:variable name="first_page">
        <xsl:value-of select="substring-before(substring-after(//tei:titleStmt/tei:title, 'pp. '), ' à')"/>
    </xsl:variable>
    <xsl:template match="//*//tei:pb">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
            <xsl:attribute name="n">
                <xsl:value-of select="$first_page + count(preceding::tei:pb)"/>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
