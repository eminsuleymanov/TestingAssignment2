*** Settings ***
Resource    ../resources/resources.robot
Suite Setup    Open BrowserStack Session
Suite Teardown    Close All Browsers

*** Test Cases ***
User Can Log In Successfully
    Log In
    Sleep    2s
    Log Out
