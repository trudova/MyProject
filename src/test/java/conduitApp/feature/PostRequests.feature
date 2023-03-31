Feature: Articles posts

  Background: Def URL works as before each
    Given url "https://api.realworld.io/api/"
    Given path 'users/login'
    And request {"user": {"email": "liv2@gmail.com","password": "123liv"}}
    When method Post
    Then status 200
    * def token = response.user.token

#    @ignore to ignore scenario or the feature
  Scenario: log in request
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"tagList": [],"title": "Test2","description": "Test1","body": "Test1"}}
    And method Post
    Then status 200
    And match response.article.title == 'Test2'
    * def slug = response.article.slug

    Given header Authorization = 'Token ' + token
    Given path 'articles', slug
    When method Delete
    Then status 204

    Given params {limit: 10, offset: 0}
    Given path "articles"
    When method Get
    Then status 200
    And match response.articles[0].title != 'Test2'



