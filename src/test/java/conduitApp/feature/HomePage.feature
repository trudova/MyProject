Feature: Tests for public-open home page
  Background: Def URL works as before each
    Given url apiUrl

  Scenario: Get all tags
    Given path "tags"
    When method Get
    Then status 200
    And match response.tags contains ['welcome','introduction']
    And match response.tags contains any ['quia','blabla', 'dom']
#    And match response.tags contains only ['quia','blabla', 'dom']
    And match response.tags !contains 'track'
    And match response.tags == "#array"
    And match each response.tags == '#string'
#    And match response.tags == "#array" fasy matching validation always with #

  Scenario: Get 10 articles from the page
    Given param limit = 10
    Given param offset = 0

    Given path "articles"
    When method Get
    Then status 200

  Scenario: Get 10 articles from the page parameters in obj
    Given params {limit: 10, offset: 0}
    Given path "articles"
    When method Get
    Then status 200
#    we are chaking that this is array of size 10 with fasy matching
    And match response.articles == '#[10]'
    And match response.articlesCount == 199
    And match response.articlesCount != 197
    And match response == {"articles": "#array", "articlesCount": "#number"}
    And match response.articles[0].createdAt contains '2023'
    And match response.articles[*].favoritesCount contains 0
    And match response.articles[*].author.bio contains null
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == "#boolean"
    And match each response..favoritesCount == "#number"
#    for string or nul use ##
    And match each response..bio =="##string"
