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
delete product sussess
    Wait Until Element Is Visible    ${locator_delete_product}
    Click Element     ${locator_delete_product}
    Wait Until Element Is Visible    ${locator_accept_delet_product}
    Click Button    ${locator_accept_delet_product}
