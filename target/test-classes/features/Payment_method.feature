Feature: Validates Payment_Method in BankDetails

  Background: 
    Given I am authorized user

  @SchemaValidation
  Scenario: Validates error response is received when Payload field payment_method is missing
     And I create request payload with valid data for all keys without "payment_methods"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"

  @SchemaValidation
  Scenario: Validates error response is received when Payload field payment_method value is Empty
     And I create request payload with valid data for all keys with "payment_methods" is "Empty"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "invalid_argument"
    And Response "message" has value "No enum constant com.airwallex.domain.transaction.payment.PaymentMethod."
    And Response "source" has value "payment_methods"

  Scenario: Validates error response is received when Payload field payment_method value is not valid <payment_methods>
     And I create request payload with valid data for all keys with "payment_methods" is "<payment_methods>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "invalid_argument"
    And Response "message" has value "No enum constant com.airwallex.domain.transaction.payment.PaymentMethod.<payment_methods>"
    And Response "source" has value "payment_methods"
  
  Examples:  
  |  payment_methods| 
  |  TARGET					|
  |  SEPA						|

@PositiveScenarios
  Scenario: Validates correct response is received when Payload field payment_method value is valid <payment_methods>
     And I create request payload with valid data for all keys with "payment_methods" is "<payment_methods>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 201
    And Response status line is "Created"
  
  Examples:  
  |  payment_methods| 
  |  SWIFT					|
