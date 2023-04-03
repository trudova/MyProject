Feature: Articles posts

  Background: Def URL works as before each
    Given url apiUrl
#    * def tokenObj = callonce read('classpath:helpers/CreateToken.feature')
#    * def token = tokenObj.authToken
#    @ignore to ignore scenario or the feature
  Scenario: log in request
#    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"tagList": [],"title": "Test11","description": "Test1","body": "Test1"}}
    And method Post
    Then status 200
    And match response.article.title == 'Test11'
    * def slug = response.article.slug

#    Given header Authorization = 'Token ' + token
    Given path 'articles', slug
    When method Delete
    Then status 204

    Given params {limit: 10, offset: 0}
    Given path "articles"
    When method Get
    Then status 200
    And match response.articles[0].title != 'Test2'



