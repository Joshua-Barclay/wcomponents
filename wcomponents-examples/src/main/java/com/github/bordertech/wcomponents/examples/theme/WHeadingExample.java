package com.github.bordertech.wcomponents.examples.theme;

import com.github.bordertech.wcomponents.HeadingLevel;
import com.github.bordertech.wcomponents.WContainer;
import com.github.bordertech.wcomponents.WDecoratedLabel;
import com.github.bordertech.wcomponents.WHeading;
import com.github.bordertech.wcomponents.WHorizontalRule;
import com.github.bordertech.wcomponents.WImage;
import com.github.bordertech.wcomponents.WStyledText;
import com.github.bordertech.wcomponents.WText;
import com.github.bordertech.wcomponents.examples.common.ExplanatoryText;
import com.github.bordertech.wcomponents.util.HtmlClassProperties;

/**
 * This component demonstrates the {@link WHeading} component.
 *
 * @author Yiannis Paschalidis
 * @since 1.0.0
 */
public class WHeadingExample extends WContainer {

	/**
	 * Creates a WHeadingExample.
	 */
	public WHeadingExample() {

		add(new WHeading(HeadingLevel.H2, "Important information regarding this example"));
		add(new ExplanatoryText("This page shows an example of each WHeading Type."
				+ " It serves as an example of the way a WHeading is created using the WComponent Java API and"
				+ " does not show how headings should be used within a user interface"
				+ " or the correct nesting order for headings.\n"
				+ "The order of headings in a user interface is extremely important and must comply"
				+ " with an unfortunately complex specification which does not lend itself to machine interpretation."
				+ " For detailed information on WHeading order consult the HTML5 specification and WCAG 2.0 guidelines.\n"
				+ "In an attempt to make this complex issue slightly simpler for application specifiers and"
				+ " developers WComponents provides components which create explicit pieces of sectioning content which"
				+ " include the requisite h1 element and reset the heading order back to WHeading Type.MAJOR. These"
				+ " components are WSection, WDialog and WPanel of Types CHROME and ACTION. In all cases WApplication defines a section"
				+ " with the heading level reset to Type.TITLE."));
		add(new WHeading(HeadingLevel.H1, "Title heading (Type.TITLE) is a HTML h1 element"));
		add(new ExplanatoryText("This heading level is rarely used. In almost all circumstances"
				+ " h1 will be output as part of a WSection, WDialog or WPanel of Types CHROME or ACTION."));
		add(new WHeading(HeadingLevel.H2, "Major heading (Type.MAJOR) is a HTML h2 element"));
		add(new ExplanatoryText("This heading level should be the first heading level used within any 'headed' WPanel type or in the content of a "
				+ "WSection or WDialog."
				+ " It must always be preceded at some level by a component which can output a HTML h1 element either a WHeading Type.TITLE or the"
				+ " title of WSection, WDialog or WPanel Types CHROME or SECTION."));
		add(new WHeading(HeadingLevel.H3, "Section heading (Type.SECTION) is a HTML h3 element"));
		add(new ExplanatoryText(
				"This WHeading Type must be preceded, within a piece of sectioning content, by a WHeading of Type.MAJOR."));
		add(new WHeading(HeadingLevel.H4, "Minor heading (Type.MINOR) is a HTML h4 element"));
		add(new ExplanatoryText(
				"This WHeading Type must be preceded, within a piece of sectioning content, by a WHeading of Type.SECTION."));
		add(new WHeading(HeadingLevel.H5, "Sub-heading (Type.SUB_HEADING) is a HTML h5 element"));
		add(new ExplanatoryText(
				"This WHeading Type must be preceded, within a piece of sectioning content, by a WHeading of Type.MINOR."));
		add(new WHeading(HeadingLevel.H6,
				"Sub-sub-heading (Type.SUB_SUB_HEADING) is a HTML h6 element"));
		add(new ExplanatoryText(
				"This WHeading Type must be preceded, within a piece of sectioning content, by a WHeading of Type.SUB_HEADING."));

		add(new WHorizontalRule());

		add(new WHeading(HeadingLevel.H2, "Examples with additional content"));
		add(new ExplanatoryText("These examples are only used to show the use of a WDecoratedLabel in the WHeading. As with the examples above they "
				+ "should not be used as a sample of good label construction"));

		add(new WHeading(HeadingLevel.H1, makeHeadingLabel("Heading h1", "draft")));
		add(new WHeading(HeadingLevel.H2, makeHeadingLabel("Heading h2", "draft")));
		add(new WHeading(HeadingLevel.H3, makeHeadingLabel("Heading h3", "deleted")));
		add(new WHeading(HeadingLevel.H4, makeHeadingLabel("Heading h4", "waiting approval")));
		add(new WHeading(HeadingLevel.H5, makeHeadingLabel("Heading h5", "approved")));
		add(new WHeading(HeadingLevel.H6, makeHeadingLabel("Heading h6", "published")));

		add(new WHeading(HeadingLevel.H2, "Examples with unescaped content"));
		WHeading unescapedHeading = new WHeading(HeadingLevel.H3, "<span style='color:red'>Red H3 (unescaped text)</span>");
		unescapedHeading.setEncodeText(false);
		add(unescapedHeading);
		unescapedHeading = new WHeading(HeadingLevel.H3, "&bull; Bulleted (unescaped text)&bull;");
		unescapedHeading.setEncodeText(false);
		add(unescapedHeading);
		add(new WHeading(HeadingLevel.H2, "Examples with Icons"));
		WHeading iconHeading = new WHeading(HeadingLevel.H3, "Headline with icon before");
		iconHeading.setHtmlClass(HtmlClassProperties.ICON_INFO_BEFORE);
		add(iconHeading);

		iconHeading = new WHeading(HeadingLevel.H3, "Headline with icon after");
		iconHeading.setHtmlClass(HtmlClassProperties.ICON_INFO_AFTER);
		add(iconHeading);

		// you should NEVER set an icon as the ONLY visible text content of a WHeading
	}

	/**
	 * @param text the label text
	 * @param statusText the status text
	 * @return the decorated label
	 */
	private WDecoratedLabel makeHeadingLabel(final String text, final String statusText) {
		return new WDecoratedLabel(new WImage("/image/information.png", "Informative heading"),
				new WText(text), new WStyledText(statusText, WStyledText.Type.EMPHASISED));
	}

}
