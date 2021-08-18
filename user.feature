@API 
Feature: Operations about user

@positive
Scenario: Creating a user with given input array 
    Given a User is using uri /users/createWithList
    When a User executes a POST call using
    | key            | value         |
    | [0].id         | 228           |
    | [0].username   | hello_user    |
    | [0].firstName  | John          |
    | [0].lastName   | Snow          |
    | [0]email       | john@user.com |
    | [0].password   | qwerty        |
    | [0].phone      | 123456789     |
    | [0].userStatus | 0             |
    | [1].id         | 6666          |
    | [1].username   | hello_user2   |
    | [1].firstName  | Liza          |
    | [1].lastName   | Star          |
    | [1]email       | liza@user.com |
    | [1].password   | qwerty        |
    | [1].phone      | 987654321     |
    | [1].userStatus | 0             |
    Then the status code is 200
    And the following fields and values are in the response
    | key     | value |
    | code    | 200   |
    | message | ok    |

Scenario: Creating a user 
#This can only be done by the logged in user?
    Given a User is using uri /user
    When a User executes a POST call using
    | key        | value         |
    | id         | 228           |
    | username   | hello_user    |
    | firstName  | John          |
    | lastName   | Snow          |
    | email      | john@user.com |
    | password   | qwerty        |
    | phone      | 123456789     |
    | userStatus | 0             |
    Then the status code is 200
    And the id field in the response is stored as {userId1}
    And the following fields and values are in the response
    | key     | value     |
    | code    | 200       |
    | type    | unknown   |
    | message | {userId1} |

@positive
Scenario: Find a user by user name
    Given a User is using uri /user
    When a User executes a POST call using
    | key        | value         |
    | id         | 228           |
    | username   | hello_user    |
    | firstName  | John          |
    | lastName   | Snow          |
    | email      | john@user.com |
    | password   | qwerty        |
    | phone      | 123456789     |
    | userStatus | 0             |
    Then the status code is 200
    Given a User is using uri /user/{username}
    And a User sets query parameter username with value hello_user
    When a User executes a GET Call
    Then the status code is 200
    And the following fields and values are in the response
    | key      | value      |
    | username | hello_user |


@positive
Scenario: Updating existing user 
    Given a User is using uri /user
    When a User executes a POST call using
    | key        | value         |
    | id         | 228           |
    | username   | hello_user    |
    | firstName  | John          |
    | lastName   | Snow          |
    | email      | john@user.com |
    | password   | qwerty        |
    | phone      | 123456789     |
    | userStatus | 0             |
    Then the status code is 200
    Given a User is using uri /user/{username}
    And a User sets query parameter username with value hello_user
    When a User executes a user PUT call using
    | key        | value         |
    | id         | 228           |
    | username   | hello_user    |
    | firstName  | Natalie       |
    | lastName   | Dove          |
    | email      | john@user.com |
    | password   | qwerty        |
    | phone      | 123456789     |
    | userStatus | 0             |
    Then the status code is 200
    And the following fields and values are in the response
    | key       | value   |
    | firstName | Natalie |
    | lastName  | Dove    |

@positive
Scenario: Deleting existing user
    Given a User is using uri /user
    When a User executes a POST call using
    | key        | value         |
    | id         | 228           |
    | username   | hello_user    |
    | firstName  | John          |
    | lastName   | Snow          |
    | email      | john@user.com |
    | password   | qwerty        |
    | phone      | 123456789     |
    | userStatus | 0             |
    Then the status code is 200
    Given a User is using uri /user/{username}
    And {username} has the value hello_user 
    When a User executes a DELETE Call
    Then the status code is 204

@positive
Scenario: Logs user into the system
# a user is possible to login into the system using any data without any errors
    Given a User is using uri /user
    When a User executes a POST call using
    | key        | value         |
    | id         | 228           |
    | username   | hello_user    |
    | firstName  | John          |
    | lastName   | Snow          |
    | email      | john@user.com |
    | password   | qwerty        |
    | phone      | 123456789     |
    | userStatus | 0             |
    Then the status code is 200
    And the username field in the response is stored as {username1}
    And the password field in the response is stored as {password1}
    Given a User is using uri /user/login
    And a User sets the following query parameters
    | key      | value       |
    | username | {username1} |
    | Password | {password1} |
    Then status code is 200
    And the following fields and values are in the response
    | key     | value   |
    | code    | 200     |
    | message | string  |

@negative
Scenario: Logs user into the system without valid credentials 
# a user is possible to login into the system using any data without any errors/400 status code
    Given a User is using uri /user
    When a User executes a POST call using
    | key        | value         |
    | id         | 228           |
    | username   | hello_user    |
    | firstName  | John          |
    | lastName   | Snow          |
    | email      | john@user.com |
    | password   | qwerty        |
    | phone      | 123456789     |
    | userStatus | 0             |
    Then the status code is 200
    And the username field in the response is stored as {username1}
    Given a User is using uri /user/login
    And a User sets the following query parameters
    | key      | value       |
    | username | {username1} |
    | Password | 321000      |
    Then status code is 400
    And a message contains "Invalid username/password supplied" in response
    

@positive
Scenario:
    Given a User is using uri /user
    When a User executes a POST call using
    | key        | value         |
    | id         | 228           |
    | username   | hello_user    |
    | firstName  | John          |
    | lastName   | Snow          |
    | email      | john@user.com |
    | password   | qwerty        |
    | phone      | 123456789     |
    | userStatus | 0             |
    Then the status code is 200
    And the username field in the response is stored as {username1}
    And the password field in the response is stored as {password1}
    Given a User is using uri /user/login
    And a User sets the following query parameters
    | key      | value       |
    | username | {username1} |
    | Password | {password1} |
    Then status code is 200
    Given a User is using uri /user/logout
    When a User executes a GET call
    Then the status code is 200
    And the following fields and values are in the response
    | key     | value |
    | code    | 200   |
    | message | ok    |

