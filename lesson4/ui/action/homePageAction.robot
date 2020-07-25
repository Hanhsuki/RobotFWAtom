*** Variables ***
*** Settings ***
Library      SeleniumLibrary
Library      OperatingSystem
Resource     ../page/homePage.robot
Resource     ../../config/common/common.robot

*** Keywords ***
click menu product
    Wait Until Element Is Visible    ${locator_menu_product}
    Click Element JS    ${locator_menu_product}
    Wait Until Element Is Visible    ${locator_submenu_product}
    Click Element JS    ${locator_submenu_product}
