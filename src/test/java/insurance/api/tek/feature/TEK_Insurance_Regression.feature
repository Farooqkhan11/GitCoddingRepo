@RegressionTest
Feature: TEK Insurance Regression Suite

  Background:
    Given url appUrl
    * def tokenGenerator = callonce read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue

    # Scenario: Post an account
  Scenario: Post an account - Primary Person
  * def generator = Java.type('insurance.api.tek.utility.DataGenerator')
  * def email = generator.getEmail()
  * def firstName = generator.getFirstName()
  * def lastName = generator.getLastName()
  * def title = generator.getTitle()
  * def employmentStatus = generator.getEmploymentStatus()
  * def dateOfBirth = generator.getDateOfBirth()
  * def maritalStatus = generator.getMaritalStatus()
  * def gender = generator.getGender()
  * path '/api/accounts/add-primary-account'
  * request
  """
  {
  "id": 0,
  "email": "#(email)",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "title": "#(title)",
  "gender": "#(gender)",
  "maritalStatus": "#(maritalStatus)",
  "employmentStatus": "#(employmentStatus)",
  "dateOfBirth": "#(dateOfBirth)",
  "new": true
}
  """
  * method post
  * status 201
  * match response.email == email
  * print response
  * karate.write(response, 'RegressionCreatedAccount.json')

  @postCar
  Scenario: Post a car - Primary Person Account
  * path '/api/accounts/add-account-car'
  * def primarypersonIdValue = read('file:./target/RegressionCreatedAccount.json')
  * param primaryPersonId = primarypersonIdValue.id
  * request
  """
  {
  "make": "BMW",
  "model": "XM",
  "year": "2024",
  "licensePlate": "Raptors2029"
}
  """
  * method post
  * status 201
  * print response
  * match response.licensePlate == 'Raptors2029'
  * karate.write(response, 'RegressionPostCar.json')


  Scenario: Put (Update) a car - Primary Person Account
  * path '/api/accounts/update-account-car'
  * def extractCarId = read('file:./target/RegressionPostCar.json')
  * def carIdValue = extractCarId.id
  * def primarypersonIdValue = read('file:./target/RegressionCreatedAccount.json')
  * param primaryPersonId = primarypersonIdValue.id
  * request
  """
  {
  "id": #(carIdValue),
  "make": "Audi",
  "model": "Q9",
  "year": "2025",
  "licensePlate": "Raptors-Cali2025"
}
  """
  * method put
  * status 202
  * print response


  Scenario: Delete a car - Primary Person
  * path '/api/accounts/delete-car'
  * def extractCarId = read('file:./target/RegressionPostCar.json')
  * def carIdValue = extractCarId.id
  * param carId = carIdValue
  * method delete
  * status 202
  * print response
  * match response.message contains 'had been deleted'






    # Scenario: Post a car account
    # Scenario: update the car
    # Scenario: delete the car
