*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser

*** Variables ***
${LOGIN_URL}      https://www.saucedemo.com/
${USERNAME}       standard_user
${PASSWORD}       secret_sauce

*** Test Cases ***
User Checks Out Items From The Shopping Cart
    Given I am on the Sauce Demo login page
    When I log in with valid credentials
    And I add items to the cart
    And I proceed to checkout
    Then I should see the checkout page
    When I complete the checkout
    Then I should see the order confirmation

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    chrome
    Maximize Browser Window

Given I am on the Sauce Demo login page
    [Documentation]    Ensure we are on the login page.
    Title Should Be    Swag Labs


When I log in with valid credentials
    Input Text    id=user-name    ${USERNAME}
    Input Text    id=password    ${PASSWORD}
    Click Button    id=login-button

And I add items to the cart
    Element Text Should Be    //*[@id="header_container"]/div[2]/span    Products
    Sleep   2s
    Wait Until Page Contains Element    xpath=//button[contains(@class, 'btn_primary')]    timeout=10
    Click Button    //*[@id="add-to-cart-sauce-labs-backpack"]


And I proceed to checkout
    Sleep   2s
    Wait Until Page Contains Element    //*[@id="shopping_cart_container"]    timeout=10
    Sleep   2s
    Click Element    //*[@id="shopping_cart_container"]
    Click Button    //*[@id="checkout"]
    Input Text    id=first-name    John
    Input Text    id=last-name     Doe
    Input Text    id=postal-code    12345
    Click Button    id=continue

Then I should see the checkout page
    Element Text Should Be    //*[@id="header_container"]/div[2]/span    Checkout: Overview

When I complete the checkout
    Click Button    id=finish

Then I should see the order confirmation
    Element Text Should Be    //*[@id="header_container"]/div[2]/span    Checkout: Complete!
