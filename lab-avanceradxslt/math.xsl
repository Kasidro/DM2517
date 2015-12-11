<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Extralaboration 1</title>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="h1">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="times">
    <xsl:variable name="fac">
      <xsl:apply-templates select="fact"/>
    </xsl:variable>
    <xsl:variable name="fibbo">
      <xsl:apply-templates select="fib"/>
    </xsl:variable>
    <xsl:value-of select="$fac*$fibbo"/>
  </xsl:template>
  
  <xsl:template match="fib">
    <xsl:value-of select="current()"/>
  </xsl:template>

   <xsl:template match="fact">
    <xsl:variable name="finalvalue">
      <xsl:call-template name="factorial">
        <xsl:with-param name="n" select="current()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$finalvalue"/>
  </xsl:template> 

  <xsl:template name="factorial">
    <xsl:param name="n"/>
    <xsl:choose>
      <xsl:when test="$n = 1">
        <xsl:value-of select="1"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="result">
          <xsl:call-template name="factorial">
            <xsl:with-param name="n" select="$n - 1"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$n * $result"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>