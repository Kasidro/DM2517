<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" indent="yes"/>

	<xsl:template match="/">
  	<html>
  		<head>
  			<title><xsl:value-of select="report/head/title"/></title>
  		</head>
  		<body>
  			<h1><xsl:value-of select="report/head/title"/></h1>
  			<xsl:apply-templates select="report/head/authors"/>
  			<xsl:apply-templates select="report/head/keywords"/>
  			<p>
  				<xsl:for-each select="report/body/h1">
  					<xsl:variable name="h1count" select="position()"/>
  					<xsl:number value="position()" format="1"/><xsl:text>.</xsl:text><xsl:text> </xsl:text><a href="#{generate-id(@title)}"><xsl:value-of select="@title"/></a><br></br>
  						<xsl:for-each select="h2">
  							<xsl:variable name="h2count" select="position()"/>
  							<xsl:value-of select="$h1count"/><xsl:text>.</xsl:text><xsl:number value="position()" format="1"/><xsl:text>.</xsl:text><xsl:text> </xsl:text><a href="#{generate-id(@title)}"><xsl:value-of select="@title"/></a><br></br>
  							<xsl:for-each select="h3">
  								<xsl:value-of select="$h1count"/><xsl:text>.</xsl:text><xsl:value-of select="$h2count"/><xsl:text>.</xsl:text><xsl:number value="position()" format="1"/><xsl:text>.</xsl:text><xsl:text> </xsl:text><a href="#{generate-id(@title)}"><xsl:value-of select="@title"/></a><br></br>
  							</xsl:for-each>
  						</xsl:for-each>
  				</xsl:for-each>
  			</p>
  			<xsl:for-each select="report/body/h1">
  					<xsl:variable name="h1count" select="position()"/>
  					<a name="{generate-id(@title)}"></a>
  					<h2>
  						<xsl:value-of select="$h1count"/><xsl:text>. </xsl:text><xsl:value-of select="@title"/>
  					</h2>
  					<xsl:for-each select="p">
  						<p><xsl:value-of select="."/></p>
  					</xsl:for-each>
  					<xsl:for-each select="h2">
  						<xsl:variable name="h2count" select="position()"/>
  						<a name="{generate-id(@title)}"></a>
  						<h3>
  							<xsl:value-of select="$h1count"/><xsl:text>.</xsl:text><xsl:value-of select="$h2count"/><xsl:text>. </xsl:text><xsl:value-of select="@title"/>
  						</h3>
  						<xsl:for-each select="p">
  							<p><xsl:value-of select="."/></p>
  						</xsl:for-each>
  						<xsl:for-each select="h3">
  							<xsl:variable name="h3count" select="position()"/>
  								<a name="{generate-id(@title)}"></a>
  								<h4>
  									<xsl:value-of select="$h1count"/><xsl:text>.</xsl:text><xsl:value-of select="$h2count"/><xsl:text>.</xsl:text><xsl:value-of select="$h3count"/><xsl:text>. </xsl:text><xsl:value-of select="@title"/>
  								</h4>
  									<xsl:for-each select="p">
  										<p><xsl:value-of select="."/></p>
  									</xsl:for-each>
  					</xsl:for-each>
  					</xsl:for-each>
  			</xsl:for-each>
  		</body>
  	</html>	
	</xsl:template>

	<xsl:template match="authors">
		<p>Authors: 
			<xsl:for-each select="author">
   			<xsl:value-of select="."/>
   				<xsl:if test="position() != last()">
   					<xsl:text>, </xsl:text>
   				</xsl:if>
			</xsl:for-each>
		</p>	
	</xsl:template>

	<xsl:template match="keywords">
		<p>Keywords: 
			<xsl:for-each select="keyword">
   			<xsl:value-of select="."/>
   				<xsl:if test="position() != last()">
   					<xsl:text>, </xsl:text>
   				</xsl:if>
			</xsl:for-each>
		</p>	
	</xsl:template>

</xsl:stylesheet>