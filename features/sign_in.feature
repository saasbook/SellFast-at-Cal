Feature: Logging in

  As a user
  I want to login with my details
  So that I can configure the server 
 
  Scenario: User enters wrong password
    Given a registered user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I am on the "/login" page
    When I fill in "email" with "test@berkeley.edu"
    And I fill in "password" with "ticklemeelmo"
    And I press "Log in"
    Then I should see "Invalid Email or password"
    And I should not be signed in
 
  Scenario: User is registered and enters correct password
    Given a registered user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I am on the "/login" page
    When I fill in "email" with "test@berkeley.edu"
    And I fill in "password" with "Qwer123456"
    Then I press "Log in"
    And I should not be signed in
    
  Scenario: User is confirmed and enters correct password
    Given a confirmed user with the email "test@berkeley.edu" with password "Qwer123456" exists
    And I am on the "/login" page
    When I fill in "email" with "test@berkeley.edu"
    And I fill in "password" with "Qwer123456"
    And I press "Log in"
    Then I should be redirected to "/items"
    And I should see 'Signed in successfully'    
    And I should be signed in