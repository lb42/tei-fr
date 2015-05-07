<xsl:stylesheet 
 xmlns:teix="http://www.tei-c.org/ns/Examples"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:rng="http://relaxng.org/ns/structure/1.0"
  exclude-result-prefixes="tei"
 version="2.0">

<xsl:output 
   method="xml"
   encoding="utf-8"
   indent="yes"
   omit-xml-declaration="yes"/>

<!-- (1)  get rid of duplicate xml:id values -->

<!-- change xml:id on name to @ref -->
<xsl:template match="tei:name/@xml:id">
<xsl:attribute name="ref">
<xsl:value-of select="concat('#',.)"/>
</xsl:attribute>
</xsl:template>

<!-- add prefix to make div xml:ids unique -->
<xsl:template match="tei:div/@xml:id">
<xsl:attribute name="xml:id">
<xsl:value-of select="concat(substring-before(ancestor::tei:TEI/@xml:id,'tei'), .)"/>
</xsl:attribute>
</xsl:template>

  <!-- likewise for handNote -->
  <xsl:template match="tei:handNote/@xml:id">
    <xsl:attribute name="xml:id">
      <xsl:value-of select="concat(substring-before(ancestor::tei:TEI/@xml:id,'tei'), .)"/>
    </xsl:attribute>
  </xsl:template>

<!-- change to scheme and make valid pointer -->
<xsl:template match="tei:taxonomy/@xml:id">
  <xsl:attribute name="scheme">
    <xsl:value-of select="concat('#',.)"/>       
  </xsl:attribute>
</xsl:template>
    
<!-- remove xml:id, used haphazardly on various elements -->
<!--xsl:template match="tei:bibl/@xml:id"/--> <!-- needed for @source and ? @resp pointers -->
<xsl:template match="tei:milestone/@xml:id"/>
<!--xsl:template match="tei:handNote/@xml:id"/--> 
<xsl:template match="tei:zone/@xml:id"/>
<xsl:template match="tei:abbr/@xml:id"/>
<!--xsl:template match="tei:add/@xml:id"/-->
  

<!-- (2) next we validate  all pointer attributes -->
  
<!-- remove empty <g> -->
<xsl:template match="tei:g[@ref='']"/>
  
<!-- fix local refs starting with "n"  --> 
<xsl:template match="tei:ref[@target]">
  <xsl:if test="starts-with(.,'n')">
    <xsl:attribute name="target">
      <xsl:value-of select="concat('#',concat(substring-before(ancestor::tei:TEI/@xml:id,'tei'), .))"/>
    </xsl:attribute>
  </xsl:if>
</xsl:template>  
  
<!-- fix @scheme attribute values -->
<xsl:template match="tei:catRef/@scheme">
 <xsl:attribute name="scheme">
  <xsl:choose>
   <xsl:when test=".='corpus-BVH'">bvh:corpus</xsl:when>
    <xsl:when test=".='version'">bvh:version</xsl:when>
    <xsl:otherwise>bvh:unknown</xsl:otherwise>
 </xsl:choose>
 </xsl:attribute>
</xsl:template>  
  
  <xsl:template match="tei:keywords/@scheme">
    <xsl:attribute name="scheme">
      <xsl:choose>
        <xsl:when test=".='#index-matiere.xml'">bvh:matiere</xsl:when>
        <xsl:when test=".='#Index-matiere.xml'">bvh:matiere</xsl:when>
        <xsl:when test=".='BVH-matiere'">bvh:matiere</xsl:when>
        <xsl:otherwise>bvh:unknown</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>  
  
  <!-- fix @who attribute values -->
  <xsl:template match="@who[substring(.,1,1)!='#']">
    <xsl:attribute name="who">
      <xsl:value-of select="concat('#',.)"/>       
    </xsl:attribute>
  </xsl:template>  
  
  <!-- fix @resp attribute values -->
  <xsl:template match="@resp[substring(.,1,1)!='#']">
    <xsl:attribute name="resp">
      <xsl:value-of select="concat('#',.)"/>       
    </xsl:attribute>
  </xsl:template>  
  
  <!-- fix @hand attribute values -->
  <xsl:template match="@hand[substring(.,1,1)!='#']">
    <xsl:attribute name="hand">
      <xsl:value-of select="concat('#',.)"/>       
    </xsl:attribute>
  </xsl:template>  
  
  <!-- remove redundant resp=#transcription -->
  <xsl:template match="tei:respStmt/tei:persName[@resp='#transcription']">
    <xsl:element name="name"  namespace="http://www.tei-c.org/ns/1.0" >
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  
  <!-- change @corresp to @ref on name -->
  <xsl:template match="tei:name/@corresp">
    <xsl:attribute name="ref">
      <xsl:value-of select="."/>       
    </xsl:attribute>
  </xsl:template>  

  <!-- change @corresp to @source on corr -->
  <xsl:template match="tei:corr/@corresp">
    <xsl:attribute name="source">
      <xsl:value-of select="."/>       
    </xsl:attribute>
  </xsl:template>  
  
  <!-- change @corresp to @facs on p -->
   <xsl:template match="tei:p/@corresp">
    <xsl:if test=".">  
    <xsl:attribute name="facs">
      <xsl:choose>
        <xsl:when test="substring(.,1,1)='#'">
          <xsl:value-of select="substring-after(.,'#')"/>
        </xsl:when>      
        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
      </xsl:choose>      
    </xsl:attribute>
  </xsl:if>
  </xsl:template>  
  
  <xsl:template match="tei:resp/@corresp"/> <!-- redundant with sibling <resp> -->
  <xsl:template match="tei:edition/@corresp"/> <!-- or make them both into child <ref>s -->
  
  <!-- remove empty taxonomy and its parent classDecl for now -->
  <xsl:template match="tei:taxonomy[@corresp]"/>
  <xsl:template match="tei:classDecl"/>
  
  <!-- turn @corresp on textClass/keywords/list/item into proper catRef -->

