*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           StringFormat
Resource          ../../config/common/envi.robot

Library           BuiltIn
*** Variables ***
${endpoint_danhmuc_hh}    /branchs/{0}/masterproducts?/format=json&Includes=ProductAttributes&ForSummaryRow
*** Keywords ***
Get thong tin ma hang hoa from API
    [Arguments]    ${input_mahang}
    [Timeout]    1 minute
    ${endpoint_pr}    Format String    ${endpoint_danhmuc_hh}    ${BRANCH_ID}
    ${jsonpath_loai_hang_hoa}    Format String    $..Data[?(@.Code=="{0}")].CategoryName    ${input_mahang}
    ${loai_hang_hoa}    Get data from API    ${endpoint_pr}      ${jsonpath_loai_hang_hoa}
    Log To Console    ${loai_hang_hoa}
    Return From Keyword    ${loai_hang_hoa}
