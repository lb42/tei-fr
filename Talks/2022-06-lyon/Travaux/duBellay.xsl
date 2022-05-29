<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="2.0">

<!--  <xsl:output method="html"/>
-->
<xsl:template match="/TEI">
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    </head>
    <body>
      <xsl:apply-templates/>
    </body>
  </html>
</xsl:template>

</xsl:stylesheet>
