*** Settings ***
Library    SeleniumLibrary
Suite Setup    openLoginPage     ${url}    ${browser}
Suite Teardown    closeLoginPage

# Test Setup       openLoginPage     ${url}    ${browser}
# Test Teardown    closeLoginPage

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
    [Tags]     firstTest
    Input Text    ${email}    &{loginAccount}[user]
    Input Password    ${password}    123
    Click Button    ${buttonSubmit}
    Element Text Should Be    ${loginfailed}    Login Successful
loginFailed
    Go To    ${url}
    Input Text    ${email}    ${emailInfo}
    Input Password    ${password}    ${passwordInfo}
    Click Button    ${buttonSubmit}
*** Keywords ***
openLoginPage
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Title Should Be    Login Page
closeLoginPage
    Close Browser
