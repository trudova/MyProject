@ignore
Feature: Sign up
  Background: register a new User
    Given url apiUrl

  Scenario: new user sign up
    Given def userData = {"email": "coc21@gmail.com","username": "coc21"}
    Given path 'users'
   And request
          """
              {
              "user": {
                  "email": #(userData.email),
                  "password": "123",
                  "username": #(userData.username)
                       }
               }
          """
    And method Post
    Then status 200