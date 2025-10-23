*** Settings ***
Resource    ../resources/resources.robot
Suite Teardown    Close Browser
*** Test Cases ***
User Can Log In Successfully
    Log In
    Sleep    2s
    Log Out
