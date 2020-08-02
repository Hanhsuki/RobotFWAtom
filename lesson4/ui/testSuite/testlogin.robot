*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           JSONLibrary
Library           RequestsLibrary
Library           StringFormat
Library           BuiltIn
Resource          ../page/homePage.robot
Resource          ../action/loginAction.robot
Resource          ../action/homePageAction.robot
Resource          ../action/listProductAction.robot
Resource          ../action/popupAddProductAction.robot
Resource          ../../config/common/common.robot
Resource          ../../api/getApi/getlistProduct.robot

*** Variables ***
${env}    live1



*** Test Cases ***
LoginManager
    [Tags]    DemoTagLogin
    [Setup]    before test login    ${env}
    [Template]   login
    ${USER_NAME}    ${PASSWORD}
    [Teardown]    after test login

Add product
    [Tags]    DemoTagAddProduct
    [Setup]    before test add product    ${env}    ${USER_NAME}    ${PASSWORD}
    [Template]     product
    HH00000001    Hàng hóa test    50000    100000    Thực phẩm chức năng
    [Teardown]    after test add product

*** Keywords ***
login
    [Arguments]    ${userName}    ${passwordInfo}
    enter info login    ${userName}    ${passwordInfo}
    Click Button    ${locator_buttonManager}
    Wait Until Element Is Visible    ${locator_account}
    Element Text Should Be    ${locator_account}    admin

product
    [Arguments]    ${code}    ${name}   ${cost}    ${price}   ${group}
    ${price}=    Evaluate    round(${price})
    click menu product
    click menu add product
    enter info Product    ${code}    ${name}   ${cost}    ${price}   ${group}
    verify message create product sussess
    ${ma_hang_hoa}    ${loai_hang_hoa}    ${ten_hang_hoa}    ${giavon_hang_hoa}    ${giaban_hang_hoa}    Get thong tin hang hoa from API    ${code}
    Should Be Equal      ${ma_hang_hoa}    ${code}
    Should Be Equal      ${loai_hang_hoa}    ${group}
    Should Be Equal      ${ten_hang_hoa}    ${name}
    Should Be Equal      ${giaban_hang_hoa}    ${price}
    Should Be Equal As Integers     ${giavon_hang_hoa}    ${cost}
