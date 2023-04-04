
Feature: Sign up
  Background: register a new User
    * def dataGenerator = Java.type("helpers.DataGenerator")
    Given url apiUrl

  Scenario: new user sign up
    * def randomEmail = dataGenerator.getRendomeEmail()
    * def randomUserName = dataGenerator.getUserName()
    Given path 'users'
   And request
          """
              {
              "user": {
                  "email": #(randomEmail),
                  "password": "123",
                  "username": #(randomUserName)
                       }
               }
          """
    And method Post
    Then status 200
    And match response ==
    """
      {
    "user": {
        "email": #(randomEmail),
        "username": #(randomUserName),
        "bio": "##string",
        "image": "https://api.realworld.io/images/smiley-cyrus.jpeg",
        "token": "#string"
    }
}
    """