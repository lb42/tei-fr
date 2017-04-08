<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:l="http://www.example.org/ns/nonTEI"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="xml"/>
    <xsl:template match="LivrESC">
        <listBibl>
            <xsl:apply-templates/>
        </listBibl>
    </xsl:template>
    <xsl:template match="item">
        <bibl>
            <xsl:attribute name="xml:id">
                <xsl:text>LIV</xsl:text>
                <xsl:value-of select="doc_id"/>
                <xsl:value-of select="type"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </bibl>
    </xsl:template>
    <xsl:template match="doc_id"/>
    <xsl:template match="type"/>
    
    <xsl:template match="reference">
        <idno>
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    
    <xsl:template match="date_publication">
        <pubDate>
            <xsl:if test="following-sibling::date_beginning">
                <xsl:attribute name="notBefore">
                    <xsl:value-of select="following-sibling::date_beginning"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="following-sibling::fr_date_beginning">
                <xsl:attribute name="notBefore">
                    <xsl:value-of select="following-sibling::fr_date_beginning"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="following-sibling::fr_period">
                <xsl:attribute name="period">
                    <xsl:value-of select="following-sibling::fr_period"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="following-sibling::fr_date_publication">
                <xsl:attribute name="when">
                    <xsl:value-of select="following-sibling::fr_date_publication"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </pubDate>
    </xsl:template>
    <!-- dates are in various formats and are inconsistently supplied -->
    <xsl:template match="date_beginning"/>
    <xsl:template match="fr_date_beginning"/>
    <xsl:template match="fr_period"/>
    <xsl:template match="fr_date_publication"/>
    <!-- we dont distinguish creator from contributor: the resp element specifies what they did -->
    
    <xsl:template match="creator">
        <respStmt>
            <xsl:attribute name="type">
                <xsl:value-of select="creator_type"/>
            </xsl:attribute>
            <persName>
                <surname>
                    <xsl:value-of select="creator_name"/>
                </surname>
                <forename>
                    <xsl:value-of select="creator_firstname"/>
                </forename>
                <xsl:apply-templates select="creator_date_birthday"/>
                <xsl:apply-templates select="creator_date_death"/>
            </persName>
            <xsl:apply-templates select="creator_job"/>
        </respStmt>
    </xsl:template>
    
    <xsl:template match="creator_date_birthday">
        <date type="birth">
            <xsl:apply-templates/>
        </date>
    </xsl:template>
    
    <xsl:template match="creator_date_death">
        <date type="death">
            <xsl:apply-templates/>
        </date>
    </xsl:template>
    
    <xsl:template match="creator_job">
        <resp>
            <xsl:apply-templates/>
        </resp>
    </xsl:template>
    
    <xsl:template match="creator_type"/>
    <xsl:template match="creator_name"/>
    <xsl:template match="creator_firstname"/>
    
    <xsl:template match="contributor">
        <respStmt>
            <xsl:attribute name="type">
                <xsl:value-of select="contributor_type"/>
            </xsl:attribute>
            <persName>
                <surname>
                    <xsl:value-of select="contributor_name"/>
                </surname>
                <forename>
                    <xsl:value-of select="contributor_firstname"/>
                </forename>
                <xsl:apply-templates select="contributor_date_birthday"/>
                <xsl:apply-templates select="contributor_date_death"/>
            </persName>
            <xsl:apply-templates select="contributor_job"/>
            <xsl:apply-templates select="contributor_fr_description"/>
        </respStmt>
    </xsl:template>
    <xsl:template match="contributor_date_birthday|publisher_date_birthday">
        <date type="birth">
            <xsl:apply-templates/>
        </date>
    </xsl:template>
    <xsl:template match="contributor_date_death|publisher_date_death">
        <date type="death">
            <xsl:apply-templates/>
        </date>
    </xsl:template>
    <xsl:template match="contributor_job">
        <resp>
            <xsl:apply-templates/>
        </resp>
    </xsl:template>
    <xsl:template match="contributor_type"/>
    <xsl:template match="contributor_name"/>
    <xsl:template match="contributor_firstname"/>
    <!-- a publisher who isn't a "editeur" is another kind of contributor -->
    <xsl:template match="publisher[contains(publisher_job, 'Editeur')]">
        <publisher>
            <xsl:attribute name="type">
                <xsl:value-of select="publisher_type"/>
            </xsl:attribute>
            <xsl:apply-templates select="publisher_name"/>
        </publisher>
    </xsl:template>
    <xsl:template match="publisher">
        <respStmt>
            <xsl:attribute name="type">
                <xsl:value-of select="publisher_type"/>
            </xsl:attribute>
            <xsl:apply-templates select="publisher_name"/>
            <xsl:apply-templates select="publisher_fr_description"/>
            <xsl:apply-templates select="publisher_date_birthday"/>
            <xsl:apply-templates select="publisher_date_death"/>
            <xsl:apply-templates select="publisher_job"/>
        </respStmt>
    </xsl:template>
    <xsl:template match="publisher_job">
        <resp>
            <xsl:value-of select="."/>
        </resp>
    </xsl:template>
    <xsl:template match="publisher_name">
        <xsl:choose>
            <xsl:when test="following-sibling::publisher_firstname">
                <persName>
                    <surname>
                        <xsl:value-of select="."/>
                    </surname>
                    <forename>
                        <xsl:value-of select="following-sibling::publisher_firstname"/>
                    </forename>
                </persName>
            </xsl:when>
            <xsl:otherwise>
                <orgName>
                    <xsl:value-of select="."/>
                </orgName>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="publisher_fr_description">
        <xsl:comment><xsl:apply-templates/></xsl:comment>
    </xsl:template>
    
    <xsl:template match="publisher_firstname"/>
    <xsl:template match="publisher_type"/>
    
    <xsl:template match="fr_identifier">
        <ref target="{.}"/>
    </xsl:template>
    
    <xsl:template match="fr_title">
        <title xml:lang="fr">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <xsl:template match="fr_title_long">
        <title level="detail">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <xsl:template match="fr_rights">
        <availability>
            <ab>
                <xsl:apply-templates/>
            </ab>
        </availability>
    </xsl:template>
    
    <xsl:template match="fr_description">
        <!-- link to more detailed description -->
        <ref><xsl:apply-templates/></ref>
    </xsl:template>
   
    <xsl:template match="meta[starts-with(@type,'collation_detail')]">
        <l:collation>
            <xsl:attribute name="l:pp">
                <xsl:value-of select="parent::fr_meta/meta[starts-with(@type,'collation_nombre')]"/>
            </xsl:attribute>
            <xsl:attribute name="l:format">
                <xsl:value-of select="parent::fr_meta/meta[starts-with(@type,'collation_format')]"/>
            </xsl:attribute>
            <ab><xsl:apply-templates/></ab></l:collation>
    </xsl:template>
    <xsl:template match="meta[starts-with(@type,'collation_nombre')]"/>
    <xsl:template match="meta[starts-with(@type,'collation_format')]"/>
    
    
    <xsl:template match="meta[@type='edition_justification_03']">
       <edition>
           <xsl:attribute name="l:size">
               <xsl:value-of select="parent::fr_meta/meta[starts-with(@type,'edition_nombre_tirages')]"/>
           </xsl:attribute>
           <xsl:attribute name="l:price">
               <xsl:value-of select="parent::fr_meta/meta[starts-with(@type,'edition_prix_origine')]"/>
           </xsl:attribute>
           <pubPlace> <xsl:value-of select="parent::fr_meta/meta[starts-with(@type,'edition_lieu')]"/></pubPlace>
           <ab><xsl:apply-templates/></ab>
           <note><xsl:value-of select="parent::fr_meta/meta[@type='edition_autre_05']"/>
             </note>
           <l:illus><xsl:value-of select="parent::fr_meta/meta[@type='illustration_nombre_total_09']"/></l:illus>
       </edition> 
    </xsl:template>
   
    <xsl:template match="meta[starts-with(@type,'edition_nombre_tirages')]"/>
    <xsl:template match="meta[starts-with(@type,'edition_prix_origine')]"/>
    <xsl:template match="meta[starts-with(@type,'edition_lieu')]"/>
    <xsl:template match="meta[starts-with(@type,'edition_autre')]"/>
    <xsl:template match="meta[starts-with(@type,'illustration_nombre_total_09')]"/>
    
   
    <xsl:template match="fr_meta">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- ignore all empty meta elements -->
   <xsl:template match="meta[@type][not(node())]"/>
    <!-- suppressed as they appear only once -->
    <xsl:template match="fr_subject"/>
     <xsl:template match="fr_tag"/> 
    
</xsl:stylesheet>
