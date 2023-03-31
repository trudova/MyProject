Feature: Articles posts

  Background: Def URL works as before each
    Given url "https://api.realworld.io/api/"
    Given path 'users/login'
    And request {"user": {"email": "liv2@gmail.com","password": "123liv"}}
    When method Post
    Then status 200
    * def token = response.user.token

  Scenario: log in request
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"tagList": [],"title": "Test4","description": "Test1","body": "Test1"}}
    And method Post
    Then status 200
    And match response.article.title == 'Test3'

