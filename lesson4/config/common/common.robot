*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    StringFormat

*** Variables ***
${account}   //span[contains(text(),'admin')]
${mes_click}      document.evaluate("{0}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()
${mes_sendkey}    document.evaluate("{0}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.send_keys('\n')
${mes_getvalue}    document.evaluate("{0}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.return()


*** Keywords ***
before test
    [Arguments]    ${url}    ${browser}
    Append To Environment Variable    PATH    ${EXECDIR}${/}drivers
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

after test
    Close Browser

Click Element JS
    [Arguments]    ${xpathElement}
    [Timeout]    15 seconds
    ${xpath}    Format String    ${mes_click}    ${xpathElement}
    Execute Javascript    ${xpath}

Sendkey JS
    [Arguments]    ${xpathElement}     ${mes_sendkey}
    ${xpath}    Format String    ${mes_sendkey}    ${xpathElement}
    Execute Javascript    ${xpath}

Get value JS
    [Arguments]    ${xpathElement}
    ${xpath}    Format String    ${mes_getvalue}    ${xpathElement}
    Execute Javascript    ${xpath}

Scroll page
    [Arguments]   
    Execute Javascript    $(document).scrollTop(500)
