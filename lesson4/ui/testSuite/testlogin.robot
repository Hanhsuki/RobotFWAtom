*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          ../page/homePage.robot
Resource          ../action/loginAction.robot
Resource          ../action/homePageAction.robot
Resource          ../action/listProductAction.robot
Resource          ../action/popupAddProductAction.robot
Resource          ../../config/common/common.robot
Resource          ../../api/getApi/getlistProduct.robot
Suite Setup       before test    ${env}
Suite Teardown    after test

*** Variables ***
${env}    live1


*** Test Cases ***
Login manager
    [Template]   login
    ${USER_NAME}    ${PASSWORD}

Add product
    [Template]     product
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
    verify message create product sussess
    ${code_api}    Get thong tin ma hang hoa from API   ${code}
    Log To Console    ${code_api}
    Should Be Equal    ${code_api}    Thực phẩm chức năng
    delete product sussess
