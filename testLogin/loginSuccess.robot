*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${url}  file:///D:/Login/fileHTML/login.html
${browser}  chrome
${email}  //input[@id="email"]
${password}  //input[@id="passwd"]
${buttonSubmit}  //input[@id="btnsubmit"]
${loginfailed}  //div[@id='loginfailed']/h1
@{loginInfo}  text  admin
&{loginAccount}  user=admin  pass=123
*** Test Cases ***
LoginSuccess
    Open Browser  ${url}  ${browser}
    Maximize Browser Window
    Input Text    ${email}    &{loginAccount}[user]
    Input Password    ${password}    123
    Click Button    ${buttonSubmit}
    Element Text Should Be    ${loginfailed}    Login Successful
    Close Browser
loginFailed
    Open Browser  ${url}  ${browser}
    Maximize Browser Window
    Input Text    ${email}    @{loginInfo}[0]
    Input Password    ${password}    @{loginInfo}[1]
    Click Button    ${buttonSubmit}
    Log To Console    run with %{username}
    Close Browser
