@API 
Feature: Access to Pet Store orders

@positive
Scenario: Getting a list of status codes to quantities
    Given a User is using uri /store/inventory
    When  a User executes a GET Call                      
    Then the status code is 200
    And the following fields and values are in the response
    | key | value |
    | 1   | 1     |

 Scenario: Placing an order for a pet
    Given a User is using uri /store/order
    When a User executes a pet POST call using
| key      | value  |
| petId    | 0      |
| quantity | 1      |
| shipDate | Today  |
| status   | placed |
| complete | true   |
    Then the status code is 201
    And the id field in the response is stored as {orderId}
    And the shipDate field in the response is stored as {date1}
    And the following fields and values are in the response
| key      | value     |
| id       | {orderId} |
| petId    | 0         |
| quantity | 1         |
| shipDate | {date1}   |
| status   | placed    |
| complete | true      |

@positive
    Scenario: Find purchase order by ID
    Given a User is using uri /store/order
    When a User executes a pet POST call using
| key      | value  |
| Id       | 1      |
| petId    | 0      |
| quantity | 1      |
| shipDate | Today  |
| status   | placed |
| complete | true   |
    Then the id field in the response is stored as {orderId1}
    Given a User is using uri /order/{orderId}
    And {orderId} is the stored variable orderId1
    When a User executes a pet find GET Call
    Then the status code is 200
    And the following fields and values are in the response
 | key      | value       |
 | shipDate | Today |
 
     @negative
    Scenario Outline: Find purchase order by ID (>1 and <10 values will generated exceptions)
    Given a User is using uri /order/{orderId}
    And {orderId} is the stored variable <orderId>
    When a User executes a pet find GET Call
    Then the status code is 404
 Examples:
     | orderId |
     | 0       |
     | 11      |
     | keyword |

 Scenario: Deleting purchase order by ID in the pet store
    Given a User is using uri /store/order
    When a User executes a pet POST call using
| key      | value  |
| petId    | 0      |
| quantity | 1      |
| shipDate | Today  |
| status   | placed |
| complete | true   |
    Then the id field in the response is stored as {orderId1}
    And the status code is 201
    Given a User is using uri /store/order/{orderId}
    And {orderId} is the stored variable orderId1
    When a User executes a DELETE Call
    Then the status code is 204    