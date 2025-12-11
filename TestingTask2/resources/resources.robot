*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Variables   ./testData.py
Variables   ./locators.py


*** Keywords ***
Open BrowserStack Session
    ${username}=    Get Environment Variable    BROWSERSTACK_USERNAME
    ${access_key}=    Get Environment Variable    BROWSERSTACK_ACCESS_KEY

    # Get browser from command line variable, default to chrome
    ${browser}=    Get Variable Value    ${BROWSER}    chrome

    # Create options based on browser type
    ${options}=    Run Keyword If    '${browser}' == 'chrome'
    ...    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ...    ELSE IF    '${browser}' == 'firefox'
    ...    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    ...    ELSE IF    '${browser}' == 'safari'
    ...    Evaluate    sys.modules['selenium.webdriver'].SafariOptions()    sys, selenium.webdriver

    # Set OS based on browser (Safari needs macOS)
    ${os}=    Set Variable If    '${browser}' == 'safari'    OS X    Windows
    ${os_version}=    Set Variable If    '${browser}' == 'safari'    Sequoia    10
    ${browser_cap}=    Set Variable If    '${browser}' == 'chrome'    Chrome
    ...    '${browser}' == 'firefox'    Firefox
    ...    '${browser}' == 'safari'    Safari

    ${bstack_caps}=    Create Dictionary
    ...    userName=${username}
    ...    accessKey=${access_key}
    ...    buildName=demoblaze-build-1
    ...    projectName=Demoblaze automation
    ...    os=${os}
    ...    osVersion=${os_version}
    ...    video=true
    ...    debug=true
    ...    networkLogs=true
    ...    consoleLogs=errors

    Call Method    ${options}    set_capability    bstack:options    ${bstack_caps}
    Call Method    ${options}    set_capability    browserName    ${browser_cap}

    Create Webdriver    Remote
    ...    command_executor=https://hub-cloud.browserstack.com/wd/hub
    ...    options=${options}

    Go To    ${baseUrl}
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