<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ui="https://github.com/bordertech/wcomponents/namespace/ui/v1.0" xmlns:html="http://www.w3.org/1999/xhtml" version="2.0">
	<xsl:import href="wc.common.ajax.xsl"/>
	<xsl:import href="wc.common.disabledElement.xsl"/>

	<!--
		Builds the elements for each text field of a multiTextField.

		param isSingular: Set to 1 if we are calling this template from a
		multiTextField with no value. This is then used to determine the element
		to use in a call to test the the value of the input (if any), the input
		field attributes set at the parent multiTextField level and the read
		only mode text to output (if any)

		param readOnly: The read only state of the parent multiTextField

		param useField: A reference to the ui:multitextfield element which may
		be the calling element or its parent depending upon from where this
		template is called.
	-->
	<xsl:template name="multiTextFieldInput">
		<xsl:variable name="field" select="ancestor-or-self::ui:multitextfield"/>
		<xsl:variable name="fieldId">
			<xsl:value-of select="$field/@id"/>
		</xsl:variable>
		<xsl:element name="input">
			<xsl:attribute name="type">
				<xsl:text>text</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="$fieldId"/>
			</xsl:attribute>
			<xsl:attribute name="id">
				<xsl:value-of select="concat($fieldId,generate-id())"/>
				<xsl:if test="self::ui:value">
					<xsl:value-of select="concat('-',position())"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:text>{{t 'mfc_option'}}</xsl:text>
			</xsl:attribute>
			<xsl:if test="$field/@size">
				<xsl:attribute name="size">
					<xsl:value-of select="$field/@size"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$field/@maxLength">
				<xsl:attribute name="maxlength">
					<xsl:value-of select="$field/@maxLength"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$field/@pattern">
				<xsl:attribute name="pattern">
					<xsl:value-of select="$field/@pattern"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$field/@minLength">
				<xsl:attribute name="minlength">
					<xsl:value-of select="$field/@minLength"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$field/@placeholder">
				<xsl:attribute name="placeholder">
					<xsl:value-of select="$field/@placeholder"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$field/@autocomplete">
				<xsl:attribute name="autocomplete">
					<xsl:value-of select="$field/@autocomplete"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="disabledElement">
				<xsl:with-param name="isControl" select="1"/>
				<xsl:with-param name="field" select="$field"/>
			</xsl:call-template>
			<xsl:if test="self::ui:value">
				<xsl:attribute name="value">
					<xsl:value-of select="."/>
				</xsl:attribute>
			</xsl:if>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