<xsl:template match="tei:textClass">
  <xsl:element name="textClass" namespace="http://www.tei-c.org/ns/1.0">
    <xsl:apply-templates/>
  <xsl:choose>
  <xsl:when test="tei:keywords/tei:list/tei:item/@corresp">
  <xsl:element name="catRef" namespace="http://www.tei-c.org/ns/1.0">
    <xsl:attribute name="scheme">bvh:unknown</xsl:attribute>
    <xsl:attribute name="target">
      <xsl:variable name="target">
        <xsl:value-of select="tei:keywords/tei:list/tei:item/@corresp"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="starts-with($target,'#')"> <xsl:value-of select="$target"/></xsl:when>
      <xsl:otherwise>
      <xsl:value-of select="concat('#',$target)"/>
    </xsl:otherwise></xsl:choose>
    </xsl:attribute>
  </xsl:element> 
  </xsl:when>
    <xsl:otherwise></xsl:otherwise>
</xsl:choose>
  </xsl:element>
</xsl:template>
  <xsl:template match="tei:keywords/tei:list/tei:item/@corresp"/>
  
  <!-- 3 : suppress some misc oddities/errors -->
  
  <xsl:template match="@rendition"/>
  
  <!--xsl:template match="tei:ab/@rend"/-->
  
  <xsl:template match="tei:relatedItem"/> <!-- all but one are type="original" and that one is empty -->
  
  <!--xsl:template match="tei:msIdentifier/@xml:id"/-->
  
  <xsl:template match="tei:sp/@xml:id">
    <xsl:attribute name="who">
      <xsl:value-of select="concat('#',.)"/>       
    </xsl:attribute>
  </xsl:template>
  
  <!-- all about the base -->
  
  <xsl:template match="tei:bibl">
    <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
      <xsl:if test="@xml:id">
        <xsl:attribute name="xml:id">
          <xsl:value-of select="@xml:id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

<xsl:template match="tei:bibl/@xml:base[.='#ref1']"/>

  <xsl:template match="tei:bibl/@xml:base">
    <xsl:element name="ref"  namespace="http://www.tei-c.org/ns/1.0" >
      <xsl:attribute name="target">
        <xsl:value-of select="."/>
       </xsl:attribute>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="tei:authority/@xml:base">
    <xsl:element name="ref"  namespace="http://www.tei-c.org/ns/1.0" >
      <xsl:attribute name="target">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="tei:edition/@xml:base">
    <xsl:element name="ref"  namespace="http://www.tei-c.org/ns/1.0" >
      <xsl:attribute name="target">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  
  
  <xsl:template match="tei:listBibl/@xml:base"/>
  
     
  
  <!-- remove some typos -->
  <xsl:template match="tei:restore"/>
  <xsl:template match="tei:author/@corresp"/>
  
  
  
  <!-- 4: fix things no longer valid -->
  
  <!-- biblScope/@type has been replaced by @unit -->
  <xsl:template match="tei:biblScope/@type">
    <xsl:attribute name="unit">  
      <xsl:value-of select="."/>
    </xsl:attribute></xsl:template>
  
 
  
  <!-- remove outdated @version -->
  <xsl:template match="tei:TEI/@version"/>
  
<!-- copy everything else -->

 <xsl:template match="*">
 <xsl:copy>
  <xsl:apply-templates select="@*"/>
  <xsl:apply-templates 
      select="*|comment()|processing-instruction()|text()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="@*|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

<xsl:template match="comment()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>