*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Resource          ../page/homePage.robot
Resource          ../action/loginAction.robot
Resource          ../action/homePageAction.robot
Resource          ../action/listProductAction.robot
Resource          ../action/popupAddProductAction.robot
Resource          ../../config/common/common.robot
Suite Setup       before test    ${url}    ${browser}
Suite Teardown    after test

*** Variables ***
${url}    https://fnb.kiotviet.vn/chuyendb1/Login
${browser}  chrome

*** Test Cases ***
Login manager
    [Template]   login
    admin    123

Add product
    [Template]    product
    HH00000001    Hàng hóa test    50000    100000    Thực phẩm chức năng    10

*** Keywords ***
login
    [Arguments]    ${userName}    ${passwordInfo}
    enter info login    ${userName}    ${passwordInfo}
    Click Button    ${locator_buttonManager}
    Wait Until Element Is Visible    ${locator_account}
    Element Text Should Be    ${locator_account}    admin
product
    [Arguments]    ${code}    ${name}   ${cost}    ${price}   ${group}    ${inventory}
    click menu product
    click menu add product
    enter info Product    ${code}    ${name}   ${cost}    ${price}   ${group}    ${inventory}
