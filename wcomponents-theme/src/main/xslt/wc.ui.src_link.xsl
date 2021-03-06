<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ui="https://github.com/bordertech/wcomponents/namespace/ui/v1.0" xmlns:html="http://www.w3.org/1999/xhtml" version="2.0">
	<!--
		Outputs an A element linking to a source file.
	-->
	<xsl:template match="ui:src" mode="link">
		<a href="{@uri}" class="wc-src wc-icon">
			<xsl:attribute name="data-wc-attach">
				<xsl:text>data-wc-attach</xsl:text>
			</xsl:attribute>
			<xsl:if test="@type">
				<xsl:attribute name="title">
					<xsl:value-of select="@type"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="../@alt">
					<xsl:value-of select="../@alt"/>
					<xsl:if test="@type">
						<xsl:value-of select="concat(' (',@type,')')"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="../@toolTip">
					<xsl:value-of select="../@toolTip"/>
					<xsl:if test="@type">
						<xsl:value-of select="concat(' (',@type,')')"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="@type">
					<xsl:value-of select="@type"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@uri"/>
				</xsl:otherwise>
			</xsl:choose>
		</a>
		<xsl:if test="position() ne last()">
			<xsl:text>&#x2002;</xsl:text>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
