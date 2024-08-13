Feature: PetStore API Tests

Background:
  # URL base de la API
  * url 'https://petstore.swagger.io/v2'

Scenario: Añadir una mascota a la tienda
  Given path 'pet'
  And request { "id": 100, "name": "doggie", "status": "available" }
  When method POST
  Then status 200
  And match response.name == 'doggie'

Scenario: Consultar la mascota ingresada previamente por ID
  Given path 'pet/100'
  When method GET
  Then status 200
  And match response.id == 100
  And match response.name == 'doggie'


Scenario: Actualizar el nombre y el estatus de la mascota
  Given path 'pet'
  And request { "id": 100, "name": "puppy", "status": "sold" }
  When method PUT
  Then status 200
  And match response.name == 'puppy'
  And match response.status == 'sold'


Scenario: Consultar la mascota modificada por estatus
  Given path 'pet/findByStatus'
  And param status = 'sold'
  When method GET
  Then status 200
  And match each response[*].status == 'sold'
