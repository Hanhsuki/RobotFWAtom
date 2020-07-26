*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
*** Variables ***
${USER_NAME}    admin
${PASSWORD}    123
${RETAILER}    chuyendb1
${API_URL}    https://fnb.kiotviet.vn/api
*** Keywords ***
Fill env
    [Arguments]    ${env}    ${remote}
    Log    ${env}
    ${DICT_API_URL}    Create Dictionary    live1=https://fnb.kiotviet.vn/api
    ${DICT_BRANCH_ID}    Create Dictionary    live1=27404
    ${DICT_LATESTBRANCH}    Create Dictionary    live1=LatestBranch_294113_172395
    ${DICT_URL}    Create Dictionary     live1=https://fnb.kiotviet.vn/chuyendb1
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

    Set Global Variable    \${API_URL}    ${API_URL}
    Set Global Variable    \${BRANCH_ID}    ${BRANCH_ID}
    Set Global Variable    \${LATESTBRANCH}    ${LATESTBRANCH}
    Set Global Variable    \${URL}    ${URL}s
    Set Global Variable    \${USER_NAME}    ${USER_NAME}
    Set Global Variable    \${PASSWORD}    ${PASSWORD}
    Set Global Variable    \${RETAILER}    ${RETAILER}

Get BearerToken from API
    [Timeout]    1 minute
    ${credential}=    Create Dictionary    UserName=${USER_NAME}    Password=${PASSWORD}    provider=credentials    UseTokenCookie=true
    ${headers}=    Create Dictionary    Content-Type=application/json; charset=UTF-8;   retailer=${RETAILER}    Accept=*/*    X-Requested-With=XMLHttpRequest
    Create Session    login_session    ${API_URL}    headers=${headers}    verify=True    disable_warnings=1
    ${resp}=    Post Request    login_session   /auth/credentials?format=json    data=${credential}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console    ${resp.status_code}
    ${bearertoken}=     Get Value From Json    ${resp.json()}    $..BearerToken
    ${bearertoken}=    Catenate    Bearer    ${bearertoken}
    Return From Keyword    ${bearertoken}    ${resp.cookies}

Get data from API
    [Arguments]    ${END_POINT}    ${json_path}
    [Timeout]    1 minute
    : FOR    ${time}    IN RANGE    5
    \    ${resp1}    ${resp1.status_code}    Get Request and validate status code    ${END_POINT}
    \    Exit For Loop If    '${resp1.status_code}'=='200'
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    ${json_path}
    Return From Keyword    ${get_raw_data}

Get Request and validate status code
    [Arguments]    ${END_POINT}
    Get BearerToken from API
    [Timeout]    1 minute
    ${header}    Create Dictionary    Authorization=${bearertoken}
    ${params}    Create Dictionary    format=json
    Create Session    list Product    ${API_URL}    cookies=${resp.cookies}
    ${resp1}=    Get Request    list Product   ${END_POINT}    params=${params}    headers=${header}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Return From Keyword    ${resp1}    ${resp1.status_code}
