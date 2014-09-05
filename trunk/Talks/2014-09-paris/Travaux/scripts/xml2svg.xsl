<?xml version="1.0" encoding="UTF-8"?>
<!-- This file is availble under a <licence>
    <ref target="http://creativecommons.org/licenses/by-nc/3.0/"
    >Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)</ref>
    </licence> -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0" xmlns:svg="http://www.w3.org/2000/svg"
    exclude-result-prefixes="svg">
    <xsl:import href="javaScript.xsl"/>
    <xsl:param name="pippo">time</xsl:param>
    <xsl:template match="/" exclude-result-prefixes="svg">
        <xsl:for-each select="//tei:surfaceGrp">
            <xsl:variable name="surface-id" select="@xml:id"/>
            <xsl:variable name="op" select="concat(tei:surface[1]/@n, '-', tei:surface[2]/@n)"/>

            <xsl:result-document href="out/{$pippo}/{$op}-{$pippo}.svg">
                <svg xmlns:dc="http://purl.org/dc/elements/1.1/"
                    xmlns:cc="http://creativecommons.org/ns#"
                    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                    xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink"
                    width="{substring-before(tei:surface[1]/tei:graphic/@width, 'px')}"
                    height="{substring-before(tei:surface[1]/tei:graphic/@height, 'px')}"
                    id="svg3170" version="1.1" onload="startup(evt)">
                    <xsl:choose>
                        <xsl:when test="$pippo = 'reading'">
                            <xsl:call-template name="reading">
                                <xsl:with-param name="surface-id" select="$surface-id"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="time">
                                <xsl:with-param name="surface-id" select="$surface-id"/>
                            </xsl:call-template>
                        </xsl:otherwise>

                    </xsl:choose>
                    <defs id="defs3172"/>
                    <metadata>
                        <rdf:RDF>
                            <cc:Work rdf:about="">
                                <dc:format>image/svg+xml</dc:format>
                                <dc:type rdf:resource="http://purl.org/dc/dcmitype/StillImage"/>
                                <dc:title>
                                    <xsl:value-of
                                        select="concat(tei:surface[1]/@n, '-', tei:surface[2]/@n)"/>
                                </dc:title>
                            </cc:Work>
                        </rdf:RDF>
                    </metadata>
                    <g id="layer1">
                        <image xlink:href="../../{tei:surface[1]/tei:graphic/@url}"
                            width="{substring-before(tei:surface[1]/tei:graphic/@width, 'px')}"
                            height="{substring-before(tei:surface[1]/tei:graphic/@height, 'px')}"/>

                        <xsl:for-each select="tei:surface/tei:zone">
                            <xsl:variable name="id-g">
                                <xsl:choose>
                                    <xsl:when test="$pippo = 'reading'">
                                        <xsl:choose>
                                            <xsl:when test="contains(@change, ' ')">
                                                <xsl:value-of
                                                  select="substring-after(substring-after(@change, ' '), '#')"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="substring-after(@change, '#')"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="contains(@change, ' ')">
                                                <xsl:value-of
                                                  select="substring-before(substring-after(@change, '#'), ' ')"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="substring-after(@change, '#')"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <g>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="$id-g"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="@points">
                                        <polygon points="{@points}"
                                            style="fill:#ffffff;stroke:#9e132b;stroke-width:1.28400004;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;fill-opacity:0.62666667;"
                                            id="{@xml:id}"/>
                                    </xsl:when>
                                    <xsl:when test="@rend = 'nobox'"> </xsl:when>
                                    <xsl:otherwise>
                                        <rect
                                            style="fill:#ffffff;stroke:#9e132b;stroke-width:1.28400004;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;fill-opacity:0.62666667;"
                                            id="{@xml:id}" width="{@lrx}" height="{@lry}" x="{@ulx}"
                                            y="{@uly}"/>
                                    </xsl:otherwise>
                                </xsl:choose>

                                <xsl:for-each select="tei:line|tei:space">
                                    <xsl:variable name="x-set">
                                        <xsl:choose>
                                            <xsl:when test="parent::tei:zone/@points">
                                                <xsl:variable name="rotat-offset">
                                                  <xsl:choose>
                                                  <xsl:when test="parent::tei:zone/@rotate">
                                                  <xsl:value-of select="6*position()"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>0</xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:variable>
                                                <xsl:variable name="indent-offset">
                                                  <xsl:choose>
                                                  <xsl:when test="@style">
                                                  <xsl:value-of
                                                  select="number(substring-after(@style, 'text-indent:'))"
                                                  />
                                                  </xsl:when>
                                                  <xsl:otherwise>0</xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:variable>
                                                <xsl:value-of
                                                  select="number(substring-before(parent::tei:zone/@points, ',')) - number($rotat-offset) + 5 + number($indent-offset) "
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="parent::tei:zone/@ulx + 10 + (if (@style) then number(substring-after(@style, 'text-indent:')) else 0) "
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>

                                    <xsl:variable name="y-set">
                                        <xsl:variable name="font-size">
                                            <xsl:choose>
                                                <xsl:when
                                                  test="number(substring-after(parent::tei:zone/@style, 'font-size:')) &lt;9"
                                                  >12</xsl:when>
                                                <xsl:when
                                                  test="number(substring-after(parent::tei:zone/@style, 'font-size:')) &lt;10"
                                                  >15</xsl:when>

                                                <xsl:when
                                                  test="number(substring-after(parent::tei:zone/@style, 'font-size:')) &gt;16"
                                                  >50</xsl:when>
                                                <xsl:when
                                                  test="number(substring-after(parent::tei:zone/@style, 'font-size:')) &gt;13"
                                                  >25</xsl:when>
                                                <xsl:otherwise>20</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>
                                        <xsl:choose>
                                            <xsl:when test="parent::tei:zone/@points">
                                                <xsl:value-of
                                                  select="number(substring-before(substring-after(parent::tei:zone/@points, ','), ' ')) + 4 + number($font-size)*position()"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="parent::tei:zone/@uly + number($font-size)*position()"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>

                                    </xsl:variable>
                                    <text x="{$x-set}" y="{$y-set}"
                                        style="font-size:{if (contains(parent::tei:zone/@style, 'font-size')) then substring-after(parent::tei:zone/@style, 'font-size:') else '14'}px;font-family:Verdana;"
                                        transform="{if(parent::tei:zone/@rotate) then concat('rotate(-', parent::tei:zone/@rotate, ')') else ''}">
                                        <xsl:apply-templates/>
                                        <xsl:apply-templates select=".//tei:add[@place='above']"
                                            mode="interlinear"/>
                                        <xsl:apply-templates select=".//tei:add[@place='below']"
                                            mode="interlinear"/>

                                    </text>

                                </xsl:for-each>
                                <xsl:if test="//tei:delSpan">
                                    <xsl:apply-templates select="tei:delSpan"/>
                                </xsl:if>
                                <xsl:apply-templates select="tei:metamark[svg:svg]"/>
                            </g>
                        </xsl:for-each>

                    </g>
                </svg>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:del" mode="#all">
        <tspan style="text-decoration:line-through" xmlns="http://www.w3.org/2000/svg">
            <xsl:apply-templates/>
        </tspan>
    </xsl:template>
    <xsl:template match="tei:hi" mode="#all">
        <xsl:choose>
            <xsl:when test="@rend='underline' or @rend='double-underline'">
                <tspan style="text-decoration:underline" xmlns="http://www.w3.org/2000/svg">
                    <xsl:apply-templates/>
                </tspan>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:metamark[svg:svg]" mode="#all">
        <xsl:copy-of select="svg:svg/svg:path"/>
    </xsl:template>
    <xsl:template match="tei:metamark/tei:desc"/>
    <xsl:template mode="interlinear" match="tei:add[@place='above']">
        <xsl:variable name="font-size">
            <xsl:choose>
                <xsl:when
                    test="number(substring-after(ancestor::tei:zone/@style, 'font-size:')) &lt;10"
                    >7</xsl:when>
                <xsl:when
                    test="number(substring-after(ancestor::tei:zone/@style, 'font-size:')) &gt;14"
                    >14</xsl:when>
                <xsl:otherwise>10</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tspan
            style="font-size:{if (contains(ancestor::tei:zone/@style, 'font-size')) then $font-size else '10'}px;font-family:Verdana"
            dy="{if (preceding-sibling::tei:add[@place='below']|preceding-sibling::tei:del[tei:add[@place='above'] | preceding-sibling::tei:add[@place='above']] ) then '0' else -$font-size}"
            x="{substring-after(@style, 'text-indent:')}" xmlns="http://www.w3.org/2000/svg">
            <xsl:apply-templates mode="interlinear"/>
        </tspan>
    </xsl:template>
    <xsl:template mode="interlinear" match="tei:add[@place='below']">
        <xsl:variable name="dy-setting">
            <xsl:choose>
                <xsl:when test="preceding-sibling::tei:add[@place='below']">
                    <xsl:text>0</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor::tei:line/tei:add[@place='above']">
                    <xsl:choose>
                        <xsl:when
                            test="number(substring-after(ancestor::tei:zone/@style, 'font-size:')) &gt;14"
                            >25</xsl:when>
                        <xsl:when
                            test="number(substring-after(ancestor::tei:zone/@style, 'font-size:')) &lt;11"
                            >18</xsl:when>
                        <xsl:otherwise>
                            <xsl:text>25</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when
                            test="number(substring-after(ancestor::tei:zone/@style, 'font-size:')) &lt;10"
                            >7</xsl:when>
                        <xsl:otherwise>10</xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="font-size">
            <xsl:choose>
                <xsl:when
                    test="number(substring-after(ancestor::tei:zone/@style, 'font-size:')) &lt;10"
                    >7</xsl:when>
                <xsl:when
                    test="number(substring-after(ancestor::tei:zone/@style, 'font-size:')) &gt;14"
                    >12</xsl:when>
                <xsl:otherwise>10</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tspan
            style="font-size:{if (contains(ancestor::tei:zone/@style, 'font-size')) then $font-size else '10'}px;font-family:Verdana"
            dy="{$dy-setting}" x="{substring-after(@style, 'text-indent:')}"
            xmlns="http://www.w3.org/2000/svg">
            <xsl:apply-templates mode="interlinear"/>
        </tspan>
    </xsl:template>
    <xsl:template mode="#all" match="tei:add[@place='superimposed']">
        <tspan xmlns="http://www.w3.org/2000/svg" dx="-4" font-weight="bold">
            <xsl:apply-templates/>
        </tspan>
    </xsl:template>

    <xsl:template match="tei:add[@place='above']"/>
    <xsl:template match="tei:add[@place='below']"/>

    <xsl:template match="tei:delSpan[@rend='cross']">
        <xsl:variable name="span" select="substring-after(@spanTo, '#')"/>
        <xsl:variable name="x1" select="ancestor::tei:zone[@ulx]/@ulx"/>
        <xsl:variable name="y1" select="ancestor::tei:zone[@ulx]/@uly"/>
        <xsl:variable name="x2"
            select="following::tei:anchor[@xml:id = $span]/ancestor::tei:zone[1][@lrx]/@lrx + following::tei:anchor[@xml:id = $span]/ancestor::tei:zone[1][@lrx]/@ulx"/>
        <xsl:variable name="y2"
            select="following::tei:anchor[@xml:id = $span]/ancestor::tei:zone[1][@lrx]/@lry + following::tei:anchor[@xml:id = $span]/ancestor::tei:zone[1][@lrx]/@uly"/>
        <path xmlns="http://www.w3.org/2000/svg" d="M {$x1},{$y1} {$x2},{$y2}"
            style="fill:none;stroke:#9e132b;stroke-width:3px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"/>
        <path xmlns="http://www.w3.org/2000/svg" d="M {$x2},{$y1} {$x1},{$y2}"
            style="fill:none;stroke:#9e132b;stroke-width:3px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"/>

    </xsl:template>
    <xsl:template match="tei:delSpan[@rend='bar']">
        <xsl:variable name="span" select="substring-after(@spanTo, '#')"/>
        <xsl:variable name="x1" select="ancestor::tei:zone[@ulx]/@ulx"/>
        <xsl:variable name="y1" select="ancestor::tei:zone[@ulx]/@uly"/>
        <xsl:variable name="x2"
            select="following::tei:anchor[@xml:id = $span]/ancestor::tei:zone[1][@lrx]/@lrx + following::tei:anchor[@xml:id = $span]/ancestor::tei:zone[1][@lrx]/@ulx"/>
        <xsl:variable name="y2"
            select="following::tei:anchor[@xml:id = $span]/ancestor::tei:zone[1][@lrx]/@lry + following::tei:anchor[@xml:id = $span]/ancestor::tei:zone[1][@lrx]/@uly"/>
        <path xmlns="http://www.w3.org/2000/svg" d="M {$x1},{$y1} {$x2},{$y2}"
            style="fill:none;stroke:#9e132b;stroke-width:3px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"/>


    </xsl:template>

</xsl:stylesheet>
