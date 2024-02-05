@Regression
Feature: Generate Access Token for TEK Insurance Application

  # this is for git lecture

  Background:
    Given url appUrl

  @GenerateToken
  Scenario: Generate Token
    * path '/api/token'
    * request {"username":"supervisor","password":"tek_supervisor"}
    * method post
    * status 200
    * print response
    * def tokenValue = response.token
    * print tokenValue

    Scenario: Verify Token
      * path '/api/token/verify'
      * def tokenGenerator = call read('generateToken.feature@GenerateToken')
      * def userValue = tokenGenerator.response.username
      * def getTokenValue = tokenGenerator.response.token
      * param username = userValue
      * param token = getTokenValue
      * method get
      * status 200
      * print response





