*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Suite Setup    openLoginPage     ${url}    ${browser}
Suite Teardown    closeLoginPage


*** Variables ***
${url}  file:///D:/Login/fileHTML/login.html
${browser}  chrome
${email}  //input[@id="email"]
${password}  //input[@id="passwd"]
${buttonSubmit}  //input[@id="btnsubmit"]
${loginfailed}  //div[@id='loginfailed']/h1
${emailInfo}  text
${passwordInfo}  admin
&{loginAccount}  user=admin  pass=123

*** Test Cases ***
LoginSuccess
    Input Text    ${email}    &{loginAccount}[user]
    Input Password    ${password}    123
    Click Button    ${buttonSubmit}
    Element Text Should Be    ${loginfailed}    Login Successful
loginFailed
    Go To    ${url}
    Input Text    ${email}    ${emailInfo}
    Input Password    ${password}    ${passwordInfo}
    Click Button    ${buttonSubmit}
    Element Text Should Be    ${loginfailed}    Login Failed
*** Keywords ***
openLoginPage
    [Arguments]    ${url}    ${browser}
    Append To Environment Variable    PATH    ${EXECDIR}${/}drivers
    Open Browser    ${url}    ${browser}    remote_url=http://192.168.31.11:4455/wd/hub
    Maximize Browser Window
    Title Should Be    Login Page
closeLoginPage
    Close Browser
