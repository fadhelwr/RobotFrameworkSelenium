Feature: Shopping Cart Checkout

  Scenario: User checks out items from the shopping cart
    Given I am on the Sauce Demo login page
    When I log in with valid credentials
    And I add items to the cart
    And I proceed to checkout
    Then I should see the checkout page
    When I complete the checkout
    Then I should see the order confirmation
