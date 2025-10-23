*** Settings ***
Resource    ../resources/resources.robot
Suite Teardown    Close Browser
*** Test Cases ***
User Can Log Out After Logging In
    Log In
    Log Out
