<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <!-- / matches root -->
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="page/title"/></title>
        <meta>
          <xsl:apply-templates select="page/author"/>
        </meta>    
        <meta>
          <xsl:apply-templates select="page/version"/>
        </meta>       
      </head>
      <body>
        <h1>Nyheter</h1>
          <xsl:apply-templates select="page/newscolumn"/>
    
        <h1>Projektstatus</h1>
          <xsl:apply-templates select="page/statuscolumn"/>

      </body>
    </html> 
  </xsl:template>
  
  <xsl:template match="version|author">
    <xsl:attribute name="name">
      <xsl:value-of select ="local-name()"/>
    </xsl:attribute>
    
    <xsl:attribute name="content">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="newscolumn">
    <ul>
      <xsl:apply-templates select="news"/>
    </ul>  
  </xsl:template>

  <xsl:template match="news">
    <li>
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="link"/>
        </xsl:attribute>
        <strong>
          <xsl:value-of select="title"/>
        </strong>
      </a> - 
      <strong>
        <xsl:value-of select="date/day"/><xsl:text> </xsl:text>
        <xsl:value-of select="date/month"/><xsl:text> </xsl:text>
        <xsl:value-of select="date/year"/>.
      </strong>  
      <xsl:value-of select="content"/>
    </li>  
  </xsl:template>

  <xsl:template match="statuscolumn">
    <ul>
      <xsl:apply-templates select="project"/>
    </ul>  
  </xsl:template>

  <xsl:template match="project">
  <li>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="link"/>
      </xsl:attribute>
      <strong><xsl:value-of select="title"/></strong>
    </a>
    <ul>
      <xsl:apply-templates select="release"/>
    </ul>
</li>
</xsl:template>

<xsl:template match="release">
  <li>
        <strong><xsl:value-of select="version"/> - 
        <xsl:value-of select="status"/>
        </strong>
        <xsl:value-of select="comment"/>
      </li>
</xsl:template>

</xsl:stylesheet>