*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Test Teardown    Close Browser
#Resource    
*** Variables ***
${Error_Message_Login}    css:.alert.alert-danger.col-md-12

*** Test Cases ***
Validate Succesful Login
    open browser with the Mortgage payment url
    Fill the Login form
    wait until it checks and display error message
    verify error message is correct

*** Keywords ***
 open browser with the Mortgage payment url
    Create Webdriver    Chrome    executable_path=/Documents/RobotFramework/robot/test/resources/chromedriver.exe
    Go To    https://rahulshettyacademy.com/loginpagePractise/

Fill the Login form
    Input Text    css:input#username    rahulshettyacademy
    Input Password    css:input#password    123456789
    Click Button    css:input#signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible    ${Error_Message_Login}

verify error message is correct
    # ${result}=    Get Text    ${Error_Message_Login}
    # Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.
    