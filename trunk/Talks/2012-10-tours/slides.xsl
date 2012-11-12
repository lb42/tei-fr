<xsl:stylesheet
    version="2.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="tei teix xsl">
  
<xsl:import href="/usr/share/xml/tei/stylesheet/slides/teilatex-slides.xsl"/>
<xsl:param name="reencode">false</xsl:param>
<xsl:param name="attsOnSameLine">6</xsl:param>
<xsl:param name="latexLogo"></xsl:param>
<xsl:param name="spaceCharacter">\hspace*{6pt}</xsl:param>
<xsl:param name="beamerClass">Singapore</xsl:param>
<xsl:param name="startAttribute">{\color{blue2}</xsl:param>
<xsl:param name="startAttributeValue">{\color{blue2}</xsl:param>
<xsl:param name="startElement">{\color{blue1}</xsl:param>
<xsl:param name="startElementName">\textbf{\color{blue1}</xsl:param>
<xsl:param name="showNamespaceDecls">false</xsl:param>

  <xsl:param name="omitNSDecls">
    xmlns="http://purl.org/NET/crm-owl#
    xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#
    http://www.tei-c.org/ns/1.0
    http://www.w3.org/1999/xhtml
  </xsl:param>
  <xsl:template name="latexPreambleHook">
\usepackage{pdfpages}
  </xsl:template>

<xsl:template name="latexPackages">
\usepackage{framed}
\usepackage{fontspec}
\usepackage{colortbl}
\usepackage{xunicode}
%\setmonofont{Junicode}
%\setmonofont[Scale=0.86]{Lucida Sans Typewriter}
%\setmonofont[Scale=0.86]{Andale Mono}
%\setmonofont[Scale=0.8]{DejaVu Sans Mono}
\setromanfont{Minion Pro}
\setsansfont{Myriad Pro}
\usetheme{<xsl:value-of select="$beamerClass"/>}
\useinnertheme[shadow=true]{rounded}
\usecolortheme{orchid}
\setbeamercolor*{frametitle}{parent=palette primary}
\definecolor{shadecolor}{gray}{0.875}
\usepackage{fancyvrb,fancyhdr,longtable}
\def\Gin@extensions{.pdf,.png,.jpg,.mps,.tif}
\setbeamercovered{transparent}
\usenavigationsymbolstemplate{}
\xdefinecolor{blue1}{rgb}{0, 0, 0.7}
\xdefinecolor{blue2}{rgb}{0, 0, 1}
\let\mainmatter\relax
\let\frontmatter\relax
\let\backmatter\relax
\let\endfoot\relax
\let\endlastfoot\relax
\parskip3pt
\setbeamertemplate{footline}
{\hspace{1em}\includegraphics[height=4ex]{logo.png} \hspace{2em}
\hfill \textcolor{gray}{\insertframenumber/\inserttotalframenumber}
\vspace{1em}}
</xsl:template>

<xsl:template match="tei:gi">
  <xsl:text>{\color{blue2}&lt;</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>&gt;}</xsl:text>
</xsl:template>

  <xsl:template match="tei:eg">
    <xsl:variable name="fontsize">
      <xsl:choose>
	<xsl:when test="@rend='teeny'">
	  <xsl:text>{5.5pt}{6pt}</xsl:text>
	</xsl:when>
	<xsl:when test="@rend='tiny'">
	  <xsl:text>{6.5pt}{7pt}</xsl:text>
	</xsl:when>
	<xsl:when test="@rend='small'">
	  <xsl:text>{7.5pt}{8pt}</xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text>{8.5pt}{9pt}</xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:text>\bgroup\fontsize</xsl:text>
    <xsl:value-of select="$fontsize"/>
    <xsl:text>\ttfamily
\selectfont\par</xsl:text>
    <xsl:text>\vskip 10pt\begin{shaded}
 \obeylines\obeyspaces </xsl:text>
    <xsl:apply-templates mode="eg"/>
    <xsl:text>\end{shaded}</xsl:text>
    <xsl:text>\par\egroup </xsl:text>
  </xsl:template>

  <xsl:template match="tei:table">
    <xsl:variable name="fontsize">
      <xsl:choose>
	<xsl:when test="@rend='teeny'">
	  <xsl:text>{5.5pt}{6pt}</xsl:text>
	</xsl:when>
	<xsl:when test="@rend='tiny'">
	  <xsl:text>{6.5pt}{7pt}</xsl:text>
	</xsl:when>
	<xsl:when test="@rend='small'">
	  <xsl:text>{7.5pt}{8pt}</xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text>{8.5pt}{9pt}</xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:text>\bgroup\fontsize</xsl:text>
    <xsl:value-of select="$fontsize"/>
    <xsl:text>\selectfont\par\begin{longtable}</xsl:text>
    <xsl:call-template name="makeTable"/>
    <xsl:text>\end{longtable}\par\egroup </xsl:text>
  </xsl:template>
</xsl:stylesheet>


