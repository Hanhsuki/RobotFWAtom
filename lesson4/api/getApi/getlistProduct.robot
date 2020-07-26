*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Resource          ../common/common.robot

Library           BuiltIn
*** Variables ***
${endpoint_danhmuc_hh}    /branchs/{0}/masterproducts?format=json&Includes=ProductAttributes&ForSummaryRow
*** Keywords ***
Get thong tin hang hoa from API
    [Arguments]    ${ma_hang_hoa}
    ${jsonpath_code}    Format String    $..Data[?(@.Code=="{0}")].CategoryName    ${ma_hang_hoa}
    Get data from API     ${endpoint_danhmuc_hh}    ${jsonpath_code}
