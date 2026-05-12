Feature: Login

  Scenario: Successful login with valid credentials
    Given the user navigates to the login page
    When the user enters a valid username and a valid password
    And the user clicks the login button
    Then the user should be redirected to the dashboard

  Scenario: Login with invalid password
    Given the user navigates to the login page
    When the user enters a valid username and an incorrect password
    And the user clicks the login button
    Then an error message "Invalid credentials" should be displayed
    And the user should remain on the login page

  Scenario: Login with non-existent username
    Given the user navigates to the login page
    When the user enters a non-existent username and any password
    And the user clicks the login button
    Then an error message "Invalid credentials" should be displayed
    And the user should remain on the login page

  Scenario: Login with empty fields
    Given the user navigates to the login page
    When the user leaves the username field empty and the password field empty
    And the user clicks the login button
    Then the system should display a validation error "Username is required"
    And the login should not be submitted

  Scenario: Brute force lockout after multiple failed attempts
    Given the user navigates to the login page
    When the user attempts to login with invalid credentials 5 times
    Then the account should be temporarily locked
    And the system should display a message "Account locked. Try again in 15 minutes."
