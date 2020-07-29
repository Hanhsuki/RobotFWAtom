*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Resource    ../page/popupAddProduct.robot
Resource     ../../config/common/common.robot
*** Keywords ***
enter info Product
    [Arguments]    ${code}    ${name}   ${cost}    ${price}   ${group}
    Input Text    ${locator_text_code_product}    ${code}
    Input Text    ${locator_text_name_product}    ${name}
    Click Element    ${locator_icon_dropdown_group_product}
    Wait Until Element Is Visible    ${locator_text_seach_group_product}
    Input Text       ${locator_text_seach_group_product}    ${group}
    Click Element    ${locator_item_group_product}
    Input Text    ${locator_text_cost_product}    ${cost}
    Input Text    ${locator_text_price_product}    ${price}
    Scroll page
    Click Element    ${locator_save_product}
verify message create product sussess
    Wait Until Element Is Visible    ${msg_create_product_success}
    Element Text Should Be    ${msg_create_product_success}    Hàng hóa đã được tạo thành công
