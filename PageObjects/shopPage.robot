*** Settings ***
Documentation    All the page objects and keywords of landing page
Library    SeleniumLibrary
Library    Collections
Resource    basicResources.robot

*** Variables ***
${Shop_page_load}    css:app-navbar .navbar-brand

*** Keywords ***
wait until Element is located in the page
    Wait Until element passed is located on page    ${Shop_page_load}

verify card titles in the shop page
    @{expected_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements}=    Get WebElements     css:.card-title
    @{actual_list}=    Create List

    FOR     ${element}    IN    @{elements}
      Log    ${element.text}
      Append To List    ${actual_list}    ${element.text}
    END

    Lists Should Be Equal    ${expected_list}    ${actual_list}

Select the card 
    [Arguments]    ${card_name}
    ${elements}=    Get WebElements     css:.card-title
    ${index}=    Set Variable    1
    FOR     ${element}    IN    @{elements}
        Exit For Loop if    '${card_name}' == '${element.text}'
            ${index}=    Evaluate    ${index} + 1

    END
    Click Button    css:app-card:nth-of-type(${index}) .btn.btn-info