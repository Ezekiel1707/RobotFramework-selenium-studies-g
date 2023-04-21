*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library    Collections
Library    RequestsLibrary
Library    ../customLibraries/Shop.py
#Test Setup       Open browser with the url    Chrome
#Test Teardown    Close browser session
Resource    ../PageObjects/basicResources.robot
Resource    ../PageObjects/Landing.robot
Resource    ../PageObjects/shopPage.robot    
Resource    ../PageObjects/checkoutPage.robot
Resource    ../PageObjects/ConfirmationPage.robot


*** Variables ***
${base_url}    http://216.10.245.166
${book_id}
${book_name}    RobotFramework

*** Test Cases ***
Play around with Dictionary
    &{data}=    Create Dictionary    name=rahulshetty    course=robot    website=rahulshettyacademy.com
    Log    ${data}
    Dictionary Should Contain Key    ${data}    name

    #retreave key of dictionary
    Log    ${data}[name]
    ${url}=    Get From Dictionary    ${data}    website
    Log    ${url}

Add Book to Library
    [Tags]    API
    &{req_body}=    Create Dictionary    name=${book_name}     isbn=9747884    aisle=561275    author=john
    ${response}=    POST    ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID
     ${book_id}=    Get From Dictionary   ${response.json()}    ID
     Set Global Variable    ${book_id}
     Log    ${book_id}
     Should be Equal as Strings    successfully added    ${response.json()}[Msg]
     Status Should Be    200    ${response}

Get the book details whick got added
    [Tags]    API
    ${get_response}=    GET    ${base_url}/Library/GetBook.php    params=ID=${book_id}     expected_status=200
    Log    ${get_response.json()}
    Should Be Equal As Strings    ${book_name}    ${get_response.json()}[0][book_name]

Delete the Book from database
    [Tags]    API
    &{delete_req}=    Create Dictionary    ID=${book_id}
    ${delete_response}=    POST    ${base_url}/Library/DeleteBook.php    json=${delete_req}    expected_status=200
    Log    ${delete_response.json()}
    Should Be Equal As Strings    book is successfully deleted    ${delete_response.json()}[msg]
*** Keywords ***

