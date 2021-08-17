@API 
Feature: Access to Pet Store orders

@positive
Scenario: Getting a list of status codes to quantities
    Given a User is using uri /store/inventory
    When  a User executes a list of status codes GET Call                      |
    Then the status code is 200
    And the following fields and values are in the response
    | key        | value |
    | [0].status | 4     |

 Scenario: Placing an order for a pet
    Given a User is using uri /store/order
    When a User executes a pet POST call using
| key      | value       |
| id       | 1400        |
| petId    | 0           |
| quantity | 1           |
| shipDate | TODAYS_DATE |
| status   | placed      |
| complete | true        |
    Then the status code is 201
    And the id field in the response is stored as {orderId}
    And the following fields and values are in the response
| key      | value       |
| id       | 1400        |
| petId    | 0           |
| quantity | 1           |
| shipDate | TODAYS_DATE |
| status   | placed      |
| complete | true        |

@positive
    Scenario Outline: Find purchase order by ID
    Given a User is using uri /store/order
    When a User executes a pet POST call using
| key      | value       |
| id       | 1400        |
| petId    | 0           |
| quantity | 1           |
| shipDate | TODAYS_DATE |
| status   | placed      |
| complete | true        |
    Then the id field in the response is stored as {orderId1}
    Given a User is using uri /order/{orderId}
    And a User sets query parameter orderId with value <orderId>
    When a User executes a pet find GET Call
    Then the status code is 200
    And the following fields and values are in the response
 | key      | value       |
 | shipDate | TODAYS_DATE |
 Examples:
     | orderId |
     | 1       |
     | 5       |
     | 10      |

     @negative
    Scenario Outline: Find purchase order by ID (>1 and <10 values will generated exceptions)
    Given a User is using uri /order/{orderId}
    And a User sets query parameter orderId with value <orderId>
    When a User executes a pet find GET Call
    Then the status code is 400
    And a message "Invalid ID supplied" in the response
    And the following fields and values are in the response
 Examples:
     | orderId |
     | 0       |
     | 11      |
     | keyword |

 Scenario: Deleting purchase order by ID in the pet store
    Given a User is using uri /store/order
    When a User executes a pet POST call using
| key      | value       |
| id       | 1400        |
| petId    | 0           |
| quantity | 1           |
| shipDate | TODAYS_DATE |
| status   | placed      |
| complete | true        |
    Then the id field in the response is stored as {orderId1}
    And the status code is 201
    Given a User is using uri /store/order/{orderId}
    And {orderId} is the stored variable orderId1
    When a User executes a DELETE Call
    Then the status code is 204    