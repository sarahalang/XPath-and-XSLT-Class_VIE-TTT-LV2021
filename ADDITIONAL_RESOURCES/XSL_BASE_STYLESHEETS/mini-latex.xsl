<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:strip-space elements="*"/> <!-- for LaTeX -->
    <xsl:output method="text" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:text>\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage[english]{babel}
\DeclareUnicodeCharacter{2060}{\nolinebreak}

\title{</xsl:text><xsl:value-of select="//t:title"/>
        <xsl:text>}
\author{</xsl:text><xsl:value-of select="//t:author"/>
        <xsl:text>}\date{\today}
\begin{document}
\maketitle
\tableofcontents\newpage</xsl:text>
        <!-- bewusst mit dem Pull-Paradigma gezielt ausgewählte Inhalte des Headers auslesen
        z.B. Zitiervorschlag mit fancyhdr-package TODO -->
<xsl:text>\begin{itemize}</xsl:text>
<xsl:for-each select="//t:persName[ancestor::t:teiHeader]">
    <xsl:text>\item </xsl:text>
    <xsl:value-of select="." />
    <xsl:text>
    
    </xsl:text>
</xsl:for-each>
<xsl:text>\end{itemize}
\newpage</xsl:text>
     
        <!--  <xsl:apply-templates/> ODER -->
        <xsl:apply-templates select="//t:text"/>
        <!-- damit nur mehr der Body mit Push-Paradigma automatisch verarbeitet wird
        und nicht der Header wahllos mit hinge-dumpt/printed wird -->
        
        <xsl:text>\end{document}</xsl:text>
    </xsl:template>
    
    <xsl:template match="t:head">
        <xsl:text>\section{</xsl:text><xsl:apply-templates/><xsl:text>} </xsl:text>
    </xsl:template>
    
    <xsl:template match="t:p">
        <xsl:apply-templates/>
        <xsl:text>
            
        </xsl:text>
    </xsl:template>
    
    <xsl:template match="t:hi">
        <xsl:text>\emph{</xsl:text><xsl:apply-templates/><xsl:text>} </xsl:text>
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:analyze-string select="." regex="([&amp;])|([_])|([$])">
            <xsl:matching-substring>
                <xsl:choose>
                    <xsl:when test="regex-group(1)">
                        <xsl:text>\&amp;</xsl:text>
                    </xsl:when>
                    <xsl:when test="regex-group(2)">
                        <xsl:text>\_</xsl:text>
                    </xsl:when>
                    <xsl:when test="regex-group(3)">
                        <xsl:text>\$</xsl:text>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="." />
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
<!-- würde stattdessen auch funktionieren...
     <xsl:template match="text()">
     <xsl:value-of select="translate(., '&#xA0;', ' ')"/>
 </xsl:template>
    -->
</xsl:stylesheet>