<xsl:stylesheet
    version="2.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
<xsl:import
    href="/usr/share/xml/tei/stylesheet/latex/latex.xsl"/>

<xsl:param name="latexLogo">logo</xsl:param>
<xsl:param name="spaceCharacter">\hspace*{6pt}</xsl:param>
<xsl:param name="showNamespaceDecls">false</xsl:param>
<xsl:template name="latexPreambleHook">
\usepackage{pdfpages}
\usepackage{times,fancyvrb,graphicx,longtable}
\def\Gin@extensions{.pdf,.png,.jpg,.mps,.tif}
\let\mainmatter\relax
\let\frontmatter\relax
\let\backmatter\relax
\setlength{\headheight}{18pt}
\setcounter{tocdepth}{2}
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{\markboth{#1}{}}
</xsl:template>

<xsl:template name="tei:pb">
\newpage
</xsl:template>

  <xsl:template match="tei:titlePage">
  \begin{titlepage}
<xsl:apply-templates/>
  \maketitle
  \end{titlepage}
  \cleardoublepage
</xsl:template>


<xsl:template match="tei:ptr[@rend='pdfslidesinclude']">
\includepdf[noautoscale=true,scale=0.65,nup=2x3,pagecommand={\sectionmark{<xsl:value-of select="@n"/>}},delta=5mm
5mm,turn=false,frame,pages=-]{<xsl:value-of select="@target"/>}
</xsl:template>

<xsl:template match="tei:ptr[@rend='pdfinclude']">
\includepdf[pages=-]{<xsl:value-of select="@target"/>}

</xsl:template>

<xsl:template match="tei:ptr[@rend='pdfinclude-landscape']">
\includepdf[pagecommand={\sectionmark{<xsl:value-of select="@n"/>}},scale=0.92,angle=90,pages=-]{<xsl:value-of select="@target"/>}

</xsl:template>


<xsl:template match="tei:ref[@rend='showurl']">
  <xsl:apply-imports/>
  \\(\texttt{<xsl:value-of select="@target"/>})
</xsl:template>

<xsl:template match="teix:egXML[@rend='invisible']"/>


</xsl:stylesheet>




