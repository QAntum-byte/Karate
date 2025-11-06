Feature: Simple Grocery Store API Tests
 

  Background:
  * def baseUrl = karate.get('groceryURL')
  * def headers = karate.get('headers')
  * url baseUrl
  * configure headers = headers
  * print 'Config loaded successfully! Base URL:', baseUrl

  # 1. STATUS CHECK
  Scenario: Verify API status
    Given path '/status'
    When method GET
    Then status 200
    * print 'Response:', response
    * match response.status == 'UP'

  # 2. GET ALL PRODUCTS
  Scenario: Get all products and return first ID
    Given path '/products'
    When method GET
    Then status 200
    * print 'Response:', response
    * def firstProductId = response[0].id

  # 3. GET PRODUCT BY PRODUCT ID
    Given path '/products/' + firstProductId
    When method GET
    Then status 200
    * print 'Response:', response

  # 4. FILTER PRODUCTS BY CATEGORY
  Scenario: Get products by category
    Given path '/products'
    And param category = 'coffee'
    When method GET
    Then status 200
    * print 'Response:', response

  # 5. SEARCH PRODUCTS BY RESULTS
  Scenario: Get products with limited results
    Given path '/products'
    And param results = 2
    When method GET
    Then status 200
    * print 'Response:', response

  # 6. FILTER PRODUCTS BY AVAILABILITY
  Scenario: Get products by availability
    Given path '/products'
    And param availability = true
    When method GET
    Then status 200
    * print 'Response:', response

  # 7. INVALID CATEGORY TEST
  Scenario: Get products by invalid category
    Given path '/products'
    And param category = 'SoulStone'
    When method GET
    Then status 400
    * print 'Response:', response
