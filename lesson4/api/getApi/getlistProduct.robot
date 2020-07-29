*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           StringFormat
Resource          ../../config/common/envi.robot

Library           BuiltIn
*** Variables ***
${endpoint_danhmuc_hh}    /branchs/{0}/masterproducts?/format=json&Includes=ProductAttributes&ForSummaryRow
*** Keywords ***
Get thong tin hang hoa from API
    [Arguments]    ${input_mahang}
    [Timeout]    1 minute
    ${endpoint_pr}    Format String    ${endpoint_danhmuc_hh}    ${BRANCH_ID}
    ${jsonpath_ma_hang_hoa}    Format String    $..Data[?(@.Code=="{0}")].Code    ${input_mahang}
    ${jsonpath_loai_hang_hoa}    Format String    $..Data[?(@.Code=="{0}")].CategoryName    ${input_mahang}
    ${jsonpath_ten_hang_hoa}    Format String    $..Data[?(@.Code=="{0}")].Name     ${input_mahang}
    ${jsonpath_giavon_hang_hoa}    Format String    $..Data[?(@.Code=="{0}")].Cost     ${input_mahang}
    ${jsonpath_giaban_hang_hoa}    Format String    $..Data[?(@.Code=="{0}")].BasePrice    ${input_mahang}
    ${ma_hang_hoa}    Get data from API 1    ${endpoint_pr}      ${jsonpath_ma_hang_hoa}
    ${loai_hang_hoa}    Get data from API    ${endpoint_pr}      ${jsonpath_loai_hang_hoa}
    ${ten_hang_hoa}    Get data from API    ${endpoint_pr}      ${jsonpath_ten_hang_hoa}
    ${giavon_hang_hoa}    Get data from API    ${endpoint_pr}      ${jsonpath_giavon_hang_hoa}
    ${giaban_hang_hoa}    Get data from API    ${endpoint_pr}      ${jsonpath_giaban_hang_hoa}
    ${giaban_hang_hoa}=    Evaluate    round(${giaban_hang_hoa})
    Return From Keyword    ${ma_hang_hoa}    ${loai_hang_hoa}    ${ten_hang_hoa}    ${giavon_hang_hoa}    ${giaban_hang_hoa}
