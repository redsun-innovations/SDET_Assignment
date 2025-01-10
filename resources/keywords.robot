*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Open Application
    Open Browser  ${URL}  Chrome
    Maximize Browser Window

Add New To-Do
    Input Text  ${ADD_TODO}  ${item}
    Press Keys  ${ADD_TODO}  RETURN

Verify To-Do Exists
    Element Should Be Visible  xpath://li[text()='${item}']

Mark To-Do Completed
    Click Element  ${MARK_DONE}

Verify To-Do Completed
    Element Attribute Value Should Be  xpath://li[text()='${item}']  class  completed

Remove To-Do
    Hover Over  ${REMOVE}
    Click Element  ${REMOVE}

Verify To-Do Removed
    Element Should Not Be Visible  xpath://li[text()='${item}']

Add Empty To-Do
    Press Keys  ${ADD_TODO}  RETURN

Verify Error Message
    Element Should Be Visible  ${ERROR_MSG}
