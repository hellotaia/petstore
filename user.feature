@API 
Feature: Operations about user

@positive
Scenario: Creating a using with given input array 
    Given a User is using uri /users/createWithList
    When a User executes a pet POST call using
| key        | value         |
| id         | 228           |
| username   | hello_user    |
| firstName  | John          |
| lastName   | Snow          |
| email      | john@user.com |
| password   | qwerty        |
| phone      | 123456789     |
| userStatus | 0             |
    Then the status code is 201
    And the id field in the response is stored as {userId}
    And the following fields and values are in the response
| key        | value         |
| id         | 228           |
| username   | hello_user    |
| firstName  | John          |
| lastName   | Snow          |
| email      | john@user.com |
| password   | qwerty        |
| phone      | 123456789     |
| userStatus | 0             |


@positive
    Scenario: Find a user by user name
    Given a User is using uri /users/createWithList
    When a User executes a pet POST call using
| key        | value         |
| id         | 228           |
| username   | hello_user    |
| firstName  | John          |
| lastName   | Snow          |
| email      | john@user.com |
| password   | qwerty        |
| phone      | 123456789     |
| userStatus | 0             |
    Then the status code is 201
    And the username field in the response is stored as {username1}
    Given a User is using uri /user/{username}
    And a User sets query parameter username with value {username1}
    When a User executes a pet find GET Call
    Then the status code is 200
    And the following fields and values are in the response
 | key      | value       |
 | username | {username1} |

 @positive
Scenario: Updating existing user 
    Given a User is using uri /users/createWithList
    When a User executes a pet POST call using
| key        | value         |
| id         | 228           |
| username   | hello_user    |
| firstName  | John          |
| lastName   | Snow          |
| email      | john@user.com |
| password   | qwerty        |
| phone      | 123456789     |
| userStatus | 0             |
    Then the status code is 201
    And the username field in the response is stored as {username1}
    Given a User is using uri /user/{username}
    And a User sets query parameter username with value {username1}
    When a User executes a pet PUT call using
| key        | value         |
| id         | 228           |
| username   | hello_user    |
| firstName  | Natalie       |
| lastName   | Portman       |
| email      | john@user.com |
| password   | qwerty        |
| phone      | 123456789     |
| userStatus | 0             |
    Then the status code is 201
    And the following fields and values are in the response
 | key       | value   |
 | firstName | Natalie |
 | lastName  | Portman |

Scenario: Deleting existing user
    Given a User is using uri /users/createWithList
    When a User executes a pet POST call using
| key        | value         |
| id         | 228           |
| username   | hello_user    |
| firstName  | John          |
| lastName   | Snow          |
| email      | john@user.com |
| password   | qwerty        |
| phone      | 123456789     |
| userStatus | 0             |
    Then the status code is 201
    And the username field in the response is stored as {username1}
    Given a User is using uri /user/{username}
    And {username} is the stored variable username1
    When a User executes a DELETE Call
    Then the status code is 204