<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0" xmlns:svg="http://www.w3.org/2000/svg"
    exclude-result-prefixes="svg">
    <xsl:template name="reading">
        <xsl:param name="surface-id"/>
<script type="text/javascript" xmlns="http://www.w3.org/2000/svg">
                    <xsl:text disable-output-escaping="yes">&lt;![CDATA[
var svgDocument;
var visLayer;
var cycleLayer = 1;
</xsl:text>
<xsl:text>var layers = [</xsl:text>
<xsl:for-each select="ancestor::tei:TEI/tei:teiHeader//tei:listChange">
    <xsl:text>[</xsl:text>
    <xsl:for-each select="tei:change">
        <xsl:variable name="current-id" select="@xml:id"/>
        <xsl:if test="ancestor::tei:TEI//tei:surfaceGrp[@xml:id = $surface-id]//tei:zone[contains(@change, $current-id)]">
<xsl:text>'</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>', </xsl:text></xsl:if></xsl:for-each>
<xsl:text>], </xsl:text></xsl:for-each> 
<xsl:text disable-output-escaping="yes">]
    function startup(evt) {
	O=evt.target;
	svgDocument=O.ownerDocument;
	visLayer = 0;
	for (i = 0; i &lt; layers.length; i++)
	  for (j = 0; j &lt; layers[i].length; j++)
	   setVisibility(layers[i][j], &apos;hidden&apos;);
    
	O.setAttribute(&quot;onmousedown&quot;,&quot;showNext()&quot;)
}

function showNext() {
   if (visLayer &gt;= layers[cycleLayer].length)
     return;
     
   setVisibility(layers[cycleLayer][visLayer++], &apos;inherit&apos;);
}

function setVisibility(elementID, visibility) {
    var element = svgDocument.getElementById(elementID);
    if (element != null)
        element.setAttribute(&apos;visibility&apos;, visibility);
}
//]]&gt;</xsl:text>
</script>
    </xsl:template>
    <xsl:template name="time">
        <xsl:param name="surface-id"></xsl:param>
        <script type="text/javascript" xmlns="http://www.w3.org/2000/svg">
                    <xsl:text disable-output-escaping="yes">&lt;![CDATA[
var svgDocument;
var visLayer;</xsl:text>
                        <xsl:text>var layers = [</xsl:text>
<xsl:for-each select="ancestor::tei:TEI/tei:teiHeader//tei:listChange/tei:change">
    <xsl:variable name="current-id" select="@xml:id"/>
        <xsl:if test="ancestor::tei:TEI//tei:surfaceGrp[@xml:id = $surface-id]//tei:zone[contains(@change, $current-id)]">
<xsl:text>'</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>', </xsl:text></xsl:if>
</xsl:for-each> 
<xsl:text disable-output-escaping="yes">]
    function startup(evt) {
	O=evt.target;
	svgDocument=O.ownerDocument;
	visLayer = 0;
	for (i = 0; i &lt; layers.length; i++)
	  setVisibility(layers[i], &apos;hidden&apos;);
	O.setAttribute(&quot;onmousedown&quot;,&quot;showNext()&quot;)
}

function showNext() {
   if (visLayer &gt;= layers.length)
     return;
     
   setVisibility(layers[visLayer++], &apos;inherit&apos;);
}

function setVisibility(elementID, visibility) {
    var element = svgDocument.getElementById(elementID);
    if (element != null)
        element.setAttribute(&apos;visibility&apos;, visibility);
}
//]]&gt;</xsl:text>
</script>
    </xsl:template>
</xsl:stylesheet>