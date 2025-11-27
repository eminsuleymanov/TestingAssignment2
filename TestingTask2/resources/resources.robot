*** Settings ***
Library     SeleniumLibrary
Variables   ./testData.py
Variables   ./locators.py


*** Keywords ***

Open BrowserStack Session
    [Arguments]    ${browser_config}
    Create WebDriver    Remote    desired_capabilities=${browser_config}    command_executor=https://$BROWSERSTACK_USERNAME:$BROWSERSTACK_ACCESS_KEY@hub-cloud.browserstack.com/wd/hub


Sign Up
    Wait Until Page Contains Element    ${signUpButton}    timeout=20
    Click Element    ${signUpButton}
    Wait Until Page Contains Element    ${signUpUsername}    timeout=20
    Input Text    ${signUpUsername}    ${login}
    Input Password    ${signUpPassword}    ${password}
    Click Element    ${signUpFormButton}
    Wait Until Page Contains    Successfully registered    timeout=10

Log In
    Wait Until Page Contains Element    ${logInButton}    timeout=20
    Click Element    ${logInButton}
    Wait Until Page Contains Element    ${loginUsernameField}    timeout=20
    Input Text    ${loginUsernameField}    ${login}
    Input Password    ${loginPasswordField}    ${password}
    Click Element    ${logInFormButton}
    Wait Until Page Contains    Welcome    timeout=10

Log Out
    Wait Until Element Is Visible    ${logoutButton}    timeout=15
    Wait Until Element Is Enabled    ${logoutButton}    timeout=10
    Click Element    ${logoutButton}
    Wait Until Page Contains    Logged out successfully    timeout=10

Add Product To Cart
    [Arguments]    ${product_name}=${productName}
    ${product_locator}=    Set Variable    //a[contains(text(),"${product_name}")]
    Wait Until Page Contains Element    ${product_locator}    timeout=20
    Scroll Element Into View    ${product_locator}
    Click Element    ${product_locator}
    Wait Until Page Contains Element    ${addToCartButton}    timeout=10
    Click Element    ${addToCartButton}
    Wait Until Alert Is Present    timeout=5
    Handle Alert    accept

Close Browser
    Close All Browsers
