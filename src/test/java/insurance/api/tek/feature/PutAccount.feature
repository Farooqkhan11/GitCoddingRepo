Feature: TEK Insurance PUT Account API

  Background:
    Given url appUrl
    * def tokenGenerator = call read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue


    Scenario: Put API - Update Phone number Primary Person
      * path '/api/accounts/update-account-phone'
      * def primarypersonIdValue = read('file:./target/createdAccount.json')
      * param primaryPersonId = primarypersonIdValue.id
      * def phoneIdExtraction = call read('PostAccount.feature@postPhone')
      * def phoneIdValue = phoneIdExtraction.phoneId
      * print phoneIdValue
      * request
      """
      {
  "id": #(phoneIdValue),
  "phoneNumber": "9099999996",
  "phoneExtension": "001",
  "phoneTime": "Morning",
  "phoneType": "Cell Phone"
}
      """
      * method put
      * status 200
      * print response

