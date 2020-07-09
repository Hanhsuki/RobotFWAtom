*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${url}  file:///D:/Login/fileHTML/login.html
${browser}  chrome
${email}  //input[@id="email"]
${password}  //input[@id="passwd"]
${buttonSubmit}  //input[@id="btnsubmit"]
${loginfailed}  //div[@id='loginfailed']/h1
${emailFail}  //
*** Test Cases ***
LoginSuccess
    Open Browser  ${url}  ${browser}
    Maximize Browser Window
    Input Text    ${email}    admin
    Input Password    ${password}    123
    Click Button    ${buttonSubmit}
    Element Text Should Be    ${loginfailed}    Login Successful
    Close Browser
loginFailed
    Open Browser  ${url}  ${browser}
    Maximize Browser Window
    Input Text    ${emailFail}    text
    Input Password    ${password}    admin
    Click Button    ${buttonSubmit}   ${loginfailed}    Login Failed
    Close Browser
