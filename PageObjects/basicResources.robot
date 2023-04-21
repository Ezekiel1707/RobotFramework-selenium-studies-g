*** Settings ***
Documentation    A resource file with reusable keyword and variables.
...              The System specific keywords created here form our own
...              domain specific language. They utilize keyword provided
...              by the imported SeleniumLibrary
Library    SeleniumLibrary

*** Variables ***
${url}                    https://rahulshettyacademy.com/loginpagePractise/
${user_name}              rahulshettyacademy
${invalid_password}       123456789
${valid_password}         learning

*** Keywords ***
 Open browser with the Mortgage payment url
    Create Webdriver    Chrome    executable_path=/Documents/RobotFramework/robot/test/resources/chromedriver
    Go To    ${url}                           

 Open browser with the url
    [Arguments]    ${browser_name}
    Create Webdriver    ${browser_name}    executable_path=/Documents/RobotFramework/robot/test/resources/${browser_name}driver
    Go To    ${url}

Close browser session
    Close Browser

Wait Until element passed is located on page
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible    ${page_locator}