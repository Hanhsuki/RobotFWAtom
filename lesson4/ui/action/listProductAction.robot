*** Variables ***
*** Settings ***
Library      SeleniumLibrary
Library      OperatingSystem
Resource     ../page/listProduct.robot
Resource     ../../config/common/common.robot

*** Keywords ***
click menu add product
    Wait Until Element Is Visible    ${locator_button_add_product}
    Click Element    ${locator_button_add_product}
    Wait Until Element Is Visible    ${locator_sub_button_add_product}
    Click Element JS    ${locator_sub_button_add_product}
