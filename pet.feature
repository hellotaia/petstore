Feature: Creating a pet in the pet store 

@api @positive
Scenario: Creating a pet
    Given a User is using uri /pet 
    When a User executes a pet POST call using
| key             | value                                                                   |
| category.id     | 228                                                                     |
| category.name   | soft kitty                                                              |
| name            | soft kitty                                                              |
| photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags.id[0].id   | 0                                                                       |
| tags.id[0].name | string                                                                  |
| status          | available                                                               |
    Then the status code is 201
    And the following fields and values are in the response
| key             | value                                                                   |
| category.id     | 228                                                                     |
| category.name   | soft kitty                                                              |
| name            | soft kitty                                                              |
| photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags.id[0].id   | 0                                                                       |
| tags.id[0].name | string                                                                  |
| status          | available                                                               |
    And where the field id has the value >0, store the field source as {pet_id}

@api @positive
    Scenario: Pet Id is automatically generated for pet
    Given a User is using uri /pet 
    When a User add a pet to the system without providing an id value
    Then an id is automatically generated for the added pet

@api @positive
Scenario: Updating existing pet in the pet store
    Given a User is using uri /pet/{pet_id}
    And {pet_id} is the stored variable id
    When a User executes a pet PUT call using
 | key             | value                                                                   |
 | category.id     | 228                                                                     |
 | category.name   | warm kitty                                                              |
 | name            | warm kitty                                                              |
 | photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
 | tags.id[0].id   | {pet_id}                                                                |
 | tags.id[0].name | warm kitty                                                              |
 | status          | sold                                                                    |
    Then the status code is 201
    And the following fields and values are in the response
 | key             | value      |
 | name            | warm kitty |
 | tags.id[0].name | warm kitty |
 | status          | sold       |

#Multiply status? 
 Scenario: Find a pet by pet status
    Given a User is using uri /pet/findByStatus
    When a User executes a pet find GET Call using
    | key       | value |
    | available |
    | sold      |
    | pending   |
    And Multiple status values can be provided with comma separated strings  
    Then the status code is 200
    And items that match the search criteria in response

Scenario: Deleting existing pet in the pet store
    Given a User is using uri /pet/{pet_id}
    And {pet_id} is the stored variable id
    When a User executes a pet find DELETE Call
    And then search for the pet by it's id using uri /pet/{pet_id}
    Then the requests response will contain the value 'Pet not found' in the 'message' field
    
