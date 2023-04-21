*** Settings ***
Documentation    All the page objects and keywords of landing page
Library    SeleniumLibrary
Library    Collections
Resource    basicResources.robot

*** Variables ***


*** Keywords ***

Verify items in Checkout Page and Proceed
    Click Element    css:.btn-success
