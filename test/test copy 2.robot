*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library    Collections
Test Setup         Open browser with the Mortgage payment url
#Test Teardown    Close browser session
    
Resource    ../PageObjects/basicResources.robot

*** Variables ***
${Error_Message_Login}    css:.alert.alert-danger.col-md-12
${Shop_page_load}    css:app-navbar .navbar-brand

*** Test Cases ***
Validate UnSuccesful Login
    
    Fill the Login form    ${user_name}    ${invalid_password} 
    wait until Element is located in the page    ${Error_Message_Login}
    verify error message is correct

Validate Cards display 
    Fill the Login form    ${user_name}    ${valid_password}
    wait until Element is located in the page    ${Shop_page_load}
    verify card titles in the shop page
    Select the card    Nokia Edge

Select the Form and navigate to Child Windows
    Fill the login Details and select user options    ${user_name}    ${valid_password}

*** Keywords ***

Fill the Login form
    [Arguments]    ${user_name}    ${password}
    Input Text    css:input#username    ${user_name} 
    Input Password    css:input#password    ${password}
    Click Button    css:input#signInBtn

wait until Element is located in the page
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}

verify error message is correct
    # ${result}=    Get Text    ${Error_Message_Login}
    # Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.

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

Fill the login Details and select user options
     [Arguments]    ${user_name}    ${password}
    Input Text    css:input#username    ${user_name} 
    Input Password    css:input#password    ${password}
    Click Element    css:label:nth-of-type(2) > .radiotextsty
    Wait Until Element Is Visible    css:.modal-body
    Double Click Element     css:#okayBtn
    Double Click Element     css:#okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms
    Click Button    css:input#signInBtn