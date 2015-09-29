<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:dc="http://purl.org/dc/elements/1.1/"
		xmlns:iso="http://www.iso.org/ns/1.0"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
		version="2.0" exclude-result-prefixes="iso tei dc html ncx">

  <!-- Modification du dossier icono, pour une archive epub correctemenT rangée -->
  <xsl:template match="//tei:graphic">
    <graphic>
      <xsl:attribute name="url"><xsl:value-of select="substring-after(@url,'../')"/></xsl:attribute>
    </graphic>
  </xsl:template>

</xsl:stylesheet>
