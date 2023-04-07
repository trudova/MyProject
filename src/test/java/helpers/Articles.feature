Feature: get articles
  Background: Def URL works as before each
    Given url apiUrl
  Scenario: Get 10 articles from the page parameters in obj
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    Given params {limit: 10, offset: 0}
    Given path "articles"
    When method Get
    Then status 200
#    we are chaking that this is array of size 10 with fasy matching
    And match response.articles == '#[10]'
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
    And match each response.articles ==
    """
       {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    """
