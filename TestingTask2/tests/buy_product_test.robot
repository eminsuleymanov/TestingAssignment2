*** Settings ***
Resource    ../resources/resources.robot
Suite Setup    Open BrowserStack Session
Suite Teardown    Close All Browsers
*** Test Cases ***
User Can Add Product To Cart Successfully
    Log In
    Add Product To Cart