*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${account}   //span[contains(text(),'admin')]


*** Keywords ***
before test
    [Arguments]    ${url}    ${browser}
    Append To Environment Variable    PATH    ${EXECDIR}${/}drivers
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

after test
    Close Browser
