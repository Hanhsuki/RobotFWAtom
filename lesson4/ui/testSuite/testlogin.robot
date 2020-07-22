*** Settings ***
Library          SeleniumLibrary
Library          OperatingSystem
Resource         ../page/homePage.robot
Resource         ../action/loginAction.robot
Resource         ../../config/common/common.robot
Suite Setup      before test    ${url}    ${browser}
Suite Teardown   after test

*** Variables ***
${url}    https://fnb.kiotviet.vn/testfnbz15/Login
${browser}  chrome

*** Test Cases ***
Login manager
    [Template]   login
    admin    123

*** Keywords ***
login
    [Arguments]    ${userName}    ${passwordInfo}
    enter info login    ${userName}    ${passwordInfo}
    Click Button    ${locator_buttonManager}
    Wait Until Element Is Visible     ${locator_icon_overview}
    Element Text Should Be     ${locator_icon_overview}     Tổng quan
