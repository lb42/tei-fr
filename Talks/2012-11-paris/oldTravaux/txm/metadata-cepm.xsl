<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xd:doc type="stylesheet">
        <xd:short>
            
        </xd:short>
        <xd:detail>
            This stylesheet is free software; you can redistribute it and/or
            modify it under the terms of the GNU Lesser General Public
            License as published by the Free Software Foundation; either
            version 3 of the License, or (at your option) any later version.
            
            This stylesheet is distributed in the hope that it will be useful,
            but WITHOUT ANY WARRANTY; without even the implied warranty of
            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
            Lesser General Public License for more details.
            
            You should have received a copy of GNU Lesser Public License with
            this stylesheet. If not, see http://www.gnu.org/licenses/lgpl.html
        </xd:detail>
        <xd:author>Alexei Lavrentiev alexei.lavrentev@ens-lyon.fr</xd:author>
        <xd:copyright>2012, CNRS / ICAR (ICAR3 LinCoBaTO)</xd:copyright>
    </xd:doc>
    
    
    <xsl:output method="text" encoding="utf-8"/>
    
    <xsl:variable name="filedir">
        <xsl:analyze-string select="document-uri(.)" regex="^(.*)/([^/]+)$">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"></xsl:value-of>
            </xsl:matching-substring>
        </xsl:analyze-string></xsl:variable>
    
    
    <xsl:variable name="path">
        <xsl:value-of select="concat($filedir,'/files/?select=*.xml;recurse=yes;on-error=warning')"/>
    </xsl:variable>
    
    <xsl:variable name="files" select="collection($path)"/>
    
    
    
    <xsl:template match="/">
        <xsl:text>"id","langue","titre","auteur","date","editeur"&#xA;</xsl:text>        
        <xsl:for-each select="$files">
            <xsl:variable name="filename">
                <xsl:analyze-string select="document-uri(.)" regex="^(.*)/([^/]+)$">
                    <xsl:matching-substring>
                        <xsl:value-of select="regex-group(2)"></xsl:value-of>
                    </xsl:matching-substring>
                </xsl:analyze-string></xsl:variable>        
            <xsl:variable name="id"><xsl:value-of select="substring-before($filename,'.xml')"/></xsl:variable>
<!--            <xsl:variable name="volume"><xsl:value-of select="substring(substring-before($filename,'_'),2)"/></xsl:variable>-->
        	<xsl:variable name="langue"><xsl:value-of select="lower-case(//teiHeader[1]/profileDesc[1]/langUsage[1]/language[1]/@ident)"/></xsl:variable>
            <xsl:variable name="titre"><xsl:apply-templates select="//teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]"/></xsl:variable>
            <xsl:variable name="auteur"><xsl:for-each select="//teiHeader[1]/fileDesc[1]/titleStmt[1]/author">
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:if test="following-sibling::author"><xsl:text>, </xsl:text></xsl:if>
            </xsl:for-each></xsl:variable>
            <xsl:variable name="date">
                <xsl:value-of select="normalize-space(//teiHeader[1]/fileDesc[1]/editionStmt[1]/edition[1]/date[1])"/>
            </xsl:variable>
            <xsl:variable name="editeur"><xsl:value-of select="normalize-space(//teiHeader[1]/fileDesc[1]/sourceDesc[1]/bibl[1]/editor[1])"/></xsl:variable>

            <xsl:value-of select="concat('&quot;',$id,'&quot;,&quot;',$langue,'&quot;,&quot;',$titre,'&quot;,&quot;',$auteur,'&quot;,&quot;',$date,'&quot;,&quot;',$editeur,'&quot;&#xA;')"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="title">
    	<xsl:for-each select="child::*|child::text()">
    		<xsl:choose>
    			<xsl:when test="self::note"></xsl:when>
    			<xsl:otherwise><xsl:value-of select="normalize-space(translate(.,'&lt;&gt;&quot;','‹›'))"/>
    			<xsl:if test="following-sibling::node()[not(self::note)]"><xsl:text> </xsl:text></xsl:if></xsl:otherwise>
    		</xsl:choose>
    	</xsl:for-each>
    </xsl:template>
    
        
</xsl:stylesheet>