Feature: Login

Scenario: Logging in as a Peer Teacher
	Given I am on the Home Page
	When I click on the Login link
	Then I am on the Login Page
	When I fill in the email blank with "dhananjay@tamu.edu"
	And I fill in the password blank with "sample123"
	And I click the "login" button
	Then I should see the Peer Teacher page