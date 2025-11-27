*** Settings ***
Resource    ../resources/resources.robot
Suite Setup    Open BrowserStack Session
Suite Teardown    Close All Browsers
*** Test Cases ***
User Can Sign Up Successfully
    Sign Up