
  
  Given("a registered user with the email {string} with password {string} exists") do |string, string2|
    #pending # Write code here that turns he phrase above into concrete actions
    email = string
    password = string2

  end
  
  Given("I am on the {string} page") do |string|
    visit '/users/sign_in'
    #pending # Write code here that turns the phrase above into concrete actions
  end
  
  When("I fill in {string} with {string}") do |string, string2|
    fill_in(string, :with => string2) 
    #pending # Write code here that turns the phrase above into concrete actions
  end
  
  When("I press {string}") do |string|
    click_button "Log in"
    #pending # Write code here that turns the phrase above into concrete actions
  end
  
#   Then("I should see {string}") do |string|
#     expect(page).to have_content("You have to confirm your email address before continuing")
#     #pending # Write code here that turns the phrase above into concrete actions
#   end
  
  Then /I should (not )?be signed in/ do |should_not|
    if should_not.nil?
        expect(page).not_to have_current_path('/users/sign_in')
    else
        expect(page).to have_current_path('/users/sign_in')
    end

    #pending # Write code here that turns the phrase above into concrete actions
  end
  
  Given("a confirmed user with the email {string} with password {string} exists") do |string, string2|
    email = string
    password = string2
    user = [{:email => string, :password => string2}]
    User.create!(user)
  end
  
#   Then("I should be redirected to {string}") do |string|
#     pending # Write code here that turns the phrase above into concrete actions
#   end
  Then ("I should see {string}") do |string|
    expect(page).to have_content(string)
  end 


#   Then ("I should not be authorized") do
#    user == nil
#   end
  
  Then ("I should be redirected to {string}") do |string|
    get string
    expect(page).to have_current_path(string)
  end

#   And ("I should see 'Signed in successfully'") do
#     expect.to have_content("Signed in successfully") 
#   end
  