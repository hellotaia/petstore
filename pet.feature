@API 
Feature: Creating a pet in the pet store 

@positive
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
    And the id field in the response is stored as {petId}
    And the following fields and values are in the response
| key             | value                                                                   |
| id              | {petId}                                                                 |
| category.id     | 228                                                                     |
| category.name   | soft kitty                                                              |
| name            | soft kitty                                                              |
| photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags.id[0].id   | 0                                                                       |
| tags.id[0].name | string                                                                  |
| status          | available                                                               |
    
@positive
Scenario: Updating existing pet in the pet store using body request
    Given a User is using uri /pet 
    When a User executes a pet POST call using
| key             | value                                                                   |
| category.id     | 229                                                                     |
| category.name   | kitty                                                                   |
| name            | kitty                                                                   |
| photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags.id[0].id   | 0                                                                       |
| tags.id[0].name | test                                                                    |
| status          | available                                                               |
    Then the status code is 201
    And the id field in the response is stored as {petId1}
    Given a User is using uri /pet/
    When a User executes a pet PUT call using
 | key           | value                                                                   |
 | id            | {petId1}                                                                |
 | category.id   | 228                                                                     |
 | category.name | warm kitty                                                              |
 | name          | warm kitty                                                              |
 | photoUrls[0]  | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
 | tags[0].id    | 0                                                                       |
 | tags[0].name  | warm kitty                                                              |
 | tags[1].id    | 32                                                                      |
 | tags[1].name  | test2                                                                   |
 | status        | sold                                                                    |
    Then the status code is 201
    And the following fields and values are in the response
 | key           | value      |
 | category.name | warm kitty |
 | name          | warm kitty |
 | tags[1].id    | 32         |
 | tags[1].name  | test2      |
 | status        | sold       |


@positive
 Scenario Outline: Find a pet by pet status
     Given a User is using uri /pet 
    When a User executes a pet POST call using
| key           | value                                                                   |
| category.id   | 229                                                                     |
| category.name | kitty                                                                   |
| name          | kitty                                                                   |
| photoUrls[0]  | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags[0].id    | 0                                                                       |
| tags[0].name  | test                                                                    |
| status        | sold                                                                    |
    Given a User is using uri /pet/findByStatus
    And a User sets query parameter status with value <status>
    When a User executes a pet find GET Call
    Then the status code is 200
    And the following fields and values are in the response
 | key        | value |
 | [0].status | sold  |

 Examples:
     | status    |
     | sold      |
     | available |
     | pending   |

@positive @manual
 Scenario: Find a pet by pet multiple statuses
     Given a User is using uri /pet 
    When a User executes a pet POST call using
| key             | value                                                                   |
| category.id     | 229                                                                     |
| category.name   | kitty                                                                   |
| name            | kitty                                                                   |
| photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags.id[0].id   | 0                                                                       |
| tags.id[0].name | test                                                                    |
| status          | sold                                                                    |
    Given a User is using uri /pet/findByStatus
    And a User sets the following query parameters
| key    | value     |
| status | sold      |
| status | available |
| status | pending   |
    When a User executes a pet find POST Call 
    Then the status code is 200 
#response contains elements with all statuses

@positive
 Scenario: Updating existing pet in the pet store using query parameters
     Given a User is using uri /pet/
    When a User executes a pet POST call using
| key             | value                                                                   |
| category.id     | 229                                                                     |
| category.name   | kitty                                                                   |
| name            | kitty                                                                   |
| photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags.id[0].id   | 0                                                                       |
| tags.id[0].name | test                                                                    |
| status          | sold                                                                    |
    Then the id field in the response is stored as {petId1}
    Given a User is using uri /pet/{petId}
    And a User sets the following query parameters
| key    | value       |
| petId  | {petId1}    |
| name   | ball of fur |
| status | sold        |
    When a User executes a pet find POST Call 
    Then the status code is 200

    @positive @manual
    Scenario Outline: Updating existing pet in the pet store with image upload
    Given a User is using uri /pet/
    When a User executes a pet POST call using
| key             | value                                                                   |
| category.id     | 229                                                                     |
| category.name   | kitty                                                                   |
| name            | kitty                                                                   |
| photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags.id[0].id   | 0                                                                       |
| tags.id[0].name | test                                                                    |
| status          | sold                                                                    |
    Then the id field in the response is stored as {petId1}
    Given a User is using uri /pet/{petId}/uploadImage
    And a User sets the following query parameters
| key                | value    |
| petId              | {petId1} |
| additionalMetadata | string   |
| file               | <path>   |
    When a User executes a POST call
    Then the status code is 200
    And a message contains "\nFile uploaded to" in response
    Examples: 
 | path             |
 | files/image.jpeg |
 | files/image.gif  |
 | files/image.png  |

@positive
Scenario: Deleting existing pet in the pet store
    Given a User is using uri /pet 
    When a User executes a pet POST call using
| key             | value                                                                   |
| category.id     | 229                                                                     |
| category.name   | kitty                                                                   |
| name            | kitty                                                                   |
| photoUrls[0]    | https://www.meme-arsenal.com/memes/42eaf8259cdf8d2bb47f55467351e132.jpg |
| tags.id[0].id   | 0                                                                       |
| tags.id[0].name | test                                                                    |
| status          | available                                                               |
    Then the status code is 201
    And the id field in the response is stored as {petId2}
    Given a User is using uri /pet/{petId}
    And {petId} is the stored variable petId2
    When a User executes a DELETE Call
    Then the status code is 204