
Feature: Sign up
  Background: register a new User
    * def dataGenerator = Java.type("helpers.DataGenerator")
    * def randomEmail = dataGenerator.getRendomeEmail()
    * def randomUserName = dataGenerator.getUserName()
    Given url apiUrl

  Scenario Outline: Validate Sign up error message
    Given path 'users'
    And request
          """
              {
              "user": {
                  "email": "<email>",
                  "password": "<password>",
                  "username": "<username>"
                       }
               }
          """
    And method Post
    Then status 422
    And match response == <errorResponse>
    Examples:
      |email         | password| username        |errorResponse                                     |
      |coc@gmail.com | 123     |#(randomUserName)|{"errors":{"email":["has already been taken"]}}   |
      |#(randomEmail)| 123     |coc              |{"errors":{"username":["has already been taken"]}}|