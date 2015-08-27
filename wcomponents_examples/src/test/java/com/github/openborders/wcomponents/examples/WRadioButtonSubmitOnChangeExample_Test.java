package com.github.openborders.wcomponents.examples; 

import com.github.openborders.wcomponents.examples.WRadioButtonSubmitOnChangeExample;
import junit.framework.Assert;

import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;

import com.github.openborders.wcomponents.test.selenium.MultiBrowserRunner;
import com.github.openborders.wcomponents.test.selenium.WComponentSeleniumTestCase;

/**
 * Selenium unit tests for {@link WRadioButtonSubmitOnChangeExample}.
 * 
 * @author Yiannis Paschalidis 
 * @since 1.0.0
 */
@Category(SeleniumTests.class)
@RunWith(MultiBrowserRunner.class)
public class WRadioButtonSubmitOnChangeExample_Test extends WComponentSeleniumTestCase
{
    /**
     * Creates a new WRadioButtonSubmitOnChangeExample_Test.
     */
    public WRadioButtonSubmitOnChangeExample_Test()
    {
        super(new WRadioButtonSubmitOnChangeExample());
    }
    
    @Test
    public void testExample()
    {
        // Launch the web browser to the LDE
        WebDriver driver = getDriver();
        
        // Select "ACT"
        driver.findElement(byWComponentPath("WRadioButton", "ACT")).click();
        
        // Should have round-tripped, check server and client-side states
        Assert.assertTrue("Incorrect state selection on server", driver.getPageSource().contains("the heart of the nation!"));
        Assert.assertTrue("Incorrect state selection on client", driver.findElement(byWComponentPath("WRadioButton", "ACT")).isSelected());
        Assert.assertTrue("Incorrect region selection on client", driver.findElement(byWComponentPath("WDropdown", "")).isSelected());
        
        // Select "City" from Region dropdown (no round trip)
        driver.findElement(byWComponentPath("WDropdown", "City")).click();
        Assert.assertTrue("Incorrect region selection on client", driver.findElement(byWComponentPath("WDropdown", "City")).isSelected());
        
        // Select "NSW"
        driver.findElement(byWComponentPath("WRadioButton", "NSW")).click();
        
        // Should have round-tripped, check server and client-side states
        Assert.assertFalse("Incorrect state selection on server", driver.getPageSource().contains("the heart of the nation!"));
        Assert.assertTrue("Incorrect state selection on client", driver.findElement(byWComponentPath("WRadioButton", "NSW")).isSelected());
        Assert.assertTrue("Incorrect region selection on client", driver.findElement(byWComponentPath("WDropdown", "")).isSelected());
        
        // Select "Hunter" from Region dropdown (no round trip)
        driver.findElement(byWComponentPath("WDropdown", "Hunter")).click();
        Assert.assertTrue("Incorrect region selection on client", driver.findElement(byWComponentPath("WDropdown", "Hunter")).isSelected());
    }    
}