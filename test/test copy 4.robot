*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library    Collections
Test Setup    Open browser with the Mortgage payment url
Test Teardown    Close browser session
Resource    ../PageObjects/basicResources.robot 
Test Template       Validate UnSuccesful Login

*** Variables ***
${Error_Message_Login}    css:.alert.alert-danger.col-md-12
${Shop_page_load}    css:app-navbar .navbar-brand

*** Test Cases ***        username        password
Invalid username          dsahed          learning
Invalid password          rahulshetty     ploudfg
special charaters         @#$             learning


*** Keywords ***
Validate UnSuccesful Login
    [Arguments]    ${username}    ${password}
    Fill the Login form    ${username}    ${password} 
    wait until Element is located in the page    ${Error_Message_Login}
    verify error message is correct

Fill the Login form
    [Arguments]    ${username}    ${password}
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
