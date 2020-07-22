*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Suite Setup    openLoginPage     ${url}    ${browser}
Suite Teardown    closeLoginPage


*** Variables ***
${url}  file:///D:/RobotFWAtom/fileHTML/login.html
${browser}  chrome
${email}  //input[@id="email"]
${password}  //input[@id="passwd"]
${buttonSubmit}  //input[@id="btnsubmit"]
${loginfailed}  //div[@id='loginfailed']/h1
${emailFail}  text
${emailPass}  admin
${passwordFail}  admin
${passTrue}  123
*** Test Cases ***
LoginSuccess
    [Template]    inputInfoTrue
    admin    123

loginFailed
    [Template]    inputInfoFail
    ${emailFail}    ${passwordFail}

*** Keywords ***
openLoginPage
    [Arguments]    ${url}    ${browser}
    Append To Environment Variable    PATH    ${EXECDIR}${/}drivers
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Title Should Be    Login Page

inputInfoTrue
    [Arguments]    ${emailPass}    ${passTrue}
    Input Text    ${email}    ${emailPass}
    Input Password    ${password}    ${passTrue}
    Click Button    ${buttonSubmit}
    Element Text Should Be    ${loginfailed}    Login Successful

inputInfoFail
    [Arguments]   ${emailFail}   ${passwordFail}
    Go To    ${url}
    Input Text    ${email}    ${emailFail}
    Input Password    ${password}   ${passwordFail}
    Click Button    ${buttonSubmit}
closeLoginPage
    Close Browser
