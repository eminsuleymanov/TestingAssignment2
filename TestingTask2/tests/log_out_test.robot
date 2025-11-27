*** Settings ***
Resource    ../resources/resources.robot
Suite Setup    Open BrowserStack Session
Suite Teardown    Close All Browsers
*** Test Cases ***
User Can Log Out After Logging In
    Log In
    Log Out
