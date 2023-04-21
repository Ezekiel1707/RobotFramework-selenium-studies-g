*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library    Collections
Library    ../customLibraries/Shop.py
Test Setup       Open browser with the url    Chrome
Test Teardown    Close browser session
Resource    ../PageObjects/basicResources.robot
Resource    ../PageObjects/Landing.robot
Resource    ../PageObjects/shopPage.robot    
Resource    ../PageObjects/checkoutPage.robot
Resource    ../PageObjects/ConfirmationPage.robot


*** Variables ***
@{listofProducts}    Blackberry    Nokia Edge
${country_name}    India

*** Test Cases ***
Validate UnSuccesful Login
    [Tags]       SMOKE
    Landing.Fill the Login form    ${user_name}    ${invalid_password} 
    Landing.wait until Element is located in the page
    Landing.verify error message is correct

Validate Cards display 
    [Tags]        REGRESSION
    Landing.Fill the Login form    ${user_name}    ${valid_password}
    shopPage.wait until Element is located in the page    
    shopPage.verify card titles in the shop page
    Add Item To Cart And Checkout    ${listofProducts} 
    #Select the card    Nokia Edge
    checkoutPage.Verify items in Checkout Page and Proceed
    ConfirmationPage.Enter the Country and select the terms    ${country_name}
    ConfirmationPage.Purchase the Product and Confirm the Purchase



Select the Form and navigate to Child Windows
    Landing.Fill the login Details and select user options    ${user_name}    ${valid_password}

*** Keywords ***

