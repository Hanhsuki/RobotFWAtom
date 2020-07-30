*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           StringFormat
Library           BuiltIn
Library           Collections
*** Variables ***
${USER_NAME}    admin
${PASSWORD}    123
${RETAILER}    chuyendb1
${API_URL}    https://fnb.kiotviet.vn/api
*** Keywords ***
Fill env
    [Arguments]    ${env}
    ${DICT_API_URL}    Create Dictionary    live1=https://fnb.kiotviet.vn/api
    ${DICT_BRANCH_ID}    Create Dictionary    live1=27404
    ${DICT_LATESTBRANCH}    Create Dictionary    live1=LatestBranch_294113_172395
    ${DICT_URL}    Create Dictionary      live1=https://fnb.kiotviet.vn/chuyendb1
    ${DICT_USER_NAME}    Create Dictionary    live1=admin
    ${DICT_PASSWORD}    Create Dictionary    live1=123
    ${DICT_RETAILER}    Create Dictionary    live1=chuyendb1

    ${API_URL}    Get From Dictionary    ${DICT_API_URL}    ${env}
    ${BRANCH_ID}    Get From Dictionary    ${DICT_BRANCH_ID}    ${env}
    ${LATESTBRANCH}    Get From Dictionary    ${DICT_LATESTBRANCH}    ${env}
    ${URL}    Get From Dictionary    ${DICT_URL}    ${env}
    ${USER_NAME}    Get From Dictionary    ${DICT_USER_NAME}    ${env}
    ${PASSWORD}    Get From Dictionary    ${DICT_PASSWORD}    ${env}
    ${RETAILER}    Get From Dictionary    ${DICT_RETAILER}    ${env}

    Set Global Variable    \${BROWSER}    Chrome
    Set Global Variable    \${API_URL}    ${API_URL}
    Set Global Variable    \${BRANCH_ID}    ${BRANCH_ID}
    Set Global Variable    \${LATESTBRANCH}    ${LATESTBRANCH}
    Set Global Variable    \${URL}    ${URL}
    Set Global Variable    \${USER_NAME}    ${USER_NAME}
    Set Global Variable    \${PASSWORD}    ${PASSWORD}
    Set Global Variable    \${RETAILER}    ${RETAILER}


Init Test Environment
    [Arguments]    ${env}
    Fill env    ${env}
    ${token_value}    ${resp.cookies}    Get BearerToken from API
    Set Global Variable    \${bearertoken}    ${token_value}
    Set Global Variable    \${resp.cookies}    ${resp.cookies}
    Append To Environment Variable    PATH    ${EXECDIR}${/}drivers
    Open Browser    ${URL}/Login     chrome
    Maximize Browser Window
    Set Screenshot Directory    ${EXECDIR}${/}out${/}failures
    Set Selenium Speed    0.6s

Get BearerToken from API
    [Timeout]    1 minute
    ${credential}=    Create Dictionary    UserName=${USER_NAME}    Password=${PASSWORD}    provider=credentials    UseTokenCookie=true
    ${headers}=    Create Dictionary    Content-Type=application/json;   charset=UTF-8;   retailer=${RETAILER}    Accept=*/*    X-Requested-With=XMLHttpRequest
    Create Session    login_session    ${API_URL}    headers=${headers}    verify=True    disable_warnings=1
    ${resp}=    Post Request    login_session   /auth/credentials?format=json    data=${credential}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.status_code}
    ${bearertoken}=     Get Value From Json    ${resp.json()}    $..BearerToken
    ${bearertoken}=    Catenate    Bearer    ${bearertoken[0]}
    Return From Keyword    ${bearertoken}    ${resp.cookies}

Get data from API
    [Arguments]    ${END_POINT}    ${json_path}
    [Timeout]    1 minute
    : FOR    ${time}    IN RANGE    5
    \    ${resp1}    ${resp1.status_code}    Get Request and validate status code    ${END_POINT}
    \    Exit For Loop If    '${resp1.status_code}'=='200'
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    ${json_path}
    # ${result} =    Evaluate    ${get_raw_data}[0] if ${get_raw_data} else 0
    # ${result} =    Evaluate    $result or 0
    # Return From Keyword    ${result}
    Return From Keyword    ${get_raw_data[0]}

Get data from API 1
    [Arguments]    ${END_POINT}    ${json_path}
    [Timeout]    1 minute
    : FOR    ${time}    IN RANGE    5
    \    ${resp1}    ${resp1.status_code}    Get Request and validate status code    ${END_POINT}
    \    Exit For Loop If    '${resp1.status_code}'=='200'
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    ${json_path}
    Run Keyword If    ${get_raw_data} != 0    Return From Keyword    ${get_raw_data[0]}
    ... ELSE    Return From Keyword    0

Get Request and validate status code
    [Arguments]    ${END_POINT}
    [Timeout]    1 minute
    ${header}    Create Dictionary    Authorization=${bearertoken}
    ${params}    Create Dictionary    format=json
    Create Session    list Product    ${API_URL}    cookies=${resp.cookies}
    ${resp1}=    Get Request    list Product   ${END_POINT}    params=${params}    headers=${header}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Return From Keyword    ${resp1}    ${resp1.status_code}
