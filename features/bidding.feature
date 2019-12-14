Feature: Bidding for an item

  As a confirmed user
  I want to bid for the item I like
  So that I can successfully buy the item
 
  Scenario: confirmed user logins in and bids for an item with a price higher than the current price
    Given a confirmed user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I have logged in
    And I am on the home page
    Then I click into a random item
    And I should be redirected to the decription page of that item
    And I enter a higher price 
    Then I press "Bid!" 
    And I should see my price shown on the list of bids

  Scenario: confirmed user logins in and bids for an item with a price lower than the current price
    Given a confirmed user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I have logged in
    And I am on the home page
    Then I click into a random item
    And I should be redirected to the decription page of that item
    And I enter a lower price 
    Then I press "Bid!" 
    And I should see "You have to enter a higher price"

  Scenario: confirmed user logins in and bids for his own item
    Given a confirmed user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I have logged in
    And I am on the home page
    Then I click into an item I list
    And I should be redirected to the decription page of that item
    And I enter a price 
    Then I press "Bid!" 
    And I should see "You can't bid for your own item"  

  Scenario: user doesn't login in but tries to bid an item 
    Given a registered user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I am on the home page
    Then I click into a random item
    And I should see "You need to sign in or sign up before continuing" 
     

    

  