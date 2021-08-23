Feature: Validates Routing_type and Routing_value in BankDetails

  Background: 
    Given I am authorized user

  @RequirementMismatch-RequiredField @SchemaValidation
  Scenario: Validates error response is received when Payload field account_routing_type1 is missing
    And I create request payload with valid data for all keys without "account_routing_type1"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"

  @SchemaValidation
  Scenario: Validates error response is received when Payload feild payment_method value is Empty
    And I create request payload with valid data for all keys with "account_routing_type1" is "Empty"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "invalid_argument"
    And Response "message" has value " is not a valid type"
    And Response "source" has value "beneficiary.bank_details.account_routing_type1"

  Scenario Outline: Validate error response is returned for "bank_country_code" <Bank_Country_Code> when "account_routing_type1" <account_routing_type1> has invalid characters <number_of_characters>
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "account_routing_type1" is "<account_routing_type1>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "invalid_argument"
    And Response "message" has value "<account_routing_type1> is not a valid type"
    And Response "source" has value "beneficiary.bank_details.account_routing_type1"

    Examples: 
      | Bank_Country_Code | account_routing_type1 |
      | US                | aab                   |
      | AU                | baa                   |
      | CN                | caa                   |

  @RequirementMismatch-RequiredField @RequirementMismatch-AUAcctRoutingValueLength
  Scenario Outline: Validate error response is returned for "bank_country_code" <Bank_Country_Code>, "account_routing_type1" <account_routing_type1> when "account_routing_value1" <account_routing_value1> contains invalid no. of charaters
    And I create request payload with valid data for all keys with "Bank_Country_Code" is "<Bank_Country_Code>" "account_routing_type1" is "<account_routing_type1>" "account_routing_value1" is "<account_routing_value1>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "Should be <valid_len> characters long"
    And Response "source" has value "beneficiary.bank_details.account_routing_value1"

    Examples: 
      | Bank_Country_Code | account_routing_type1 | account_routing_value1 | acct_rounting_value1_length | valid_len |
      | US                | aba                   |               12345678 |                           8 |         9 |
      | US                | aba                   |             1234567890 |                          10 |         9 |
      | AU                | bsb                   |                  12345 |                           5 |         6 |
      | AU                | bsb                   |             1234567890 |                          10 |         6 |
      | US                | aba                   |                        |                           0 |         9 |
      | AU                | bsb                   |                        |                           0 |         6 |

  @PositiveScenarios
  Scenario Outline: Validate error response is returned for "bank_country_code" <Bank_Country_Code>, "account_routing_type1" <account_routing_type1> when "account_routing_value1" <account_routing_value1> contains invalid no. of charaters
    And I create request payload with valid data for all keys with "Bank_Country_Code" is "<Bank_Country_Code>" "account_routing_type1" is "<account_routing_type1>" "account_routing_value1" is "<account_routing_value1>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 201
    And Response status line is "Created"

    Examples: 
      | Bank_Country_Code | account_routing_type1 | account_routing_value1 |
      | US                | aba                   |              123456789 |
      | AU                | bsb                   |                 123456 |
 