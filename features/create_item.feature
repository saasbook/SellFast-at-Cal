Feature: Create an item and post it

  As a confirmed user
  I want to create my own post for my item
  So that I can successfully sell the item
 
  Scenario: confirmed user logins in and adds a new item
    Given a confirmed user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I have logged in
    And I am on the home page
    Then I click "Add new item" link
    And I should be redirected to "/items/new"
    And I fill in with item name "iphone" with decription "A used phone" with Selling price "350"
    Then I press "Create" 
    And I should see my item be posted on the home page

  Scenario: user doesn't login in but tries to add a new item 
    Given a registered user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I am on the home page
    Then I click "add new item" link 
    And I should see "You need to sign in or sign up before continuing" 
     

    

  