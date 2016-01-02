<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  version="2"
  exclude-result-prefixes="tei xs">
 
  <!--
            <p>Numéro de scan* : 10010200</p>
            <p>Numéros de pages* : 1 à 2</p>
            <p>Type de document : </p>
            <p>Date : 03/11/1977 <hi rend="italic">(dd/MM/yyyy)</hi></p>
            <p>Lieu : chez FLL</p>
            <p>Oulipiens présents : FLL; HM;CB;IC;PF;LF;MB; JR; NA (<hi rend="italic">intiales
                    seulement, séparées par des point-virgules)</hi></p>
            <p>Invités : Jacques Rigaud</p>
            <p>Président : FLL</p>
            <p>Secrétaire : PF</p>
            <p>Expéditeur : <ref target=" FORMTEXT "><anchor xml:id="Text11"/>     </ref></p>
            <p>Destinataires : <ref target=" FORMTEXT "><anchor xml:id="Text12"/>     </ref></p>
        -->


  <xsl:template match="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title">

    <title>
      <xsl:text>Transcription du scan </xsl:text>
      <xsl:value-of select='tei:sanitize(substring-after(//tei:body/tei:p[1], ":"))'/>
      <xsl:text> pp. </xsl:text>
      <xsl:value-of select='tei:sanitize(substring-after(//tei:body/tei:p[2], ":"))'/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select='tei:sanitize(substring-before(substring-after(//tei:body/tei:p[3], ":"), "("))'/>
      <xsl:text>) : version TEI</xsl:text>
    </title>
    <respStmt>
      <resp>transcription</resp>
      <name>
        <xsl:value-of select="//tei:author"/>
      </name>
    </respStmt>
  </xsl:template>
 
  <xsl:template match="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:p">

    <xsl:variable name="doctype">
      <xsl:value-of
        select='tei:sanitize(substring-before(substring-after(//tei:body/tei:p[3],":"), "("))'/>
    </xsl:variable>

    <xsl:variable name="docdate">
      <xsl:value-of
        select='tei:sanitize(substring-before(substring-after(//tei:body/tei:p[4], ":"), "("))'/>
    </xsl:variable>

    <xsl:variable name="docplace">
      <xsl:value-of
        select='tei:sanitize(substring-after(//tei:body/tei:p[5], ":"))'/>
    </xsl:variable>

    <xsl:variable name="partix">
      <xsl:value-of select='tei:sanitize(substring-before(substring-after(//tei:body/tei:p[8], ":"), "("))'/>
    </xsl:variable>
    <xsl:variable name="invites">
      <xsl:value-of select='tei:sanitize(substring-after(//tei:body/tei:p[9], ":"))'/>
    </xsl:variable>
    <xsl:variable name="pres">
      <xsl:value-of select='tei:sanitize(substring-after(//tei:body/tei:p[6], ":"))'/>
    </xsl:variable>
    <xsl:variable name="sec">
      <xsl:value-of select='tei:sanitize(substring-after(//tei:body/tei:p[7], ":"))'/>
    </xsl:variable>
    <xsl:variable name="exp">
      <xsl:value-of select='tei:sanitize(substring-after(//tei:body/tei:p[10], ":"))'/>
    </xsl:variable>
    <xsl:variable name="dest">
      <xsl:value-of select='tei:sanitize(substring-after(//tei:body/tei:p[11], ":"))'/>
    </xsl:variable>

    <bibl>    
      <xsl:choose>
        <xsl:when test='$doctype = "CR"'>
          <meeting>
            <date>
              <xsl:attribute name="when">
                <xsl:value-of select="tei:whenify($docdate)"/>
              </xsl:attribute>
            </date>
            <placeName>
              <xsl:value-of select='$docplace'/>
            </placeName>
            <list type="present">
              <xsl:for-each select="tokenize($partix, ' ')">
                <xsl:if test=". ne ''">
                  <item>
                    <persName>
                      <xsl:attribute name="ref">
                        <xsl:text>#</xsl:text>
                        <xsl:sequence select="tei:sanitize(.)"/>
                      </xsl:attribute>
                    </persName>
                  </item>
                </xsl:if>
              </xsl:for-each>
              <xsl:if test="$invites ne 'xx'">             
              <item>
                <persName role="invité">
                  <xsl:value-of select="normalize-space($invites)"/>
                </persName>
              </item>
              </xsl:if>
              <xsl:if test="$pres ne 'xx'">             
              <item>
                <persName role="président">
                  <xsl:if test="$pres ne ''">
                  <xsl:attribute name="ref">
                    <xsl:text>#</xsl:text>
                    <xsl:sequence select="normalize-space($pres)"/>
                  </xsl:attribute>
                  </xsl:if>
                </persName>
              </item>
              </xsl:if>
              <xsl:if test="$sec ne 'xx'">             
              <item>
                <persName role="secrétaire">
                  <xsl:if test="$sec ne ''">
                    <xsl:attribute name="ref">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="normalize-space($sec)"/>
                  </xsl:attribute>
                  </xsl:if>      
                </persName>
              </item>
              </xsl:if>
            </list>
          </meeting>
        </xsl:when>

        <xsl:when test='($doctype = "Convocation" or $doctype = "CV")'>
          <title>Convocation à une réunion Oulipo, envoyée le <date><xsl:attribute name="when">
                <xsl:value-of select="tei:whenify($docdate)"/></xsl:attribute></date> par <persName
              role="expéditeur">
              <xsl:value-of select="$exp"/>
            </persName>
            <xsl:if test="string-length($dest) gt 1"> Destinataire : <persName role="destinataire">
                <xsl:value-of select="$dest"/>
              </persName>
            </xsl:if></title>
        </xsl:when>


        <xsl:when test='$doctype = "OJ"'>
          <title>Ordre de jour de la réunion Oulipo du <date><xsl:attribute name="when">
                <xsl:value-of select="tei:whenify($docdate)"/></xsl:attribute></date>
          </title>
        </xsl:when>

        <xsl:when test='$doctype = "autre"'>         
          <title>Document supplémentaire  pour la réunion Oulipo du <date><xsl:attribute name="when">
            <xsl:value-of select="tei:whenify($docdate)"/></xsl:attribute></date>
          </title>
        </xsl:when>
        
        <xsl:otherwise>
         <title>DOCUMENT DE TYPE IMPREVU : LES METADONNEES RISQUENT D'ETRE FAUTIVES </title>
        </xsl:otherwise>

      </xsl:choose>
    </bibl>
  </xsl:template>
  
   <xsl:template match="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:p" >
    <p>Edition numérique distribué par le projet ANR DifDePo</p>
  </xsl:template>


  <xsl:template match="tei:listChange">
    <listChange>
      <change>
        <xsl:attribute name="when">
          <xsl:value-of select="tei:whatsTheDate()"/>
        </xsl:attribute> Oulipo specific tags added</change>
      <xsl:apply-templates/>
    </listChange>    
  </xsl:template>
  
  <xsl:template match="tei:appInfo"/>
  <xsl:template match="tei:encodingDesc"/>
  <xsl:template match="tei:editionStmt"/>
  <xsl:template match="tei:author"/>
  
  
  <!-- Now handle body -->
  
  <!-- delete stuff from form -->
  <xsl:template match="tei:p[tei:anchor]"/>
  
  <xsl:template match="tei:hi[@rend]">
    <xsl:choose>
      <xsl:when test="@rend='illisible'">
        <unclear>
          <xsl:apply-templates/>
        </unclear></xsl:when>
      <xsl:when test="@rend='personne'">      
        <persName>
          <xsl:apply-templates/>
        </persName>
      </xsl:when>
      
      <xsl:when test= "@rend='manifestation'">
        <name type="manif">
          <xsl:apply-templates/>
        </name>
      </xsl:when>
      <xsl:when test="@rend = 'notion'">
        <term>
          <xsl:apply-templates/>
        </term>
      </xsl:when>
      <xsl:when test="@rend= 'organisation'">
        <orgName>
          <xsl:apply-templates/>
        </orgName>
      </xsl:when>
      <xsl:when test="@rend= 'refDocument'">
        <ref>
          <xsl:apply-templates/>
        </ref>
      </xsl:when>
      <xsl:when test="@rend= 'titre'">
        <title>
          <xsl:apply-templates/>
        </title>
      </xsl:when>
  
    <xsl:otherwise>
      <xsl:message><xsl:text>Unanticipated @rend value : </xsl:text>
        <xsl:value-of select="@rend"/></xsl:message>
      <hi><xsl:apply-templates/></hi></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="tei:text">
    <xsl:element name="text">
    <!--  <xsl:attribute name="decls">
        <xsl:text>#</xsl:text>
        <xsl:value-of
          select='normalize-space(substring-before(substring-after(//tei:body/tei:p[3], ":"), "("))'
        />
      </xsl:attribute>-->
      <xsl:attribute name="type">
         <xsl:value-of
          select='tei:sanitize(substring-before(substring-after(//tei:body/tei:p[3], ":"), "("))'
        />
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="tei:body">
    <body><pb/>
    <xsl:apply-templates/>
    </body>  
  </xsl:template>

  <xsl:template match="tei:p[@rend]">
    <xsl:choose>
      <xsl:when test="@rend='rubrique'">
       <p> <label type="rubrique">
          <xsl:apply-templates/>
        </label></p>
      </xsl:when>
      <xsl:when test="@rend='locuteur'">
        <p> <label type="locuteur">
          <xsl:apply-templates/>
        </label></p>
      </xsl:when>
      <xsl:when test="@rend='incipit'">
        <p rend='incipit'><xsl:apply-templates/></p>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message><xsl:text>Unanticipated @rend value : </xsl:text>
       <xsl:value-of select="@rend"/></xsl:message>
      <p><xsl:apply-templates/></p></xsl:otherwise>
    </xsl:choose>    
  </xsl:template>

  <!-- and copy everything else -->
  <xsl:template match="@* | comment() | processing-instruction() | text()">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"
       />
    </xsl:copy>
  </xsl:template>

  <!-- funky functions -->
  
  <xsl:function name="tei:whenify">
    <xsl:param name="str"/>
    <xsl:message>
      <xsl:value-of select="$str"/>
    </xsl:message>
    <xsl:value-of select="substring($str, 5, 4)"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="substring($str, 3, 2)"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="substring($str, 1, 2)"/>
  </xsl:function>
  

  <xsl:function name="tei:match" as="xs:boolean">
    <xsl:param name="att"/>
    <xsl:param name="value"/>
    <xsl:sequence select="if (tokenize($att,' ')=($value)) then true()
      else false()"/>
  </xsl:function>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Returns the current date.</desc>
  </doc>
  <xsl:function name="tei:whatsTheDate" as="node()+"> 
    <xsl:value-of
      select="format-dateTime(current-dateTime(),'[Y]-[M02]-[D02]T[H02]:[m02]:[s02]Z')"/>
  </xsl:function>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>pare back a string to contain only alphanumerics and some punctuation</desc>
  </doc>
  <xsl:function name="tei:sanitize" as="xs:string">
    <xsl:param name="text"/>
    <xsl:variable name="alltext">
      <xsl:value-of select="($text)" separator=""/>
    </xsl:variable>
    <xsl:variable name="result"
      select="replace(normalize-space($alltext),'[^\w\[\]\\(\)._\s]+','')"/>
    <xsl:value-of select="if (string-length($result)&gt;127) then
      concat(substring($result,1,127),'...') else $result"/>
  </xsl:function>
  
  
  <!-- unused templates -->
  
  <xsl:template match="tei:opener">
    <p>
      <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"
       />
    </p>
  </xsl:template>
  <xsl:template match="tei:closer">
    <p>
      <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"
       />
    </p>
  </xsl:template>
  <xsl:function name="tei:is-meta" as="xs:boolean">
    <xsl:param name="p"/>
    <xsl:variable name="pPos">
      <xsl:number select="$p"/>
    </xsl:variable>
    <xsl:value-of select="$pPos &lt; 12"/>
  </xsl:function>
  <xsl:function name="tei:is-front" as="xs:boolean">
    <xsl:param name="p"/>
    <xsl:choose>
      <xsl:when test="$p[@rend ='incipit']">true</xsl:when>
      <xsl:when test="$p[self::tei:opener]">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:function name="tei:is-back" as="xs:boolean">
    <xsl:param name="p"/>
    <xsl:choose>
      <xsl:when test="$p[self::tei:closer]">true</xsl:when>
      <xsl:when test="$p[@rend ='closer']">true</xsl:when>
      <xsl:when test="$p[self::tei:byline]">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  
</xsl:stylesheet>
