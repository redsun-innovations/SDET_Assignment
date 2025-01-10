*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://127.0.0.1:5000/
${ITEM}   Buy groceries

*** Test Cases ***
Test Todo App
    Open Browser  ${URL}  Chrome  --headless  --no-sandbox  --disable-dev-shm-usage
    Maximize Browser Window
    # Your test steps
    Close Browser
    

*** Keywords ***
Add To-Do Item
    [Arguments]    ${item}
    Input Text    id=new-item-input    ${item}
    Click Button    id=add-item-button
    Page Should Contain    ${item}

Mark Item as Completed
    Wait Until Element Is Visible    id=complete-item-button    10s
    Click Button    id=complete-item-button
    Page Should Contain    Completed

Remove Item
    Wait Until Element Is Visible    id=remove-item-button    10s
    Wait Until Element Is Enabled    id=remove-item-button    10s
    Click Button    id=remove-item-button
    # Wait for the item to be removed by checking that it no longer exists in the DOM
    Wait Until Page Does Not Contain Element    xpath=//li[contains(text(), '${ITEM}')]    10s

*** Test Cases ***
Add a New To-Do Item
    Open Browser    ${URL}    Chrome
    Add To-Do Item    ${ITEM}
    Close Browser

Mark a To-Do Item as Completed
    Open Browser    ${URL}    Chrome
    Add To-Do Item    ${ITEM}
    Mark Item as Completed
    Close Browser

Remove a Completed To-Do Item
    Open Browser    ${URL}    Chrome
    Add To-Do Item    ${ITEM}
    Mark Item as Completed
    Remove Item
    Remove Item
    Remove Item
    Close Browser

Verify Empty To-Do Item Message
    Open Browser    ${URL}    Chrome
    # Check if the empty to-do message is displayed
    Wait Until Page Contains Element    id=no-todo-message    10s
    Element Text Should Be    id=no-todo-message    No to-do items
    Close Browser
