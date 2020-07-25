
*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Resource    ../page/loginPage.robot

*** Keywords ***
enter info login
    [Arguments]    ${userName}    ${passwordInfo}
    Input Text    ${locator_user}    ${userName}
    Input Password    ${locator_password}    ${passwordInfo}
