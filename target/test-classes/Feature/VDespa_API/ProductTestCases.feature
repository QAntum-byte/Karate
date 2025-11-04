Feature: Simple Grocery Store API Tests
  Description: Validate public endpoints of the Grocery Store API (read-only).

  Background:
    * url 'https://simple-grocery-store-api.glitch.me'
    * configure headers = { 'Content-Type': 'application/json' }

  # -----------------------------
  # 1. STATUS CHECK
  # -----------------------------
  Scenario: Verify API status
    Given path '/status'
    When method GET
    Then status 200
    * print 'Response:', response
    * match response.status == 'UP'

  # -----------------------------
  # 2. GET ALL PRODUCTS
  # -----------------------------
  @GetAllProducts
  Scenario: Get all products and return first ID
    Given path '/products'
    When method GET
    Then status 200
    * match response == '#[]'
    * def productId = response[0].id
    * print 'Stored productId:', productId
    * karate.set('productId', productId)
    * return { productId: productId }

  # -----------------------------
  # 3. GET PRODUCT BY VALID ID
  # -----------------------------
  Scenario: Get product details using stored product ID
    * def result = callonce read('classpath:Feature/VDespa_API/ProductTestCases.feature@GetAllProducts')
    * def productId = result.productId
    Given path '/products', productId
    When method GET
    Then status 200
    * print 'Response:', response
    * match response.id == productId
    * match response contains { name: '#string', category: '#string' }

  # -----------------------------
  # 4. GET PRODUCT BY INVALID ID
  # -----------------------------
  Scenario: Get product by invalid ID
    Given path '/products/999999'
    When method GET
    Then status 404
    * print 'Response:', response
    * match response.error contains 'No product with id'

  # -----------------------------
  # 5. FILTER PRODUCTS BY CATEGORY
  # -----------------------------
  Scenario: Get products by category
    Given path '/products'
    And param category = 'coffee'
    When method GET
    Then status 200
    * print 'Response:', response
    * match each response contains { id: '#number', name: '#string' }

  # -----------------------------
  # 6. INVALID CATEGORY - NEGATIVE TEST
  # -----------------------------
  Scenario: Validate invalid category error
    Given path '/products'
    And param category = 'invalidCategory'
    When method GET
    Then status 400
    * print 'Response:', response
    * match response.error contains 'Invalid value for query parameter'
