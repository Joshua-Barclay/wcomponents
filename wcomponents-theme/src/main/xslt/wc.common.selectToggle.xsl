<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ui="https://github.com/bordertech/wcomponents/namespace/ui/v1.0" xmlns:html="http://www.w3.org/1999/xhtml" version="2.0">
	<xsl:import href="wc.common.toggleElement.xsl"/>
	<xsl:import href="wc.common.ajax.xsl"/>
	<xsl:import href="wc.common.n.className.xsl"/>

	<!-- Keys used by selectToggle if it is targetted at a single checkbox or group of disparate check boxes rather than at a container or checkBoxSelect-->
	<xsl:key name="checkboxIdKey" match="//ui:checkbox[@groupName]" use="@id"/>
	<xsl:key name="checkboxGroupKey" match="//ui:checkbox[@groupName]" use="@groupName"/>
	<!--
		Builds selectToggle/rowSelection controls.
			wc.ui.selectToggle.xsl
			wc.ui.table.rowSelection.xsl

		param id: the ID to apply to the selectToggle outer element. Default @id

		param name: the name attribute to apply to each button in the selectToggle

		param for: the ID of the element controlled by the selectToggle. This is the ID
			of a container element.

		param selected: "all"|"none"|""
			Indicates the initial selected state for the selectToggle. We could calculate
			this from the state of the controlled components but that calculation is very
			expensive in XSLT and the WComponents should be able to report the correct
			state in the XML.

		param roundTrip: "true"|""
			If "true" the selectToggle is a submit button and the selection takes place
			on the server, otherwise the selection is client side.

		param label
			A text label to apply to the selectToggle. This is only set for ui:rowselection in
			ui:table. It is generally empty. For ui:selecttoggle and we look up
			the label by looking for a WLabel which is "for" the WSelectToggle.

		param type:
			The display mechanism for the selectToggle. The selectToggle controls are
			always HTML button elements but when this is "text" they are displayed as two
			link styled buttons: one to select and one to deselect, these function as a radio
			button group analog. When this is "control" the button is displayed and functions
			as a tri-state checkbox analog. Default 'text'.
	-->
	<xsl:template name="selectToggle">
		<xsl:param name="id" select="@id"/>
		<xsl:param name="name" select="''"/>
		<xsl:param name="for" select="''"/>
		<xsl:param name="selected" select="''"/>
		<xsl:param name="label" select="''"/><!--not set for ui:selecttoggle -->
		<xsl:param name="type" select="'text'"/>

		<xsl:variable name="toggleId">
			<xsl:value-of select="$id"/>
			<xsl:if test="not(self::ui:selecttoggle)">
				<xsl:text>_st</xsl:text>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="mode">
			<xsl:choose>
				<xsl:when test="self::ui:selectToggle and @roundTrip">
					<xsl:text>server</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>client</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--
			WComponents groups WCheckBoxes in a CheckBoxGroup (note: NOT a WCheckBoxSelect)
			in which each WCheckBox has a common groupName property. The WSelectToggle is
			then pointed to this CheckBoxGroup and the for attribute reflects the id of one
			of the WCheckBoxes in that group.

			This test uses the fact that a WCheckBox will have a groupName only if it is in
			such a group so if the WCheckBox that this toggle is for has a groupName then
			we can infer that the toggle is actually intended to be for the group.
		-->
		<xsl:variable name="isCheckboxTarget" select="key('checkboxIdKey',$for)"/>
		<!--
			Based on the test in isCheckboxTarget if the toggle is for a group of
			WCheckBoxes we need to extract the groupName. This can be extracted from any
			node returned from isCheckboxTarget so we may as well use the first since
			it is the only one guaranteed to be there.
		-->
		<xsl:variable name="thisGroupName">
			<xsl:if test="$isCheckboxTarget">
				<xsl:value-of select="$isCheckboxTarget[1]/@groupName"/>
			</xsl:if>
		</xsl:variable>
		<!--
			Generates a space separated list of ids for the components controlled by this
			toggle. If we have a nodeList returned from isCheckboxTarget and a groupName
			returned from thisGroupName then we get the id of all WCheckBoxes in that
			group. Otherwise the target id is the only thing controlled by the toggle.
		-->
		<xsl:variable name="targetList">
			<xsl:choose>
				<xsl:when test="$isCheckboxTarget and $thisGroupName ne ''">
					<xsl:apply-templates select="key('checkboxGroupKey',$thisGroupName)" mode="getIdList"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$for"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="myLabel" select="key('labelKey',$id)[1]"/>

		<xsl:choose>
			<xsl:when test="$type eq 'text'">
				<span id="{$toggleId}" role="radiogroup">
					<xsl:call-template name="makeCommonClass">
						<xsl:with-param name="additional">
							<xsl:text>wc_seltog</xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="ajaxTarget"/>
					<xsl:if test="$isCheckboxTarget">
						<xsl:attribute name="data-wc-cbgroup">
							<xsl:value-of select="$thisGroupName"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="self::ui:rowselection">
							<xsl:call-template name="disabledElement"><!-- WDataTable compatibility only. -->
								<xsl:with-param name="field" select=".."/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="disabledElement"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:variable name="defaultLabelId">
						<xsl:value-of select="concat($toggleId, '_l')"/>
					</xsl:variable>

					<xsl:variable name="labelContent">
						<xsl:choose>
							<xsl:when test="$label ne ''">
								<xsl:value-of select="$label"/>
							</xsl:when>
							<xsl:when test="self::ui:rowselection">
								<xsl:text>{{t 'toggle_label'}}</xsl:text>
							</xsl:when>
							<xsl:when test="not($myLabel)">
								<xsl:text>{{t 'toggle_label'}}</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:if test="$labelContent ne ''">
						<span id="{$defaultLabelId}">
							<xsl:value-of select="$labelContent"/>
						</span>
					</xsl:if>

					<xsl:variable name="realLabelId">
						<xsl:choose>
							<xsl:when test="self::ui:rowselection">
								<xsl:value-of select="$defaultLabelId"/>
							</xsl:when>
							<xsl:when test="$myLabel">
								<xsl:value-of select="$myLabel/@id"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$defaultLabelId"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<xsl:variable name="subClass">
						<xsl:value-of select="concat('wc_', local-name(.), ' wc_seltog')"/>
					</xsl:variable>
					<xsl:call-template name="toggleElement">
						<xsl:with-param name="mode" select="$mode"/>
						<xsl:with-param name="id" select="concat($id,'_all')"/>
						<xsl:with-param name="for" select="$targetList"/>
						<xsl:with-param name="name" select="$name"/>
						<xsl:with-param name="value" select="'all'"/>
						<xsl:with-param name="class" select="$subClass"/>
						<xsl:with-param name="text"><xsl:text>{{t 'toggle_all'}}</xsl:text></xsl:with-param>
						<xsl:with-param name="selected">
							<xsl:choose>
								<xsl:when test="$selected eq 'all'">
									<xsl:number value="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:number value="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="labelId" select="$realLabelId"/>
					</xsl:call-template>

					<xsl:call-template name="toggleElement">
						<xsl:with-param name="mode" select="$mode"/>
						<xsl:with-param name="id" select="concat($id,'_none')"/>
						<xsl:with-param name="for" select="$targetList"/>
						<xsl:with-param name="name" select="$name"/>
						<xsl:with-param name="value" select="'none'"/>
						<xsl:with-param name="class" select="$subClass"/>
						<xsl:with-param name="text"><xsl:text>{{t 'toggle_none'}}</xsl:text></xsl:with-param>
						<xsl:with-param name="selected">
							<xsl:choose>
								<xsl:when test="$selected eq 'none'">
									<xsl:number value="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:number value="0"></xsl:number>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="labelId" select="$realLabelId"/>
					</xsl:call-template>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="textEquivalent">
					<xsl:choose>
						<xsl:when test="$label ne ''">
							<xsl:value-of select="$label"/>
						</xsl:when>
						<xsl:when test="self::ui:rowselection">
							<xsl:text>{{t 'toggle_all_label'}}</xsl:text>
						</xsl:when>
						<xsl:when test="$myLabel">
							<xsl:apply-templates select="$myLabel" mode="selectToggle"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>{{t 'toggle_all_label'}}</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<button id="{$toggleId}" role="checkbox" aria-controls="{$targetList}">
					<xsl:attribute name="type">
						<xsl:choose>
							<xsl:when test="$mode eq 'server'">
								<xsl:text>submit</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>button</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:if test="$mode eq 'server'">
						<xsl:attribute name="formnovalidate">
							<xsl:text>formnovalidate</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="aria-checked">
						<xsl:choose>
							<xsl:when test="$selected eq 'all'">
								<xsl:copy-of select="$t"/>
							</xsl:when>
							<xsl:when test="$selected eq 'some'">
								<xsl:text>mixed</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>false</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<!--
						The controls must have a name surrogate to report back to the server. However
						we <<do not>> use a value surrogate because the value is determined at the time
						we write the state based on the aria-checked state of the control(s).
					-->
					<xsl:if test="$name ne ''">
						<xsl:attribute name="data-wc-name">
							<xsl:value-of select="$name"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="makeCommonClass">
						<xsl:with-param name="additional">
							<xsl:text>wc_seltog wc-nobutton wc-icon</xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="self::ui:selecttoggle">
						<xsl:attribute name="title">
							<xsl:value-of select="$textEquivalent"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="self::ui:selecttoggle">
							<xsl:call-template name="disabledElement">
								<xsl:with-param name="isControl" select="1"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise><!-- TODO: this applies only to WDataTable and is to be removed -->
							<xsl:call-template name="disabledElement">
								<xsl:with-param name="isControl" select="1"/>
								<xsl:with-param name="field" select="parent::ui:table"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="$isCheckboxTarget">
						<xsl:attribute name="data-wc-cbgroup">
							<xsl:value-of select="$thisGroupName"/>
						</xsl:attribute>
					</xsl:if>
					<!-- ADDING TEXT CONTENT - NO MORE ATTRIBUTES AFTER THIS COMMENT -->
					<xsl:if test="self::ui:rowselection">
						<span>
							<xsl:value-of select="$textEquivalent"/>
						</span>
					</xsl:if>
				</button>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
