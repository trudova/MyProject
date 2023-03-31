Feature: Tests for public-open home page
  Background: Def URL works as before each
    Given url "https://api.realworld.io/api/"

  Scenario: Get all tags
    Given path "tags"
    When method Get
    Then status 200
    And match response.tags contains ['welcome','introduction']
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
    And match response.articlesCount == 197
