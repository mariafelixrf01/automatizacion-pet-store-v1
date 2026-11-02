Feature: Crear consultar modificar delete y consultar de los servicios de projects.json

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header Content-Type = 'application/json'

    # CREAR AUTOMATIZACION DE PET
  Scenario Outline:
    * def idPet = <idPet>
    * def petName = "<nombre>"

    * def cuerpo = read('classpath:data/project.json')
    * set cuerpo.id = idPet
    * set cuerpo.name = "<nombre>"

    # Crear mascato - (METODO POST)

    Given path '/pet'
    And request cuerpo
    When method post
    Then status 200
    And match response.id == idPet
    And match response.name == petName
    * print 'response POST', response

    # OBTENER INFORMACION (GET)
    Given path '/pet', idPet
    When method get
    Then status 200
    And match response.id == idPet
    And match response.name == petName
    * print 'response GET', response

    # UPDATE DE PET (METODO PUT)
    * def body = read('classpath:data/project.json')
    * set body.id = idPet
    * set body.name = "<nombreActualizado>"

    Given path '/pet'
    And request body
    When method put
    Then status 200
    And match response.id == idPet
    And match response.name == "<nombreActualizado>"
    * print 'response PUT', response

    # DELETE PET (METODO DELETE)
    Given path '/pet', idPet
    When method delete
    Then status 200
    * print 'Delete Response', response

    # CONSULTAR PET ELIMINADO (METODO GET)
    Given path '/pet', idPet
    When method get
    Then status 404
    And match response.message == "Pet not found"
    * print 'Response después de delete:', response

    Examples:
      |idPet|nombre|nombreActualizado|
      |1    |salome|bobi             |
      |2    |yaco  |pepito           |