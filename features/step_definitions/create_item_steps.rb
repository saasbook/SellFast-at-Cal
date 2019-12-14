
Given("I have logged in") do
  visit '/users/sign_in'
  email = "test@berkeley.edu"
  password = "Qwer123456"
  fill_in('email', :with => email)
  fill_in('password', :with => password)
  click_button "Log in" 
  string_1 = "Signed in successfully"
  expect(page).to have_content(string_1)
end

Given("I am on the home page") do
  expect(page).to have_current_path('/items')
end

Then("I click {string} link") do |string|
  click_link(string)
end

Then("I fill in with item name {string} with decription {string} with Selling price {string}") do |string, string2, string3|
  item_name = string
  fill_in('Name', :with => string) 
  fill_in('Description', :with => string2) 
  # fill_in "current_price", with: string3.to_i
end

Then("I should see my item be posted on the home page") do
  get '/items'
  expect(page).to have_content(item_name)

end

