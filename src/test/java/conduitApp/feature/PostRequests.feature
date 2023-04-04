Feature: Articles posts

  Background: Def URL works as before each
    Given url apiUrl
    * def articleBody = read('classpath:conduitApp/jsonFiles/article.json')
    * def dataGenerator = Java.type("helpers.DataGenerator")
    * set articleBody.article.title = dataGenerator.getRandomArticleValue().title
    * set articleBody.article.description = dataGenerator.getRandomArticleValue().description
    * set articleBody.article.body = dataGenerator.getRandomArticleValue().body
 #    * def tokenObj = callonce read('classpath:helpers/CreateToken.feature')
#    * def token = tokenObj.authToken
#    @ignore to ignore scenario or the feature
  Scenario:create and delete article
#    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request articleBody
    And method Post
    Then status 200
    And match response.article.title == articleBody.article.title


  Scenario:create and delete article
#    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request articleBody
    And method Post
    Then status 200
    And match response.article.title == articleBody.article.title
    * def slug = response.article.slug

#    Given header Authorization = 'Token ' + token
    Given path 'articles', slug
    When method Delete
    Then status 204

    Given params {limit: 10, offset: 0}
    Given path "articles"
    When method Get
    Then status 200
    And match response.articles[0].title != articleBody.article.title



