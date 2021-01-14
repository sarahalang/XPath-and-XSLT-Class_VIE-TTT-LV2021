<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t" version="2.0">
    <xsl:output method="html" encoding="utf-8" indent="yes" />

    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;
        </xsl:text>
        
        <html>
            <head>
                <title>
                    <xsl:value-of select="//t:title"/>
                </title>
            </head>
            <body>
                <h1>Personenliste</h1>
                

                    <h3>Wie oft kommt ein Name im Text vor?</h3>
                    <ul>
                        <xsl:for-each select="//t:person">
                            <xsl:variable name="currentPersonsXMLID" select="concat('#', t:persName/@xml:id)"/>
                            <xsl:variable name="count" select="count(//t:persName[@ref = $currentPersonsXMLID])"/>
                            
                            
                            <li>
                                <xsl:value-of select="."/>
                                <xsl:text> ------- </xsl:text>
                                <!-- For testing purposes: <xsl:value-of select="$self"/> -->
                                <xsl:value-of select="count(//t:persName[@ref = $currentPersonsXMLID])"/>
                            </li>
                        </xsl:for-each>
                    </ul>
                
                
                <h1>Personenliste</h1>
                <xsl:for-each select="//t:div[@type= 'part' ]">
                    <xsl:variable name="thispart" select="position()"/>
                    <xsl:text>this is one part ------------------------------------------------</xsl:text>
                <xsl:for-each select="//t:div[$thispart]/t:div[@type= 'chapter']">
                    <xsl:variable name="kapitel" select="position()"/>
                    <h3><xsl:value-of select="t:head"/><xsl:text>:: </xsl:text><xsl:value-of select="$kapitel"/></h3>
                    <ul>
                        <xsl:for-each select="//t:person">
                            <xsl:variable name="self" select="concat('#', @xml:id)"/>
                            <li>
                                <xsl:value-of select="."/>
                                <xsl:text>-------</xsl:text>
                                <xsl:value-of select="count(//t:div[$thispart]/t:div[$kapitel]//t:persName[@ref = $self])"/>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
                </xsl:for-each>
                
                <xsl:apply-templates select="//t:text"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="t:text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="t:div">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="t:head[parent::t:div[@type = 'part']]">
        <h1>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>

    <xsl:template match="t:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="t:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>



</xsl:stylesheet>
