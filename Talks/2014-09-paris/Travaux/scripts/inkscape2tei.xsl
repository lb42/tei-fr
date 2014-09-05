<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="tei"
    version="2.0">
    
    <xsl:template match="svg:svg">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>TITLE OF FILE</title>
                    </titleStmt>
                    <editionStmt>
                        <edition>Digital Edition</edition>
                        <respStmt>
                            <resp>Editor</resp>
                            <name>YOUR NAME HERE</name>
                        </respStmt>
                    </editionStmt>
                    <publicationStmt>
                        <availability>
                            <licence>
                                <ref target="http://creativecommons.org/licenses/by-nc/3.0/"
                                    >Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)</ref>
                            </licence>
                        </availability>
                        
                    </publicationStmt>
                    <sourceDesc>
                       <p>INFORMATION ABOUT THE SOURCE</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <creation>
                        <listChange n="writing" ordered="true">
                            <change xml:id="ch01"><certainty locus="location" cert="low">
                                <desc>Order uncertain</desc>
                            </certainty>
                            </change>
                        </listChange>
                    </creation>
                </profileDesc>
            </teiHeader>
            <sourceDoc>
            <surfaceGrp xml:id="{generate-id()}">
                <surface n="NUMBER">              
                    <graphic url="{tokenize(.//svg:image/@xlink:href, '/')[last()]}" width="{.//svg:image/@width}px" height="{.//svg:image/@height}px"/>
                    <xsl:for-each select=".//svg:rect | .//svg:path">
                        <zone xml:id="{@id}">
                            <xsl:choose>
                                <xsl:when test="self::svg:rect">
                                    <xsl:attribute name="ulx">
                                        <xsl:value-of select="@x"></xsl:value-of>
                                    </xsl:attribute>
                                    <xsl:attribute name="uly">
                                        <xsl:value-of select="@y"></xsl:value-of>
                                    </xsl:attribute>
                                    <xsl:attribute name="lrx">
                                        <xsl:value-of select="@width"></xsl:value-of>
                                    </xsl:attribute>
                                    <xsl:attribute name="lry">
                                        <xsl:value-of select="@height"></xsl:value-of>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="self::svg:path">
                                    <xsl:variable name="path1">
                                        <xsl:value-of select="substring-before(lower-case(@d), 'z')"/>
                                    </xsl:variable>
                                    <xsl:variable name="path2">
                                        <xsl:value-of select="substring-after($path1, 'm')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="contains($path2, 'c')">
                                    <xsl:variable name="path3">
                                        <xsl:value-of select="substring-before($path2, 'c'),substring-after($path2,'c')"/>
                                    </xsl:variable>
                                    <xsl:variable name="path">
                                        <xsl:value-of select="substring-before($path3, 'l'),substring-after($path3,'l')"/>
                                    </xsl:variable>
                                            <xsl:attribute name="points">
                                                <xsl:value-of select="normalize-space($path)"/>
                                            </xsl:attribute></xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="points">
                                                <xsl:value-of select="normalize-space($path2)"/>
                                            </xsl:attribute>
                                        </xsl:otherwise></xsl:choose>
                                    
                                </xsl:when>
                            </xsl:choose>
                            <line/>
                        </zone>
                    </xsl:for-each>
                </surface>
            </surfaceGrp>
            </sourceDoc>
        </TEI>
    </xsl:template>
</xsl:stylesheet>