*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Variables   ./testData.py
Variables   ./locators.py


*** Keywords ***
Open BrowserStack Session
    ${username}=    Get Environment Variable    BROWSERSTACK_USERNAME
    ${access_key}=    Get Environment Variable    BROWSERSTACK_ACCESS_KEY
    ${base_url}=    Set Variable    ${baseUrl}

    ${caps}=    Create Dictionary
    ...    browserName=chrome
    ...    os=Windows
    ...    os_version=10
    ...    browserstack.user=${username}
    ...    browserstack.key=${access_key}
    ...    name=Demoblaze Test
    ...    build=demoblaze-build-1
    ...    project=Demoblaze automation

    ${hub_url}=    Set Variable    https://${username}:${access_key}@hub-cloud.browserstack.com/wd/hub

    Open Browser    ${base_url}    remote_url=${hub_url}    desired_capabilities=${caps}
    Maximize Browser Window
    Set Selenium Timeout    30s

Sign Up
    Wait Until Page Contains Element    ${signUpButton}    timeout=20
    Click Element    ${signUpButton}
    Wait Until Page Contains Element    ${signUpUsername}    timeout=20
    Input Text    ${signUpUsername}    ${login}
    Input Password    ${signUpPassword}    ${password}
    Click Element    ${signUpFormButton}
    Sleep    2s
    Handle Alert    accept

Log In
    Wait Until Page Contains Element    ${logInButton}    timeout=20
    Click Element    ${logInButton}
    Wait Until Page Contains Element    ${loginUsernameField}    timeout=20
    Input Text    ${loginUsernameField}    ${login}
    Input Password    ${loginPasswordField}    ${password}
    Click Element    ${logInFormButton}
    Sleep    2s
    Wait Until Page Contains Element    ${logoutButton}    timeout=15

Log Out
    Wait Until Element Is Visible    ${logoutButton}    timeout=15
    Click Element    ${logoutButton}
    Sleep    2s

Add Product To Cart
    [Arguments]    ${product_name}=${productName}
    Go To    ${baseUrl}
    Sleep    2s
    ${product_locator}=    Set Variable    //a[contains(text(),"${product_name}")]
    Wait Until Page Contains Element    ${product_locator}    timeout=20
    Scroll Element Into View    ${product_locator}
    Click Element    ${product_locator}
    Wait Until Page Contains Element    ${addToCartButton}    timeout=10
    Click Element    ${addToCartButton}
    Sleep    1s
    Handle Alert    accept