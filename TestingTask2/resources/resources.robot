*** Settings ***
Library     SeleniumLibrary
Variables   ./testData.py
Variables   ./locators.py

*** Keywords ***

Sign Up
    Open Browser    ${baseUrl}    Chrome
    Wait Until Page Contains Element    ${signUpButton}    timeout=80    error=signUpButtonNotFound
    Sleep    1s
    Click Element    ${signUpButton}
    Wait Until Page Contains Element    ${signUpUsername}    timeout=80    error=signUpUsernameNotFound
    Sleep    1s
    Input Text    ${signUpUsername}    ${login}
    Sleep    2s
    Input Password    ${signUpPassword}    ${password}
    Sleep    2s
    Click Element    ${signUpFormButton}
    Sleep    3s

Log In
    Open Browser    ${baseUrl}    Chrome
    Wait Until Page Contains Element    ${logInButton}    timeout=80    error=logInButtonNotFound
    Sleep    1s
    Click Element    ${logInButton}
    Wait Until Page Contains Element    ${loginUsernameField}    timeout=80    error=loginUsernameFieldNotFound
    Sleep    1s
    Input Text    ${loginUsernameField}    ${login}
    Input Password    ${loginPasswordField}    ${password}
    Sleep    1s
    Click Element    ${logInFormButton}
    Sleep    2s

Log Out
    Wait Until Page Contains Element    ${logoutButton}    timeout=15
    Sleep    1s
    Click Element    ${logoutButton}
    Sleep    2s

Add Product To Cart
    Sleep    3s
    ${product_locator}=    Set Variable    //a[contains(text(),"${productName}")]
    Wait Until Page Contains Element    ${product_locator}    timeout=20
    Scroll Element Into View    ${product_locator}
    Sleep    1s
    Click Element    ${product_locator}
    Wait Until Page Contains Element    ${addToCartButton}    timeout=10
    Sleep    1s
    Click Element    ${addToCartButton}
    Sleep    2s
    Handle Alert    accept
    Sleep    1s
Close Browser
    Close All Browsers