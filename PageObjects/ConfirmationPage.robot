*** Settings ***
Documentation    All the page objects and keywords of confirmation Page
Library    SeleniumLibrary
Library    Collections
Resource    basicResources.robot

*** Variables ***


*** Keywords ***

Enter the Country and select the terms
    [Arguments]    ${country_name}
    Input Text    id:country    ${country_name}
    Sleep    5
    Wait Until element passed is located on page    //ul//a[.='${country_name}']
    Click Element    //ul//a[.='${country_name}']
    Sleep    5
    Click Element    css:.checkbox label

Purchase the Product and Confirm the Purchase
    Click Button    css:.btn-success
    Page Should Contain    Success!