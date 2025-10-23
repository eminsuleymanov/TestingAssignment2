*** Settings ***
Resource    ../resources/resources.robot
Suite Teardown    Close Browser
*** Test Cases ***
User Can Add Product To Cart Successfully
    Log In
    Add Product To Cart