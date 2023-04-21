*** Settings ***
Documentation    All the page objects and keywords of landing page
Library    SeleniumLibrary
Library    Collections
Resource    basicResources.robot

*** Variables ***
${Error_Message_Login}    css:.alert.alert-danger.col-md-12

*** Keywords ***
Fill the Login form
    [Arguments]    ${user_name}    ${password}
    Input Text    css:input#username    ${user_name} 
    Input Password    css:input#password    ${password}
    Click Button    css:input#signInBtn

wait until Element is located in the page
    Wait Until element passed is located on page    ${Error_Message_Login}

verify error message is correct
    # ${result}=    Get Text    ${Error_Message_Login}
    # Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.

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