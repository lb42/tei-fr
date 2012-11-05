<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    
    
<xsl:template match="TEI">
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
            <title>Molière</title>
        </head>        
        <body>
        <xsl:apply-templates/>
        </body>        
    </html>
</xsl:template>

<xsl:template match="head">
    <h1 style="color:blue;text-align:center;">
        <xsl:apply-templates/>
    </h1>
</xsl:template>

<xsl:template match="castList">
    <h2 style="color:green;text-align:center;">
        <xsl:apply-templates/>
    </h2>
</xsl:template>
    
<xsl:template match="sp">
    <p>
        <xsl:apply-templates/>
    </p>
</xsl:template>

<xsl:template match="speaker">
    <span style="font-weight:bold;">
        <xsl:apply-templates/>
    </span>
</xsl:template>

<xsl:template match="hi[@rend='it']">
    <i>
        <xsl:apply-templates/>
    </i>
</xsl:template>


</xsl:stylesheet>