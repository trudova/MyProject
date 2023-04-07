
Feature: Count of the like functionality

  Background: Preconditions
    * def dataGenerator = Java.type("helpers.DataGenerator")
    * def comment  = dataGenerator.getRandomComment()
    * url apiUrl
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def allArticles = callonce read("classpath:helpers/Articles.feature")
    * def initialCount = allArticles.response.articles[2].favoritesCount
    * def slugId = allArticles.response.articles[2].slug


  Scenario: Favorite articles
    And path "articles/"+ slugId+ "/favorite"
    And request "{}"
    When method Post
    Then status 200
    And match response ==
    """
    {
    "article": {
        "id": "#number",
        "slug": "#string",
        "title": "#string",
        "description": "#string",
        "body": "#string",
        "createdAt": "#? timeValidator(_)",
        "updatedAt": "#? timeValidator(_)",
        "authorId": "#number",
        "tagList": "#array",
        "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": "#boolean"
        },
        "favoritedBy": "#array",
        "favorited": "#boolean",
        "favoritesCount": "#number"
    }
}
    """
    And match response.article.favoritesCount == initialCount +1

  Scenario: Comment articles
    Given path "articles/"+slugId+"/comments"
    When method Get
    Then status 200
    And match response ==
    """
          {
          "comments": "#array"
      }
    """
    * def initialCommentCount = response.comments.length
    And path "articles/"+slugId+"/comments"
    And request comment
    When method Post
    Then status 200
    And match response ==
  """
      {
        "comment": {
            "id": "#number",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "body": "#string",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    }
  """
    * def commentId = response.comment.id

    Given path "articles/"+slugId+"/comments"
    When method Get
    Then status 200
    And response.comments.length == initialCommentCount+1
    When path "articles/"+slugId+"/comments/" + commentId
    And method Delete
    Then status 200

    Given path "articles/"+slugId+"/comments"
    When method Get
    Then status 200
    And match initialCommentCount == response.comments.length