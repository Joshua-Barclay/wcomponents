package com.github.bordertech.wcomponents.examples.theme;

import com.github.bordertech.wcomponents.Action;
import com.github.bordertech.wcomponents.ActionEvent;
import com.github.bordertech.wcomponents.HeadingLevel;
import com.github.bordertech.wcomponents.Margin;
import com.github.bordertech.wcomponents.WButton;
import com.github.bordertech.wcomponents.WContainer;
import com.github.bordertech.wcomponents.WFieldLayout;
import com.github.bordertech.wcomponents.WFieldSet;
import com.github.bordertech.wcomponents.WHeading;
import com.github.bordertech.wcomponents.WPanel;
import com.github.bordertech.wcomponents.WPartialDateField;
import com.github.bordertech.wcomponents.WTextField;
import com.github.bordertech.wcomponents.layout.FlowLayout;
import com.github.bordertech.wcomponents.layout.FlowLayout.Alignment;
import java.util.Date;

/**
 * An example showing use of a {@link WPartialDateField}.
 *
 * @author Ming Gao
 */
public class WPartialDateFieldExample extends WContainer {

	private final WPartialDateField dateField = new WPartialDateField();

	private final WTextField text = new WTextField();
	private final WTextField day = new WTextField();
	private final WTextField month = new WTextField();
	private final WTextField year = new WTextField();

