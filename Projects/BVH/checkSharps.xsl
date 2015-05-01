<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:rng="http://relaxng.org/ns/structure/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0" 
  version="2.0" exclude-result-prefixes="svrl rng tei a teix">
  


  <xsl:output indent="yes" omit-xml-declaration="yes"/>

  <!--xsl:include href="pointerattributes.xsl"/-->
  
  <xsl:key name="IDS" match="*[@xml:id]" use="@xml:id"/>
  
  <xsl:variable name="root" select="/"/>

  <xsl:template match="/">
    <Messages>
      <xsl:apply-templates/>
      <xsl:for-each select="distinct-values( //*[@xml:id]/@xml:id )">
        <xsl:variable name="thisID" select="."/>
        <xsl:for-each select="$root">
          <xsl:if test="count( key('IDS', $thisID ) ) > 1">
            <ERROR>id '<xsl:value-of select="$thisID"/>' used more than once</ERROR>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>

    </Messages>
  </xsl:template>
  
  
  <xsl:template match="text()"/>

  <xsl:template match="teix:*|tei:*|rng:*">
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates select="teix:*|tei:*|rng:*"/>
  </xsl:template>
  
  <xsl:template match="@*">
    <xsl:if test="starts-with(.,'#')">    <xsl:call-template name="checklinks">
      <xsl:with-param name="stuff" select="normalize-space(.)"/>
    </xsl:call-template></xsl:if>  </xsl:template>


  <xsl:template name="checklinks">
    <xsl:param name="stuff"/>
    <xsl:variable name="context" select="."/>
    <xsl:for-each select="tokenize($stuff,' ')">
      <xsl:sequence select="tei:checkThisLink(normalize-space(.),$context)"/>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:function name="tei:checkThisLink" as="node()*">
    <xsl:param name="What"/>
    <xsl:param name="Where"/>
    <xsl:for-each select="$Where">
      <xsl:choose>
        <xsl:when test="starts-with($What,'#')">
          <xsl:choose>
            <xsl:when test="id(substring($What,2))"/>
            <xsl:otherwise>
              <xsl:call-template name="Error">
                <xsl:with-param name="value" select="$What"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="starts-with($What,'tei:')"/>
        <xsl:when test="starts-with($What,'bvh:')"/>
        <xsl:when test="contains($What,'.jpg')"/>
        <xsl:when test="contains($What,'.JPG')"/>
        
        <xsl:when test="starts-with($What,'mailto:')"/>
        <xsl:when test="starts-with($What,'http:')"/>
        <xsl:when test="contains($What,'.html')"/>
        <xsl:when test="not(contains($What,'/')) and not(id($What))">
          <xsl:call-template name="Error">
            <xsl:with-param name="value" select="$What"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:function>

  <xsl:template name="loc">
    <xsl:for-each select="ancestor::tei:*|ancestor::teix:*">
      <xsl:value-of select="name(.)"/>
      <xsl:text>[</xsl:text>
      <xsl:choose>
        <xsl:when test="@ident">
          <xsl:text>"</xsl:text>
          <xsl:value-of select="@ident"/>
          <xsl:text>"</xsl:text>
        </xsl:when>
        <xsl:when test="@xml:id">
          <xsl:text>"</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>"</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="position()"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>]/</xsl:text>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="Remark">
    <xsl:param name="value"/>
    <Note><xsl:value-of select="name(.)"/> points to ID not in my namespace: <xsl:value-of
        select="$value"/> (<xsl:call-template name="loc"/>) </Note>
  </xsl:template>
  <xsl:template name="Error">
    <xsl:param name="value"/>
    <ERROR>      <xsl:value-of select="concat(name(parent::*), '@',name(.))"/> points to non-existent <xsl:value-of select="$value"/>
        (<xsl:call-template name="loc"/>) </ERROR>
  </xsl:template>
  <xsl:template name="Warning">
    <xsl:param name="value"/>
    <xsl:variable name="where">
      <xsl:value-of select="name(parent::*)"/>
      <xsl:text>@</xsl:text>
      <xsl:value-of select="name(.)"/>
    </xsl:variable>
    <Note><xsl:value-of select="$where"/> points to something I cannot find: <xsl:value-of
        select="$value"/> (<xsl:call-template name="loc"/>) </Note>
  </xsl:template>
  
  
  <!--<xsl:template name="checkexamplelinks">
    <xsl:param name="stuff"/>
    <xsl:variable name="context" select="."/>
    <xsl:for-each select="tokenize($stuff,' ')">
      <xsl:sequence select="tei:checkThisExampleLink(normalize-space(.),$context)"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:function name="tei:checkThisExampleLink" as="node()*">
    <xsl:param name="What"/>
    <xsl:param name="Where"/>
    <xsl:for-each select="$Where">
      <xsl:choose>
        <xsl:when test="starts-with($What,'#')">
          <xsl:variable name="N">
            <xsl:value-of select="substring-after($What,'#')"/>
          </xsl:variable>
          <xsl:choose>
            
  
        
            <xsl:when test="id($N)">
              <xsl:call-template name="Remark">
                <xsl:with-param name="value" select="$What"/>
              </xsl:call-template>
            </xsl:when>
            
          </xsl:choose>
        </xsl:when>
        <xsl:when test="starts-with($What,'example.xml')"/>
        <xsl:when test="ends-with($What,'.png')"/>
        <xsl:when test="ends-with($What,'.mp4')"/>
        <xsl:when test="ends-with($What,'.wav')"/>
        <xsl:when test="ends-with($What,'.rng')"/>
        <xsl:when test="starts-with($What,'tei:')"/>
        <xsl:when test="starts-with($What,'mailto:')"/>
        <xsl:when test="starts-with($What,'http:')"/>
        <xsl:when test="name(.)='url' and         local-name(parent::*)='graphic'"/>
        <xsl:when test="name(.)='url' and         local-name(parent::*)='fsdDecl'"/>
        <xsl:when test="name(.)='target' and         local-name(parent::*)='ref'"/>
        <xsl:when test="name(.)='target' and         local-name(parent::*)='ptr'"/>
        <xsl:when test="name(.)='url' and local-name(parent::*)='graphic'"/>
        <xsl:when test="not(contains($What,'/'))">
          <xsl:call-template name="Warning">
            <xsl:with-param name="value" select="$What"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:function>
-->
</xsl:stylesheet>
