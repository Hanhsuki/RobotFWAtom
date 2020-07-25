*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Resource    ../page/popupAddProduct.robot
Resource     ../../config/common/common.robot
*** Keywords ***
enter info Product
    [Arguments]    ${code}    ${name}   ${cost}    ${price}   ${group}    ${inventory}
    Input Text    ${locator_text_code_product}    ${code}
    Input Text    ${locator_text_name_product}    ${name}
    Click Element    ${locator_icon_dropdown_group_product}
    Select From List By Value    ${locator_dropdown_group_product}   ${group}
    Input Text    ${locator_text_cost_product}    ${cost}
    Input Text    ${locator_text_price_product}    ${price}
    Input Text    ${locator_text_inventory_product}    ${inventory}
