<?xml version="1.0" encoding="UTF-8"?>
<xs:stylesheet xmlns:xs="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsl="http://www.w3.org/1999/XSL/fakeTransform"
    xmlns="http://www.w3.org/1999/XSL/Transform"
     exclude-result-prefixes="xsl xs" xpath-default-namespace="http://www.w3.org/1999/XSL/fakeTransform"
    version="2.0">
    
    <xs:key name="TAGS" match="*" use="name(.)"/>
   
   <xs:template match="/">
       <xsl:stylesheet>
           
           <xs:apply-templates />
       </xsl:stylesheet>
     
   </xs:template>
   
  <xs:template match="*[generate-id() =
            generate-id(key('TAGS', name())[1])  ]">
           <xs:text>
           </xs:text>
            <xsl:template match="{name(.)}">
                <xsl:apply-templates/>
            </xsl:template>
            <xs:comment><xsl:value-of select="count(//name())"/>
            </xs:comment>
            <xs:apply-templates select="*"/>
        </xs:template>
  
 <xs:template match="text()"/>
   
  
    
</xs:stylesheet>