	/**
	 * Creates a WPartialDateFieldExample.
	 */
	public WPartialDateFieldExample() {

		// First block with button Panel
		WPanel wrapper = new WPanel();
		add(wrapper);
		WFieldLayout layout = new WFieldLayout();
		layout.setLabelWidth(30);
		text.setReadOnly(true);

		layout.addField("Enter any part(s) of a date", dateField).setInputWidth(100);
		layout.addField("Text from entered date", text);
		wrapper.add(layout);

		WButton copyBtn = new WButton("Copy date text");
		WButton btnGetDay = new WButton("Copy the day of month");
		WButton btnGetMonth = new WButton("Copy month value");
		WButton btnGetYear = new WButton("Copy year value");
		WButton btnGetDate = new WButton("Copy the Java Date");

		WPanel buttonPanel = new WPanel(WPanel.Type.FEATURE);
		buttonPanel.setLayout(new FlowLayout(Alignment.LEFT, 6));
		buttonPanel.setMargin(new Margin(8, 0, 0, 0));
		buttonPanel.add(copyBtn);
		buttonPanel.add(btnGetDay);
		buttonPanel.add(btnGetMonth);
		buttonPanel.add(btnGetYear);
		buttonPanel.add(btnGetDate);
		wrapper.add(buttonPanel);
		wrapper.setDefaultSubmitButton(copyBtn);

		//
		wrapper = new WPanel();
		add(wrapper);
		wrapper.setMargin(new Margin(16, 0, 16, 0));
		WFieldSet setDateFieldSet = new WFieldSet("Set some or all of the date");
		wrapper.add(setDateFieldSet);
		// setDateFieldSet.setFrameType(WFieldSet.FrameType.NO_BORDER);
		WFieldLayout componentPanel = new WFieldLayout();
		componentPanel.setLabelWidth(30);
		componentPanel.addField("Day", day);
		componentPanel.addField("Month", month);
		componentPanel.addField("Year", year);
		setDateFieldSet.add(componentPanel);

		WPanel setDateButtonPanel = new WPanel(WPanel.Type.FEATURE);
		wrapper.add(setDateButtonPanel);
		setDateButtonPanel.setLayout(new FlowLayout(FlowLayout.LEFT, 6));
		setDateButtonPanel.setMargin(new com.github.bordertech.wcomponents.Margin(6, 0, 0, 0));

		final WButton btnSetDMY = new WButton("Set the day month year");
		setDateButtonPanel.add(btnSetDMY);
		WButton btnSetDate = new WButton("Set the Java Date(Today)");
		setDateButtonPanel.add(btnSetDate);
		wrapper.setDefaultSubmitButton(btnSetDMY);

		add(new WHeading(HeadingLevel.H2, "Other properties"));
		layout = new WFieldLayout();
		layout.setLabelWidth(30);
		add(layout);
		WPartialDateField pdfPropField = new WPartialDateField();
		pdfPropField.setDisabled(true);
		layout.addField("Disabled partial date field", pdfPropField);
		pdfPropField = new WPartialDateField();
		pdfPropField.setDisabled(true);
		pdfPropField.setPartialDate(null, 7, 2015);
		layout.addField("Disabled partial date field with content", pdfPropField);
		pdfPropField = new WPartialDateField();
		pdfPropField.setMandatory(true);
		layout.addField("Mandatory partial date field", pdfPropField);
		pdfPropField = new WPartialDateField();
		pdfPropField.setToolTip("Any part of the date is fine");
		layout.addField("Partial date field with toolTip", pdfPropField);

		add(new WHeading(HeadingLevel.H2, "Read-only"));
		WPartialDateField roDate = new WPartialDateField();
		roDate.setReadOnly(true);
		layout = new WFieldLayout();
		add(layout);
		layout.addField("read-only no date", roDate);
		roDate = new WPartialDateField();
		roDate.setReadOnly(true);
		roDate.setDate(new Date());
		layout.addField("read-only today", roDate);
		roDate = new WPartialDateField();
		roDate.setReadOnly(true);
		roDate.setPartialDate(null, 11, 2013);
		layout.addField("read-only November 2013", roDate);
		roDate = new WPartialDateField();
		roDate.setReadOnly(true);
		roDate.setPartialDate(13, null, 2013);
		layout.addField("read-only 13th unknown month 2013", roDate);
		roDate = new WPartialDateField();
		roDate.setReadOnly(true);
		roDate.setPartialDate(13, 07, null);
		layout.addField("read-only 13th July", roDate);

		copyBtn.setAction(new Action() {
			@Override
			public void execute(final ActionEvent event) {
				text.setText(dateField.getValueAsString());
			}
		});

		btnGetDay.setAction(new Action() {
			@Override
			public void execute(final ActionEvent event) {
				Integer value = dateField.getDay();
				text.setText(value == null ? null : value.toString());
			}
		});

		btnGetMonth.setAction(new Action() {
			@Override
			public void execute(final ActionEvent event) {
				Integer value = dateField.getMonth();
				text.setText(value == null ? null : value.toString());
			}
		});

		btnGetYear.setAction(new Action() {
			@Override
			public void execute(final ActionEvent event) {
				Integer value = dateField.getYear();
				text.setText(value == null ? null : value.toString());
			}
		});

		btnGetDate.setAction(new Action() {
			@Override
			public void execute(final ActionEvent event) {
				if (dateField.getDate() != null) {
					text.setText(dateField.getDate().toString());
				} else {
					text.setText("");
				}
			}
		});

		btnSetDMY.setAction(new Action() {
			@Override
			public void execute(final ActionEvent event) {
				dateField.setPartialDate(parseInt(day.getText()), parseInt(month.getText()),
						parseInt(year.getText()));
			}
		});

		btnSetDate.setAction(new Action() {
			@Override
			public void execute(final ActionEvent event) {
//                Calendar now = Calendar.getInstance();
//                dateField.setPartialDate(now.get(Calendar.DAY_OF_MONTH), now.get(Calendar.MONTH) + 1, now.get(Calendar.YEAR));
				dateField.setDate(new Date());
			}
		});
	}

	/**
	 * Attempts to parse an integer string.
	 *
	 * @param integerString the text to parse
	 * @return the parsed text, or null if it couldn't be parsed.
	 */
	private Integer parseInt(final String integerString) {
		try {
			return new Integer(integerString);
		} catch (NumberFormatException e) {
			return null;
		}
	}
}
