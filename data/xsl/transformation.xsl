<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:output method="text"/>
  <xsl:template match="tei:TEI">
    <xsl:value-of select="normalize-space(//tei:titleStmt/tei:title)"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:value-of select="normalize-space(//tei:titleStmt/tei:author)"/>
    <xsl:for-each select="//tei:div">
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
      <xsl:value-of select="normalize-space(./tei:head)"/>
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
      <xsl:for-each select="./tei:p">
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:for-each>
    </xsl:for-each>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>
</xsl:stylesheet>

